Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F42CFD36C
	for <kexec@archiver.kernel.org>; Tue, 25 Nov 2025 04:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yK36ADvRnvn7Z88J1V2Eb5Oki0HN2SsGScGiByHtlSA=; b=GqCjLwHRt1bPpId4uJ2gvRItBi
	FatdfLa8OqUeod/X16mlKdAiv8BEvVO6VjZVn2vRxY8+z24Ehbv3b2+Cl1gbTQ6U8MEqSxt1T0Lko
	QXQbcX5k0m47DEE5rzjJVdilntcRpAvzWno46Y7HC1chL+vKxn/phHg5QTRVSLFAp0hrzw6l8hjlH
	1ggDAL6kVhPHnkXWcsjh39278bib0Itg87UpHHrN9flUIpMvxbo5zN9om/nFxhZ4Q59qPygqs9vnX
	8S/fUvOWlbmIJ0cMMarIJOLP7HprGOxS59o+OkHxHz3Au4x2qGv9Ich1CylOPG3wwMW6XANodsCGJ
	pFR78mxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNkO3-0000000CjJ8-1x6f;
	Tue, 25 Nov 2025 04:10:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNkNx-0000000CjIg-3oam
	for kexec@lists.infradead.org;
	Tue, 25 Nov 2025 04:10:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764043835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yK36ADvRnvn7Z88J1V2Eb5Oki0HN2SsGScGiByHtlSA=;
	b=ZyItio85uf/mlWYkjgzv7mDVHmdGtXb2MMQrCLrLJHv9XSDFpYzHoBcMKizvtBRtR012ao
	OCW/yVo9Llb+88jDfxumplh+ywCT6HaMLcwVQgQ3KQ5n2h341NbDuGDewgtutpPcs9YWyH
	fVjBPCJ1gg1JayodK2ReWZ+3R2tuiNU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-Qg5NBORmOy-KQ2916fchdg-1; Mon, 24 Nov 2025 23:10:31 -0500
X-MC-Unique: Qg5NBORmOy-KQ2916fchdg-1
X-Mimecast-MFC-AGG-ID: Qg5NBORmOy-KQ2916fchdg_1764043830
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b993eb2701bso4811900a12.0
        for <kexec@lists.infradead.org>; Mon, 24 Nov 2025 20:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764043830; x=1764648630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yK36ADvRnvn7Z88J1V2Eb5Oki0HN2SsGScGiByHtlSA=;
        b=kuQEZpu7BasjhHJcXBT9kNqr5BwwSqirmCdTASyZ8EECdNT0cLPkMk9XKjjJxPtDcX
         7pAr36UvXFC5ce4H27JAlcIFy/1FXI5AXQVixBFmGvx6HZ1Hl7Mz55imQLmb8adp8gJ8
         y783TzcrB6JMvWDixzuQRQvIcn4k6rhrt2b3ONPfcdqW9ObtNLRaQNTpfYmjG/SeZ8Gg
         eHEiIxd301A3tdaIa9tUTACSsbXLbZhUMHrMw0V9nlzkzrYFSuxcM6B/kKvKJTUxrAAb
         qW8WSgZS01pHNmVijAyFuZSFl72TxIOIgK+X8a+VUaq+Z9+ArfDOm8k7LEfX52FXVIaJ
         KmvA==
X-Gm-Message-State: AOJu0Yy83D959jQ5E9v5aHaLeRTvEDH7eL1i1UNpGfzuirC3qWFwHbTR
	qOSKdOYLMPxpee2BRcwwEBZkorZ98ZlFR7zR3e/vE0EcZJW2h5CeIAZuP/+JGevM+Zhn0zqNk//
	s1ORp5f12r3CEsGADV9NMbWiKG4+LqDhtjAFK6cVc7QtALSkxOQd7UnhzKhsqshF+VlPiVjGrs7
	i4mSWryMZmdNDauroxTPClsb4lbqPrhd10dstm
X-Gm-Gg: ASbGncs39LxiDWiCkf3RKfY+EyxdV4vmniZhlDl13q2zT2YP7MPoB3fk9G6lYElMvpG
	nQk2w+OAnlebBu0FalKmO/Mv5RNI8WSui2tx4WKT5hnKSHQkErCWpEGn/zQG60UqxSj4H0DY7PG
	tCIJORGP9ixgFV6zcpOviGJzEh0PbLoxwC81SjnaS/Mz82OAkl56/HMkr+b4JKbYOgqLo=
X-Received: by 2002:a05:7300:3c9d:b0:2a4:3592:c604 with SMTP id 5a478bee46e88-2a94174e0a3mr968009eec.21.1764043830396;
        Mon, 24 Nov 2025 20:10:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgUoue+m7hDF3DbmgObHkl//DmmrJWlhnJcpAhd/7zU+XNPQQveIwUfL2CdEABUBwK3fALWag5I+mmEpqWE4g=
X-Received: by 2002:a05:7300:3c9d:b0:2a4:3592:c604 with SMTP id
 5a478bee46e88-2a94174e0a3mr967995eec.21.1764043829940; Mon, 24 Nov 2025
 20:10:29 -0800 (PST)
