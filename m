Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D641C636D3
	for <kexec@archiver.kernel.org>; Tue,  7 Feb 2023 22:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Subject:To:From:
	Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=j/sfH2K/3GSI9fqhi2Wmqr6nQDNryyim/WMlhYM/ydM=; b=Y5ecf+Wm5dX2A3
	dZltGNKep5ROfQu/W4qAaAnB0v0djWM4wPvAK69HyZ1RbPbv45nOSol4uY6KN285W8kL+HSwSdj1Y
	v2uM03VzIj9BZxwkStHPg+hzH/mr+I7lQz5GejCtpLEgrk5gpcH5McGNFMXa83QY0jsankie8i87U
	FPU+FuHbwLdtZIJ3QiPs7g8BPtuvbbM/5Qj0+hqZbiOi9nStXaFyA6GIe8AlrdsEn3RohntWYUyoO
	WZ/ACTn/0X44hmYoreNoA4iWMAZMXAeFSDgOJYH6dtN0Aj3Kb5Wx8GDx89L8fp1nsCRYTquPTiVk/
	cAR9OTtX5Mi80IDoNpjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPW93-00DYGs-QL; Tue, 07 Feb 2023 22:08:57 +0000
Received: from sdaoden.eu ([217.144.132.164])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPW8z-00DYFf-Df
	for kexec@lists.infradead.org; Tue, 07 Feb 2023 22:08:55 +0000
Date: Tue, 07 Feb 2023 23:08:42 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: kexec@lists.infradead.org
Subject: question on microcode loading
Message-ID: <20230207220842.Xerbq%steffen@sdaoden.eu>
User-Agent: s-nail v14.9.24-403-gdc9ff6b368
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_140853_800484_DDB75DF0 
X-CRM114-Status: UNSURE (   5.63  )
X-CRM114-Notice: Please train this message.
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello!

First a thank you for kexec, i use it for a homegrown boot
solution, where stage1 EFI_STUB kernel is used with busybox and
cryptsetup to unlock an encrypted device, and then boots into
stage2 via kexec -- a wonderful and easy solution that makes me
happy (for years)!

A bit lengthy now.
There is only one question regarding CPU microcode loading: it
seems the microcode is not "updated early" with kexec upon "boot".
This is a homegrown kernel, with built-in firmware

  CONFIG_EXTRA_FIRMWARE="intel-ucode/06-8e-0a ..."

but also with the firmware (prefix)in(g) the initrd

    {
            # Microcode update must be uncompressed and first
            [ -f ../../boot/early-ucode.cpio ] && ./$BB cat ../../boot/early-ucode.cpio
            # Followed by (possibly compressed) normal initrd
            ./$BB find . | ./$BB cpio -H newc -o | ./$BB gzip -9 -n
    } > ../.initrd

(ie early-ucode.cpio exists) like here:

  #?0|kent:/boot# cpio -t <.kent.initrd.0
  kernel
  kernel/x86
  kernel/x86/microcode
  kernel/x86/microcode/.enuineIntel.align.0123456789abc
  kernel/x86/microcode/GenuineIntel.bin
  11020 blocks
  #?0|kent:/boot# dd if=.kent.initrd.0 skip=5642240 bs=1|gunzip|cpio -t
  .
  init
  linux-init-s1.sh
  sys
  run
  proc
  mnt
  dev
  dev/console
  bin
  bin/sh
  etc
  etc/mdev.sh
  etc/mdev.conf
  linux-init-lib.sh
  linux-init-s2.sh
  cryptsetup.static
  busybox.static
  4491733+0 records in
  4491733+0 records out
  4491733 bytes (4.5 MB, 4.3 MiB) copied, 5.67558 s, 791 kB/s
  18439 blocks

If stage2 then boots it goes like

  Feb  6 17:38:15 (none) kernel: Linux version 6.1.9-ideapad (ports@kent) (gcc (CRUX-x86_64-multilib) 12.2.0, GNU ld (GNU Binutils) 2.39) #1 SMP PREEMPT_DYNAMIC Sat Feb  4 20:40:06 CET 2023
  Feb  6 17:38:15 (none) kernel: Command line: rtw88_pci.disable_aspm=1 rc.hostname=kent
  Feb  6 17:38:15 (none) kernel: KERNEL supported cpus:
  Feb  6 17:38:15 (none) kernel:   Intel GenuineIntel
  ...
  Feb  6 17:38:15 (none) kernel: Freeing SMP alternatives memory: 48K
  Feb  6 17:38:15 (none) kernel: smpboot: CPU0: Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz (family: 0x6, model: 0x8e, stepping: 0xa)
  ..
  Feb  6 17:38:15 (none) kernel: .... node  #0, CPUs:      #1 #2 #3 #4
  Feb  6 17:38:15 (none) kernel: MDS CPU bug present and SMT on, data leak possible. See[..]
  Feb  6 17:38:15 (none) kernel: MMIO Stale Data CPU bug present and SMT on, data leak possible. See[..]
  Feb  6 17:38:15 (none) kernel:  #5 #6 #7
  Feb  6 17:38:15 (none) kernel: smp: Brought up 1 node, 8 CPUs
  Feb  6 17:38:15 (none) kernel: smpboot: Max logical packages: 1
  Feb  6 17:38:15 (none) kernel: smpboot: Total of 8 processors activated (28811.00 BogoMIPS)
  ...
  Feb  6 17:38:15 (none) kernel: Unpacking initramfs...
  ...
  Feb  6 17:38:15 (none) kernel: Freeing initrd memory: 9900K
  ...
  Feb  6 17:38:16 (none) kernel: microcode: sig=0x806ea, pf=0x80, revision=0xf0
  Feb  6 17:38:16 (none) kernel: microcode: Microcode Update Driver: v2.2.

Ie microcode comes late (SMT is later disabled)  It (seems) ok
after suspend/resume (due to
  Feb  7 01:30:12 (none) /root/bin/zzz.sh:
    echo mem > /sys/power/state
  Feb  7 20:11:26 (none) /root/bin/zzz.sh:
    echo off > /sys/devices/system/cpu/smt/control
):

  Feb  7 01:30:12 (none) kernel: PM: suspend entry (deep)
  ...
  Feb  7 20:11:23 (none) kernel: ACPI: PM: Preparing to enter system sleep state S3
  Feb  7 20:11:23 (none) kernel: ACPI: EC: event blocked
  Feb  7 20:11:23 (none) kernel: ACPI: EC: EC stopped
  Feb  7 20:11:23 (none) kernel: ACPI: PM: Saving platform NVS memory
  Feb  7 20:11:23 (none) kernel: Disabling non-boot CPUs ...
  Feb  7 20:11:23 (none) kernel: smpboot: CPU 1 is now offline
  Feb  7 20:11:23 (none) kernel: smpboot: CPU 2 is now offline
  Feb  7 20:11:23 (none) kernel: smpboot: CPU 3 is now offline
  Feb  7 20:11:23 (none) kernel: [Firmware Bug]: TSC ADJUST differs: CPU0 0 --> -720144233. Restoring
  Feb  7 20:11:23 (none) kernel: microcode: microcode updated early to revision 0xf0, date = 2021-11-12
  Feb  7 20:11:23 (none) kernel: ACPI: PM: Low-level resume complete

I wonder whether anything can be done about that.

Thank you.

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
