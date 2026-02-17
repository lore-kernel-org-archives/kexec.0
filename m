Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D577E68145
	for <kexec@archiver.kernel.org>; Tue, 17 Feb 2026 08:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xfYi7PI9qxM4J7aWJczxJb+aA3YSTrI6zxvigzJKugo=; b=J9SlWtGZPptN/w8KpujCXA/+NO
	gCjBlinqtiQad1RxiTgmWvcrbLS+VTIcmHxS4DJ3Z4DKVwJV7OpVPxwr4Cx+32aTTfo31ja45B5sV
	euaIfXTbR3ZmD60LD9N93aBQPfgWJYvfLD1y4xtD3NRK0sQNTN3SM4AP/F14IlQPa5TJ8fvt96vMm
	jXhAm7gu3qZKHNoFMH9/UbHmVzW/6MOaxKaRRBUWlMB4DvUFFIzi7bb5k7Wa4Z4ZBVf3zGXxik91m
	SswLTt3a2+i/NblYkZlcbbe8HHDj64PnryWMsML+VipNSZ9m0JDT3EWpgVcxCUwI7M/Z/6L8krAn4
	Rkg3RUMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsGKR-00000007r3X-2sFL;
	Tue, 17 Feb 2026 08:21:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsGKN-00000007r2k-1izV
	for kexec@lists.infradead.org;
	Tue, 17 Feb 2026 08:21:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771316461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfYi7PI9qxM4J7aWJczxJb+aA3YSTrI6zxvigzJKugo=;
	b=dsIZ6ZcKrnysaIj7STXM9ZpGkPbKuNbJMoKZKXWnhQsymUIerHQQrTQnq7f0h3BYmAM5mU
	sqWXAf0jYbHmkGw+Z63/56ADi5S4bCpNH4pqDAe+cIyHBDPfUR4jAqHujiXQEueBLA2e1D
	7GhCMSvvuUdYPSlV2+WSCCcydHbHvv4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-IBumm3AzOZyZOcmrrTQ70g-1; Tue, 17 Feb 2026 03:19:21 -0500
X-MC-Unique: IBumm3AzOZyZOcmrrTQ70g-1
X-Mimecast-MFC-AGG-ID: IBumm3AzOZyZOcmrrTQ70g_1771316360
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-38704a51eddso28557201fa.1
        for <kexec@lists.infradead.org>; Tue, 17 Feb 2026 00:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771316359; x=1771921159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfYi7PI9qxM4J7aWJczxJb+aA3YSTrI6zxvigzJKugo=;
        b=p8X6V4xknuER5mBJtmFkj4IUrlwfq6yRIjFF+s6RaNaJD7rxh8tDe0ma4JugTlyRoG
         vFVAg67gZ7UhnWkxwYGHMAriTbx74ekRONtTvC7qzjom4yU2xpZkxtbVWk1scHZZoPoO
         C0tSMRaAcvevv6QD2fffThATXZuASHkUuoZzHrDJBXft9u6C9X3dNQ2W+yrBcx5h9rKz
         lKK6gMv2LNbstv5r26yjs7lWE1m0YwdODW6KpWoRKeuCdvFcESEnpqVyHLlBnWQkEfx/
         lCY0tcqWkbueUdwCDvdGh9KifVcq9OUCXd9yIUXbiU8HhWJjpB+IH9w33ZPiMPq/Ncxg
         LkUA==
X-Forwarded-Encrypted: i=1; AJvYcCX7ZuaG1T3XH49muZoMyZ3KP2eun1rjwVpxql0v0ImOSNWYugypWDBqV/ZSuaiVI3/DLGV7NQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxiY81SzSx1fT3HcyBR2j0YzZvPgCDaZdsW2VMvIt2BXh/cbJ4T
	nAzed/LWb4qWAdrlpTBOTjQRuj4HVW0/acSNu7LlCOW+e34wEbqX5hmCVt/2KUXPOhjXjIb85E5
	bIbTscG7xFGYvQPIv7yZfDXfmTcRqd1q6hXHpVHbvN26P08tQcTxXyHaJ/X93upaWZJd3PrQ/D4
	eHTrfdQelPPgSNZ719IGTvhnPlC6mpBfhpwddr8moyFST7Gds=
