Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C08CA0FFD
	for <kexec@archiver.kernel.org>; Wed, 27 Aug 2025 08:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=itUnoaFqfbQDsJKy5iAP7CimhLmDmHDeVSdAY05Jcqk=; b=kWpMW76+lIwYpYXi3gxDCM9CVS
	c7f6y7cE0HEpDs5EZtQTkctQSU0ycfNETVut7qQg80nwp2zLRpjxjpMrlhn+Epzd6rixg/o/MPqWI
	I0hjiRF9HLFS/P1xd65EbCk1VW74aUUKdxZLhmnAsnj/GDQ5gjCagJZgsb/CWV09AmEF55PdMy+mr
	WZR/nt61p/07VK/OY2iWTTNrkQpwJMlOWru/5YadH3/Q55DZxne6uyh60hepoo39ssvMExs5rCyJl
	4LvHSQEZhsP396XFbb4VPNA1IuE48gF4FNTrXfowJg5e4hFRn2P/KaldQOBshKCjPfu3pgqHBECDG
	/c33In8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urBdU-0000000Egtf-0UXJ;
	Wed, 27 Aug 2025 08:36:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urBOu-0000000EdfA-26Y1
	for kexec@lists.infradead.org;
	Wed, 27 Aug 2025 08:21:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756282859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=itUnoaFqfbQDsJKy5iAP7CimhLmDmHDeVSdAY05Jcqk=;
	b=bEGznmEXDwDYit4HbBnFhKsU8NcSIGP/LM0CGTQCpCYiXUgA+E3pZGxm7Suc2CvGexvXgJ
	lLUewUxT79Hl+w6/NiAqk4H8iaSS3GFJFVdpdudnSh45USgE566oEe7qVpZrqU5koApGff
	OFWN17XIV+rHusqOakVF4gPIewzuivQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-Lop7fnCuMfWym4RZFBsqaQ-1; Wed, 27 Aug 2025 04:20:56 -0400
X-MC-Unique: Lop7fnCuMfWym4RZFBsqaQ-1
X-Mimecast-MFC-AGG-ID: Lop7fnCuMfWym4RZFBsqaQ_1756282855
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7720b00a313so351281b3a.1
        for <kexec@lists.infradead.org>; Wed, 27 Aug 2025 01:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756282855; x=1756887655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itUnoaFqfbQDsJKy5iAP7CimhLmDmHDeVSdAY05Jcqk=;
        b=RQ4+NR9ESL7UypmApuAHyARncn8tRnNh1n5KBNh2b18iR82QPqtHV5Cn504/ynVAPO
         aaLzj2Kz9hSJHenDPsN8HzoUjmFEffgsuT02iyG/SGkSe/3FTyEaU3TCg0Vn/mCXDJId
         CuUSLJ+eb7KGgurIyD6qNkfRzCGJR5u+YTijMmFl1dWdFOy9G8TwBFIRd6D0DAbX5iLn
         FQCIth67//p8eyAaJXSwi3f4Q6Hh3mfeufEXB5FUvO3TlCUs/MR0YJLiotD/TBIlRtmq
         ZYMH5N5Nhnv8zzTqPsEpA3lJ7CMqgUzPdA5H3sF/Ycv2aFMzWGcCVbihlEgJkSzl2QfL
         Zr2w==
X-Forwarded-Encrypted: i=1; AJvYcCUcux8I/9YuVsA+rkIuP8CAlZXf2tfNhme0uU+FMWf6flyYfWarD3f7FcwR6MkmIJlyNXALvA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxcnnF7JuD01+MPK+07Bvyp3L/PxCGqECp8HDoDIclbbD8k5gv5
	yfB2GXq1kyWDRUzEce1H4vAwuky9Pe7qJmNZThztm392NC30e2ROLmqwML1Zx8xGplLGvD9DxnU
	YbPIKsLIhXSB9iRDnBHqZSyxU4gpii5au1uaLP5JhPFEZNfdGJcXfSsea3iNftA==
X-Gm-Gg: ASbGnct3f/7vLSkhqsWpcc44P+F3d0Hz2eBgfs0r9hiq1o4CqtO0RmwGuAp7FfcGZHL
	8TGlnlVmkeDjLC86Om6vXyeTbBb1sZImOa3XlP0w+FS1F1mI/9Gl4e7jsu0nvrKKayQJQJJ/0Gf
	21B0H3EXxqJdwSFv/OH6YnBBQRYspUV3YgQU+6pEUR1J8FB3sxPmhwUDZuGA/nZNvfboXmbtfH8
	g5TO0ptwOLisdCPcMRENjtFzQwTKJ1dys5Cx0//iGNdEHfHAWJOby+nXV/xazC+fCTSU/691d+8
	QwbIEQXillzbzTtaQuLvVlHhNv49d+M=
X-Received: by 2002:a05:6a20:3949:b0:240:10d2:add2 with SMTP id adf61e73a8af0-24340d0244amr27008079637.31.1756282855134;
        Wed, 27 Aug 2025 01:20:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2FJN8dt6Gdj10YjTZnHD4mWZmsq42NC+Hy4iGGo/P8vtVLMd8cGd0cyzQQ5JOahSfz6NXfg==
X-Received: by 2002:a05:6a20:3949:b0:240:10d2:add2 with SMTP id adf61e73a8af0-24340d0244amr27008051637.31.1756282854686;
        Wed, 27 Aug 2025 01:20:54 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7720c63d660sm644421b3a.71.2025.08.27.01.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 01:20:54 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:17:28 +0800
