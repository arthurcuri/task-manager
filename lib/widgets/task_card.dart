import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/task.dart';
import '../models/category.dart';

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

  bool _isOverdue() {
    if (task.completed) return false;
    if (task.dueDate == null) return false;
    return task.dueDate!.isBefore(DateTime.now());
  }

  Color _getCardBorderColor() {
    // Se vencida, usa vermelho
    if (_isOverdue()) return Colors.red;
    
    // Se tem categoria, usa a cor da categoria
    final category = AppCategories.getById(task.category);
    if (category != null) return category.color;
    
    // Senão, usa cor da prioridade
    return _getPriorityColor();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final dueDateFormat = DateFormat('dd/MM/yyyy');
    final priorityColor = _getPriorityColor();
    final category = AppCategories.getById(task.category);
    final isOverdue = _isOverdue();
    
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
          elevation: task.completed ? 1 : (isOverdue ? 6 : 3),
          color: isOverdue && !task.completed
              ? Colors.red.withValues(alpha: 0.05)
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: task.completed
                  ? Theme.of(context).colorScheme.outline.withValues(alpha: 0.3)
                  : _getCardBorderColor().withValues(alpha: 0.7),
              width: isOverdue && !task.completed ? 3 : 2,
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
                            // Categoria (se tiver)
                            if (category != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: category.color.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: category.color.withValues(alpha: 0.5),
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      category.icon,
                                      size: 16,
                                      color: category.color,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      category.name,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: category.color,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            
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
                            
                            // Data de Vencimento (se tiver)
                            if (task.dueDate != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: isOverdue
                                      ? Colors.red.withValues(alpha: 0.15)
                                      : Colors.blue.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isOverdue
                                        ? Colors.red.withValues(alpha: 0.5)
                                        : Colors.blue.withValues(alpha: 0.5),
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      isOverdue ? Icons.warning : Icons.event,
                                      size: 16,
                                      color: isOverdue ? Colors.red : Colors.blue,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      dueDateFormat.format(task.dueDate!),
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: isOverdue ? Colors.red : Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (isOverdue) ...[
                                      const SizedBox(width: 4),
                                      const Text(
                                        'VENCIDA',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            
                            // Data de Criação
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