X-Gm-Gg: AZuq6aIDMGY4CPn2VlxBsE47JOjt4P4SlBS4WbncpQt8XhwP5JCT3Ww+IqJG9o16hNb
	fher0Yedmcgkw5USV/uaszQKPpNTNaLEsYT3ghF+m+tQU8mxdha2qOWR3I9rGCzTN/nw8B7+jtP
	eVx0nBRGAK2iVB0hKrUs3AKSgP8I/5Wl3TvroFrHCWNu8zfNd6BhX/PExQkWCGEO8Byy5PO/KKj
	UcTfRqH9Je/r+EUZXPIQb5Hfy/d0Z7FJapVJ9qGiecsdSFMkvEUcgYCeovFTQSOw70r
X-Received: by 2002:a05:651c:19ac:b0:366:ef7d:bab3 with SMTP id 38308e7fff4ca-38819c700c7mr38337441fa.1.1771316359378;
        Tue, 17 Feb 2026 00:19:19 -0800 (PST)
X-Received: by 2002:a05:651c:19ac:b0:366:ef7d:bab3 with SMTP id
 38308e7fff4ca-38819c700c7mr38337321fa.1.1771316358898; Tue, 17 Feb 2026
 00:19:18 -0800 (PST)
MIME-Version: 1.0
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com> <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com>
In-Reply-To: <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 17 Feb 2026 16:19:49 +0800
X-Gm-Features: AaiRm50zAzOyAQM4NIdbG6YmCuiYZEV_-O5L8qObfrqsfGlmm9wPU8TIm0MG7Ls
Message-ID: <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, x86@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jV_kckjiamPGIyAGoytJhtS2ia3s0HIl8exyZjIDPXw_1771316360
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_002103_524644_091914AF 
X-CRM114-Status: GOOD (  26.29  )
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

Hi Ard,

On Tue, 17 Feb 2026 at 16:10, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Hi Dave,
>
> On Tue, 17 Feb 2026, at 09:04, Dave Young wrote:
> > Kernel panic occurs during a kexec reboot when EFI runtime services
> > are not enabled in the first kernel. The issue is that the second
> > kernel cannot find the ACPI RSDP address during boot.
> >
> > In legacy boot, the acpi_rsdp_addr is set in early x86 boot code.
> > However, kernel decompression has moved to the EFI stub for EFI boot.
> > Therefore, the x86 EFI stub must also be updated to store the
> > acpi_rsdp_addr in the boot parameters to ensure the kexec kernel
> > can find it.
> >
> > (Note: If the pre-kexec kernel was itself a kexec boot, the later kexec
> > reboot will still utilize the legacy decompressor path, so the original
> > code remains functional though some cleanups can be done later.)
> >
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  drivers/firmware/efi/libstub/x86-stub.c |   18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
>
> If this issue is kexec-specific, can we move this to where the kexec code prepares the boot_params struct for the next kernel?
>

The kexec use case is it depends on the pre-kexec kernel saving it
during boot for noefi case.  I do not have a better idea to do it in
kexec code for the time being.  Otherwise it seems the early
acpi_rsdp_addr was introduced for other reason (KASLR) although I'm
not sure about the exact background:   (Before this the original kexec
fallback just depend on end user to put acpi_rsdp in kernel cmdline
explictily or in kexec-tools)
commit 3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
Author: Chao Fan <fanc.fnst@cn.fujitsu.com>
Date:   Wed Jan 23 19:08:48 2019 +0800

    x86/boot: Early parse RSDP and save it in boot_params

Another thing is I do not have much time to work on big changes in
recent years, so if you suggest to have a resturcture I have to give
up :)   But I'm happy to do some trival thing during this week as I'm
in a holiday break and I have some time to play with it.

Thanks
Dave