MIME-Version: 1.0
References: <20251106065904.10772-1-piliu@redhat.com> <20251124141620.eaef984836fe2edc7acf9179@linux-foundation.org>
In-Reply-To: <20251124141620.eaef984836fe2edc7acf9179@linux-foundation.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 25 Nov 2025 12:10:18 +0800
X-Gm-Features: AWmQ_bls9hRXbIMq8va3xXzXthhHZlNlk1j_k-sv8prZCGat9H5AAgW6u60PH-U
Message-ID: <CAF+s44SPQe9XCopTJcCN-FOfdupc9ZYrj3C+Q3CKfRKFFUYgNg@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] kernel/kexec: Change the prototype of kimage_map_segment()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Baoquan He <bhe@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AYT4vyHa7zF_2_XrfKai3f3qmglK2HVFw8BYgzvHpWo_1764043830
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_201038_044932_EF91D357 
X-CRM114-Status: GOOD (  27.00  )
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

On Tue, Nov 25, 2025 at 6:16=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu,  6 Nov 2025 14:59:03 +0800 Pingfan Liu <piliu@redhat.com> wrote:
>
> > The kexec segment index will be required to extract the corresponding
> > information for that segment in kimage_map_segment(). Additionally,
> > kexec_segment already holds the kexec relocation destination address an=
d
> > size. Therefore, the prototype of kimage_map_segment() can be changed.
>
> Could we please have some reviewer input on thee two patches?
>
> Thanks.
>
> (Pingfan, please cc linux-kernel on patches - it's where people go to
> find emails on lists which they aren't suscribed to)
>
OK, I will cc linux-kernel for the future kexec patches

For this series, it can also be found on
https://lore.kernel.org/linux-integrity/20251106065904.10772-1-piliu@redhat=
.com/

Thanks,

Pingfan

> (akpm goes off and subscribes to kexec@)
>
> > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: <stable@vger.kernel.org>
> > To: kexec@lists.infradead.org
> > To: linux-integrity@vger.kernel.org
> > ---
> >  include/linux/kexec.h              | 4 ++--
> >  kernel/kexec_core.c                | 9 ++++++---
> >  security/integrity/ima/ima_kexec.c | 4 +---
> >  3 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index ff7e231b0485..8a22bc9b8c6c 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -530,7 +530,7 @@ extern bool kexec_file_dbg_print;
> >  #define kexec_dprintk(fmt, arg...) \
> >          do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0=
)
> >
> > -extern void *kimage_map_segment(struct kimage *image, unsigned long ad=
dr, unsigned long size);
> > +extern void *kimage_map_segment(struct kimage *image, int idx);
> >  extern void kimage_unmap_segment(void *buffer);
> >  #else /* !CONFIG_KEXEC_CORE */
> >  struct pt_regs;
> > @@ -540,7 +540,7 @@ static inline void __crash_kexec(struct pt_regs *re=
gs) { }
> >  static inline void crash_kexec(struct pt_regs *regs) { }
> >  static inline int kexec_should_crash(struct task_struct *p) { return 0=
; }
> >  static inline int kexec_crash_loaded(void) { return 0; }
> > -static inline void *kimage_map_segment(struct kimage *image, unsigned =
long addr, unsigned long size)
> > +static inline void *kimage_map_segment(struct kimage *image, int idx)
> >  { return NULL; }
> >  static inline void kimage_unmap_segment(void *buffer) { }
> >  #define kexec_in_progress false
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index fa00b239c5d9..9a1966207041 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -960,17 +960,20 @@ int kimage_load_segment(struct kimage *image, int=
 idx)
> >       return result;
> >  }
> >
> > -void *kimage_map_segment(struct kimage *image,
> > -                      unsigned long addr, unsigned long size)
> > +void *kimage_map_segment(struct kimage *image, int idx)
> >  {
> > +     unsigned long addr, size, eaddr;
> >       unsigned long src_page_addr, dest_page_addr =3D 0;
> > -     unsigned long eaddr =3D addr + size;
> >       kimage_entry_t *ptr, entry;
> >       struct page **src_pages;
> >       unsigned int npages;
> >       void *vaddr =3D NULL;
> >       int i;
> >
> > +     addr =3D image->segment[idx].mem;
> > +     size =3D image->segment[idx].memsz;
> > +     eaddr =3D addr + size;
> > +
> >       /*
> >        * Collect the source pages and map them in a contiguous VA range=
.
> >        */
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/im=
a/ima_kexec.c
> > index 7362f68f2d8b..5beb69edd12f 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -250,9 +250,7 @@ void ima_kexec_post_load(struct kimage *image)
> >       if (!image->ima_buffer_addr)
> >               return;
> >
> > -     ima_kexec_buffer =3D kimage_map_segment(image,
> > -                                           image->ima_buffer_addr,
> > -                                           image->ima_buffer_size);
> > +     ima_kexec_buffer =3D kimage_map_segment(image, image->ima_segment=
_index);
> >       if (!ima_kexec_buffer) {
> >               pr_err("Could not map measurements buffer.\n");
> >               return;
> > --
> > 2.49.0
>


