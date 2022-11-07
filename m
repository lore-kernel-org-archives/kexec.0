Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12546C4332F
	for <kexec@archiver.kernel.org>; Mon,  7 Nov 2022 07:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+3mB4C3FJo6mvJdjCGV9b3cIMjGNmGu12a+4yEuK5QM=; b=jEUGHXWf188OJy
	RO3qAvGAzAHxxQLItW/m33m9x3zjHlvev4CQJVre0JWphjRNCVysaZPQ2w25iNf2BxDVBZawTMc3F
	d1W+xnl7cNySpgi3t05ZlcopqkANUB/TOT0XT4/SxYxV5QPMUmC2tCe80gPG21PjpeNKPImDnK+1Z
	b2GzFkEY/RBjBIGSbA0OjKMjAFPs/9SUNRK6hynvfa6Kn+XoIU7Z2pf7WpghriGIdqgvdTy7iVyLn
	on98jSoIvEM9vSUsLlAySxigNP0srsFsimPm/3vSRVrwmdnGvMCw5+0dRvE5KpM+rzestrBH14br9
	SJEQjSF97V7hftL3FSWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orwhV-00CRob-Mc; Mon, 07 Nov 2022 07:37:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orwhL-00CRmY-Pn
	for kexec@lists.infradead.org; Mon, 07 Nov 2022 07:37:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667806653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Pv+XZ8GTm3Xpm7Pag3dWyKUKxxzVePCW3rTAW6lgKY=;
	b=eW1T1upx96jnKlTcgONr0WYabhkvls/ydgoXrFQAO6gypX+g/HGWuaDRie2NkZhRBmUi0A
	/ys7zirPuwUUA/ebBWQbt8JD9PAim/WFvUEPXjrXm5rJvuer35wOLldLBul5ZFnyRTBlGG
	WP/V+ou4CDg8/XNPYDmr1prhb8BHb4Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-30-MGoV2wotPqmTqanekJgSXA-1; Mon, 07 Nov 2022 02:37:30 -0500
X-MC-Unique: MGoV2wotPqmTqanekJgSXA-1
Received: by mail-ej1-f71.google.com with SMTP id qk31-20020a1709077f9f00b00791a3e02c80so5898862ejc.21
        for <kexec@lists.infradead.org>; Sun, 06 Nov 2022 23:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Pv+XZ8GTm3Xpm7Pag3dWyKUKxxzVePCW3rTAW6lgKY=;
        b=w67sHSWp+HjhVB8YU4v3k7NXTM3tYV6m3zFAe6gjjO06I2uaJORiDfCfTbGX4sKjYX
         F10mgpinZ5n0BGPd8Q2Z7f2LQG5FpPzn1tf3SfM5Lv3Efq1M/co+SWaXEzJ8OP5pT4Y+
         thtn0HE/Nh+1dd3KTFkIbRnZGL2U399NM26/L7e7zo4r00zRUFVxLexaXLQ0CNniSTHK
         wE/OxuX5hmgwcF9ZxEmBDueBgNE8pT2oLmXdyAlNuHlr7/jA1F/l9JTq3vawGn/cE5Ke
         /6R+G49wgM0lU43u3uD6Qwu22Jnpdp8caJjJFIYUi95MM9v9EdC3V/TObJY8yr4Im+f0
         2huQ==
X-Gm-Message-State: ACrzQf0MnyYLPsMkXH6SEX2QvMtHl4i+Yu9A5K5+HA7FxYX3tlmadQku
	ETx8uJq3aMD+kjcdZpQpBrf7+JBMWnkFIi1NL3qW0qe8MtR9w46Z2Q+dZHP+RQZtO64rSqn18bn
	rwtXN6MewCOQL47oqSa5LX5WwrJxdZELiEQUy
X-Received: by 2002:a17:907:2705:b0:7ad:8460:7d30 with SMTP id w5-20020a170907270500b007ad84607d30mr45706244ejk.693.1667806648140;
        Sun, 06 Nov 2022 23:37:28 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5SMn/awCas99VTs3iG8aAirHLAS/NmwXGRyS0peu+Hviel4lclCIW+L0+47lmJj1KqP4kXOesafraVPq6mRTE=
X-Received: by 2002:a17:907:2705:b0:7ad:8460:7d30 with SMTP id
 w5-20020a170907270500b007ad84607d30mr45706231ejk.693.1667806647912; Sun, 06
 Nov 2022 23:37:27 -0800 (PST)
MIME-Version: 1.0
References: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf> <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
 <CALu+AoTVtO=-tzbgjeVRQ3uO0yGUPWKPuAiLn0CpaAq_=xr-sw@mail.gmail.com>
 <2f43e1e583a92e1592c48a15a763e1f7@tfwno.gf> <CALu+AoQqb23tnNS6VY4+Q5Mz85NDFfWOP_aynoz7fcoMvzNeKg@mail.gmail.com>
 <CAMj1kXGyo7q1Jgkw8RAfiiyLpe8GAvsWT+jEt4DM-1W9Qf7oUQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGyo7q1Jgkw8RAfiiyLpe8GAvsWT+jEt4DM-1W9Qf7oUQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 7 Nov 2022 15:36:50 +0800
Message-ID: <CALu+AoQeraV2fLx_6q_76rdUXdsY6wYVMNU0o_VVuXLyfqiDNA@mail.gmail.com>
Subject: Re: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
To: Ard Biesheuvel <ardb@kernel.org>
Cc: ns@tfwno.gf, Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221106_233735_981261_BDDA3802 
X-CRM114-Status: GOOD (  57.55  )
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

Hi Ard,

