# print to screen
print("Python is painful")

# example of using a variable
message = "Python is painful"
print(message)

# Capitalizes words
name = "merritt burch"
print(name.title())

first_name = "merritt"
last_name = "burch"
full_name = f"{first_name} {last_name}"
print(full_name)
print(f"My name is, {full_name.title()}!")

# Manipulating Lists
states = ['New York', 'Hawaii', 'Arizona']
print(states)
print(states[1])

# Change an element of a list
states[-1] = 'Alaska'
print(states)

# insert an element
states.insert(0, 'Ohio')
print(states)

# Loops
states = ['New York', 'Hawaii', 'Arizona']
for state in states:
    print(state)
print("All states in list printed")

# dictionaries
plants = {'color': 'blue', 'height' : 10}
print(plants['color'])


# example of a function
def weather():
    answer = input("How is the weather?")
    print(answer)
weather()
