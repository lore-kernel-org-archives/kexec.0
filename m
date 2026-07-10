Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EE9C44506
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZHdWJB2BiyxmhREK7giZIXjhCTkA1O03lnMMdRJ9eRY=; b=v4s2J38J9WH7x0fvmAMtQ0pBbl
	Tj1HvOGwXWNVNllwQj0jcVbUzt2Bds/S1ZmhRhavRhMdqu+cVZucp8waIFJx1HQEs8iw0klMdwRKG
	D94JEHElTdbFLvkeHGczaXkVruOl/bGixi5ls1eqyjIWBhyroxDoEzqVhYXIet/EQDUmM/KWQbD3c
	CF2X29PBnPwRm34UtlMovwRYIIyccc892JBLchcREcpqvpe2o7nULaYYr48BwWRA9Cd8Sot/2pqnj
	G58FjZwftFigJZUhEYtz9Apc7RC3HmqL7+8nzheWQD3C6VdAn+2LA2ry0yC3b3IIWTQZUh+mkGvid
	1xgU0s2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiByX-0000000540u-3jeb;
	Fri, 10 Jul 2026 14:13:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiByW-0000000540d-1ZB8
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 14:13:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6193A60051
	for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 14:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B39A1F00A3A
	for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 14:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692787;
	bh=ZHdWJB2BiyxmhREK7giZIXjhCTkA1O03lnMMdRJ9eRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YNva9iHvkOPHIkRRCqb1ovPNv6AtInyxJdmgqlUaz+6H91RohX7g5hbn0z6NKpQyQ
	 WM1GQp7aaMaffEyzxb+9GIpa3ofTrGTCGkpFQNiHZYhFGnSHG8PyPXLxpUBDTWciXa
	 3/GNAJJcsV7Iw5HlhOYQo977KTmIx6rYZHKsZVFzkhr0JCHdtMsocJYDsJ1VBc05sj
	 NLOGC4uWV+YzfXiXRNHT/pjUOnlUUdoeazw9gIcOYvEZ/yIZJR0r+PK90hgeDckvHE
	 gcmcBJLbHpzBrECpherUqayrzV1U9FS7pVQAdKDFFR50iR39bHKoEGLCY2khs3OuP6
	 FuIeg8tBPDBWA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698acd36d67so1952599a12.0
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 07:13:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqXgudQbSPx6HGGJM2p8lK5HS/R0XAFwX75+JcvDjvXVblw7U8D0/nDx6IWxiEJ3VbbiKlDuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzSKRDfKJEwp1W2KwbGEDGuspPQ+ws9wHGgljfQar7ROPfBo7Tu
	mSZenPPK7sa4f8jisb9t0Ojfuw7fbbC+G1YkaUeaycW235Xl5jDAqidKF/jS7RYJeUyVefB57gl
	Beg74VdwlrQ4CMbHAjCirF59RwvL24wQ=
X-Received: by 2002:a05:6402:194e:b0:698:bbe:9c8 with SMTP id
 4fb4d7f45d1cf-69ab4469aa3mr5016750a12.15.1783692785766; Fri, 10 Jul 2026
 07:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H7S9_hPDFoCtzgfY9TeH_koN9NfKq9mo8y9BmLA5-7how@mail.gmail.com>
 <20260709124830.15417-1-dongtai.guo@linux.dev>
In-Reply-To: <20260709124830.15417-1-dongtai.guo@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 10 Jul 2026 22:12:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H48MWTkJuqOV3M1wFhZXL5U7Kp0Vegv74P4t6XEvOEpHA@mail.gmail.com>
X-Gm-Features: AUfX_mwEQbfiRwKJSjmg9Z9gLLMMYvWBHmoip68TanGdrsXRUZEOoiUPd_-0Iac
Message-ID: <CAAhV-H48MWTkJuqOV3M1wFhZXL5U7Kp0Vegv74P4t6XEvOEpHA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] LoongArch: kexec: avoid clobbering the QEMU FDT
To: George Guo <dongtai.guo@linux.dev>
Cc: maobibo@loongson.cn, loongarch@lists.linux.dev, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jul 9, 2026 at 8:48=E2=80=AFPM George Guo <dongtai.guo@linux.dev> w=
rote:
>
> Hi Huacai,
>
> Thanks for the correction, and I am sorry for the way I handled this.
>
> > Who told you the trampoline is dead code? All non-boot CPUs are
> > running in the trampoline, you can use maxcpus=3D1 to go to the new
> > kernel, and do something, and then hotplug the non-boot CPUs at any
> > time.
>
> You are right, and I was wrong to call the trampoline dead once the new
> kernel starts.  The non-boot CPUs spin in kexec_smp_wait inside the
> trampoline buffer and only leave it when the new kernel brings them
> online, so with maxcpus=3D1 they stay there until a later CPU hotplug.
> The buffer has to stay valid the whole time.
>
> That breaks my patch 1.  control_code_page is allocated by the kexec
> core and is not reserved in the new kernel, so the new kernel can reuse
> that page while the non-boot CPUs are still spinning in it, and small
> memory makes that more likely.  The fixed KEXEC_CONTROL_CODE at 0x100000
> avoided this because the first 2MB is memblock_reserve()d in both
> kernels; its only problem was that it overlaps QEMU's machine FDT at
> 0x100000.  So my Q2 answer in the cover letter was also wrong, and "as
> arm64/riscv do" does not apply here.
>
> So the trampoline still needs to live in the cross-kexec reserved first
> 2MB, just not on top of the FDT.  The FDT declares fdt_totalsize 1MB and
> covers [0x100000, 0x200000), so the room left is below 0x100000.
>
> Do you have a different fix in mind? I would like to agree on the
> direction with you before I send anything.
>
> > BTW,  you have never replied to my comments, all you have done is
> > submit new versions again and again.
>
> That is fair, and it was my mistake.  I should have replied to your
> review in the thread and discussed it before sending a new version,
> instead of putting my answers in a cover letter.  I will reply to
> comments first from now on.
>
> I will hold the series until we settle the trampoline approach.
I had proposed a reasonable solution as early as in v1.

Huacai

>
> Thanks,
> George

