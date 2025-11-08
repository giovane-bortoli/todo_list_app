enum TodoFilterEnum {
  all('all', 'All'),
  pending('pending', 'Pending'),
  done('done', 'Done');

  final String value;
  final String label;

  const TodoFilterEnum(this.value, this.label);
}
