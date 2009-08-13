Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
In-Reply-To: <OF7433B9C5.3D5E2748-ON65257611.0037CE47-65257611.0037EEDB@tcs.com>
References: <OF7433B9C5.3D5E2748-ON65257611.0037CE47-65257611.0037EEDB@tcs.com>
Subject: Re: vmcore file 0 size in x86_64
MIME-Version: 1.0
From: Chandan12 K <chandan12.k@tcs.com>
Message-ID: <OF8B20E4B3.38CCED3C-ON65257611.003DC8CE-65257611.00461ED3@tcs.com>
Date: Thu, 13 Aug 2009 18:15:54 +0530
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0138587334=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Chandan12 K <chandan12.k@tcs.com>
Cc: kexec-bounces@lists.infradead.org, fastboot@lists.linux-foundation.org, kexec@lists.infradead.org

This is a multipart message in MIME format.
--===============0138587334==
Content-Type: multipart/alternative; boundary="=_alternative 00461E8765257611_="

This is a multipart message in MIME format.
--=_alternative 00461E8765257611_=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"

Hi,

I checked.. through and fond out that one of the following check condition 
is failing

 516         if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0 ||
    517                 (ehdr.e_type != ET_CORE) ||
    518                 !vmcore_elf_check_arch(&ehdr) ||
    519                 ehdr.e_ident[EI_CLASS] != ELFCLASS64 ||
    520                 ehdr.e_ident[EI_VERSION] != EV_CURRENT ||
    521                 ehdr.e_version != EV_CURRENT ||
    522                 ehdr.e_ehsize != sizeof(Elf64_Ehdr) ||
    523                 ehdr.e_phentsize != sizeof(Elf64_Phdr) ||
    524                 ehdr.e_phnum == 0) {
    525                 printk(KERN_WARNING "Warning: Core image elf 
header is not"
    526 "sane:%ld\n",elfcorehdr_addr);
    527               return -EINVAL
    528         }

If I comment this return at line 527, then the code flows through and the 
vmcore is getting generated. 

However, I am facing a new issue, my user space is 32 bit and the kernel 
is 64 bit. And I want to access the high memory (high_memory - 
BACK_UP_SIZE) area of the previous/primary kernel. Where some log data I 
had saved. The toral RAM is 8GB.

As the 32 bit pointers could not reach there... means simple file 
operations lseek() , read etc are not working.. to access some region 
around 8GB.

Can you please suggest me some way to reach that memory and read my raw 
data from the user space. 

I am able to read the data from kernel space( a simple kernel module via 
/proc interface to transfer the data from kernel to user space using 
physical address of the primary kernel).



Chandan Kumar
TCS Mumbai




Chandan12 K <chandan12.k@tcs.com> 
Sent by: kexec-bounces@lists.infradead.org
08/13/2009 03:40 PM

To
kexec@lists.infradead.org
cc

Subject
vmcore file 0 size in x86_64







Hi, 

Adding boot logs 

NET: Registered protocol family 1 
audit: initializing netlink socket (disabled) 
type=2000 audit(1250069944.104:1): initialized 
VFS: Disk quotas dquot_6.5.1 
Dquot-cache hash table entries: 512 (order 0, 4096 bytes) 
Warning: Core image elf header is notsane 
Kdump: vmcore not initialized 
Registering unionfs 2.2-mm 
msgmni has been set to 90 
io scheduler noop registered 
io scheduler anticipatory registered


however, similar case has already been discussed in other mailing lists 
with vivek. The only difference is that, I am not using redhat system and 
dont have any user level kexel tools.   

https://lists.linux-foundation.org/pipermail/fastboot/2007-January/012572.html 


