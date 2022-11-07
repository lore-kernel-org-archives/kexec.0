Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226B2C433FE
	for <kexec@archiver.kernel.org>; Mon,  7 Nov 2022 07:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n+WstjKzIlc/RHd8mXGbmLYnyetVmTsIyj0R89IT7K0=; b=lQhToa8Mwy77d8
	TnUy0PBExZmAjevC0bRT/w0IFsVL76CHn0hIclYUp64nAOU7j8Qyq+XTsTfWFzrCVhgPPj0AjzBfj
	AjkSNRf6l/weAkxfCwrwihdcV3nQDhniJ5XlBfm5Mo1gvnEe73ReFgsGuzGNkkmmTVKJWxodmnrIG
	A5cY0I8dhPgcDs0r5aIc55DIKc0MK3Zu73JpCORcClSxGTnUcMEMyuJbxn3GywMqgonDZTJydUn1F
	x4tl7ozoat7DjL06sNp+JC+qfBxu5YOX31w9jHLT67cPCIlIRFfFrlnbmpTrkzUP08g+xRxhPlpds
	9Hg/5JZ48Ge3XEmwADYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orwjn-00CTgX-6l; Mon, 07 Nov 2022 07:40:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orwjf-00CTdl-Gh
	for kexec@lists.infradead.org; Mon, 07 Nov 2022 07:40:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667806798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gqTH/IxvvklYXKMEdnIMrBW3qua+LAhrbLqR4JyUT5Y=;
	b=DgPddmXsZRjIKVlvsWt0s3Q1k3wd9nqK0erxuzzwHr9nvgCErdyvf+IulACckTOchD9S/6
	FlKG+ZuL0KWnW313yPrgnNVpaeRYv7RgQ5zR4DFceOMx9d2SRe+obMAOThNT3pHN7fkHn8
	rAOzrcRBJJ2lPL2aFMr0gwZvOJ7mXos=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-ZBRqXBSfNsCui2ovNBNaEw-1; Mon, 07 Nov 2022 02:39:57 -0500
X-MC-Unique: ZBRqXBSfNsCui2ovNBNaEw-1
Received: by mail-ej1-f69.google.com with SMTP id hp16-20020a1709073e1000b007adf5a83df7so5812159ejc.1
        for <kexec@lists.infradead.org>; Sun, 06 Nov 2022 23:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqTH/IxvvklYXKMEdnIMrBW3qua+LAhrbLqR4JyUT5Y=;
        b=wyWmqQ0WRwhCPK/aDPNYrG4Lf83L6b2xA4WIjTSPbdTSUVGaIqSZw6ZKZwnHKn/EGt
         rf5HFtrzjDejrethnKlHtKXCu6acRFVmopx4h2In/caJAKXvd6WlC/nocOLX4qwocDfC
         GYGUlH17zY2p75ZLv36lCMW1r/EfEjGrqQHjpia4N5TxpjcggrAYhQUdHciWigCkuufp
         cHqOfvVxstYBXmFfxEcUQyo3bYRYPtUJkJbeUoW6XNS3JyyzZCUTBdX8dflIUOIjeLR1
         bzlx04rikKtk2Qn2PWymWt0eqtCSB157iWUP849gN0+bEZPYPSiS26iWkkfy/A/IYFxx
         kRNA==
X-Gm-Message-State: ANoB5pkyE/Qt19InWCiu/Nf+RrG3gR/M0V19CARY3dRqogF7yG0YHMAd
	zNzX2BwL1kHcw4VudTOohUzNyo0WykCMZWp0Mum1E54BnOkKlir9URnvUu/zQjHkZARdk1U+ruA
	saIcIMCz8z/gjmrUBM/FkPurB8J99S1WIjJ96
X-Received: by 2002:aa7:d385:0:b0:461:8cd3:b38b with SMTP id x5-20020aa7d385000000b004618cd3b38bmr10532982edq.172.1667806796350;
        Sun, 06 Nov 2022 23:39:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6kEcP7IRVZbDPlLZz1yB6QJ3FRoM6CZNsHc+5ZoCmUj79D76jdLuYBr+2+StZs/5kxjL+vZjuSVSNBbtEMAwc=
