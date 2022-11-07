Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE68C433FE
	for <kexec@archiver.kernel.org>; Mon,  7 Nov 2022 07:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nrub8Vk2bV9piGgCBq1x93ZbmpjM8Qq77UnWET4qmg8=; b=xJJAe4Pl4YKFpE
	hDljl9d/4IgSUIbdMSrvWIbp+swNsSFmld99nmbnKD6R9I9EcM8DGagjccbLSKg/hzX7zQuNen8oC
	fA/n554WaWLaeFBdB54PkGs6/JRhcBRNGzLLVLVB8htA8jfAmh0qNzEksRfJrsnNvli1yGbaXtdCl
	9KKacDa7fqR0sJin2b0UcH19oDzlsIaZoHYoHd0hxdXG4sPSZkEwcbh0VSSzbDa+iuHkjPSeZiPz1
	HXA4oLtjxgdOWAtofz+XhUFcIVIMVdXIkGER10eSUKqZHDjZ4jep/2iKoMbNhs7009Hc9DNP6sUm7
	0uTtZ+tjcDFpA21cMdYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orwe7-00CQDW-9R; Mon, 07 Nov 2022 07:34:15 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orwZx-00COBj-2k
	for kexec@lists.infradead.org; Mon, 07 Nov 2022 07:29:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 24A0660F0B
	for <kexec@lists.infradead.org>; Mon,  7 Nov 2022 07:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7572C433B5
	for <kexec@lists.infradead.org>; Mon,  7 Nov 2022 07:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667806195;
	bh=QOaSu9qGtU5Wj6xX/GFltjjuiih5+FtN1uwai4IFTv4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oi+KoDdpoI2k1qhnC8/sojNVgbckesWVeXNxjI1fErap0Tfq1AMIv1IpOMoZBmM+o
	 Vr9jBN8NGoS9eRDXkboPVEab4gv+iD7ia84mqeynAVY7LIVNxVh+Dz8qZkcdintOb0
	 MauW/AZ+OylG8gEn4NXrlXChApioAvXhTLgg7ysOhVGgl0IGYsrVHbJ/nJ9EA4tpgp
	 0VvhWcDqD9QVeGw273r2y1UlHE9cea9v9GoCfJRkKK20IsYVwO3XKpadYIkAaKGcD3
	 zv8F4QB4fRe8Gtcjf1RN3lXwNqlXasBZSDKNPQUxjEISPiA2kZdkEaLyeggaQlq44d
	 OpnUPwM4M+gjA==
Received: by mail-lf1-f50.google.com with SMTP id bp15so15509967lfb.13
        for <kexec@lists.infradead.org>; Sun, 06 Nov 2022 23:29:55 -0800 (PST)
X-Gm-Message-State: ACrzQf0M/QN5NTqlCztZA4xLC+J8A3ClfUxX61vICiS1zPms97AJKbGc
	cXhhOnJ+jqitxjuWcqxejJi60uEyZvwfXCbydHc=
X-Google-Smtp-Source: AMsMyM6oAXHjBSYVzPZ7+5dZzgspxMz7eu34pmFsBF/TD3bot8pBvFVTR8Cy8dahKVwvAGc8YjF6Vhb2vSid58Wt1wY=
X-Received: by 2002:a19:4f53:0:b0:4b1:1f35:279b with SMTP id
 a19-20020a194f53000000b004b11f35279bmr11081444lfk.637.1667806193859; Sun, 06
 Nov 2022 23:29:53 -0800 (PST)
MIME-Version: 1.0
References: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf> <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
 <CALu+AoTVtO=-tzbgjeVRQ3uO0yGUPWKPuAiLn0CpaAq_=xr-sw@mail.gmail.com>
 <2f43e1e583a92e1592c48a15a763e1f7@tfwno.gf> <CALu+AoQqb23tnNS6VY4+Q5Mz85NDFfWOP_aynoz7fcoMvzNeKg@mail.gmail.com>
In-Reply-To: <CALu+AoQqb23tnNS6VY4+Q5Mz85NDFfWOP_aynoz7fcoMvzNeKg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 7 Nov 2022 08:29:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGyo7q1Jgkw8RAfiiyLpe8GAvsWT+jEt4DM-1W9Qf7oUQ@mail.gmail.com>
Message-ID: <CAMj1kXGyo7q1Jgkw8RAfiiyLpe8GAvsWT+jEt4DM-1W9Qf7oUQ@mail.gmail.com>
Subject: Re: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
To: Dave Young <dyoung@redhat.com>
Cc: ns@tfwno.gf, Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221106_232957_247695_6AC1BC21 
X-CRM114-Status: GOOD (  56.52  )
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

