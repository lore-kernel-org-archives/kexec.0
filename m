Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wy0-f177.google.com ([74.125.82.177])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PBFUc-00016d-PT
	for kexec@lists.infradead.org; Wed, 27 Oct 2010 23:33:19 +0000
Received: by wyf22 with SMTP id 22so1262052wyf.36
	for <kexec@lists.infradead.org>; Wed, 27 Oct 2010 16:33:16 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Oct 2010 16:33:16 -0700
Message-ID: <AANLkTi=HN3xrXz+xnZJY2iOV6nfpf0w9_O_V7s8QL=Ui@mail.gmail.com>
Subject: kexec -p panics on system with 96GB memory
From: Sujit V <sujit.linux@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

kexec -p is having issues on Intel x86_64 machine with 96GB memory.
We have another machine same architecture with 48GB memory and kexec
-p is working fine.

The system kernel is x86_64 while the capture kernel is i386 pae.
We are using 2.6.23 kernel version.

When I do kexec -p bzImage --initrd --command-line
The kernel panics as soon as it returns from sys_kexec_load().
The back trace shows it panic'ed in storage subsystem. (In the megasas
RAID driver).

The only thing which comes to my mind is the 64GB PAE limit. [We are
using the i386 PAE kernel as capture kernel].
Is there a known issue with kexec on systems with > 64 GB memory.?

Thanks


shell# cat /proc/iomem
00000000-0009abff : System RAM
0009ac00-0009ffff : reserved
000e0000-000fffff : reserved
00100000-bf2f4fff : System RAM
  00200000-007005c1 : Kernel code
  007005c2-0099796f : Kernel data
  01000000-08ffffff : Crash kernel
bf2f5000-bf354fff : ACPI Non-volatile Storage
bf355000-bf38dfff : reserved
bf38e000-bf38efff : ACPI Non-volatile Storage
bf38f000-bf39ffff : reserved
bf3a0000-bf3a2fff : ACPI Non-volatile Storage
bf3a3000-bf3b3fff : reserved
bf3b4000-bf3b4fff : System RAM
bf3b5000-bf3b5fff : ACPI Non-volatile Storage
bf3b6000-bf3f4fff : reserved
bf3f5000-bf400fff : ACPI Non-volatile Storage
bf401000-bf42bfff : reserved
bf42c000-bf62efff : ACPI Non-volatile Storage
bf62f000-bf7fffff : System RAM
c0000000-cfffffff : reserved
fad00000-faefffff : PCI Bus #04
  fad00000-faefffff : PCI Bus #05
    fad00000-fadfffff : PCI Bus #0b
    fae00000-faefffff : PCI Bus #09
faf00000-faffffff : PCI Bus #03
  faf00000-faf00fff : 0000:03:00.0
fb000000-fb8fffff : PCI Bus #10
  fb000000-fb8fffff : PCI Bus #11
    fb000000-fb7fffff : 0000:11:00.0
    fb800000-fb81ffff : 0000:11:00.0
fb900000-fbbfffff : PCI Bus #04
  fb900000-fbafffff : PCI Bus #05
    fb900000-fb9fffff : PCI Bus #0b
      fb900000-fb91ffff : 0000:0b:00.1
      fb920000-fb93ffff : 0000:0b:00.1
        fb920000-fb93ffff : igb
     fb940000-fb95ffff : 0000:0b:00.1
        fb940000-fb95ffff : igb
      fb960000-fb97ffff : 0000:0b:00.0
      fb980000-fb99ffff : 0000:0b:00.0
        fb980000-fb99ffff : igb
      fb9a0000-fb9bffff : 0000:0b:00.0
        fb9a0000-fb9bffff : igb
      fb9c0000-fb9c3fff : 0000:0b:00.1
        fb9c0000-fb9c3fff : igb
      fb9c4000-fb9c7fff : 0000:0b:00.0
        fb9c4000-fb9c7fff : igb
    fba00000-fbafffff : PCI Bus #09
      fba00000-fba1ffff : 0000:09:00.1
      fba20000-fba3ffff : 0000:09:00.1
        fba20000-fba3ffff : igb
      fba40000-fba5ffff : 0000:09:00.1
        fba40000-fba5ffff : igb
      fba60000-fba7ffff : 0000:09:00.0
      fba80000-fba9ffff : 0000:09:00.0
        fba80000-fba9ffff : igb
      fbaa0000-fbabffff : 0000:09:00.0
        fbaa0000-fbabffff : igb
      fbac0000-fbac3fff : 0000:09:00.1
        fbac0000-fbac3fff : igb
      fbac4000-fbac7fff : 0000:09:00.0
        fbac4000-fbac7fff : igb
  fbb00000-fbb1ffff : 0000:04:00.0
fbc00000-fbcfffff : PCI Bus #13
  fbc00000-fbc1ffff : 0000:13:00.0
    fbc00000-fbc1ffff : e1000e
  fbc20000-fbc23fff : 0000:13:00.0
    fbc20000-fbc23fff : e1000e
fbd00000-fbdfffff : PCI Bus #12
  fbd00000-fbd1ffff : 0000:12:00.0
    fbd00000-fbd1ffff : e1000e
  fbd20000-fbd23fff : 0000:12:00.0
    fbd20000-fbd23fff : e1000e
fbe00000-fbefffff : PCI Bus #0d
  fbe00000-fbe3ffff : 0000:0d:00.0
 fbe40000-fbe7ffff : 0000:0d:00.0
    fbe40000-fbe7ffff : megasas: LSI
  fbe80000-fbe83fff : 0000:0d:00.0
    fbe80000-fbe83fff : megasas: LSI
fbf00000-fbf03fff : 0000:00:16.7
fbf04000-fbf07fff : 0000:00:16.6
fbf08000-fbf0bfff : 0000:00:16.5
fbf0c000-fbf0ffff : 0000:00:16.4
fbf10000-fbf13fff : 0000:00:16.3
fbf14000-fbf17fff : 0000:00:16.2
fbf18000-fbf1bfff : 0000:00:16.1
fbf1c000-fbf1ffff : 0000:00:16.0
fbf20000-fbf200ff : 0000:00:1f.3
fbf21000-fbf213ff : 0000:00:1d.7
  fbf21000-fbf213ff : ehci_hcd
fbf22000-fbf223ff : 0000:00:1a.7
  fbf22000-fbf223ff : ehci_hcd
fbf23000-fbf23fff : 0000:00:13.0
fc000000-fcffffff : pnp 00:01
fd000000-fdffffff : pnp 00:01
fe000000-fe9fffff : pnp 00:01
fea00000-fea0001f : pnp 00:01
fec00000-fecfffff : pnp 00:0c
  fec00000-fec00fff : IOAPIC 0
fed00000-fed003ff : HPET 0
fed1c000-fed1ffff : reserved
fee00000-fee00fff : Local APIC
ff000000-ffffffff : reserved
100000000-183fffffff : System RAM

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