X-Received: by 2002:aa7:d385:0:b0:461:8cd3:b38b with SMTP id
 x5-20020aa7d385000000b004618cd3b38bmr10532968edq.172.1667806796080; Sun, 06
 Nov 2022 23:39:56 -0800 (PST)
MIME-Version: 1.0
References: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf> <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
 <CALu+AoTVtO=-tzbgjeVRQ3uO0yGUPWKPuAiLn0CpaAq_=xr-sw@mail.gmail.com>
 <2f43e1e583a92e1592c48a15a763e1f7@tfwno.gf> <CALu+AoQqb23tnNS6VY4+Q5Mz85NDFfWOP_aynoz7fcoMvzNeKg@mail.gmail.com>
 <CAMj1kXGyo7q1Jgkw8RAfiiyLpe8GAvsWT+jEt4DM-1W9Qf7oUQ@mail.gmail.com> <CALu+AoQeraV2fLx_6q_76rdUXdsY6wYVMNU0o_VVuXLyfqiDNA@mail.gmail.com>
In-Reply-To: <CALu+AoQeraV2fLx_6q_76rdUXdsY6wYVMNU0o_VVuXLyfqiDNA@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 7 Nov 2022 15:39:18 +0800
Message-ID: <CALu+AoTJeMry54KmSWooP5Jm3t0EqCxOid_GzfU51KQmXUYp8Q@mail.gmail.com>
Subject: Re: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
To: Ard Biesheuvel <ardb@kernel.org>
Cc: ns@tfwno.gf, Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221106_233959_667888_D94F941B 
X-CRM114-Status: GOOD (  61.91  )
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