On Mon, 7 Nov 2022 at 15:30, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 7 Nov 2022 at 07:55, Dave Young <dyoung@redhat.com> wrote:
> >
> > Hi,
> >
> > On Sat, 5 Nov 2022 at 22:16, <ns@tfwno.gf> wrote:
> > >
> > > On 2022-11-05 05:49, Dave Young wrote:
> > > > Baoquan, thanks for cc me.
> > > >
> > > > On Sat, 5 Nov 2022 at 11:10, Baoquan He <bhe@redhat.com> wrote:
> > > >>
> > > >> Add Dave to CC
> > > >>
> > > >> On 10/28/22 at 01:02pm, ns@tfwno.gf wrote:
> > > >> > Greetings,
> > > >> >
> > > >> > I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
> > > >> > cause EFI mode (if that's the right term for it) to be unconditionally
> > > >> > disabled, even when not using the --noefi option to kexec.
> > > >> >
> > > >> > What I mean by "EFI mode" being disabled, more than just EFI runtime
> > > >> > services, is that basically nothing about the system's EFI is visible
> > > >> > post-kexec. Normally you have a message like this in dmesg when the
> > > >> > system is booted in EFI mode:
> > > >> >
> > > >> > [    0.000000] efi: EFI v2.70 by EDK II
> > > >> > [    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 2.0=0x7fb7e014
> > > >> > MEMATTR=0x7ec63018
> > > >> > (obviously not the real firmware of the machine I'm talking about, but I
> > > >> > can also send that if it would be of any help)
> > > >> >
> > > >> > No such message pops up in my dmesg as a result of this bug, & this
> > > >> > causes some fallout like being unable to find the system's DMI
> > > >> > information:
> > > >> >
> > > >> > <6>[    0.000000] DMI not present or invalid.
> > > >> >
> > > >> > The efivarfs module also fails to load with -ENODEV.
> > > >> >
> > > >> > I've tried also booting with efi=runtime explicitly but it doesn't
> > > >> > change anything. The kernel still does not print the name of the EFI
> > > >> > firmware, DMI is still missing, & efivarfs still fails to load.
> > > >> >
> > > >> > I've been using the kexec_load syscall for all these tests, if it's
> > > >> > important.
> > > >> >
> > > >> > Also, to make it very clear, all this only ever happens post-kexec. When
> > > >> > booting straight from UEFI (with the EFI stub), all the aforementioned
> > > >> > stuff that fails works perfectly fine (i.e. name of firmware is printed,
> > > >> > DMI is properly found, & efivarfs loads & mounts just fine).
> > > >> >
> > > >> > This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
> > > >> > bisect it, but it seems like it goes pretty far back. I've got vanilla
> > > >> > mainline kernel builds dating back to 5.17 that have the exact same
> > > >> > issue. It might be worth noting that during this testing, I made sure
> > > >> > the version of the kernel being kexeced & the kernel kexecing were the
> > > >> > same version. It may not have been a problem in older kernels, but that
> > > >> > would be difficult to test for me (a pretty important driver for this
> > > >> > machine was only merged during v5.17-rc4). So it may not have been a
> > > >> > regression & just a hidden problem since time immemorial.
> > > >> >
> > > >> > I am willing to test any patches I may get to further debug or fix
> > > >> > this issue, preferably based on the current state of torvalds/linux.git.
> > > >> > I can build & test kernels quite a few times per day.
> > > >> >
> > > >> > I can also send any important materials (kernel config, dmesg, firmware
> > > >> > information, so on & so forth) on request. I'll also just mention I'm
> > > >> > using kexec-tools 2.0.24 upfront, if it matters.
> > > >
> > > > Can you check the efi runtime in sysfs:
> > > > ls /sys/firmware/efi/runtime-map/
> > > >
> > > > If nothing then maybe you did not enable CONFIG_EFI_RUNTIME_MAP=y, it
> > > > is needed for kexec UEFI boot on x86_64.
> > >
> > > Oh my, it really is that simple.
> > >
> > > Indeed, enabling this in the pre-kexec kernel fixes it all up. I had
> > > blindly disabled it in my quest to downsize the pre-kexec kernel to
> > > reduce boot time (it only runs a bootloader). In hindsight, the firmware
> > > drivers section is not really a good section to tweak on a whim.
> > >
> > > I'm terribly sorry to have taken your time to "fix" this "bug". But I
> > > must ask, is there any reason why this is a visible config option, or at
> > > least not gated behind CONFIG_EXPERT? drivers/firmware/efi/runtime-map.c
> > > is pretty tiny, & considering it depends on CONFIG_KEXEC_CORE, one
> > > probably wants to have kexec work properly if they can even enable it.
> >
> > Glad to know it works with the .config tweaking. I can not recall any
> > reason for that though.
> >
> > Since it sits in the efi code path, let's see how Ard thinks about
> > your proposal.
> >
>
> I don't understand why EFI_RUNTIME_MAP should depend on KEXEC_CORE at
> all: it is documented as a feature that can be enabled for debugging
> as well, and kexec does not work as expected without it.

Probably debugging only mentioned in text, but not been considered in
the kconfig logic :(

>
> Should we just change it like this perhaps?
>
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -28,8 +28,8 @@ config EFI_VARS_PSTORE_DEFAULT_DISABLE
>
>  config EFI_RUNTIME_MAP
>         bool "Export efi runtime maps to sysfs"
> -       depends on X86 && EFI && KEXEC_CORE
> -       default y
> +       depends on X86 && EFI
> +       default KEXEC_CORE
>         help
>
> and maybe add an 'if EXPERT' so that the option is only visible to
> modify when CONFIG_EXPERT=y ?

Above changes look good to me.

>
> In any case, I intend to move this code into arch/x86 as well, so I'll
> have a couple of patches out shortly.

That would be better since it is X86 only.  Thanks, Ard.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
