Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C314CCF9F8
	for <kexec@archiver.kernel.org>; Thu,  6 Nov 2025 02:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yKO0jQM7c+UeOx9mMhDNDpMYJPkI1D9+LEqkYZlqE/I=; b=c5rRDJuDq0uf+oYjNuoTi74fck
	cpHs/WMuT9ANJWPprlTI7Ua0Pddfzip9zaDNt/LKZdnGyoBGKngGLQfkv2tWlE563OQroeVzxd+ti
	yMB8OJpjoXzINiLPRsvWqY7GvJlBN/86M5gUwKQ8f5SwbLZWB+gJdSWmukzXDcifRmy8QhImQAysv
	fq4SjfF+oQvqTLa69TdaniWXWzFvDGwCNhalVEMQ5FVKS3LXKMh9WBcZ+Cmez84RfZWY/Nb06rDSq
	yXU14SOiHpgavL6xKnJ20T/20xBCYjSVW48Hop9boTB+0uxRWnHQPCYhEegmbSDHPmqHWYJeqB0Lr
	ffXwV5Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGpof-0000000Ell0-1cYp;
	Thu, 06 Nov 2025 02:33:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGpob-0000000ElkZ-1Jqg
	for kexec@lists.infradead.org;
	Thu, 06 Nov 2025 02:33:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762396412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKO0jQM7c+UeOx9mMhDNDpMYJPkI1D9+LEqkYZlqE/I=;
	b=iJ1mZUXxZjd974+fiuTZO9YjzAKkPyKQ+wkre/pDmZ+zvaCsmszgKRBejRb3z8RsTdK7hG
	VE2++333IvbY5JqF1W1cEU0nqm8/ftSyTL6ijCwljXfzPIITk3I6nBLPvKh9pSks4hVcPH
	Y0WCR42KCx9ETZ7DOL0NIJoHko0ak9o=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-QVVc_hToOp6Bb5W4xDjgaw-1; Wed, 05 Nov 2025 21:33:30 -0500
X-MC-Unique: QVVc_hToOp6Bb5W4xDjgaw-1
X-Mimecast-MFC-AGG-ID: QVVc_hToOp6Bb5W4xDjgaw_1762396409
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso946139a12.2
        for <kexec@lists.infradead.org>; Wed, 05 Nov 2025 18:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762396409; x=1763001209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKO0jQM7c+UeOx9mMhDNDpMYJPkI1D9+LEqkYZlqE/I=;
        b=FRPRirRTtt0pTRbmMj4eU875A3h4bDMskuz7+r4aPMWZRQL29rKkaNiKfeJw3m4BHw
         WW/x56UxKqXuS8LfnQ84QLjgUxYa0nEbeprUbclbEXmeRJF4SQdU8sEns7tyaikaN8hX
         41v6vrAImHT3Yq9KOfcHoHsV8k6CJVZOaLYgDo/3fBJu27bQWIKQsSqfPts6iyJDsdrx
         PwfJ1oNFQdiZoJj47tezKxDZKyqWg9KmLeVRcwU3fDpb3XcwtY/yWpBcUy384lWuGAO4
         +3QsgRW2hNj/dmSSBRky04h/8jH6H625veJGGwvxHhDu38OdZd58nYT3xXfBAMASzSIw
         syGw==
X-Gm-Message-State: AOJu0YwNiPodfipZjexO9Gs/1x6sksUdNWx/TJ3BXztC19pYP+VD7wpv
	fbXFY+VxjvDFWvS34gY1GN/rTXrHp59D9xR87MVtHT0e8mKsG1jFS2I+MXT3MKJL7HGRyEmSZm+
	3ROmsOYd83ZzZQYqLD8nNJdkhkBFNUAmSRuwIIg76T7cvUU2wbnVbrK+opZFT+qaemieuiSjYhH
	+9aY0taCoz1uJeBzbstIHH4Nu360a/7R+RyC3XsrqcaMfISQ/88zag
X-Gm-Gg: ASbGncvEOVoBIm15R8PbPTlTMZEPiAdjfG6nQK32ildwMDSBTBAqe+Y0f8y6AXVF4YD
	K1wAtBlqKS1TedWcwPz0fwpTK9KTshTJpSOv4lAuDn/SzBtoyJjWSe+P+VG2MsTx1xrNlHZg+zg
	ddof0PjMFff0wQmzFy2UDCsuQmQ6eEzK0qwNQy5TM3PDYKTIpsCOUT9S9r
