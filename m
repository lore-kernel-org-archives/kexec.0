Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E998C4332F
	for <kexec@archiver.kernel.org>; Sat,  5 Nov 2022 05:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x8Il/bdP6ZqkOJZPaEJnj+z+B7WAiBXtfLmD19KiO30=; b=DkXNGtoSTlsez7
	+SMc6JCJCm24+SstNEMZIoXVGxXwRTc79PPaUlHqo16JIEQRW9ETEB2zOBEYF7+E1+QrQUDtxSscM
	1c0n0P29oAYV5QnCgORJz4b8H5cRIg/VbqFkDE+uLt/UVXts87FOLTstz3VEydP+RfCkZ62k91lm7
	VNsn30DLg1+vzP553Bp+5No09TBdYyzc8SxAgann4kYMciyLDP6FJ0tODepSMpWCHdzy+yZFUoUpb
	hUMcDsFpAGtkiKbzxuLghM2ZYO98i2jJHvdUFTWjj1V5cg6IZZIoTflQHaicKks/8XKbOyxDOsXKT
	m3RzCXmManwbeRjybsgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orC6P-005uER-PM; Sat, 05 Nov 2022 05:52:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1orC6M-005uE7-QX
	for kexec@lists.infradead.org; Sat, 05 Nov 2022 05:52:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667627535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n/DPXqnNM3/vCTawtYzMf2SZGZlw8n3vrmnUPC8gUwE=;
	b=TsBAYt1dNE+/pQQOX83HT/Z4NhLffShaoFQ6sISS3QbudXOB7+7lBFZ2ymwkIokgFlPOm+
	1aTddPy+9wTxC3Evzb2lK4FqupzEwYG8GLjhL/WezTtHN/OSZLZU7DEQhCMsbTvWnVN1tZ
	Tp+eTL+QPExl++xkFbflZDE3NBcEKZk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-88IJAqInMB28GcPIUynRFg-1; Sat, 05 Nov 2022 01:50:37 -0400
X-MC-Unique: 88IJAqInMB28GcPIUynRFg-1
Received: by mail-ed1-f70.google.com with SMTP id w4-20020a05640234c400b004631f8923baso4725012edc.5
        for <kexec@lists.infradead.org>; Fri, 04 Nov 2022 22:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/DPXqnNM3/vCTawtYzMf2SZGZlw8n3vrmnUPC8gUwE=;
        b=kUSqEcpYuRCliMy0OiC5lEkLjD9cXJVF3F5TxumgzzFBDQm1E846euSgHTpU5yITYE
         nnsKOLgGE1X1+P6mVG8qDg5j9kVahLzsmkO2XvoTXGmC4ndhrMT2KcRxRejv8A1TJ+2W
         IN+x+MgjHk1bidR3oMWO4dXZah/SjqXuGw28jJSA5i0eN9pwceuwb6AGesJaLWmkB/Om
         8ISywxzkYWEaOAsbcWwANb9GfZj1CNkR6ghwiyJZgBX6B+CtBOcVEu0Qgdr2so/9ue3j
         k0SQ5/pk0GufAFU52RihKLGe8GwaYE4B2QMNlm2r1jMByccVbEy/UFymWw8fc49UNeSk
         msSA==
X-Gm-Message-State: ACrzQf1qyTMa7mJ8K12sRSlFk2qZf5Szjq4LBEqRUdcHkNUUzf2HqtxX
	WZRahrzKY0eGqyFz1NriDfbBprDWo4JxvTINQMIgWfXIx8kc7byLi7UCID+Jok6f8H8wdbbBHLu
	SA34F1ETvuh5zHOjT7cFFfVtJGqMgxWIUr4c9
X-Received: by 2002:aa7:c859:0:b0:463:4b54:16a8 with SMTP id g25-20020aa7c859000000b004634b5416a8mr32111551edt.136.1667627436422;
        Fri, 04 Nov 2022 22:50:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5A9+6ol1jnUB036VhOH+sVLMKPc0rjDaF4P/UgBmXrj6EZZzZioW4TXgnIDDoT14UQIBs4LTH6v6uVO017x1c=
