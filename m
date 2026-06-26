Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2662CD4F26
	for <kexec@archiver.kernel.org>; Fri, 26 Jun 2026 08:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lIgeO+X2vwzTq4XhASktreFTW3e+NC5uIr2FcOBPz9M=; b=YsH0pCGF03OuTyoaIrxKT18sWS
	xXESzRwUJtlyNMwfb1wrRgXLH+MTDtf6YP8Pkp54rYNoQe7UfnJ5HAPkcRzko/ON6c7Sb5HBEPhcP
	QknLvvSJb0SuT+kvaNd/Q9Kar4WEYaHKvKqDg3iMcOBZPi1XZQFRwZut0Rxr1hD8xbpKpsIEzT4/X
	u8LLwMNxc3X9m1UU7nlFBc488RSwONpBvGTO8KSclwnH75KPkkKZEcqzc4MRSLAgucCSUwmdsZaNi
	0QzC45seOWSB5EkZoEJhadxmgsdor5KF/HTDcP/NtdRMqSiWiiy5tF5L2z/W6iDY+X656jzq60BD2
	6q3n4e4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1fc-0000000Alki-3Zk6;
	Fri, 26 Jun 2026 08:12:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1fZ-0000000Alk2-3nkG
	for kexec@lists.infradead.org;
	Fri, 26 Jun 2026 08:12:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782461533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIgeO+X2vwzTq4XhASktreFTW3e+NC5uIr2FcOBPz9M=;
	b=hVohBabgQedRRJ+k+DO6c2gZNAsFSNYkVG1gS9AomHrp2GmGTo9/KL5rncDJiYvy00hXz3
	1998+stlgfv2zML4AMOWsDChjgh1dHv0H1+rMLZ54CeORnhXJ9eOksrHPt9ZAJfHEft5e+
	blOP6glJ+Pk1Sz/qYQxICBcjEnpjmlw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-08Q3cRNSNdiz-Gd8gc3WSg-1; Fri, 26 Jun 2026 04:04:51 -0400
X-MC-Unique: 08Q3cRNSNdiz-Gd8gc3WSg-1
X-Mimecast-MFC-AGG-ID: 08Q3cRNSNdiz-Gd8gc3WSg_1782461090
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-396708fabd9so2450791fa.0
        for <kexec@lists.infradead.org>; Fri, 26 Jun 2026 01:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782461090; x=1783065890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lIgeO+X2vwzTq4XhASktreFTW3e+NC5uIr2FcOBPz9M=;
        b=IWL2b0x/qFydG2iw5gPZO2oZc/FRnmLI+bfUhuppkW8uYMREeHDxrEgdhq2s8cqvCZ
         uPI0b/pvBkMYFGldqmjmT6lgsa+9Z9WGmcr3ZynyMo/tK98mbdfaYS7GPTILpb+nfbjE
         T743cksdehPVPGmU/I/GJlTfCg9O+o4arYjDJ/UoW4xVfoGQqfVtvZlmB2yMEcp1RE02
         Zmci60rG7j63AcWO3uTzrW2fb3M+8gZu4NMeJn1iWSd6FqilpVPxFPXjJnbmxk+Xo5sD
         k4Y1vVNZl/TvlG90r/RdiIs9STfClR1lVztqPuYbQeXXj254VxSrWtRxLmuAwV6GhkLY
         oOYQ==
X-Forwarded-Encrypted: i=1; AHgh+RpKUgg4HQNa15caLCyE4uA5uk6WeuK4w3lDHEOG3e+XzhkyYZdfo8Ivltat/uDzZGW883hK8g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwLTLYjSC1K3eSXZvA59UYAkbWm99eBAFE4A1yI/GMqGWgBL76H
	7q6qcfWSmj07wSzuxa9YN5uhxsLjl3Js2rSzmkvRLCZ2bi0szNqQVAklCWvPiN6pgj2TPsZ4xne
	c0ngAa6AMFKrvJOX2ttVNL1+99k/Oq/qkb4Y+icwsQSHStaGCMz3gqWZC9eXOIlgz9oaDHFlA5c
	4UrhZ9vPj0OY+AXDwQCNV/YML5UN69xErZpOze
