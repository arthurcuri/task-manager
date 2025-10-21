import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggle,
    required this.onDelete,
  });

  Color _getPriorityColor() {
    switch (task.priority) {
      case 'low':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'high':
        return Colors.red;
      case 'urgent':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getPriorityIcon() {
    switch (task.priority) {
      case 'urgent':
        return Icons.priority_high;
      default:
        return Icons.flag;
    }
  }

  String _getPriorityLabel() {
    switch (task.priority) {
      case 'low':
        return 'Baixa';
      case 'medium':
        return 'Média';
      case 'high':
        return 'Alta';
      case 'urgent':
        return 'Urgente';
      default:
        return 'Média';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final priorityColor = _getPriorityColor();
    
    return Semantics(
      label: '${task.completed ? "Concluída" : "Pendente"}: ${task.title}. Prioridade ${_getPriorityLabel()}',
      button: true,
      child: Slidable(
        key: ValueKey(task.id),
        
        // Ações ao deslizar para direita (início)
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => onToggle(),
              backgroundColor: task.completed 
                  ? Colors.orange 
                  : Colors.green,
              foregroundColor: Colors.white,
              icon: task.completed ? Icons.undo : Icons.check,
              label: task.completed ? 'Desfazer' : 'Concluir',
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
            ),
            SlidableAction(
              onPressed: (_) => onTap(),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Editar',
            ),
          ],
        ),
        
        // Ações ao deslizar para esquerda (fim)
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => onDelete(),
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Deletar',
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
            ),
          ],
        ),
        
        child: Card(
          elevation: task.completed ? 1 : 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: task.completed
                  ? Theme.of(context).colorScheme.outline.withValues(alpha: 0.3)
                  : priorityColor.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Checkbox com área de toque maior
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: Checkbox(
                      value: task.completed,
                      onChanged: (_) => onToggle(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                
                  const SizedBox(width: 12),
                
                  // Conteúdo Principal
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título
                        Text(
                          task.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            decoration: task.completed 
                                ? TextDecoration.lineThrough 
                                : null,
                            color: task.completed 
                                ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        if (task.description.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            task.description,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: task.completed 
                                  ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)
                                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                              decoration: task.completed 
                                  ? TextDecoration.lineThrough 
                                  : null,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        
                        const SizedBox(height: 12),
                        
                        // Metadata Row
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            // Prioridade Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: priorityColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: priorityColor.withValues(alpha: 0.5),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _getPriorityIcon(),
                                    size: 16,
                                    color: priorityColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    _getPriorityLabel(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: priorityColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Data
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  dateFormat.format(task.createdAt),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Ícone de hint para deslizar
                  Icon(
                    Icons.drag_indicator,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
