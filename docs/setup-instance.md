# Setup Instance

## First login remote instance

When we buy a new instance from Any Cloud platform, that instance already has sshd service. So we can using the following command to log into remote instance.

  ```
  $> ssh root@<ip>
  ```

# Setup New User

## Create a new user

Because the root user has highest permission, so we need to create a new user which has low permission.

1. Create user

  ```
  $> useradd <user>
  ```
2. Set password for new user

  ```
  $> passwd <user>
  ```

## Add sudo permission

In order to using `sudo` to execute system command and less dependency on root user. So we can config the sudo permission on `/etc/sudoers` files.

  ```
  $> vim /etc/sudoers
  ```

Edit the file like this:
```
root    ALL=(ALL)  ALL
<user>  ALL=(ALL)  ALL
```

**NOTE**
If we can't change that file, we need to change the permission and change back.

  ```
  $> chmod a+w /etc/sudoers    # add permission
  ```
  ```
  $> chmod a-w /etc/sudoers    # remove permission
  ```

# Setup SSH permission

## Generate a key pair in local system.

  ```
  $> ssh-keygen -t rsa -b 4096 -C "<my-email>"
  ```

**NOTE**
Parameter `-b` to point the strength of key. Linux using 4096 as default value.

## Upload public key into remote server

In order to we can using key pair to ssh remote server.

  ```
  $> scp keypair/<public_key> <user>@<ip>:/home/<user>/.ssh/
  ```
**NOTE**
1. We need to check the `.ssh` is exist before upload public key.
2. We need to check the permission of `.ssh` folder. Suggest using system command to create that folder.

## Change the public key name

Because sshd server will check `.ssh/authorized_keys` by default, so we need to change name.

```
$> mv .ssh/<public_key> .ssh/authorized_keys
```
**NOTE**
Must make sure this file using `400` permission, or like the following to set the permission.

```
$> chmod 400 .ssh/authorized_keys
```

## Change the permission for ssh

In order to avoid using root user and password to log into remote server. Change `sshd_config` to modify permission.

```
$> vim /etc/ssh/sshd_config
```

According the following to change the config

```
Protocol 2                  # Only using ssh2 protocol.
ServerKeyBits 4096          # Same as your point stength value when you create key-pair.
PermitRootLogin no          # Forbid to using root user to login.
PasswordAuthentication no   # Forbid to using password to login.
PermitEmptyPasswords no     # Forbid to using empty password to login.
```

# How to login?

Clone this repo and using the following to connect remote instance.
```
$> ssh -i ~/.ssh/<private_key> <user>@<ip>
```
Or copy the private key into `.ssh`, and then using the following command.
```
$> ssh -i ~/.ssh/<private_key> <user>@<ip>
```

# Set config to make login easily

Create a ssh config

```
$> vim ~/.ssh/config
```

Config like this:

```
Host <my-server>
    HostName <ip>
    User <user>
    Port <22>
    IdentityFile ~/.ssh/<private_key>
```

Then you can use the following command to login host

```
$> ssh <my-server>
```
