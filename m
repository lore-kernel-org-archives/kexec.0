Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DB3C636CC
	for <kexec@archiver.kernel.org>; Wed,  8 Feb 2023 03:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=699nqBRwMiKcXjDWR87JgFpbwcjcHggDcK1B38/IoXY=; b=WhHN7PoxoVW2RI
	qlbtkmr4nE4dHIq1v1TDcuz/grmDM1uz0f8UGl1nIfJY4PKZscQKEBSNJaAL2CujUsdt3w+3QKb/y
	ev92p38qpPybnAQs1309mJ9Q34Wyill09PKHg+PLZ0C3R88k+ZK1xQBFiFuPx6JjNBC3zF8e+xe2c
	qkCbAK4z9ZZZ726iJ8vw+d8/jJK0hEDFAb1i9vxDc+A+8XyJx5L49ccgEt2qpYsownn0+FhgGE+hX
	T7+uQngkRr7oq9FP4cdm8DriDSzsrAae0P40AJEyOlZRDoeopSty1CHkxpTeJY8FqM9zqv1UhyBGz
	NkuLxVpap4PR/RLwfavA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPb34-00Dvqu-Kc; Wed, 08 Feb 2023 03:23:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPb30-00DvqO-Ql
	for kexec@lists.infradead.org; Wed, 08 Feb 2023 03:23:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675826580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKy/o+5cZSY3/YKKP0OIsZmwMUuIuaZSjY7d+rn8ZG8=;
	b=e5PvOnxzcbddkTRPD2Vq/iWCI85Lj7l+r14N8mDGYVi7aw7Uq/kFVIVP7nEeJg87AE7ys/
	tA4tqeGON0z/AfyFMkKeHFazLMr2Xb6FkmLDG4a4BzT8hHmYxxmoI7RFPhw0vMr3g70aqv
	/LUZUSnu8hjsejVkTd9ZHwopmsqj4xY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-395khHkOPKS5E1jEM1gDVA-1; Tue, 07 Feb 2023 22:21:00 -0500
X-MC-Unique: 395khHkOPKS5E1jEM1gDVA-1
Received: by mail-il1-f200.google.com with SMTP id i23-20020a056e021d1700b003111192e89aso12049398ila.10
        for <kexec@lists.infradead.org>; Tue, 07 Feb 2023 19:21:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKy/o+5cZSY3/YKKP0OIsZmwMUuIuaZSjY7d+rn8ZG8=;
        b=Wq3lufXQGEuckqpHdru09JAvthaggPMZ2RaHfbLBRPRfdtnm4JOQeDlkRn+0YRlCm9
         b6ckIxM+7l5vREaeZWAs8ObzfP7yMjverlPKLXgly2cQFNCS0/BloUR+6RIMq80vbb3B
         N2BNiP01X4LJHCBGq5l6LT+Xuwi922H2mv1yhg4szJ12VfLT45COGUr2Ksk0eN5YKVhK
         LNz6IuvGJUJlBtCdHcrUlVaLN8fKn1LjP5Kqb5rfwJV1/8v/DZlCSEaS7acQhMEi6z1l
         SoWX5UA+h586XxqGg/U1xh3qIUQsKbaSrUKZJmvcAABM3TMV66jGCVyTTaZny6vO7ifF
         qPKQ==
X-Gm-Message-State: AO0yUKU7IhMOZmjM8SqRxtTOr9imIuhf8k6u7HgiJz71oMbDrlxyE3xH
	EHGK7UVxJdY5uTEM1qTeCVm8nEF//2HDa5hArlCYFmE66g9Q4t9CWMkEHYSYUtFHSPBUGGJ9GP4
	/OD8AAyNI5eVesC6clsXS7H+Ax9WPL7k4Ksly
X-Received: by 2002:a6b:6607:0:b0:704:56dd:23f3 with SMTP id a7-20020a6b6607000000b0070456dd23f3mr3527496ioc.14.1675826459540;
        Tue, 07 Feb 2023 19:20:59 -0800 (PST)
X-Google-Smtp-Source: AK7set/UwsZYbMlanvB4UcjI1F/JUX0gta7GPWxL7Oe1C53V1PHRQaeLjG3kAmsf4TUdJpssaERDYxGDeL1iz5xfLZM=
X-Received: by 2002:a6b:6607:0:b0:704:56dd:23f3 with SMTP id
 a7-20020a6b6607000000b0070456dd23f3mr3527492ioc.14.1675826459228; Tue, 07 Feb
 2023 19:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20230207220842.Xerbq%steffen@sdaoden.eu>
