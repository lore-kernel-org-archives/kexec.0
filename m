Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OuHew-0005mF-Bk
	for kexec@lists.infradead.org; Sat, 11 Sep 2010 04:25:51 +0000
Date: Sat, 11 Sep 2010 00:25:48 -0400 (EDT)
From: caiqian@redhat.com
Message-ID: <652751907.729931284179148661.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1780019082.729911284179131961.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [GIT PULL] Please pull x86 biarch crashdump support and misc devel
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Simon Horman <horms@verge.net.au>, Kexec Mailing List <kexec@lists.infradead.org>


> I have fixed the wrong variable problem and I also spotted another
> architecture test in crashdump-x86e that would only work on i386, and
> fixed that.
> 
> The new version is up at:
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/kexec-tools-devel.git
# /sbin/kexec -p '--command-line=ro root=/dev/mapper/vg_intels3e3601-lv_root rd_LVM_LV=vg_intels3e3601/lv_root rd_LVM_LV=vg_intels3e3601/lv_swap rd_NO_LUKS rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us console=ttyS0,115200n81 irqpoll maxcpus=1 reset_devices cgroup_disable=memory sysrq_always_enabled ' --initrd=/boot/initrd-2.6.32-71.el6.bz623007.x86_64kdump.img /boot/vmlinuz-2.6.32-71.el6.bz623007.x86_64
Segmentation fault (core dumped)

(gdb) bt
#0  0x0000000000000001 in ?? ()
#1  0x0000000000406eb7 in crash_create_elf64_headers (info=0x7fffae61c880, elf_info=0x7fffae6144b0, range=0x635ec0, ranges=21, buf=<value optimized out>, 
    size=0x7fffae6144b0, align=1024) at kexec/crashdump-elf.c:147
#2  0x000000000040b2e0 in load_crashdump_segments (info=0x7fffae61c880, 
    mod_cmdline=0x1645150 "ro root=/dev/mapper/vg_intels3e3601-lv_root rd_LVM_LV=vg_intels3e3601/lv_root rd_LVM_LV=vg_intels3e3601/lv_swap rd_NO_LUKS rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc "..., max_addr=18446744073709551615, min_base=0)
    at kexec/arch/i386/crashdump-x86.c:772
#3  0x0000000000408526 in do_bzImage_load (info=0x7fffae61c880, kernel=0x7fb6382ff010 "\352\005", kernel_len=3791104, 
    command_line=0x1645010 "ro root=/dev/mapper/vg_intels3e3601-lv_root rd_LVM_LV=vg_intels3e3601/lv_root rd_LVM_LV=vg_intels3e3601/lv_swap rd_NO_LUKS rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc "..., command_line_len=312, initrd=0x7fb637ebc010 "\037\213\b", initrd_len=4466561, 
    real_mode_entry=0, debug=0) at kexec/arch/i386/kexec-bzImage.c:186
#4  0x00000000004086fa in bzImage_load (argc=<value optimized out>, argv=<value optimized out>, buf=0x7fb6382ff010 "\352\005", len=3791104, 
    info=0x7fffae61c880) at kexec/arch/i386/kexec-bzImage.c:402
#5  0x0000000000402879 in my_load (type=0x0, fileind=<value optimized out>, argc=5, argv=0x7fffae61cb98, kexec_flags=<value optimized out>, entry=0x0)
    at kexec/kexec.c:724
#6  0x0000000000403357 in main (argc=5, argv=0x7fffae61cb98) at kexec/kexec.c:1208

> 
> So if you want to live on the bleeding edge and see if I have fixed
> all of my thinkos you can test that.
> 
> I hope this gets the weird biarch software architecture right
> finally.
> 
> Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