On Mon, 7 Nov 2022 at 15:36, Dave Young <dyoung@redhat.com> wrote:
>
> Hi Ard,
>
> On Mon, 7 Nov 2022 at 15:30, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 7 Nov 2022 at 07:55, Dave Young <dyoung@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On Sat, 5 Nov 2022 at 22:16, <ns@tfwno.gf> wrote:
> > > >
> > > > On 2022-11-05 05:49, Dave Young wrote:
> > > > > Baoquan, thanks for cc me.
> > > > >
> > > > > On Sat, 5 Nov 2022 at 11:10, Baoquan He <bhe@redhat.com> wrote:
> > > > >>
> > > > >> Add Dave to CC
> > > > >>
> > > > >> On 10/28/22 at 01:02pm, ns@tfwno.gf wrote:
> > > > >> > Greetings,
> > > > >> >
> > > > >> > I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
> > > > >> > cause EFI mode (if that's the right term for it) to be unconditionally
> > > > >> > disabled, even when not using the --noefi option to kexec.
> > > > >> >
> > > > >> > What I mean by "EFI mode" being disabled, more than just EFI runtime
> > > > >> > services, is that basically nothing about the system's EFI is visible
> > > > >> > post-kexec. Normally you have a message like this in dmesg when the
> > > > >> > system is booted in EFI mode:
> > > > >> >
> > > > >> > [    0.000000] efi: EFI v2.70 by EDK II
> > > > >> > [    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 2.0=0x7fb7e014
> > > > >> > MEMATTR=0x7ec63018
> > > > >> > (obviously not the real firmware of the machine I'm talking about, but I
> > > > >> > can also send that if it would be of any help)
> > > > >> >
> > > > >> > No such message pops up in my dmesg as a result of this bug, & this
> > > > >> > causes some fallout like being unable to find the system's DMI
> > > > >> > information:
> > > > >> >
> > > > >> > <6>[    0.000000] DMI not present or invalid.
> > > > >> >
> > > > >> > The efivarfs module also fails to load with -ENODEV.
> > > > >> >
> > > > >> > I've tried also booting with efi=runtime explicitly but it doesn't
> > > > >> > change anything. The kernel still does not print the name of the EFI
> > > > >> > firmware, DMI is still missing, & efivarfs still fails to load.
> > > > >> >
> > > > >> > I've been using the kexec_load syscall for all these tests, if it's
> > > > >> > important.
> > > > >> >
> > > > >> > Also, to make it very clear, all this only ever happens post-kexec. When
> > > > >> > booting straight from UEFI (with the EFI stub), all the aforementioned
> > > > >> > stuff that fails works perfectly fine (i.e. name of firmware is printed,
> > > > >> > DMI is properly found, & efivarfs loads & mounts just fine).
> > > > >> >
> > > > >> > This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
> > > > >> > bisect it, but it seems like it goes pretty far back. I've got vanilla
> > > > >> > mainline kernel builds dating back to 5.17 that have the exact same
> > > > >> > issue. It might be worth noting that during this testing, I made sure
> > > > >> > the version of the kernel being kexeced & the kernel kexecing were the
> > > > >> > same version. It may not have been a problem in older kernels, but that
> > > > >> > would be difficult to test for me (a pretty important driver for this
> > > > >> > machine was only merged during v5.17-rc4). So it may not have been a
> > > > >> > regression & just a hidden problem since time immemorial.
> > > > >> >
> > > > >> > I am willing to test any patches I may get to further debug or fix
> > > > >> > this issue, preferably based on the current state of torvalds/linux.git.
> > > > >> > I can build & test kernels quite a few times per day.
> > > > >> >
> > > > >> > I can also send any important materials (kernel config, dmesg, firmware
> > > > >> > information, so on & so forth) on request. I'll also just mention I'm
> > > > >> > using kexec-tools 2.0.24 upfront, if it matters.
> > > > >
> > > > > Can you check the efi runtime in sysfs:
> > > > > ls /sys/firmware/efi/runtime-map/
> > > > >
> > > > > If nothing then maybe you did not enable CONFIG_EFI_RUNTIME_MAP=y, it
> > > > > is needed for kexec UEFI boot on x86_64.
> > > >
> > > > Oh my, it really is that simple.
> > > >
> > > > Indeed, enabling this in the pre-kexec kernel fixes it all up. I had
> > > > blindly disabled it in my quest to downsize the pre-kexec kernel to
> > > > reduce boot time (it only runs a bootloader). In hindsight, the firmware
> > > > drivers section is not really a good section to tweak on a whim.
> > > >
> > > > I'm terribly sorry to have taken your time to "fix" this "bug". But I
> > > > must ask, is there any reason why this is a visible config option, or at
> > > > least not gated behind CONFIG_EXPERT? drivers/firmware/efi/runtime-map.c
> > > > is pretty tiny, & considering it depends on CONFIG_KEXEC_CORE, one
> > > > probably wants to have kexec work properly if they can even enable it.
> > >
> > > Glad to know it works with the .config tweaking. I can not recall any
> > > reason for that though.
> > >
> > > Since it sits in the efi code path, let's see how Ard thinks about
> > > your proposal.
> > >
> >
> > I don't understand why EFI_RUNTIME_MAP should depend on KEXEC_CORE at
> > all: it is documented as a feature that can be enabled for debugging
> > as well, and kexec does not work as expected without it.
>
> Probably debugging only mentioned in text, but not been considered in
> the kconfig logic :(
>
> >
> > Should we just change it like this perhaps?
> >
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -28,8 +28,8 @@ config EFI_VARS_PSTORE_DEFAULT_DISABLE
> >
> >  config EFI_RUNTIME_MAP
> >         bool "Export efi runtime maps to sysfs"
> > -       depends on X86 && EFI && KEXEC_CORE
> > -       default y
> > +       depends on X86 && EFI
> > +       default KEXEC_CORE
> >         help
> >
> > and maybe add an 'if EXPERT' so that the option is only visible to
> > modify when CONFIG_EXPERT=y ?
>
> Above changes look good to me.
>
> >
> > In any case, I intend to move this code into arch/x86 as well, so I'll
> > have a couple of patches out shortly.
>
> That would be better since it is X86 only.  Thanks, Ard.

Hmm,  before doing that, do you think it is useful for debugging
purposes? That could be a reason to sit in efi code instead of x86 ..


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