X-Received: by 2002:a05:6a20:7fa6:b0:341:1dc6:aea with SMTP id adf61e73a8af0-34f80c9ec3fmr7522562637.0.1762396409278;
        Wed, 05 Nov 2025 18:33:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJiJnwI3+a6JpU1049glaBP/bHDR83VsC+UC84UXCO/uIZ9yubYNrF9cD7W/tL+0bV0yMl7bp3nZqx31DthMo=
X-Received: by 2002:a05:6a20:7fa6:b0:341:1dc6:aea with SMTP id
 adf61e73a8af0-34f80c9ec3fmr7522543637.0.1762396408945; Wed, 05 Nov 2025
 18:33:28 -0800 (PST)
MIME-Version: 1.0
References: <20251105130922.13321-1-piliu@redhat.com> <20251105130922.13321-2-piliu@redhat.com>
 <aQwCDMhidg+a2Jzt@MiWiFi-R3L-srv>
In-Reply-To: <aQwCDMhidg+a2Jzt@MiWiFi-R3L-srv>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 6 Nov 2025 10:33:17 +0800
X-Gm-Features: AWmQ_bmryauOB9ZCZ0k0YycHU0cpkpY0xr2TTfmcbnK7K9r18U3Qc4Rj3H82sZM
Message-ID: <CAF+s44StrV1USH4ZLQ6DRobXA=hXOs6EVkmeeeTsK-koWsV_KQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in CMA area
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JXI-IjtonNsg9VP4V5k__j1epJb0iPLDRKcRfqmLGDc_1762396409
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_183333_773988_4ADAF10E 
X-CRM114-Status: GOOD (  27.18  )
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

Hi Baoquan,

Thanks for your review. Please see the comment below.

On Thu, Nov 6, 2025 at 10:04=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Pingfan,
>
> On 11/05/25 at 09:09pm, Pingfan Liu wrote:
> > When I tested kexec with the latest kernel, I ran into the following wa=
rning:
> >
> > [   40.712410] ------------[ cut here ]------------
> > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 ki=
mage_map_segment+0x144/0x198
> > [...]
> > [   40.816047] Call trace:
> > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > [...]
> > [   40.855423] ---[ end trace 0000000000000000 ]---
> >
> > This is caused by the fact that kexec allocates the destination directl=
y
> > in the CMA area. In that case, the CMA kernel address should be exporte=
d
> > directly to the IMA component, instead of using the vmalloc'd address.
> >
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: linux-integrity@vger.kernel.org
> > To: kexec@lists.infradead.org
> > ---
> >  kernel/kexec_core.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 9a1966207041..abe40286a02c 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -967,6 +967,7 @@ void *kimage_map_segment(struct kimage *image, int =
idx)
> >       kimage_entry_t *ptr, entry;
> >       struct page **src_pages;
> >       unsigned int npages;
> > +     struct page *cma;
> >       void *vaddr =3D NULL;
> >       int i;
> >
> > @@ -974,6 +975,9 @@ void *kimage_map_segment(struct kimage *image, int =
idx)
> >       size =3D image->segment[idx].memsz;
> >       eaddr =3D addr + size;
> >
> > +     cma =3D image->segment_cma[idx];
>
> Thanks for your fix. But I totally can't get what you are doing. The idx
> passed into kimage_map_segment() could index image->segment[], and can
> index image->segment_cma[], could you reconsider and make the code more
> reasonable?
>

Since idx can index both image->segment[] and segment_cma[], the
behavior differs based on whether segment_cma[idx] is NULL:

- If segment_cma[idx] is not NULL, it points directly to the final
target location, eliminating the need for data copying that
traditional kexec relocation requires.
- If segment_cma[idx] is NULL, the segment relies on the traditional
kexec relocation code to copy its data.


Thanks,

Pingfan


> > +     if (cma)
> > +             return cma;
> >       /*
> >        * Collect the source pages and map them in a contiguous VA range=
.
> >        */
> > @@ -1014,7 +1018,8 @@ void *kimage_map_segment(struct kimage *image, in=
t idx)
> >
> >  void kimage_unmap_segment(void *segment_buffer)
> >  {
> > -     vunmap(segment_buffer);
> > +     if (is_vmalloc_addr(segment_buffer))
> > +             vunmap(segment_buffer);
> >  }
> >
> >  struct kexec_load_limit {
> > --
> > 2.49.0
> >
>