X-Gm-Gg: AfdE7ckhZcCcmPfSYN3q7Udz8vyTfdt22klUdcgAJbumK5dSTdzDdSM2jN8ELAZ+cKQ
	7oZzFd7s9dyBx9C/DPlmRrgnAKscBHx3tghbJNvmU+oenAdqNb6TY6qgD4HUS9Alm/RZs1MCSVp
	i+BMohIRvE7grZJkM5nse7glKdf4vZhfBsreuVlzQXdCM9UEtlaPsM0cbJZs0y1WrysQ==
X-Received: by 2002:a05:6512:252c:b0:5ae:a822:d095 with SMTP id 2adb3069b0e04-5aea822d1dfmr255345e87.20.1782461089569;
        Fri, 26 Jun 2026 01:04:49 -0700 (PDT)
X-Received: by 2002:a05:6512:252c:b0:5ae:a822:d095 with SMTP id
 2adb3069b0e04-5aea822d1dfmr255335e87.20.1782461089046; Fri, 26 Jun 2026
 01:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260529032739.13264-2-ltao@redhat.com> <CAO7dBbW+LEy8SBGAKcrxEDzK5Xctw-r7ztgnXuURa9g0xntbtQ@mail.gmail.com>
In-Reply-To: <CAO7dBbW+LEy8SBGAKcrxEDzK5Xctw-r7ztgnXuURa9g0xntbtQ@mail.gmail.com>
From: Baoquan He <bhe@redhat.com>
Date: Fri, 26 Jun 2026 16:04:37 +0800
X-Gm-Features: AVVi8CcYdrkpgr8-G7cNCgcpkfh9Qy-n4dIwvNbnG1GCr-0ywSv4JL4rHejIwe0
Message-ID: <CAP_BRoQEM8Re1dT7JNQgO72o50GAnb2y7R1HWPd+E772GVYAJg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix a NULL pointer reference in machine_kexec_prepare
To: Tao Liu <ltao@redhat.com>, kexec@lists.infradead.org
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: woUIc0pTgbxG7Ei6FCttyTnoSDghwobsWqql2u6bME0_1782461090
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_011214_006830_B4B1301F 
X-CRM114-Status: GOOD (  20.25  )
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

Add kexec ML to CC.

On Fri, Jun 26, 2026 at 7:46=E2=80=AFAM Tao Liu <ltao@redhat.com> wrote:
>
> Kindly ping, any comments?
>
> Thanks,
> Tao Liu
>
> On Fri, May 29, 2026 at 3:35=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
> >
> > A NULL pointer reference issue is noticed in riscv's machine_kexec_prep=
are,
> > where image->segment[i].buf might be NULL and copied unchecked.
> >
> > The NULL buf comes from security/integrity/ima/ima_kexec.c:
> > ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> > but kbuf.buffer is NULL.
> >
> > Fix this by simply adding a check before copy.
> >
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> >  arch/riscv/kernel/machine_kexec.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/mach=
ine_kexec.c
> > index 2306ce3e5f22..d81d576f9cb5 100644
> > --- a/arch/riscv/kernel/machine_kexec.c
> > +++ b/arch/riscv/kernel/machine_kexec.c
> > @@ -41,6 +41,9 @@ machine_kexec_prepare(struct kimage *image)
> >                 if (image->segment[i].memsz <=3D sizeof(fdt))
> >                         continue;
> >
> > +               if (image->segment[i].buf =3D=3D NULL)
> > +                       continue;
> > +

This is a good fix, maybe we can add code comments to explain it as
below, just for reference.

               /*
                * Some segments (e.g. IMA) reserve space but have no buffer
                * loaded yet. Skip them as they cannot contain an FDT.
                */
And is there any other place where the similar issue exists? e.g on LoongAr=
ch?

Other than above concerns, this patch looks good to me:

Acked-by: Baoquan He <bhe@redhat.com>

> >                 if (image->file_mode)
> >                         memcpy(&fdt, image->segment[i].buf, sizeof(fdt)=
);
> >                 else if (copy_from_user(&fdt, image->segment[i].buf, si=
zeof(fdt)))
> > --
> > 2.47.0
> >
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
>