On Mon, 7 Nov 2022 at 07:55, Dave Young <dyoung@redhat.com> wrote:
>
> Hi,
>
> On Sat, 5 Nov 2022 at 22:16, <ns@tfwno.gf> wrote:
> >
> > On 2022-11-05 05:49, Dave Young wrote:
> > > Baoquan, thanks for cc me.
> > >
> > > On Sat, 5 Nov 2022 at 11:10, Baoquan He <bhe@redhat.com> wrote:
> > >>
> > >> Add Dave to CC
> > >>
> > >> On 10/28/22 at 01:02pm, ns@tfwno.gf wrote:
> > >> > Greetings,
> > >> >
> > >> > I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
> > >> > cause EFI mode (if that's the right term for it) to be unconditionally
> > >> > disabled, even when not using the --noefi option to kexec.
> > >> >
> > >> > What I mean by "EFI mode" being disabled, more than just EFI runtime
> > >> > services, is that basically nothing about the system's EFI is visible
> > >> > post-kexec. Normally you have a message like this in dmesg when the
> > >> > system is booted in EFI mode:
> > >> >
> > >> > [    0.000000] efi: EFI v2.70 by EDK II
> > >> > [    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 2.0=0x7fb7e014
> > >> > MEMATTR=0x7ec63018
> > >> > (obviously not the real firmware of the machine I'm talking about, but I
> > >> > can also send that if it would be of any help)
> > >> >
> > >> > No such message pops up in my dmesg as a result of this bug, & this
> > >> > causes some fallout like being unable to find the system's DMI
> > >> > information:
> > >> >
> > >> > <6>[    0.000000] DMI not present or invalid.
> > >> >
> > >> > The efivarfs module also fails to load with -ENODEV.
> > >> >
> > >> > I've tried also booting with efi=runtime explicitly but it doesn't
> > >> > change anything. The kernel still does not print the name of the EFI
> > >> > firmware, DMI is still missing, & efivarfs still fails to load.
> > >> >
> > >> > I've been using the kexec_load syscall for all these tests, if it's
> > >> > important.
> > >> >
> > >> > Also, to make it very clear, all this only ever happens post-kexec. When
> > >> > booting straight from UEFI (with the EFI stub), all the aforementioned
> > >> > stuff that fails works perfectly fine (i.e. name of firmware is printed,
> > >> > DMI is properly found, & efivarfs loads & mounts just fine).
> > >> >
> > >> > This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
> > >> > bisect it, but it seems like it goes pretty far back. I've got vanilla
> > >> > mainline kernel builds dating back to 5.17 that have the exact same
> > >> > issue. It might be worth noting that during this testing, I made sure
> > >> > the version of the kernel being kexeced & the kernel kexecing were the
> > >> > same version. It may not have been a problem in older kernels, but that
> > >> > would be difficult to test for me (a pretty important driver for this
> > >> > machine was only merged during v5.17-rc4). So it may not have been a
> > >> > regression & just a hidden problem since time immemorial.
> > >> >
> > >> > I am willing to test any patches I may get to further debug or fix
> > >> > this issue, preferably based on the current state of torvalds/linux.git.
> > >> > I can build & test kernels quite a few times per day.
> > >> >
> > >> > I can also send any important materials (kernel config, dmesg, firmware
> > >> > information, so on & so forth) on request. I'll also just mention I'm
> > >> > using kexec-tools 2.0.24 upfront, if it matters.
> > >
> > > Can you check the efi runtime in sysfs:
> > > ls /sys/firmware/efi/runtime-map/
> > >
> > > If nothing then maybe you did not enable CONFIG_EFI_RUNTIME_MAP=y, it
> > > is needed for kexec UEFI boot on x86_64.
> >
> > Oh my, it really is that simple.
> >
> > Indeed, enabling this in the pre-kexec kernel fixes it all up. I had
> > blindly disabled it in my quest to downsize the pre-kexec kernel to
> > reduce boot time (it only runs a bootloader). In hindsight, the firmware
> > drivers section is not really a good section to tweak on a whim.
> >
> > I'm terribly sorry to have taken your time to "fix" this "bug". But I
> > must ask, is there any reason why this is a visible config option, or at
> > least not gated behind CONFIG_EXPERT? drivers/firmware/efi/runtime-map.c
> > is pretty tiny, & considering it depends on CONFIG_KEXEC_CORE, one
> > probably wants to have kexec work properly if they can even enable it.
>
> Glad to know it works with the .config tweaking. I can not recall any
> reason for that though.
>
> Since it sits in the efi code path, let's see how Ard thinks about
> your proposal.
>

I don't understand why EFI_RUNTIME_MAP should depend on KEXEC_CORE at
all: it is documented as a feature that can be enabled for debugging
as well, and kexec does not work as expected without it.

Should we just change it like this perhaps?

--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -28,8 +28,8 @@ config EFI_VARS_PSTORE_DEFAULT_DISABLE

 config EFI_RUNTIME_MAP
        bool "Export efi runtime maps to sysfs"
-       depends on X86 && EFI && KEXEC_CORE
-       default y
+       depends on X86 && EFI
+       default KEXEC_CORE
        help

and maybe add an 'if EXPERT' so that the option is only visible to
modify when CONFIG_EXPERT=y ?

In any case, I intend to move this code into arch/x86 as well, so I'll
have a couple of patches out shortly.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
