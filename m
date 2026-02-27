Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A83FD9E30
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 02:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HZhniSNkbfOkNF4qC2hYeVFLUMtmUrZtxX5b9EmLi/c=; b=sShfOdVuAjb4NdER/uSI9rycBN
	O7qtKoz6896p+4IIsg2V0tHcleX+F4ADXluZ7cEaZSv1MmfckY+mlgaSE2B7CtXmDaRaZTUltykgS
	RoQe5kqWn/PuK2E70IU2h3h4u5C96N9nUk4HzWFzCnpKTHmdhA7KK7nfs6ZEBapacWh0D6oSNIw7Q
	4tZIM3BqQagyZNMDI7EGqZfs7nMWtb1LrJJAObOSq1XhdliTao9NR/BXwlC64Qa6m1k5abQYNHKKG
	8WroYWM/3PGTcv3dGjgoRO/6PN0OX9D/Hc9okB17Wnm5SOoK8V1METeUg3WPeNM2FJdU9Hk0e+4tf
	2yELCk3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvnhM-00000007Y9Y-04QO;
	Fri, 27 Feb 2026 02:35:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvnhI-00000007Y98-2kMd
	for kexec@lists.infradead.org;
	Fri, 27 Feb 2026 02:35:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772159718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZhniSNkbfOkNF4qC2hYeVFLUMtmUrZtxX5b9EmLi/c=;
	b=ALmcIIwDRMaiRwj7+0zfDBa0zija79maLtKdsAfTEmtwIVtKp6ybYvanwdIFlEC/dFy/R0
	cDuXM6FA+jXw6J7/SjF1hnDD/Q94i51r9k+b170OM36MI1leBSRJxG7j/878NDXvzDe0Vf
	1VatZR3Edb4smIDOtYKDem1XUxGmj5Q=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-xV5UN_w8OTi8QJySFCv_EA-1; Thu, 26 Feb 2026 21:33:37 -0500
X-MC-Unique: xV5UN_w8OTi8QJySFCv_EA-1
X-Mimecast-MFC-AGG-ID: xV5UN_w8OTi8QJySFCv_EA_1772159616
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bde02c11b6so371787eec.1
        for <kexec@lists.infradead.org>; Thu, 26 Feb 2026 18:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772159616; x=1772764416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HZhniSNkbfOkNF4qC2hYeVFLUMtmUrZtxX5b9EmLi/c=;
        b=c6L1zG49QH/PG9EWAvJWoYJpFb5Q+J18JX1WxuEqjavQkW8RCEr0afBSdBlcLe6rLn
         7cwhR9SWyniRRliqBR1Sx8p65EtMho6s+sZD4fnbISJFr72DXqp67iUH3gPShUylxGCC
         jwEzPqBLdHfU+GLlDOQkYBOS8zljd6VevNyRtZQ5sygYsBybqHLBI3AWZSlTDGpPwAP2
         ZFfoVv4r9GsIvtqMIW0eV4j35hdWJd1UIolotJRQYq/WW+jm5hRpQKfMcE+muygYPMay
         LoSk/7XHznErEEYc0NQUcdYiXYOyYy0irh0t+Pk1oVKBB6M/lA8suCb357tg+NrKBcx6
         9SBA==
X-Gm-Message-State: AOJu0YwADRj/fqCbuBGJsYBL1cW5GleGvsjRIwVerVIT1DESdfrZgLpe
	RiOeY7R/Bi9bj4CgXTNzQIk7RBCkzdRnX+UW99Hsv1jv/HDmWHerQskU3DOZYXENAmpOppFIcKn
	8OokrXEPdpJscU2zQdUhxTGWKzxXLBEy/QlYFBC5d1vdhETq0aklX4kP/wIX/B7t4aX/NoNPFB9
	YWU4JCRMbLxXAF0fXae3ZZG78MiVwRwCZB60hD
