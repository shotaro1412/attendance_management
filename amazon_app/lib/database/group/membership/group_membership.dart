class GroupMembership {
  const GroupMembership({
    this.documentId,
    required this.groupId,
    required this.userId,
    this.createdAt,
  });

  final String? documentId;
  final String groupId;
  final String userId;
  final DateTime? createdAt;
}
