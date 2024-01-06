import 'package:companies/companies.dart';
import 'package:flutter/material.dart';

class CompaniesItem extends StatelessWidget {
  const CompaniesItem({
    required this.onTap,
    required this.company,
    required this.onDismissed,
    super.key,
  });

  final VoidCallback onTap;
  final CompanyEntity company;
  final DismissDirectionCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Container(
          margin: const EdgeInsets.only(right: 20.0),
          child: const Icon(
            Icons.delete,
            color: Color(0xAAFFFFFF),
          ),
        ),
      ),
      confirmDismiss: (DismissDirection direction) async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you sure you want to delete?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Yes'),
                )
              ],
            );
          },
        );
        return confirmed;
      },
      child: Card(
        // margin: const EdgeInsets.all(10),
        child: ListTile(
          onTap: onTap,
          title: Text(
            company.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            company.cnpj,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
