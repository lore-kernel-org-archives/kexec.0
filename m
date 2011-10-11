Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-yw0-f49.google.com ([209.85.213.49])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RDlup-0000Yt-Cp
	for kexec@lists.infradead.org; Tue, 11 Oct 2011 23:39:20 +0000
Received: by ywf9 with SMTP id 9so141846ywf.36
	for <kexec@lists.infradead.org>; Tue, 11 Oct 2011 16:39:13 -0700 (PDT)
Subject: Crash during vmcore_init
From: Tim Hartrick <tim@edgecast.com>
Date: Tue, 11 Oct 2011 16:39:05 -0700
Message-ID: <1318376345.2050.20.camel@boudreau>
Mime-Version: 1.0
Reply-To: tim@edgecast.com
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
To: kexec@lists.infradead.org


Kexec,

I have been experiencing the crash below on Ubuntu 10.04 running
2.6.32-34-server and 2.6.38-8-server as the crashkernel on X86_64.
The tools are:

kexec-tools	1:2.0.2-1ubuntu3
makedumpfile	1.3.7-2
kdump-tools	1.3.7-2

I would be interested to know if this is a known problem and if so
whether or not there is a patch in the pipeline to correct the problem.

I will be happy to provide any other details that are required including
debug builds if necessary.


Tim Hartrick
EdgeCast Networks, Inc.


[    1.322100] ioremap: invalid physical address db74000000000000
[    1.327919] ------------[ cut here ]------------
[    1.332530] WARNING:
at /build/buildd/linux-2.6.32/arch/x86/mm/ioremap.c:120 __ioremap_caller
+0x360/0x3d0()
[    1.342249] Hardware name: PowerEdge R710
[    1.346249] Modules linked in:
[    1.349306] Pid: 1, comm: swapper Not tainted 2.6.32-34-server
#77-Ubuntu
[    1.356079] Call Trace:
[    1.358523]  [<ffffffff81067c7b>] warn_slowpath_common+0x7b/0xc0
[    1.364516]  [<ffffffff81067cd4>] warn_slowpath_null+0x14/0x20
[    1.370335]  [<ffffffff81041610>] __ioremap_caller+0x360/0x3d0
[    1.376155]  [<ffffffff8103551e>] ? copy_oldmem_page+0x4e/0xc0
[    1.381974]  [<ffffffff811211d5>] ? __free_vmap_area+0xa5/0xb0
[    1.387792]  [<ffffffff81041774>] ioremap_cache+0x14/0x20
[    1.393177]  [<ffffffff8103551e>] copy_oldmem_page+0x4e/0xc0
[    1.398828]  [<ffffffff811a8b5a>] read_from_oldmem+0x7a/0xb0
[    1.404478]  [<ffffffff818aa7d0>] T.531+0x6c/0x20f
[    1.409255]  [<ffffffff8103555b>] ? copy_oldmem_page+0x8b/0xc0
[    1.415075]  [<ffffffff811a8b5a>] ? read_from_oldmem+0x7a/0xb0
[    1.420891]  [<ffffffff818aaa86>] parse_crash_elf64_headers
+0x113/0x218
[    1.427490]  [<ffffffff8103555b>] ? copy_oldmem_page+0x8b/0xc0
[    1.433309]  [<ffffffff811a8600>] ? kclist_add_private+0x0/0x180
[    1.439303]  [<ffffffff818ab0bf>] ? vmcore_init+0x0/0x75
[    1.444603]  [<ffffffff818ab01b>] parse_crash_elf_headers+0x7e/0x122
[    1.450941]  [<ffffffff818ab0e0>] vmcore_init+0x21/0x75
[    1.456158]  [<ffffffff8100a04c>] do_one_initcall+0x3c/0x1a0
[    1.461806]  [<ffffffff8188776f>] do_basic_setup+0x54/0x66
[    1.467278]  [<ffffffff8188780f>] kernel_init+0x8e/0xde
[    1.472491]  [<ffffffff8105c8fa>] ? schedule_tail+0x2a/0xb0
[    1.478052]  [<ffffffff810141aa>] child_rip+0xa/0x20
[    1.483004]  [<ffffffff81887781>] ? kernel_init+0x0/0xde
[    1.488303]  [<ffffffff810141a0>] ? child_rip+0x0/0x20
[    1.493431] ---[ end trace 93d72a36b9146f22 ]---
[    1.498037] Kdump: vmcore not initialized
[    1.657335] Freeing initrd memory: 8647k freed



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
