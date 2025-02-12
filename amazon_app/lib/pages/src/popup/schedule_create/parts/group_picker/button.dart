import 'package:amazon_app/pages/src/home/parts/group/controller/joined_group_controller.dart';
import 'package:amazon_app/pages/src/popup/schedule_create/parts/group_picker/modal.dart';
import 'package:amazon_app/pages/src/popup/schedule_create/parts/group_picker/riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupPickerButton extends ConsumerStatefulWidget {
  const GroupPickerButton({
    super.key,
    required this.groupsProfile,
  });

  final AsyncValue<List<GroupWithId>> groupsProfile;
  @override
  ConsumerState<GroupPickerButton> createState() =>
      _GroupPickerButtonState();
}

class _GroupPickerButtonState extends ConsumerState<GroupPickerButton> {
  void _showGroupPicker(
    BuildContext context,
    List<GroupWithId> groupWithId,
  ) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return GroupPickerModal(
          groups: groupWithId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupName = ref.watch(groupNameProvider);
    final groupsProfile = widget.groupsProfile;

    return Container(
      margin: const EdgeInsets.only(top: 160),
      child: Row(
        children: [
          const Icon(
            Icons.group_add,
            color: Colors.grey,
          ),
          groupsProfile.when(
            data: (groups) => CupertinoButton(
              onPressed: () => _showGroupPicker(context, groups),
              child: Text(
                groupName,
                style: const TextStyle(fontSize: 18, color: Color(0xFF7B61FF)),
              ),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (error, _) => Text('Error: $error'),
          ),
        ],
      ),
    );
  }
}