X-Received: by 2002:aa7:c859:0:b0:463:4b54:16a8 with SMTP id
 g25-20020aa7c859000000b004634b5416a8mr32111531edt.136.1667627436187; Fri, 04
 Nov 2022 22:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf> <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
In-Reply-To: <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
From: Dave Young <dyoung@redhat.com>
Date: Sat, 5 Nov 2022 13:49:59 +0800
Message-ID: <CALu+AoTVtO=-tzbgjeVRQ3uO0yGUPWKPuAiLn0CpaAq_=xr-sw@mail.gmail.com>
Subject: Re: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
To: Baoquan He <bhe@redhat.com>
Cc: ns@tfwno.gf, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_225218_978216_FCCDEF11 
X-CRM114-Status: GOOD (  37.46  )
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

Baoquan, thanks for cc me.

On Sat, 5 Nov 2022 at 11:10, Baoquan He <bhe@redhat.com> wrote:
>
> Add Dave to CC
>
> On 10/28/22 at 01:02pm, ns@tfwno.gf wrote:
> > Greetings,
> >
> > I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
> > cause EFI mode (if that's the right term for it) to be unconditionally
> > disabled, even when not using the --noefi option to kexec.
> >
> > What I mean by "EFI mode" being disabled, more than just EFI runtime
> > services, is that basically nothing about the system's EFI is visible
> > post-kexec. Normally you have a message like this in dmesg when the
> > system is booted in EFI mode:
> >
> > [    0.000000] efi: EFI v2.70 by EDK II
> > [    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 2.0=0x7fb7e014
> > MEMATTR=0x7ec63018
> > (obviously not the real firmware of the machine I'm talking about, but I
> > can also send that if it would be of any help)
> >
> > No such message pops up in my dmesg as a result of this bug, & this
> > causes some fallout like being unable to find the system's DMI
> > information:
> >
> > <6>[    0.000000] DMI not present or invalid.
> >
> > The efivarfs module also fails to load with -ENODEV.
> >
> > I've tried also booting with efi=runtime explicitly but it doesn't
> > change anything. The kernel still does not print the name of the EFI
> > firmware, DMI is still missing, & efivarfs still fails to load.
> >
> > I've been using the kexec_load syscall for all these tests, if it's
> > important.
> >
> > Also, to make it very clear, all this only ever happens post-kexec. When
> > booting straight from UEFI (with the EFI stub), all the aforementioned
> > stuff that fails works perfectly fine (i.e. name of firmware is printed,
> > DMI is properly found, & efivarfs loads & mounts just fine).
> >
> > This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
> > bisect it, but it seems like it goes pretty far back. I've got vanilla
> > mainline kernel builds dating back to 5.17 that have the exact same
> > issue. It might be worth noting that during this testing, I made sure
> > the version of the kernel being kexeced & the kernel kexecing were the
> > same version. It may not have been a problem in older kernels, but that
> > would be difficult to test for me (a pretty important driver for this
> > machine was only merged during v5.17-rc4). So it may not have been a
> > regression & just a hidden problem since time immemorial.
> >
> > I am willing to test any patches I may get to further debug or fix
> > this issue, preferably based on the current state of torvalds/linux.git.
> > I can build & test kernels quite a few times per day.
> >
> > I can also send any important materials (kernel config, dmesg, firmware
> > information, so on & so forth) on request. I'll also just mention I'm
> > using kexec-tools 2.0.24 upfront, if it matters.

Can you check the efi runtime in sysfs:
ls /sys/firmware/efi/runtime-map/

If nothing then maybe you did not enable CONFIG_EFI_RUNTIME_MAP=y, it
is needed for kexec UEFI boot on x86_64.

Otherwise you can add debug printf in kexec-tools efi error path to
see what is wrong.
kexec/arch/i386/x86-linux-setup.c : function setup_efi_data

And if it still not work please post your kernel config, I can have a
try although I do not have the t480 now.


> >
> > Regards,
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
