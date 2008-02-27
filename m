Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from an-out-0708.google.com ([209.85.132.250])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JUHzg-0007TO-2w
	for kexec@lists.infradead.org; Wed, 27 Feb 2008 08:50:28 +0000
Received: by an-out-0708.google.com with SMTP id c3so483979ana.99
	for <kexec@lists.infradead.org>; Wed, 27 Feb 2008 00:50:27 -0800 (PST)
Message-ID: <74661ce20802270044y2babfde7nb181797b2ba2542a@mail.gmail.com>
Date: Wed, 27 Feb 2008 10:44:15 +0200
From: "Emil Natan" <shlyoko@gmail.com>
Subject: load image oops
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1090169525=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--===============1090169525==
Content-Type: multipart/alternative; 
	boundary="----=_Part_30106_23061371.1204101855563"

------=_Part_30106_23061371.1204101855563
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list,

I'm trying for some time to use kexec on a dual CPU machine with 3GB of RAM
running Debian Etch and I got oops every few times I try to load a new
kernel. The issue is always reproducible (sometimes I got the error
immediately and sometimes after 50-100 iterations when running the kexec -l
and kexec -u commands in a loop). The error slightly differs when using the
original Etch kernel 2.6.18-[456]-686 and a newer one - 2.6.24-1-686. The
problem does not exist when the currently running kernel (not the kexec'd
one) is 486 in which case only 1GB of memory is recognized, or when 686
kernel was run with mem=900M kernel argument (mem=1G still causes the
problem). As far as I understand this means that the problem exist when the
HIGHMEM is used. Here are the oops messages:

from the 2.6.24-1-686 kernel:

