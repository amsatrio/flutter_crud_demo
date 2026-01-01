import 'package:flutter/material.dart';
import 'package:flutter_crud_demo/modules/m_biodata/model.dart';
import 'package:flutter_crud_demo/modules/m_biodata/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void _showMBiodataDialog(BuildContext context, WidgetRef ref, {MBiodata? biodata}) {
  // Initialize controllers with existing data if editing
  final nameController = TextEditingController(text: biodata?.fullname ?? '');
  final phoneController = TextEditingController(text: biodata?.mobilePhone ?? '');

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(biodata == null ? 'Add Biodata' : 'Edit Biodata'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Full Name'),
          ),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(labelText: 'Mobile Phone'),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final name = nameController.text.trim();
            final phone = phoneController.text.trim();

            if (name.isNotEmpty && phone.isNotEmpty) {
              if (biodata == null) {
                // Logic for Adding (Note: Your addMBiodata currently only accepts 'title')
                // You might need to update your Service to accept name/phone
                await ref.read(serviceProvider.notifier).addMBiodata(name);
              } else {
                // Logic for Editing
                await ref.read(serviceProvider.notifier).editMBiodata(
                      biodata.id,
                      name,
                      phone,
                      false, // isDelete
                    );
              }
              if (context.mounted) Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
class MBiodataView extends ConsumerWidget {
  const MBiodataView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the AsyncNotifierProvider
    final biodataList = ref.watch(serviceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biodata CRUD'),
        actions: [
          // Refresh button to manually trigger build()
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(serviceProvider),
          )
        ],
      ),
      body: biodataList.when(
        data: (list) => ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            return ListTile(
              title: Text(item.fullname ?? 'No Name'),
              subtitle: Text(item.mobilePhone ?? 'No Phone'),
              onTap: () => _showMBiodataDialog(context, ref, biodata: item),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () => ref.read(serviceProvider.notifier).removeMBiodata(item.id),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Error: $err'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMBiodataDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}