X-Gm-Gg: ATEYQzz0hjNbKoXlMfxa5kf5laRKnWSro+GCfx5ZSOI6hwV8anhKW2OHZFLt/fOscof
	4W7WulOL/JPJbfXtlx2L1rTcUU3VbWqfSRg8jokY89lVLOBxTrzXtOz10W4M5nOPvmaVgIlb0df
	ZgOmVu9WRw4CvUir9O24eVEPm9uwPl6up45ggzR03DqI9Juv61mWyVDucQmhRrfvY94m+6IDaUq
	9e0KkQ=
X-Received: by 2002:a05:7300:cd86:b0:2ba:7c92:82fb with SMTP id 5a478bee46e88-2bdd0eccf46mr1356288eec.5.1772159615887;
        Thu, 26 Feb 2026 18:33:35 -0800 (PST)
X-Received: by 2002:a05:7300:cd86:b0:2ba:7c92:82fb with SMTP id
 5a478bee46e88-2bdd0eccf46mr1356266eec.5.1772159615443; Thu, 26 Feb 2026
 18:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20260119032424.10781-1-piliu@redhat.com> <20260119032424.10781-3-piliu@redhat.com>
 <20260226143710.42ba1843@rotkaeppchen>
In-Reply-To: <20260226143710.42ba1843@rotkaeppchen>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 27 Feb 2026 10:33:24 +0800
X-Gm-Features: AaiRm51sv1BDNshyMBDK5hf7V7z9_aThj1MpWelhNhiRBiqIEooTA6HtBrVxGwk
Message-ID: <CAF+s44TxkHPfGpiuD+RSGUCZ-WASOSUneObeEenYNFyCgdogQg@mail.gmail.com>
Subject: Re: [PATCHv6 02/13] kexec_file: Move signature validation ahead
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kfGDA68jVBUoMlspvscocxxWjY5lz8h64Q3r_VeCzOY_1772159616
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_183520_765194_C67D3671 
X-CRM114-Status: GOOD (  27.48  )
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

On Thu, Feb 26, 2026 at 9:37=E2=80=AFPM Philipp Rudo <prudo@redhat.com> wro=
te:
>
> Hi Pingfan,
>
> On Mon, 19 Jan 2026 11:24:13 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
>
> > Move the signature validation at the head of the function, so the image
> > can be unfold and handled later.
>
> besides what the bpf-bot already mentioned.
>
> What do you want to achieve by moving signature verification in front
> of probing the image? Do you want to avoid calling
> arch_kexec_kernel_image_probe twice? It would be great if you could add
> the reasoning why the change is needed to the commit message in the
> future. Not only to make review easier but also to document it for the
> future.
>
Here I made a mistake. I think the UKI case and the convention case
should be handled separately. For the UKI case, signature verification
should be applied to the UKI envelope but skipped for the unpacked
kernel image since it has no signature.


Thanks,

Pingfan

> Thanks
> Philipp
>
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > To: kexec@lists.infradead.org
> > ---
> >  kernel/kexec_file.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index eb62a97942428..0222d17072d40 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -231,18 +231,19 @@ kimage_file_prepare_segments(struct kimage *image=
, int kernel_fd, int initrd_fd,
> >       kexec_dprintk("kernel: %p kernel_size: %#lx\n",
> >                     image->kernel_buf, image->kernel_buf_len);
> >
> > -     /* Call arch image probe handlers */
> > -     ret =3D arch_kexec_kernel_image_probe(image, image->kernel_buf,
> > -                                         image->kernel_buf_len);
> > -     if (ret)
> > -             goto out;
> > -
> >  #ifdef CONFIG_KEXEC_SIG
> >       ret =3D kimage_validate_signature(image);
> >
> >       if (ret)
> >               goto out;
> >  #endif
> > +
> > +     /* Call arch image probe handlers */
> > +     ret =3D arch_kexec_kernel_image_probe(image, image->kernel_buf,
> > +                                         image->kernel_buf_len);
> > +     if (ret)
> > +             goto out;
> > +
> >       /* It is possible that there no initramfs is being loaded */
> >       if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
> >               ret =3D kernel_read_file_from_fd(initrd_fd, 0, &image->in=
itrd_buf,
>


