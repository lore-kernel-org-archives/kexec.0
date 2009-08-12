Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from inmumg01.tcs.com ([219.64.33.12])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MbF5H-00005i-Qs
	for kexec@lists.infradead.org; Wed, 12 Aug 2009 14:45:52 +0000
In-Reply-To: <1314222164.1823831250086192446.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
References: <OF3BE32408.A37213B3-ON65257610.002173CE-65257610.0021C659@tcs.com>
	<1314222164.1823831250086192446.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Subject: Re: [Crash-utility] vmcore file size 0 on x86_64
MIME-Version: 1.0
From: Chandan12 K <chandan12.k@tcs.com>
Message-ID: <OF4E992B5A.72B86206-ON65257610.005028D7-65257610.0050E645@tcs.com>
Date: Wed, 12 Aug 2009 20:13:38 +0530
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1780533672=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This is a multipart message in MIME format.
--===============1780533672==
Content-Type: multipart/alternative; boundary="=_alternative 0050E60865257610_="

This is a multipart message in MIME format.
--=_alternative 0050E60865257610_=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"

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

Shukriya,

Chandan




Dave Anderson <anderson@redhat.com> 
Sent by: crash-utility-bounces@redhat.com
08/12/2009 07:39 PM
Please respond to
"Discussion list for crash utility usage,       maintenance and 
development" <crash-utility@redhat.com>


To
"Discussion list for crash utility usage,       maintenance and 
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



--=_alternative 0050E60865257610_=
Content-Transfer-Encoding: 7bit
Content-Type: text/html; charset="us-ascii"


<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">Adding boot logs</font>
<br>
<br><font size=2 face="sans-serif">NET: Registered protocol family 1</font>
<br><font size=2 face="sans-serif">audit: initializing netlink socket (disabled)</font>
<br><font size=2 face="sans-serif">type=2000 audit(1250069944.104:1): initialized</font>
<br><font size=2 face="sans-serif">VFS: Disk quotas dquot_6.5.1</font>
<br><font size=2 face="sans-serif">Dquot-cache hash table entries: 512
(order 0, 4096 bytes)</font>
<br><font size=2 face="sans-serif">Warning: Core image elf header is notsane</font>
<br><font size=2 face="sans-serif">Kdump: vmcore not initialized</font>
<br><font size=2 face="sans-serif">Registering unionfs 2.2-mm</font>
<br><font size=2 face="sans-serif">msgmni has been set to 90</font>
<br><font size=2 face="sans-serif">io scheduler noop registered</font>
<br><font size=2 face="sans-serif">io scheduler anticipatory registered<br>
</font>
<br>
<br><font size=2 face="sans-serif">however, similar case has already been
discussed in other mailing lists with vivek. The only difference is that,
I am not using redhat system and dont have any user level kexel tools.
&nbsp;</font>
<br>
<br><a href="https://lists.linux-foundation.org/pipermail/fastboot/2007-January/012572.html"><font size=2 color=blue face="Trebuchet MS"><u>https://lists.linux-foundation.org/pipermail/fastboot/2007-January/012572.html</u></font></a>
<br>
<br><font size=2 face="sans-serif">The kernel command line of capture kernel
(kexe'ed kernel) : Kernel command line: root=/dev/nfs rw console=ttyS0,115200
ip=::::::dhcp selinux=0 noacpi maxcpus=1 memmap=exactmap memmap=640K@0K
memmap=64876K@16384K elfcorehdr=81260K</font>
<br>
<br>
<br><font size=2 face="sans-serif">Command line for the Primary kernel
: root=/dev/nfs rw console=ttyS0,115200 ip=::::::dhcp crashkernel=64M@16M</font>
<br>
<br><font size=2 face="sans-serif">kexec command used : kexec -p bzImage
--append=&quot;root=/dev/nfs rw console=ttyS0,115200 ip=::::::dhcp selinux=0
noacpi maxcpus=1&quot;</font>
<br>
<br><font size=2 face="sans-serif">Kconfig options :</font>
<br>
<br><font size=2 face="sans-serif">CONFIG_CRASH_DUMP=y</font>
<br><font size=2 face="sans-serif">CONFIG_PHYSICAL_START=0x200000</font>
<br><font size=2 face="sans-serif">CONFIG_RELOCATABLE=y</font>
<br><font size=2 face="sans-serif">CONFIG_PHYSICAL_ALIGN=0x200000<br>
</font>
<br><font size=2 face="sans-serif">Please suggest.</font>
<br>
<br><font size=2 face="sans-serif">Shukriya,</font>
<br>
<br><font size=2 face="sans-serif">Chandan</font>
<br>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Dave Anderson &lt;anderson@redhat.com&gt;</b>
</font>
<br><font size=1 face="sans-serif">Sent by: crash-utility-bounces@redhat.com</font>
<p><font size=1 face="sans-serif">08/12/2009 07:39 PM</font>
<table border>
<tr valign=top>
<td bgcolor=white>
<div align=center><font size=1 face="sans-serif">Please respond to<br>
&quot;Discussion list for crash utility usage, &nbsp; &nbsp; &nbsp; &nbsp;maintenance
and development&quot; &lt;crash-utility@redhat.com&gt;</font></div></table>
<br>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">&quot;Discussion list for crash utility
usage, &nbsp; &nbsp; &nbsp; &nbsp;maintenance and development&quot;
&lt;crash-utility@redhat.com&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: [Crash-utility] vmcore file size
0 on x86_64</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><tt><font size=2><br>
Forwarded to kexec list:<br>
<br>
 &nbsp;</font></tt><a href="http://lists.infradead.org/pipermail/kexec/2009-August/003474.html"><tt><font size=2>http://lists.infradead.org/pipermail/kexec/2009-August/003474.html</font></tt></a><tt><font size=2><br>
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
&gt; </font></tt><a href="https://www.redhat.com/mailman/listinfo/crash-utility"><tt><font size=2>https://www.redhat.com/mailman/listinfo/crash-utility</font></tt></a><tt><font size=2><br>
<br>
--<br>
Crash-utility mailing list<br>
Crash-utility@redhat.com<br>
</font></tt><a href="https://www.redhat.com/mailman/listinfo/crash-utility"><tt><font size=2>https://www.redhat.com/mailman/listinfo/crash-utility</font></tt></a><tt><font size=2><br>
</font></tt>
<br><font size=1 color=white face="sans-serif">ForwardSourceID:NT0000987A
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
--=_alternative 0050E60865257610_=--



--===============1780533672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1780533672==--