The kernel command line of capture kernel (kexe'ed kernel) : Kernel 
command line: root=/dev/nfs rw console=ttyS0,115200 ip=::::::dhcp 
selinux=0 noacpi maxcpus=1 memmap=exactmap memmap=640K@0K 
memmap=64876K@16384K elfcorehdr=81260K 


Command line for the Primary kernel : root=/dev/nfs rw 
console=ttyS0,115200 ip=::::::dhcp crashkernel=64M@16M 

kexec command used : kexec -p bzImage --append="root=/dev/nfs rw 
console=ttyS0,115200 ip=::::::dhcp selinux=0 noacpi maxcpus=1" 

Kconfig options : 

CONFIG_CRASH_DUMP=y 
CONFIG_PHYSICAL_START=0x200000 
CONFIG_RELOCATABLE=y 
CONFIG_PHYSICAL_ALIGN=0x200000

Please suggest. 


Chandan 


Dave Anderson <anderson@redhat.com> 
Sent by: crash-utility-bounces@redhat.com 
08/12/2009 07:39 PM 

Please respond to
"Discussion list for crash utility usage,        maintenance and 
development" <crash-utility@redhat.com>



To
"Discussion list for crash utility usage,        maintenance and 
development" <crash-utility@redhat.com> 
cc

Subject
Re: [Crash-utility] vmcore file size 0 on x86_64











Forwarded to kexec list:

http://lists.infradead.org/pipermail/kexec/2009-August/003474.html

----- "Chandan12 K" <chandan12.k@tcs.com> wrote:

> Hi,
> 
> I am little new in this mailing list. I just wondered if anybody could
> help me regarding the vmcore file generation. I ran kexec on my x86_64
> machine, and the /proc/vmcore file is created with zero size.
> 
> However, even if I read the /dev/oldmem file, I am only able to read
> till 16M. I guess I am only able to read till the 'X', where X is
> crashkernel=Y@X.
> 
> Moreover, My machine seems to have 32 bit user space and ofcourse, 64
> bit kernel space.
> 
> Appreciate any response.
> 
> Chandan Kumar
> ____________________________________________ =====-----=====-----=====
> Notice: The information contained in this e-mail
> message and/or attachments to it may contain
> confidential or privileged information. If you are
> not the intended recipient, any dissemination, use,
> review, distribution, printing or copying of the
> information contained in this e-mail message
> and/or attachments to it are strictly prohibited. If
> you have received this communication in error,
> please notify us by reply e-mail or telephone and
> immediately and permanently delete the message
> and any attachments. Thank you 
> --
> Crash-utility mailing list
> Crash-utility@redhat.com
> https://www.redhat.com/mailman/listinfo/crash-utility

--
Crash-utility mailing list
Crash-utility@redhat.com
https://www.redhat.com/mailman/listinfo/crash-utility

ForwardSourceID:NT0000987A     
=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

ForwardSourceID:NT000098BE     

Chandan Kumar
TCS Mumbai
=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

ForwardSourceID:NT0000994A 
=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you



--=_alternative 00461E8765257611_=
Content-Transfer-Encoding: 7bit
Content-Type: text/html; charset="us-ascii"


<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I checked.. through and fond out that
one of the following check condition is failing</font>
<br>
<br><font size=2 face="sans-serif">&nbsp;516 &nbsp; &nbsp; &nbsp; &nbsp;
if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0 ||</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; 517 &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (ehdr.e_type != ET_CORE) ||</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; 518 &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; !vmcore_elf_check_arch(&amp;ehdr) ||</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; 519 &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ehdr.e_ident[EI_CLASS] != ELFCLASS64
||</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; 520 &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ehdr.e_ident[EI_VERSION] != EV_CURRENT
||</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; 521 &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ehdr.e_version != EV_CURRENT ||</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; 522 &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ehdr.e_ehsize != sizeof(Elf64_Ehdr)
||</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; 523 &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ehdr.e_phentsize != sizeof(Elf64_Phdr)
||</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; 524 &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ehdr.e_phnum == 0) {</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; 525 &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; printk(KERN_WARNING &quot;Warning: Core
image elf header is not&quot;</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; 526 &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;sane:%ld\n&quot;,elfcorehdr_addr);</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; 527 &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; return -EINVAL</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; 528 &nbsp; &nbsp; &nbsp;
&nbsp; }</font>
<br>
<br><font size=2 face="sans-serif">If I comment this return at line 527,
then the code flows through and the vmcore is getting generated. </font>
<br>
<br><font size=2 face="sans-serif">However, I am facing a new issue, my
user space is 32 bit and the kernel is 64 bit. And I want to access the
high memory (high_memory - BACK_UP_SIZE) area of the previous/primary kernel.
Where some log data I had saved. The toral RAM is 8GB.</font>
<br>
<br><font size=2 face="sans-serif">As the 32 bit pointers could not reach
there... means simple file operations lseek() , read etc are not working..
to access some region around 8GB.</font>
<br>
<br><font size=2 face="sans-serif">Can you please suggest me some way to
reach that memory and read my raw data from the user space. </font>
<br>
<br><font size=2 face="sans-serif">I am able to read the data from kernel
space( a simple kernel module via /proc interface to transfer the data
from kernel to user space using physical address of the primary kernel).</font>
<br>
<br>
<br><font size=2 face="sans-serif"><br>
Chandan Kumar<br>
TCS Mumbai<br>
</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Chandan12 K &lt;chandan12.k@tcs.com&gt;</b>
</font>
<br><font size=1 face="sans-serif">Sent by: kexec-bounces@lists.infradead.org</font>
<p><font size=1 face="sans-serif">08/13/2009 03:40 PM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">kexec@lists.infradead.org</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">vmcore file 0 size in x86_64</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><font size=2 face="sans-serif"><br>
Hi,</font><font size=3> </font><font size=2 face="sans-serif"><br>
<br>
Adding boot logs</font><font size=3> </font><font size=2 face="sans-serif"><br>
<br>
NET: Registered protocol family 1</font><font size=3> </font><font size=2 face="sans-serif"><br>
audit: initializing netlink socket (disabled)</font><font size=3> </font><font size=2 face="sans-serif"><br>
type=2000 audit(1250069944.104:1): initialized</font><font size=3> </font><font size=2 face="sans-serif"><br>
VFS: Disk quotas dquot_6.5.1</font><font size=3> </font><font size=2 face="sans-serif"><br>
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)</font><font size=3>
</font><font size=2 face="sans-serif"><br>
Warning: Core image elf header is notsane</font><font size=3> </font><font size=2 face="sans-serif"><br>
Kdump: vmcore not initialized</font><font size=3> </font><font size=2 face="sans-serif"><br>
Registering unionfs 2.2-mm</font><font size=3> </font><font size=2 face="sans-serif"><br>
msgmni has been set to 90</font><font size=3> </font><font size=2 face="sans-serif"><br>
io scheduler noop registered</font><font size=3> </font><font size=2 face="sans-serif"><br>
io scheduler anticipatory registered</font><font size=3><br>
</font><font size=2 face="sans-serif"><br>
<br>
however, similar case has already been discussed in other mailing lists
with vivek. The only difference is that, I am not using redhat system and
dont have any user level kexel tools. &nbsp;</font><font size=3> </font><font size=3 color=blue><u><br>
<br>
</u></font><a href="https://lists.linux-foundation.org/pipermail/fastboot/2007-January/012572.html"><font size=2 color=blue face="Trebuchet MS"><u>https://lists.linux-foundation.org/pipermail/fastboot/2007-January/012572.html</u></font></a><font size=3>
</font><font size=2 face="sans-serif"><br>
<br>
The kernel command line of capture kernel (kexe'ed kernel) : Kernel command
line: root=/dev/nfs rw console=ttyS0,115200 ip=::::::dhcp selinux=0 noacpi
maxcpus=1 memmap=exactmap memmap=640K@0K memmap=64876K@16384K elfcorehdr=81260K</font><font size=3>
<br>
</font><font size=2 face="sans-serif"><br>
<br>
Command line for the Primary kernel : root=/dev/nfs rw console=ttyS0,115200
ip=::::::dhcp crashkernel=64M@16M</font><font size=3> </font><font size=2 face="sans-serif"><br>
<br>
kexec command used : kexec -p bzImage --append=&quot;root=/dev/nfs rw console=ttyS0,115200
ip=::::::dhcp selinux=0 noacpi maxcpus=1&quot;</font><font size=3> </font><font size=2 face="sans-serif"><br>
<br>
Kconfig options :</font><font size=3> </font><font size=2 face="sans-serif"><br>
<br>
CONFIG_CRASH_DUMP=y</font><font size=3> </font><font size=2 face="sans-serif"><br>
CONFIG_PHYSICAL_START=0x200000</font><font size=3> </font><font size=2 face="sans-serif"><br>
CONFIG_RELOCATABLE=y</font><font size=3> </font><font size=2 face="sans-serif"><br>
CONFIG_PHYSICAL_ALIGN=0x200000<br>
<br>
Please suggest.</font><font size=3> </font><font size=2 face="sans-serif"><br>
</font><font size=3><br>
</font><font size=2 face="sans-serif"><br>
Chandan</font><font size=3> <br>
<br>
</font>
<table width=100%>
<tr valign=top>
<td width=48%><font size=1 face="sans-serif"><b>Dave Anderson &lt;anderson@redhat.com&gt;</b>
<br>
Sent by: crash-utility-bounces@redhat.com</font><font size=3> </font>
<p><font size=1 face="sans-serif">08/12/2009 07:39 PM</font><font size=3>
</font>
<br>
<table border>
<tr valign=top>
<td bgcolor=white>
<div align=center><font size=1 face="sans-serif">Please respond to<br>
&quot;Discussion list for crash utility usage, &nbsp; &nbsp; &nbsp; &nbsp;maintenance
and development&quot; &lt;crash-utility@redhat.com&gt;</font></div></table>
<br>
<td width=51%>
<br>
<table width=100%>
<tr valign=top>
<td width=7%>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td width=92%><font size=1 face="sans-serif">&quot;Discussion list for
crash utility usage, &nbsp; &nbsp; &nbsp; &nbsp;maintenance and development&quot;
&lt;crash-utility@redhat.com&gt;</font><font size=3> </font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: [Crash-utility] vmcore file size
0 on x86_64</font></table>
<br><font size=3><br>
</font>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br><font size=3><br>
<br>
</font><tt><font size=2><br>
<br>
<br>
Forwarded to kexec list:<br>
</font></tt><font size=3 color=blue><u><br>
</u></font><a href="http://lists.infradead.org/pipermail/kexec/2009-August/003474.html"><tt><font size=2 color=blue><u>http://lists.infradead.org/pipermail/kexec/2009-August/003474.html</u></font></tt></a><tt><font size=2><br>
<br>
----- &quot;Chandan12 K&quot; &lt;chandan12.k@tcs.com&gt; wrote:<br>
<br>
&gt; Hi,<br>
&gt; <br>
&gt; I am little new in this mailing list. I just wondered if anybody could<br>
&gt; help me regarding the vmcore file generation. I ran kexec on my x86_64<br>
&gt; machine, and the /proc/vmcore file is created with zero size.<br>
&gt; <br>
&gt; However, even if I read the /dev/oldmem file, I am only able to read<br>
&gt; till 16M. I guess I am only able to read till the 'X', where X is<br>
&gt; crashkernel=Y@X.<br>
&gt; <br>
&gt; Moreover, My machine seems to have 32 bit user space and ofcourse,
64<br>
&gt; bit kernel space.<br>
&gt; <br>
&gt; Appreciate any response.<br>
&gt; <br>
&gt; Chandan Kumar<br>
&gt; ____________________________________________ =====-----=====-----=====<br>
&gt; Notice: The information contained in this e-mail<br>
&gt; message and/or attachments to it may contain<br>
&gt; confidential or privileged information. If you are<br>
&gt; not the intended recipient, any dissemination, use,<br>
&gt; review, distribution, printing or copying of the<br>
&gt; information contained in this e-mail message<br>
&gt; and/or attachments to it are strictly prohibited. If<br>
&gt; you have received this communication in error,<br>
&gt; please notify us by reply e-mail or telephone and<br>
&gt; immediately and permanently delete the message<br>
&gt; and any attachments. Thank you <br>
&gt; --<br>
&gt; Crash-utility mailing list<br>
&gt; Crash-utility@redhat.com<br>
&gt; </font></tt><a href="https://www.redhat.com/mailman/listinfo/crash-utility"><tt><font size=2 color=blue><u>https://www.redhat.com/mailman/listinfo/crash-utility</u></font></tt></a><tt><font size=2><br>
<br>
--<br>
Crash-utility mailing list<br>
Crash-utility@redhat.com</font></tt><font size=3 color=blue><u><br>
</u></font><a href="https://www.redhat.com/mailman/listinfo/crash-utility"><tt><font size=2 color=blue><u>https://www.redhat.com/mailman/listinfo/crash-utility</u></font></tt></a><font size=1 color=white face="sans-serif"><br>
<br>
ForwardSourceID:NT0000987A &nbsp; &nbsp;</font><font size=3> </font><tt><font size=3><br>
=====-----=====-----=====<br>
Notice: The information contained in this e-mail<br>
message and/or attachments to it may contain <br>
confidential or privileged information. If you are <br>
not the intended recipient, any dissemination, use, <br>
review, distribution, printing or copying of the <br>
information contained in this e-mail message <br>
and/or attachments to it are strictly prohibited. If <br>
you have received this communication in error, <br>
please notify us by reply e-mail or telephone and <br>
immediately and permanently delete the message <br>
and any attachments. Thank you<br>
<br>
</font></tt><tt><font size=2><br>
_______________________________________________<br>
kexec mailing list<br>
kexec@lists.infradead.org</font></tt><font size=3 color=blue><u><br>
</u></font><a href=http://lists.infradead.org/mailman/listinfo/kexec><tt><font size=2 color=blue><u>http://lists.infradead.org/mailman/listinfo/kexec</u></font></tt></a><font size=3><br>
</font><font size=1 color=white face="sans-serif"><br>
ForwardSourceID:NT000098BE &nbsp; &nbsp;</font><font size=3> </font><font size=2 face="sans-serif"><br>
<br>
Chandan Kumar<br>
TCS Mumbai</font>
<br><tt><font size=3>=====-----=====-----=====<br>
Notice: The information contained in this e-mail<br>
message and/or attachments to it may contain <br>
confidential or privileged information. If you are <br>
not the intended recipient, any dissemination, use, <br>
review, distribution, printing or copying of the <br>
information contained in this e-mail message <br>
and/or attachments to it are strictly prohibited. If <br>
you have received this communication in error, <br>
please notify us by reply e-mail or telephone and <br>
immediately and permanently delete the message <br>
and any attachments. Thank you<br>
<br>
<br>
</font></tt><tt><font size=2>_______________________________________________<br>
kexec mailing list<br>
kexec@lists.infradead.org<br>
</font></tt><a href=http://lists.infradead.org/mailman/listinfo/kexec><tt><font size=2>http://lists.infradead.org/mailman/listinfo/kexec</font></tt></a><tt><font size=2><br>
</font></tt>
<br><font size=1 color=white face="sans-serif">ForwardSourceID:NT0000994A
&nbsp; &nbsp;</font>
<br><pre>=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you


</pre>
--=_alternative 00461E8765257611_=--



--===============0138587334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0138587334==--