From: Coiby Xu <coxu@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	jbastian@redhat.com, cmirabil@redhat.com
Subject: Re: [Regression] kdump fails to get DHCP address unless booting with
 pci=nomsi or without nr_cpus=1
Message-ID: <r3k7yvv3ezpmudnmqphlpx56lvd43gabqcaewucwfzsgcwopml@s7zm2cmeifug>
References: <878qjq80yu.ffs@tglx>
 <86v7mt9ai3.wl-maz@kernel.org>
 <i2l2ujhqjd6akzosvzj4njv2vemsfuvywz4gsnj2nwo3fwyjyz@cfhekxpartf2>
 <86ms84974v.wl-maz@kernel.org>
 <gec2yl5wx6vvt67smx5emhcoifvtp4orw6sub24b2nrqwryhp2@i4h7qbtwjo3r>
 <86ldno8yxa.wl-maz@kernel.org>
 <yweverlt7onyse3rbm7phxzwrwfk4pq2dipzdjenrx4onrak6r@dsm4ra3x3gv6>
 <j4atkwhumotioe2nhu6esrb3yrvwsoz2eyqeopwmr7o6iw65ga@wdkvgahnyhln>
 <87qzx6jrql.wl-maz@kernel.org>
 <p7aa2fcm3g32ydulq3nqrvsg57tyvt5ro5cs3oqrdahxesoroj@tqpulky4drlo>
MIME-Version: 1.0
In-Reply-To: <p7aa2fcm3g32ydulq3nqrvsg57tyvt5ro5cs3oqrdahxesoroj@tqpulky4drlo>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jg_GyG_GxCrhLFmd8tG2D98JLsdK7NVAN7lrMzU_2Go_1756282855
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_012100_609291_650A8D05 
X-CRM114-Status: GOOD (  24.98  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sat, Aug 23, 2025 at 11:00:11AM +0800, Coiby Xu wrote:
>Hi Marc,
>
>If I understand correctly, you want to reproduce the issue by yourself.
>Then finally I manage to reproduce this issue by playing with the setup
>shared by my collogue. Here are the five prerequisites to reproduce the
>bug,

Hi Marc,

It turns out host kernel and host machine are not absolute prerequisites to
reproduce the problem. But they matter because they can make it much
more difficult to reproduce this problem. I also did a bisection against
QEMU to find out which commit make the issue gone. For details, please
check following inline comments.

>
>1. Guest kernel    Newer than commit b5712bf89b4b 
>("irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]")
>
>2. Host kernel
>   Relatively older ones like v6.10.0. Newer ones like v6.12.0 and
>   v6.17.0 don't have this issue.

It turns out with other conditions met, the latest host kernel
(6.17.0-0.rc3) can still reproduce the issue but it's much more
difficult to reproduce it. For example, with RHEL8 kernel
4.18.0-372.9.1.el8.aarch64, I need to trigger kernel crash for 3
times at maximum to reproduce it. But for Fedora rawhide kernel
6.17.0-0.rc3.31.fc43.aarch64, 3/10 times I can't reproduce this issue
after triggering kernel crash for 60 consecutive times. For a
comparison, I've listed the times of triggering kernel crash to reproduce
the issue in 10 trials,

RHEL8:           2  1  1  1  1  1  2  1  3  2
Fedora rawhide: 43 60 47 60 12 56 60 45 49 18

>
>3. QEMU <= v6.2

I did a bisection and it shows the issue is gone with QEMU commit
f39b7d2b96e3e73c01bb678cd096f7baf0b9ab39 ("kvm: Atomic memslot updates")
which is last/3rd patch of patch set "KVM: allow listener to stop all
vcpus before"
https://lists.nongnu.org/archive/html/qemu-devel/2022-11/msg02172.html
Note this commit shows in QEMU > 7.2 so QEMU <= v7.2.0 can also
reproduce this issue.

>
>4. Specific host machines    I'm not familiar with the hardware so 
>currently I haven't figured out
>   what hardware factor makes the issue reproducible. I've attached
>   dmidecode outputs of four machines (files inside indmidecode_host folder).
>   Two systems (dmidecode_not_work*) can reproduce this issue and the
>   other two systems (dmidecode_work*) can't despite all have the same
>   product name R152-P31-00, CPU model ARMv8 (M128-30) and SKU
>   01234567890123456789AB. One difference that doesn't seem to found in
>   the dmidecode output is the two machines that can't reproduce the issue
>   have the model name "PnP device PNP0c02" where the problematic
>   machines have "R152-P31-00 (01234567890123456789AB)" according to our
>   internal web pages that show the hardware info.

It turns out all four machines can reproduce the issue. I tried to
reproduce this issue for 10 times and counted the times to trigger
kernel crash and here's a comparison

R152-P31-00:        2  1 1  1  1  1 2 1  3 2 
PnP device PNP0c02: 8  3 5 15 11 18 2 5 12 4 

>
>5. The Guest needs to be bridged to a physical host interface.    
>Bridging the guest to tun interface can't reproduce the issue (for
>   example, the default bridge (virbr0) created by libvirtd uses tun
>   interface)

I tried triggering kernel crash for 100 consecutive times for virbr0 in
one trial but can't reproduce it. So I think bridging the guest to a
physical network interface is still a must.


[...]


-- 
Best regards,
Coiby


