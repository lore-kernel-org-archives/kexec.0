Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9C9C4332F
	for <kexec@archiver.kernel.org>; Mon,  7 Nov 2022 06:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MOUcqrYVqhiuipNzAhiu3BoO79IGVrBMwXvXAm91t/A=; b=yGf4Zgnzxr8d92
	8Z4KLTzXpHC5ymXdiVYl/3Lis2H32QA9VdwMFO6z9uTI9SOOACaHcE2PbAla5070A2c+sktloFBL9
	F7fbuyOVQJ90Hgzy/3d0Coh+MntF206scq4COrEjKTvRDXyL2POGan6brpNzr0gjKh5Dbt09kNgvS
	L4by2E5N8hrgQ7nkYH1Hrqe1vAeGO0ZAha28nmUUry/kxy94qxFdAyT1rlG4ymGH+VDQeSxKzdlCe
	XVw7aeh6RyXhRgCh05gZB1V6+4tUyLAdP9+Qgc6dU6HfMnlvrhKHC+LRj8mpCG8+p0NUV2J9BFeB0
	R4Madp4hInpX1gn+a4nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orw2a-00CCWN-VE; Mon, 07 Nov 2022 06:55:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orw2Q-00CCVC-DF
	for kexec@lists.infradead.org; Mon, 07 Nov 2022 06:55:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667804112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y18m8azyHOn5Ibl6TKD7X9UraJRtgy45vbRa6wrCY5k=;
	b=costeaCCyaZRD2q38KINlbWp/COWJRR9AzOO/wainKRgqxSsuqzBCFmnaAGOMsPI1QeHjb
	znOpj/L4uSEHdZXi2gL2GZXdoTKZQXAMkwIwnK/QsKLPZQW9nroE4uhhBjh6LAiZbrZVwm
	5vDJhfhy3HzsSWPV0n2EV8C06O9v4ec=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-MOKVxNP8MaKpLHqKTTeStg-1; Mon, 07 Nov 2022 01:55:10 -0500
X-MC-Unique: MOKVxNP8MaKpLHqKTTeStg-1
Received: by mail-ed1-f70.google.com with SMTP id z9-20020a05640235c900b0046358415c4fso7574161edc.9
        for <kexec@lists.infradead.org>; Sun, 06 Nov 2022 22:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y18m8azyHOn5Ibl6TKD7X9UraJRtgy45vbRa6wrCY5k=;
        b=LnOMTvk8NLKCBU2nrHIJofCpr5huLDKfgErlp3ju2OPlENMLFentRacsVovwlRM3po
         31IWNX6BUERChshPZB3djvlaRuPcFnKvVRb+S6SDm2jmSa67wnFY0BEx5bSPlf8CDQsT
         S61xhkPibMAqtl3Eo5FJ+ei+l0s+PZmXLo9p/xyicV5daugU/K6qdNfK12opEJ8rmqjv
         fHHyAvhyB1IpChTQ6jMy2xIQVS84MYoDfCCSBEk4T7fRRnQTgkJlzYH8rzvmO1sjNfzH
         6JwoIkFWnT7RwnzH6V/3BaSmALUFajNrw9vXCgF79U08qm3jb5oXZ9f11oCWIPnRPZGd
         S6Eg==
X-Gm-Message-State: ANoB5pkAERUzUqfcSrd45ULl/yyw1GDEapnRXDSSpfOEUl1EG51AELGl
	0ueMLzpFTAsQuisQ8HNaDMSWMzAh02jnm7UB74A+JAIH+Q1rc3M3q4R4e25C1iugDw7whr2q7Bs
	YM+7CldoO05/vX1pYcbaIkI37xr1TWRrXLd1J
X-Received: by 2002:a17:906:3ada:b0:7ae:566e:3a1c with SMTP id z26-20020a1709063ada00b007ae566e3a1cmr8250025ejd.223.1667804108999;
        Sun, 06 Nov 2022 22:55:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6uXDuXJgOmXAKWQ2kw35atMalXsKsAYB/O9QnMHiEi9sGLW0X78hBV93ehTpTac+itcHRs4D2V0w/vPKwvWQE=
X-Received: by 2002:a17:906:3ada:b0:7ae:566e:3a1c with SMTP id
 z26-20020a1709063ada00b007ae566e3a1cmr8250014ejd.223.1667804108772; Sun, 06
 Nov 2022 22:55:08 -0800 (PST)
MIME-Version: 1.0
References: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf> <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
 <CALu+AoTVtO=-tzbgjeVRQ3uO0yGUPWKPuAiLn0CpaAq_=xr-sw@mail.gmail.com> <2f43e1e583a92e1592c48a15a763e1f7@tfwno.gf>