In-Reply-To: <20230207220842.Xerbq%steffen@sdaoden.eu>
From: RuiRui Yang <ruyang@redhat.com>
Date: Wed, 8 Feb 2023 11:21:13 +0800
Message-ID: <CALu+AoTogTF8rYteoJ9JTc8By9_F4k0SdrmS5bZVV_9F3AZQmQ@mail.gmail.com>
Subject: Re: question on microcode loading
To: Steffen Nurpmeso <steffen@sdaoden.eu>
Cc: kexec@lists.infradead.org, Eugene Syromiatnikov <esyr@redhat.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_192302_969375_E1B9E732 
X-CRM114-Status: GOOD (  19.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Ccing x86 and more people.

On Wed, 8 Feb 2023 at 06:09, Steffen Nurpmeso <steffen@sdaoden.eu> wrote:
>
> Hello!
>
> First a thank you for kexec, i use it for a homegrown boot
> solution, where stage1 EFI_STUB kernel is used with busybox and
> cryptsetup to unlock an encrypted device, and then boots into
> stage2 via kexec -- a wonderful and easy solution that makes me
> happy (for years)!
>
> A bit lengthy now.
> There is only one question regarding CPU microcode loading: it
> seems the microcode is not "updated early" with kexec upon "boot".
> This is a homegrown kernel, with built-in firmware
>
>   CONFIG_EXTRA_FIRMWARE="intel-ucode/06-8e-0a ..."
>
> but also with the firmware (prefix)in(g) the initrd
>
>     {
>             # Microcode update must be uncompressed and first
>             [ -f ../../boot/early-ucode.cpio ] && ./$BB cat ../../boot/early-ucode.cpio
>             # Followed by (possibly compressed) normal initrd
>             ./$BB find . | ./$BB cpio -H newc -o | ./$BB gzip -9 -n
>     } > ../.initrd
>
> (ie early-ucode.cpio exists) like here:
>
>   #?0|kent:/boot# cpio -t <.kent.initrd.0
>   kernel
>   kernel/x86
>   kernel/x86/microcode
>   kernel/x86/microcode/.enuineIntel.align.0123456789abc
>   kernel/x86/microcode/GenuineIntel.bin
>   11020 blocks
>   #?0|kent:/boot# dd if=.kent.initrd.0 skip=5642240 bs=1|gunzip|cpio -t
>   .
>   init
>   linux-init-s1.sh
>   sys
>   run
>   proc
>   mnt
>   dev
>   dev/console
>   bin
>   bin/sh
>   etc
>   etc/mdev.sh
>   etc/mdev.conf
>   linux-init-lib.sh
>   linux-init-s2.sh
>   cryptsetup.static
>   busybox.static
>   4491733+0 records in
>   4491733+0 records out
>   4491733 bytes (4.5 MB, 4.3 MiB) copied, 5.67558 s, 791 kB/s
>   18439 blocks
>
> If stage2 then boots it goes like
>
>   Feb  6 17:38:15 (none) kernel: Linux version 6.1.9-ideapad (ports@kent) (gcc (CRUX-x86_64-multilib) 12.2.0, GNU ld (GNU Binutils) 2.39) #1 SMP PREEMPT_DYNAMIC Sat Feb  4 20:40:06 CET 2023
>   Feb  6 17:38:15 (none) kernel: Command line: rtw88_pci.disable_aspm=1 rc.hostname=kent
>   Feb  6 17:38:15 (none) kernel: KERNEL supported cpus:
>   Feb  6 17:38:15 (none) kernel:   Intel GenuineIntel
>   ...
>   Feb  6 17:38:15 (none) kernel: Freeing SMP alternatives memory: 48K
>   Feb  6 17:38:15 (none) kernel: smpboot: CPU0: Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz (family: 0x6, model: 0x8e, stepping: 0xa)
>   ..
>   Feb  6 17:38:15 (none) kernel: .... node  #0, CPUs:      #1 #2 #3 #4
>   Feb  6 17:38:15 (none) kernel: MDS CPU bug present and SMT on, data leak possible. See[..]
>   Feb  6 17:38:15 (none) kernel: MMIO Stale Data CPU bug present and SMT on, data leak possible. See[..]
>   Feb  6 17:38:15 (none) kernel:  #5 #6 #7
>   Feb  6 17:38:15 (none) kernel: smp: Brought up 1 node, 8 CPUs
>   Feb  6 17:38:15 (none) kernel: smpboot: Max logical packages: 1
>   Feb  6 17:38:15 (none) kernel: smpboot: Total of 8 processors activated (28811.00 BogoMIPS)
>   ...
>   Feb  6 17:38:15 (none) kernel: Unpacking initramfs...
>   ...
>   Feb  6 17:38:15 (none) kernel: Freeing initrd memory: 9900K
>   ...
>   Feb  6 17:38:16 (none) kernel: microcode: sig=0x806ea, pf=0x80, revision=0xf0
>   Feb  6 17:38:16 (none) kernel: microcode: Microcode Update Driver: v2.2.
>
> Ie microcode comes late (SMT is later disabled)  It (seems) ok
> after suspend/resume (due to
>   Feb  7 01:30:12 (none) /root/bin/zzz.sh:
>     echo mem > /sys/power/state
>   Feb  7 20:11:26 (none) /root/bin/zzz.sh:
>     echo off > /sys/devices/system/cpu/smt/control
> ):
>
>   Feb  7 01:30:12 (none) kernel: PM: suspend entry (deep)
>   ...
>   Feb  7 20:11:23 (none) kernel: ACPI: PM: Preparing to enter system sleep state S3
>   Feb  7 20:11:23 (none) kernel: ACPI: EC: event blocked
>   Feb  7 20:11:23 (none) kernel: ACPI: EC: EC stopped
>   Feb  7 20:11:23 (none) kernel: ACPI: PM: Saving platform NVS memory
>   Feb  7 20:11:23 (none) kernel: Disabling non-boot CPUs ...
>   Feb  7 20:11:23 (none) kernel: smpboot: CPU 1 is now offline
>   Feb  7 20:11:23 (none) kernel: smpboot: CPU 2 is now offline
>   Feb  7 20:11:23 (none) kernel: smpboot: CPU 3 is now offline
>   Feb  7 20:11:23 (none) kernel: [Firmware Bug]: TSC ADJUST differs: CPU0 0 --> -720144233. Restoring
>   Feb  7 20:11:23 (none) kernel: microcode: microcode updated early to revision 0xf0, date = 2021-11-12
>   Feb  7 20:11:23 (none) kernel: ACPI: PM: Low-level resume complete
>
> I wonder whether anything can be done about that.
>
> Thank you.
>
> --steffen
> |
> |Der Kragenbaer,                The moon bear,
> |der holt sich munter           he cheerfully and one by one
> |einen nach dem anderen runter  wa.ks himself off
> |(By Robert Gernhardt)
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
