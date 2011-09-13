Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from imr3.ericy.com ([198.24.6.13])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R3ac7-0000cz-Hb
	for kexec@lists.infradead.org; Tue, 13 Sep 2011 21:33:56 +0000
From: Dennis Flynn <dennis.flynn@ericsson.com>
Date: Tue, 13 Sep 2011 17:33:42 -0400
Subject: vmcore_init() failure using uImage on fsl_booke
Message-ID: <D58A856745AB5A47B1448181D1A8BBFA0F6195C855@EUSAACMS0701.eamcs.ericsson.se>
Content-Language: en-US
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: McClintock Matthew-B29882 <B29882@freescale.com>


Hi,

I am seeing a problem with the kdump kernel running on my Freescale mpc8536 based board.
Specifically when the crash kernel boots after a forced panic, vmcore fails to initialize.
The following errors are displayed by vmcore_init()

Warning: Core image elf header not found
Kdump: vmcore not initialized

I only see this problem when loading a uImage-ppc image type. The problem does not occur when loading a elf-ppc image type (i.e. vmlinux).
I am using kernel version 2.6.39 and kexec-tools version as of 6/16/2011.

The problem seems to one of vmcore_init not being able to locate the ELF image header within the old kernel (/dev/oldmem).
See additional details below.

Reserved crash kernel memory: crashkernel=256M@512

uImage file built as below to match the reserved memory area:

lxapp-2:lc$ mkimage -A ppc -O linux -T kernel -C gzip -a 0x20000000 -e 0x20000000 -n Linux-2.6.39.3-495-g56d1401-dirty -d vmlinux.bin.gz uImage.kdump
Image Name:   Linux-2.6.39.3-495-g56d1401-dirt
Created:      Mon Sep 12 14:06:23 2011
Image Type:   PowerPC Linux Kernel Image (gzip compressed)
Data Size:    4842545 Bytes = 4729.05 kB = 4.62 MB
Load Address: 20000000
Entry Point:  20000000

After loading the crash kernel (uImage.kdump) I then force a kernel panic and the crash kernel is invoked as expected. However it appears as though the crash kernel is having trouble accessing some of the memory of the original kernel (/dev/oldmem). Specifically the test for the ELF header magic number is failing during vmcore_init(). As a result /proc/vmcore is not available within the crash kernel and hence I cannot create a dump of the original kernel. Here's the errors I am seeing. Note I have augmented the debug prints slightly to verify the inability to see the kernel image elf header.

Reading 16 bytes from address 0x000000002086E000 within /dev/oldmem
00 00 00 00 00 00 00 00
Warning: Core image elf header not found
Kdump: vmcore not initialized

Here's the crash kernel bootline showing the elfcorehdr argument passed to the crash kernel.

Kernel command line: irqpoll maxcpus=1 reset_devices boot_mode=crash root=/dev/nfs  nfsroot=127.3.252.1:/var/export/hitchhiker-6kn/current/rootfs  ip=127.3.10.1:127.3.252.1:127.3.252.1:255.255.0.0:hitchhiker-6kn:eth0:off  rbn_net_dev=eth0 console=ttyS0,115200 dump_type=kernel dump_server=0.0.0.0 dump_server_port=9999 hwether=x board_name=wolf_lc slot_number=255  elfcorehdr=532920K savemaxmem=2048M
 
To help me debug all of this I added some debug prints to the powerpc kexec code (default_machine_kexec()) so I could verify the kernel kimage and memory segment contents. See below.

Bye!
Calling reboot_code_buffer (vaddr:0xe086f000): page_list=0x00000004, reboot_code_buffer_phys=0x2086f000, start=0x2fffa724

Dumping kimage @ 0xdfbdf800
  head: 0x00000004
  entry: 0xdfbdf800
  last_entry: 0xdfbdf800
  destination: 0x00000000
  start: 0x2fffa724
  control_code_page: 0xc0c97de0
  swap_page: 0x  (null)
  control_page: 0x2086ffff
  type: 0x00000001
  preserve_context: 0x00000000
nr_segments = 5
segment[0].buf   = 48831008
segment[0].bufsz = 75d640
segment[0].mem   = 0x20000000
segment[0].memsz = 85e000
segment[1].buf   = 1007d988
segment[1].bufsz = 10000
segment[1].mem   = 0x2085e000
segment[1].memsz = 10000
segment[2].buf   = 1007d350
segment[2].bufsz = 400
segment[2].mem   = 0x2086e000
segment[2].memsz = 1000
segment[3].buf   = 10093fa8
segment[3].bufsz = 2b62
segment[3].mem   = 0x217fd000
segment[3].memsz = 3000
segment[4].buf   = 1008e380
segment[4].bufsz = 5c20
segment[4].mem   = 0x2fffa000
segment[4].memsz = 6000


Thanks for any help,
Dennis



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