In-Reply-To: <2f43e1e583a92e1592c48a15a763e1f7@tfwno.gf>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 7 Nov 2022 14:54:31 +0800
Message-ID: <CALu+AoQqb23tnNS6VY4+Q5Mz85NDFfWOP_aynoz7fcoMvzNeKg@mail.gmail.com>
Subject: Re: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
To: ns@tfwno.gf
Cc: Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221106_225518_567126_D21D3ADF 
X-CRM114-Status: GOOD (  46.10  )
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

Hi,

On Sat, 5 Nov 2022 at 22:16, <ns@tfwno.gf> wrote:
>
> On 2022-11-05 05:49, Dave Young wrote:
> > Baoquan, thanks for cc me.
> >
> > On Sat, 5 Nov 2022 at 11:10, Baoquan He <bhe@redhat.com> wrote:
> >>
> >> Add Dave to CC
> >>
> >> On 10/28/22 at 01:02pm, ns@tfwno.gf wrote:
> >> > Greetings,
> >> >
> >> > I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
> >> > cause EFI mode (if that's the right term for it) to be unconditionally
> >> > disabled, even when not using the --noefi option to kexec.
> >> >
> >> > What I mean by "EFI mode" being disabled, more than just EFI runtime
> >> > services, is that basically nothing about the system's EFI is visible
> >> > post-kexec. Normally you have a message like this in dmesg when the
> >> > system is booted in EFI mode:
> >> >
> >> > [    0.000000] efi: EFI v2.70 by EDK II
> >> > [    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 2.0=0x7fb7e014
> >> > MEMATTR=0x7ec63018
> >> > (obviously not the real firmware of the machine I'm talking about, but I
> >> > can also send that if it would be of any help)
> >> >
> >> > No such message pops up in my dmesg as a result of this bug, & this
> >> > causes some fallout like being unable to find the system's DMI
> >> > information:
> >> >
> >> > <6>[    0.000000] DMI not present or invalid.
> >> >
> >> > The efivarfs module also fails to load with -ENODEV.
> >> >
> >> > I've tried also booting with efi=runtime explicitly but it doesn't
> >> > change anything. The kernel still does not print the name of the EFI
> >> > firmware, DMI is still missing, & efivarfs still fails to load.
> >> >
> >> > I've been using the kexec_load syscall for all these tests, if it's
> >> > important.
> >> >
> >> > Also, to make it very clear, all this only ever happens post-kexec. When
> >> > booting straight from UEFI (with the EFI stub), all the aforementioned
> >> > stuff that fails works perfectly fine (i.e. name of firmware is printed,
> >> > DMI is properly found, & efivarfs loads & mounts just fine).
> >> >
> >> > This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
> >> > bisect it, but it seems like it goes pretty far back. I've got vanilla
> >> > mainline kernel builds dating back to 5.17 that have the exact same
> >> > issue. It might be worth noting that during this testing, I made sure
> >> > the version of the kernel being kexeced & the kernel kexecing were the
> >> > same version. It may not have been a problem in older kernels, but that
> >> > would be difficult to test for me (a pretty important driver for this
> >> > machine was only merged during v5.17-rc4). So it may not have been a
> >> > regression & just a hidden problem since time immemorial.
> >> >
> >> > I am willing to test any patches I may get to further debug or fix
> >> > this issue, preferably based on the current state of torvalds/linux.git.
> >> > I can build & test kernels quite a few times per day.
> >> >
> >> > I can also send any important materials (kernel config, dmesg, firmware
> >> > information, so on & so forth) on request. I'll also just mention I'm
> >> > using kexec-tools 2.0.24 upfront, if it matters.
> >
> > Can you check the efi runtime in sysfs:
> > ls /sys/firmware/efi/runtime-map/
> >
> > If nothing then maybe you did not enable CONFIG_EFI_RUNTIME_MAP=y, it
> > is needed for kexec UEFI boot on x86_64.
>
> Oh my, it really is that simple.
>
> Indeed, enabling this in the pre-kexec kernel fixes it all up. I had
> blindly disabled it in my quest to downsize the pre-kexec kernel to
> reduce boot time (it only runs a bootloader). In hindsight, the firmware
> drivers section is not really a good section to tweak on a whim.
>
> I'm terribly sorry to have taken your time to "fix" this "bug". But I
> must ask, is there any reason why this is a visible config option, or at
> least not gated behind CONFIG_EXPERT? drivers/firmware/efi/runtime-map.c
> is pretty tiny, & considering it depends on CONFIG_KEXEC_CORE, one
> probably wants to have kexec work properly if they can even enable it.

Glad to know it works with the .config tweaking. I can not recall any
reason for that though.

Since it sits in the efi code path, let's see how Ard thinks about
your proposal.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
