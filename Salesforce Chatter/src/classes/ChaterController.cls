public class ChaterController {
public List
<selectOption>
getUsers()
{
List
<selectOption>
options = new List
<selectOption>
();
options.add(new selectOption('', 'Current User'));
for (User users : [SELECT Id, Name FROM User ])
{
options.add(new selectOption(users.Id, users.Name));
}
return options;
}
}