BUG: unable to handle kernel paging request at virtual address ffa0e538
printing eip: c0149643 *pde = 00004067 *pte = 00000000
Oops: 0000 [#1] SMP
Modules linked in: ipv6 ipt_LOG xt_limit xt_tcpudp iptable_filter ip_tables
x_tables dm_snaps
hot dm_mirror dm_mod serio_raw psmouse iTCO_wdt floppy pcspkr container
button e752x_edac eda
c_core shpchp pci_hotplug evdev ext3 jbd mbcache ide_generic ide_cd cdrom
generic piix ide_co
re ata_generic libata uhci_hcd cciss tg3 ehci_hcd scsi_mod usbcore thermal
processor fan

Pid: 3333, comm: kexec Not tainted (2.6.24-1-686 #1)
EIP: 0060:[<c0149643>] EFLAGS: 00010282 CPU: 0
EIP is at kimage_add_entry+0x9/0x6e
EAX: ffa0e538 EBX: f71ac800 ECX: f71ac840 EDX: b5fd5008
ESI: b5fd5008 EDI: 00000000 EBP: 00001000 ESP: f7105f54
DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process kexec (pid: 3333, ti=f7104000 task=f7fc37b0 task.ti=f7104000)
Stack: 00001000 c26bfaa0 c0149bc9 08071718 ff800000 f71ac840 c03e19a0
f71ac800
       00000003 0000000a b7c27008 000d4000 000d302a 1ff2b000 b7faccc0
bfcda6a0
       00000046 c2813060 c01292ac f71ac800 00096498 00000000 000000d6
f7104000
Call Trace:
 [<c0149bc9>] sys_kexec_load+0x2b5/0x4b4
 [<c01292ac>] irq_exit+0x53/0x6b
 [<c0103ed6>] syscall_call+0x7/0xb
 [<c02b0000>] unix_mkname+0x4d/0x6f
 =======================
Code: 00 eb 15 8b 16 8d 47 18 89 42 04 89 57 18 89 70 04 89 06 e9 bf fe ff
ff 83 c4 1c 89 f8
5b 5e 5f 5d c3 56 89 d6 53 89 c3 8b 40 04 <83> 38 00 74 06 83 c0 04 89 43 04
8b 43 04 3b 43 0
8 75 36 83 c9
EIP: [<c0149643>] kimage_add_entry+0x9/0x6e SS:ESP 0068:f7105f54
---[ end trace edb4bca1461a27d3 ]---
test1:/images#  test1 kernel: Oops: 0000 [#1] SMP
test1 kernel: Process kexec (pid: 3333, ti=f7104000 task=f7fc37b0
task.ti=f7104000)
test1 kernel: Stack: 00001000 c26bfaa0 c0149bc9 08071718 ff800000 f71ac840
c03e19a0 f71ac800
test1 kernel: 00000003 0000000a b7c27008 000d4000 000d302a 1ff2b000 b7faccc0
bfcda6a0
test1 kernel: 00000046 c2813060 c01292ac f71ac800 00096498 00000000 000000d6
f7104000
test1 kernel: Call Trace:
test1 kernel: [<c0149bc9>] sys_kexec_load+0x2b5/0x4b4
test1 kernel: [<c01292ac>] irq_exit+0x53/0x6b
test1 kernel: [<c0103ed6>] syscall_call+0x7/0xb
test1 kernel: [<c02b0000>] unix_mkname+0x4d/0x6f
test1 kernel: =======================
test1 kernel: Code: 00 eb 15 8b 16 8d 47 18 89 42 04 89 57 18 89 70 04 89 06
e9 bf fe ff ff 8
3 c4 1c 89 f8 5b 5e 5f 5d c3 56 89 d6 53 89 c3 8b 40 04 <83> 38 00 74 06 83
c0 04 89 43 04 8b
 43 04 3b 43 08 75 36 83 c9
test1 kernel: EIP: [<c0149643>] kimage_add_entry+0x9/0x6e SS:ESP
0068:f7105f54


####################################################################################

and from the 2.6.18 one:

test1 kernel: Oops: 0002 [#1]
test1 kernel: SMP
test1 kernel: CPU:    1
test1 kernel: EIP is at kimage_add_entry+0x55/0x6e
test1 kernel: eax: 00000000   ebx: f7ccc600   ecx: c2b03ffc   edx: 40000002
test1 kernel: esi: b22dd008   edi: 00000000   ebp: 00001000   esp: f795bf5c
test1 kernel: ds: 007b   es: 007b   ss: 0068
test1 kernel: Process kexec (pid: 4749, ti=f795a000 task=dfa5c550
task.ti=f795a000)
test1 kernel: Stack: 00001000 c2645ba0 c013a316 ff81d000 f7ccc640 c0367058
f7ccc600 00000003
test1 kernel: 0000000a b7b1e008 001a2000 001a1e55 1fe5d000 00000001 c030cf48
0000000a
test1 kernel: c0121838 00000046 f7ccc600 00096498 00000000 000000ab f795a000
c0102c7b
test1 kernel: Call Trace:
test1 kernel: Code: ff ba f4 ff ff ff 85 c0 74 35 e8 c8 07 01 00 8b 4b 04 8d
90 00 00 00 40 83 ca 02 89 11 89 43 04 05 fc 0f 00 00 89 43 08 8b 43 04 <89>
30 8b 53 04 8d 42 04 89 43 04 c7 42 04 00 00 00 00 31 d2 5b
test1 kernel: EIP: [<c0139ddd>] kimage_add_entry+0x55/0x6e SS:ESP
0068:f795bf5c
Segmentation fault

###########################################################################

BUG: unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
 c0139ddd
 *pde = 00000000
 Oops: 0002 [#1]
 SMP
 Modules linked in: ipv6 ipt_LOG xt_limit xt_tcpudp iptable_filter ip_tables
x_tables dm_snapshot dm_mirror dm_mod tsdev floppy psmouse serio_raw pcspkr
e752x_edac edac_mc shpchp pci_hotplug evdev ext3 jbd mbcache ide_generic
ide_cd cdrom generic tg3 ehci_hcd uhci_hcd cciss scsi_mod piix ide_core
usbcore thermal processor fan
 CPU:    1
 EIP:    0060:[<c0139ddd>]    Not tainted VLI
 EFLAGS: 00010206   (2.6.18-5-686 #1)
 EIP is at kimage_add_entry+0x55/0x6e
 eax: 00000000   ebx: f7ccc600   ecx: c2b03ffc   edx: 40000002
 esi: b22dd008   edi: 00000000   ebp: 00001000   esp: f795bf5c
 ds: 007b   es: 007b   ss: 0068
 Process kexec (pid: 4749, ti=f795a000 task=dfa5c550 task.ti=f795a000)
 Stack: 00001000 c2645ba0 c013a316 ff81d000 f7ccc640 c0367058 f7ccc600
00000003
        0000000a b7b1e008 001a2000 001a1e55 1fe5d000 00000001 c030cf48
0000000a
        c0121838 00000046 f7ccc600 00096498 00000000 000000ab f795a000
c0102c7b
 Call Trace:
  [<c013a316>] sys_kexec_load+0x2b5/0x4ad
  [<c0121838>] __do_softirq+0x5a/0xbb
  [<c0102c7b>] syscall_call+0x7/0xb
 Code: ff ba f4 ff ff ff 85 c0 74 35 e8 c8 07 01 00 8b 4b 04 8d 90 00 00 00
40 83 ca 02 89 11 89 43 04 05 fc 0f 00 00 89 43 08 8b 43 04 <89> 30 8b 53 04
8d 42 04 89 43 04 c7 42 04 00 00 00 00 31 d2 5b
EIP: [<c0139ddd>] kimage_add_entry+0x55/0x6e SS:ESP 0068:f795bf5c


The problem is reproducible on two different machines (both HP DL360 G4) so
I assume it is not hardware dependent.
Hope someone can help.
Thanks

ena

------=_Part_30106_23061371.1204101855563
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi list,<br><br>I&#39;m trying for some time to use kexec on a dual CPU
machine with 3GB of RAM&nbsp; running Debian Etch and I got oops every few
times I try to load a new kernel. The issue is always reproducible
(sometimes I got the error immediately and sometimes after 50-100
iterations when running the kexec -l and kexec -u commands in a loop).
The error slightly differs when using the original Etch kernel
2.6.18-[456]-686 and a newer one - 2.6.24-1-686. The problem does not
exist when the currently running kernel (not the kexec&#39;d one) is 486 in
which case only 1GB of memory is recognized, or when 686 kernel was run
with mem=900M kernel argument (mem=1G still causes the problem). As far
as I understand this means that the problem exist when the HIGHMEM is
used. Here are the oops messages:<br>
<br>from the 2.6.24-1-686 kernel:<br><br>BUG: unable to handle kernel paging request at virtual address ffa0e538<br>printing eip: c0149643 *pde = 00004067 *pte = 00000000 <br>Oops: 0000 [#1] SMP <br>Modules linked in: ipv6 ipt_LOG xt_limit xt_tcpudp iptable_filter ip_tables x_tables dm_snaps<br>

hot dm_mirror dm_mod serio_raw psmouse iTCO_wdt floppy pcspkr container button e752x_edac eda<br>c_core shpchp pci_hotplug evdev ext3 jbd mbcache ide_generic ide_cd cdrom generic piix ide_co<br>re ata_generic libata uhci_hcd cciss tg3 ehci_hcd scsi_mod usbcore thermal processor fan<br>

<br>Pid: 3333, comm: kexec Not tainted (2.6.24-1-686 #1)<br>EIP: 0060:[&lt;c0149643&gt;] EFLAGS: 00010282 CPU: 0<br>EIP is at kimage_add_entry+0x9/0x6e<br>EAX: ffa0e538 EBX: f71ac800 ECX: f71ac840 EDX: b5fd5008<br>ESI: b5fd5008 EDI: 00000000 EBP: 00001000 ESP: f7105f54<br>

DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068<br>Process kexec (pid: 3333, ti=f7104000 task=f7fc37b0 task.ti=f7104000)<br>Stack: 00001000 c26bfaa0 c0149bc9 08071718 ff800000 f71ac840 c03e19a0 f71ac800 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000003 0000000a b7c27008 000d4000 000d302a 1ff2b000 b7faccc0 bfcda6a0 <br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000046 c2813060 c01292ac f71ac800 00096498 00000000 000000d6 f7104000 <br>Call Trace:<br>&nbsp;[&lt;c0149bc9&gt;] sys_kexec_load+0x2b5/0x4b4<br>&nbsp;[&lt;c01292ac&gt;] irq_exit+0x53/0x6b<br>&nbsp;[&lt;c0103ed6&gt;] syscall_call+0x7/0xb<br>

&nbsp;[&lt;c02b0000&gt;] unix_mkname+0x4d/0x6f<br>&nbsp;=======================<br>Code: 00 eb 15 8b 16 8d 47 18 89 42 04 89 57 18 89 70 04 89 06 e9 bf fe ff ff 83 c4 1c 89 f8 <br>5b 5e 5f 5d c3 56 89 d6 53 89 c3 8b 40 04 &lt;83&gt; 38 00 74 06 83 c0 04 89 43 04 8b 43 04 3b 43 0<br>

8 75 36 83 c9 <br>EIP: [&lt;c0149643&gt;] kimage_add_entry+0x9/0x6e SS:ESP 0068:f7105f54<br>---[ end trace edb4bca1461a27d3 ]---<br>test1:/images#&nbsp; test1 kernel: Oops: 0000 [#1] SMP <br>test1 kernel: Process kexec (pid: 3333, ti=f7104000 task=f7fc37b0 task.ti=f7104000)<br>

test1 kernel: Stack: 00001000 c26bfaa0 c0149bc9 08071718 ff800000 f71ac840 c03e19a0 f71ac800 <br>test1 kernel: 00000003 0000000a b7c27008 000d4000 000d302a 1ff2b000 b7faccc0 bfcda6a0 <br>test1 kernel: 00000046 c2813060 c01292ac f71ac800 00096498 00000000 000000d6 f7104000 <br>

test1 kernel: Call Trace:<br>test1 kernel: [&lt;c0149bc9&gt;] sys_kexec_load+0x2b5/0x4b4<br>test1 kernel: [&lt;c01292ac&gt;] irq_exit+0x53/0x6b<br>test1 kernel: [&lt;c0103ed6&gt;] syscall_call+0x7/0xb<br>test1 kernel: [&lt;c02b0000&gt;] unix_mkname+0x4d/0x6f<br>

test1 kernel: =======================<br>test1 kernel: Code: 00 eb 15 8b 16 8d 47 18 89 42 04 89 57 18 89 70 04 89 06 e9 bf fe ff ff 8<br>3 c4 1c 89 f8 5b 5e 5f 5d c3 56 89 d6 53 89 c3 8b 40 04 &lt;83&gt; 38 00 74 06 83 c0 04 89 43 04 8b<br>

&nbsp;43 04 3b 43 08 75 36 83 c9 <br>test1 kernel: EIP: [&lt;c0149643&gt;] kimage_add_entry+0x9/0x6e SS:ESP 0068:f7105f54<br><br><br>####################################################################################<br><br>
and from the 2.6.18 one:<br>
<br>test1 kernel: Oops: 0002 [#1]<br>test1 kernel: SMP <br>test1 kernel: CPU:&nbsp;&nbsp;&nbsp; 1<br>test1 kernel: EIP is at kimage_add_entry+0x55/0x6e<br>test1 kernel: eax: 00000000&nbsp;&nbsp; ebx: f7ccc600&nbsp;&nbsp; ecx: c2b03ffc&nbsp;&nbsp; edx: 40000002<br>test1 kernel: esi: b22dd008&nbsp;&nbsp; edi: 00000000&nbsp;&nbsp; ebp: 00001000&nbsp;&nbsp; esp: f795bf5c<br>

test1 kernel: ds: 007b&nbsp;&nbsp; es: 007b&nbsp;&nbsp; ss: 0068<br>test1 kernel: Process kexec (pid: 4749, ti=f795a000 task=dfa5c550 task.ti=f795a000)<br>test1 kernel: Stack: 00001000 c2645ba0 c013a316 ff81d000 f7ccc640 c0367058 f7ccc600 00000003 <br>

test1 kernel: 0000000a b7b1e008 001a2000 001a1e55 1fe5d000 00000001 c030cf48 0000000a <br>test1 kernel: c0121838 00000046 f7ccc600 00096498 00000000 000000ab f795a000 c0102c7b <br>test1 kernel: Call Trace:<br>test1
kernel: Code: ff ba f4 ff ff ff 85 c0 74 35 e8 c8 07 01 00 8b 4b 04 8d
90 00 00 00 40 83 ca 02 89 11 89 43 04 05 fc 0f 00 00 89 43 08 8b 43 04
&lt;89&gt; 30 8b 53 04 8d 42 04 89 43 04 c7 42 04 00 00 00 00 31 d2 5b <br>
test1 kernel: EIP: [&lt;c0139ddd&gt;] kimage_add_entry+0x55/0x6e SS:ESP 0068:f795bf5c<br>Segmentation fault<br><br>###########################################################################<br><br>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000<br>

&nbsp;printing eip:<br>&nbsp;c0139ddd<br>&nbsp;*pde = 00000000<br>&nbsp;Oops: 0002 [#1]<br>&nbsp;SMP <br>&nbsp;Modules
linked in: ipv6 ipt_LOG xt_limit xt_tcpudp iptable_filter ip_tables
x_tables dm_snapshot dm_mirror dm_mod tsdev floppy psmouse serio_raw
pcspkr e752x_edac edac_mc shpchp pci_hotplug evdev ext3 jbd mbcache
ide_generic ide_cd cdrom generic tg3 ehci_hcd uhci_hcd cciss scsi_mod
piix ide_core usbcore thermal processor fan<br>
&nbsp;CPU:&nbsp;&nbsp;&nbsp; 1<br>&nbsp;EIP:&nbsp;&nbsp;&nbsp; 0060:[&lt;c0139ddd&gt;]&nbsp;&nbsp;&nbsp; Not tainted VLI<br>&nbsp;EFLAGS: 00010206&nbsp;&nbsp; (2.6.18-5-686 #1) <br>&nbsp;EIP is at kimage_add_entry+0x55/0x6e<br>&nbsp;eax: 00000000&nbsp;&nbsp; ebx: f7ccc600&nbsp;&nbsp; ecx: c2b03ffc&nbsp;&nbsp; edx: 40000002<br>&nbsp;esi: b22dd008&nbsp;&nbsp; edi: 00000000&nbsp;&nbsp; ebp: 00001000&nbsp;&nbsp; esp: f795bf5c<br>

&nbsp;ds: 007b&nbsp;&nbsp; es: 007b&nbsp;&nbsp; ss: 0068<br>&nbsp;Process kexec (pid: 4749, ti=f795a000 task=dfa5c550 task.ti=f795a000)<br>&nbsp;Stack: 00001000 c2645ba0 c013a316 ff81d000 f7ccc640 c0367058 f7ccc600 00000003 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000000a b7b1e008 001a2000 001a1e55 1fe5d000 00000001 c030cf48 0000000a <br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c0121838 00000046 f7ccc600 00096498 00000000 000000ab f795a000 c0102c7b <br>&nbsp;Call Trace:<br>&nbsp; [&lt;c013a316&gt;] sys_kexec_load+0x2b5/0x4ad<br>&nbsp; [&lt;c0121838&gt;] __do_softirq+0x5a/0xbb<br>&nbsp; [&lt;c0102c7b&gt;] syscall_call+0x7/0xb<br>

&nbsp;Code: ff ba f4 ff ff ff 85 c0 74 35 e8 c8 07 01 00 8b 4b 04 8d 90 00
00 00 40 83 ca 02 89 11 89 43 04 05 fc 0f 00 00 89 43 08 8b 43 04
&lt;89&gt; 30 8b 53 04 8d 42 04 89 43 04 c7 42 04 00 00 00 00 31 d2 5b <br>EIP: [&lt;c0139ddd&gt;] kimage_add_entry+0x55/0x6e SS:ESP 0068:f795bf5c<br>
<br><br>The problem is reproducible on two different machines (both HP DL360 G4) so I assume it is not hardware dependent.<br>Hope someone can help.<br>Thanks<br><br>ena

------=_Part_30106_23061371.1204101855563--


--===============1090169525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1090169525==--

