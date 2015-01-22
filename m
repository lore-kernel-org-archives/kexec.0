Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YEOiE-0004Q4-Fq
 for kexec@lists.infradead.org; Thu, 22 Jan 2015 20:50:47 +0000
Received: from zmail15.collab.prod.int.phx2.redhat.com
 (zmail15.collab.prod.int.phx2.redhat.com [10.5.83.17])
 by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id t0MKoOFQ027635
 for <kexec@lists.infradead.org>; Thu, 22 Jan 2015 15:50:24 -0500
Date: Thu, 22 Jan 2015 15:50:24 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1765458944.16558276.1421959824481.JavaMail.zimbra@redhat.com>
In-Reply-To: <mailman.5.1421956801.918.kexec@lists.infradead.org>
References: <mailman.5.1421956801.918.kexec@lists.infradead.org>
Subject: Re: Failure to crashdump under Centos-6.4 x86_64 with kernel 3.12.30
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org



----- Original Message -----

> My kernel crashdumps don't work with vanilla 3.12.30 on a 256GB x86_64 intel box.
> Centos-6.4. With the standard makedumpfile, makedumpfile segfaults, and no output is written to disk.
> with makedumpfile 1.5.7, kexec-tools-2.0.8, and crash 7.0.2 I actually get vmcore files,
> but then crash rejects them with:
> 
> crash vmcore /boot/vmlinux-3.12.30
> 
> crash 7.0.2
> ...
> GNU gdb (GDB) 7.6
> ...
> 
> crash: seek error: kernel virtual address: ffff88207fffcb60  type: "pglist node_id"

With respect to the crash error, since it's a seek error, it means that the page for
physical address 0x207fffcb60 (~130GB) is not included in the dumpfile.  Are you getting any 
other error messages prior to that one?  Getting some debug output might show something
else of interest, for example by entering:

  $ crash -d4 vmcore /boot/vmlinux-3.12.30

Also, for a sanity check, what happens when you do this: 

  $ crash --minimal vmcore /boot/vmlinux-3.12.30
  ...
  crash> rd -a linux_banner 

It should show something like this (taken from the only 3.12 dumpfile I have):

  crash> rd -a linux_banner
  ffffffff818000a0:  Linux version 3.12.0-rc2+ (root@vm9-f19) (gcc version 4.8.1 
  ffffffff818000dc:  20130603 (Red Hat 4.8.1-1) (GCC) ) #2 SMP Wed Nov 6 13:25:13
  ffffffff81800118:   EST 2013
  crash> 

Dave 

 
> 
> the grub entry for this kernel is:
>      kernel /boot/vmlinuz-3.12.30 ro root=LABEL=ROOT
> numa_balancing=disable intel_idle.max_cstate=0 processor.max_cstate=0
> mce=ignore_mce clocksource=tsc nohz=off nomodeset nodmraid rd_NO_LUKS
> rd_NO_LVM rd_NO_MD rd_NO_DM LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16
> KEYBOARDTYPE=pc KEYTABLE=us crashkernel=256M@256M  console=ttyS1,115200n8
> 
> 
> CONFIG_CRASH_DUMP=y
> CONFIG_KEXEC_JUMP=y
> CONFIG_PHYSICAL_START=0x2000000
> CONFIG_RELOCATABLE=y
> CONFIG_PHYSICAL_ALIGN=0x1000000
> 
> A similar issue appears with a grub crashkernel=128M@32M
> 
> Turning off all the makedumpfile exclusions (dump all pages) results in a much larger
> vmcore, but it still gets the same failures.
> 
> Where do I start looking for the problems here?
> kernel 3.10.65 won't dump either, but an old 3.0.29 kernel dumps just fine.
> Is this a problem with some .config setting?
> 
> Berkley

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
