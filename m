Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B6BCCF9F8
	for <kexec@archiver.kernel.org>; Thu,  6 Nov 2025 06:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5om+jgkF7lMNLCSif3n8iVPJleVZd8uHxQY35uUaYt4=; b=ogIK7tX0TEP26XUtNdilVd7ZV4
	v2vHkFzYBN64XEekp0ZDGDr+5K8rEn9LxQWDqkCTpwtQ1tr4OFcf3s39XcFS0d0Oi1KnheYJ8QrO9
	K211dmBy9A2nxSQN89sI9nnmQhMG9RhS4n08p6t0egei5KpxNPrxhADLM20/OYHvEp1K//LnYzV/C
	QdYlDL9InJEUky5KW9ttnzckOCA6F+tS7jjAh2q73CmQjblKzV1QP14KsCTUCaqOzMq0O9taggjP4
	7bNlIP26rB9J2pG6mJy9LMoyrOOWeRbAy8Day4LQTUL/1BIzRmi09n+Rel1YUlumRnisyc9PtOAFM
	PaulH1Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGtvM-0000000EyGo-3qqE;
	Thu, 06 Nov 2025 06:56:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGtvJ-0000000EyGO-07I7
	for kexec@lists.infradead.org;
	Thu, 06 Nov 2025 06:56:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762412203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5om+jgkF7lMNLCSif3n8iVPJleVZd8uHxQY35uUaYt4=;
	b=NVebCcOV29Sjctore4xUNWag82Pj2en5eDSRZC3eYFPaJjq1cLILMgXFY+rM+VuedQYArq
	3H4tSTKVSDIaIKlL0xjq18gz5g/u3QRN/iiA+SF+HaKDSZWOBhzXYceLYtLUJJaWEf3H/n
	PXBdHrwt1fkHRilboH4ip8B5KyOQ5uo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-ih9JhdVKN7ikOJV_T1vRiQ-1; Thu, 06 Nov 2025 01:56:39 -0500
X-MC-Unique: ih9JhdVKN7ikOJV_T1vRiQ-1
X-Mimecast-MFC-AGG-ID: ih9JhdVKN7ikOJV_T1vRiQ_1762412199
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-782063922ceso198005b3a.0
        for <kexec@lists.infradead.org>; Wed, 05 Nov 2025 22:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762412199; x=1763016999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5om+jgkF7lMNLCSif3n8iVPJleVZd8uHxQY35uUaYt4=;
        b=QQzRLmJuNbBQeOShCbOyFYPUqCnEJTtHD7fWgnLrzLMTVnRAAmEsTkkFlqhG1xLgSu
         yXKA2XJy1ujRclvmGgqixeFL5lBxvCTELv4D9+Rle7TdE5mHGiLzRzNz3/FlymeFk17h
         dNV6roxxjDVmm39P5iRXWQE7K5xBoCydUk1vYFkrwmxTNSYSHmhbxkT2SVgWtIjw1xTy
         TSiCbml48ArF2nxFPqqMvz4hw8lu+U8KCLCRFC+eU2j8YJ9Q8wurWCaGMF13vn9bSPYx
         U9lF0VMvkzbJF+I4/rTBHFd/GkIwX0inptHWTrbybNCp7yKXYUqZqFPzyCcVY6Rn+Ao5
         FZRw==
X-Gm-Message-State: AOJu0YxM6JfmbgbFaAMdBhDcvV8EAU+2hIwrMOI5/iiBYmHH/VsbzViJ
	q2qzq7J1t86ESZiqAgLFVHWl8tTOgdHFlVLCMwpn9e89O8B/4WvPp5RGVfyLLtBLO/uZ3jIInbb
	BHcNxev/GFtAxU+W9YhBCeu676eKexdG/Ups95JsSbZl1aqgv9gdgS5mQVjICU34CdXP6cipckj
	UZqNqza4uA0i+iQMwWDFGL0Smmw9Eq3Trgv1ep
X-Gm-Gg: ASbGncvKFjjklGDd8dYfiGJf/RBTRkodGf7215tjCI50U4mfb6qDWDpFCv0KyjPgLUW
	4S6uIgjM5IeLsjcSnJ8fXvsTH0Cssc47ZmUOpZ2xvdCB/QEGoPp+OAuadYXkVD9CPLTo5DCqJcJ
	H43VAFbyHGyI48mD0uOpR2eNhXcU2OndAXnTQTLjExeNeP02mkRzs25DtD
X-Received: by 2002:a05:6a20:9186:b0:34e:e0ba:7c1 with SMTP id adf61e73a8af0-34f839e0371mr7539087637.6.1762412198858;
        Wed, 05 Nov 2025 22:56:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwXf06EEtGqGt59eNE630eIQryoAHY3nsXO3Hk+QYKm+lQdENUtVhqE0eUA9haxSSEpTHDrv5myNmqIZbmVw4=
X-Received: by 2002:a05:6a20:9186:b0:34e:e0ba:7c1 with SMTP id
 adf61e73a8af0-34f839e0371mr7539064637.6.1762412198513; Wed, 05 Nov 2025
 22:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20251105130922.13321-1-piliu@redhat.com> <20251105130922.13321-2-piliu@redhat.com>
 <aQwCDMhidg+a2Jzt@MiWiFi-R3L-srv> <CAF+s44StrV1USH4ZLQ6DRobXA=hXOs6EVkmeeeTsK-koWsV_KQ@mail.gmail.com>
 <aQwUUh3noWGXaite@MiWiFi-R3L-srv>
In-Reply-To: <aQwUUh3noWGXaite@MiWiFi-R3L-srv>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 6 Nov 2025 14:56:27 +0800
X-Gm-Features: AWmQ_bmDJKbpbWUjPVU7pY3OEsXiayXePeKuaPXhcc9NBNJcotJApHoGGTl8gVw
Message-ID: <CAF+s44QzxjPpWkBLrO1WpORy+QTj2=mFRJFeuPsGvp9K=hfKJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in CMA area
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7C93_aqF6Rv4hfp0dK9EEO4uSBW4KLsHvhUkSTyVKr8_1762412199
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_225645_144543_42BC74F8 
X-CRM114-Status: GOOD (  27.39  )
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

On Thu, Nov 6, 2025 at 11:22=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 11/06/25 at 10:33am, Pingfan Liu wrote:
> > Hi Baoquan,
> >
> > Thanks for your review. Please see the comment below.
> >
> > On Thu, Nov 6, 2025 at 10:04=E2=80=AFAM Baoquan He <bhe@redhat.com> wro=
te:
> > >
> > > Hi Pingfan,
> > >
> > > On 11/05/25 at 09:09pm, Pingfan Liu wrote:
> > > > When I tested kexec with the latest kernel, I ran into the followin=
g warning:
> > > >
> > > > [   40.712410] ------------[ cut here ]------------
> > > > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:100=
1 kimage_map_segment+0x144/0x198
> > > > [...]
> > > > [   40.816047] Call trace:
> > > > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > > > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > > > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > > > [...]
> > > > [   40.855423] ---[ end trace 0000000000000000 ]---
> > > >
> > > > This is caused by the fact that kexec allocates the destination dir=
ectly
> > > > in the CMA area. In that case, the CMA kernel address should be exp=
orted
> > > > directly to the IMA component, instead of using the vmalloc'd addre=
ss.
> > > >
> > > > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Baoquan He <bhe@redhat.com>
> > > > Cc: Alexander Graf <graf@amazon.com>
> > > > Cc: Steven Chen <chenste@linux.microsoft.com>
> > > > Cc: linux-integrity@vger.kernel.org
> > > > To: kexec@lists.infradead.org
> > > > ---
> > > >  kernel/kexec_core.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > > index 9a1966207041..abe40286a02c 100644
> > > > --- a/kernel/kexec_core.c
> > > > +++ b/kernel/kexec_core.c
> > > > @@ -967,6 +967,7 @@ void *kimage_map_segment(struct kimage *image, =
int idx)
> > > >       kimage_entry_t *ptr, entry;
> > > >       struct page **src_pages;
> > > >       unsigned int npages;
> > > > +     struct page *cma;
> > > >       void *vaddr =3D NULL;
> > > >       int i;
> > > >
> > > > @@ -974,6 +975,9 @@ void *kimage_map_segment(struct kimage *image, =
int idx)
> > > >       size =3D image->segment[idx].memsz;
> > > >       eaddr =3D addr + size;
> > > >
> > > > +     cma =3D image->segment_cma[idx];
> > >
> > > Thanks for your fix. But I totally can't get what you are doing. The =
idx
> > > passed into kimage_map_segment() could index image->segment[], and ca=
n
> > > index image->segment_cma[], could you reconsider and make the code mo=
re
> > > reasonable?
> > >
> >
> > Since idx can index both image->segment[] and segment_cma[], the
> > behavior differs based on whether segment_cma[idx] is NULL:
> >
> > - If segment_cma[idx] is not NULL, it points directly to the final
> > target location, eliminating the need for data copying that
> > traditional kexec relocation requires.
> > - If segment_cma[idx] is NULL, the segment relies on the traditional
> > kexec relocation code to copy its data.
>
> I see, thanks. While image->segment_cma[idx] records the struct page of
> the relevant cma area, but not virtual address. Is it OK for IMA later

Oops. It requires page_address(page) to convert the address. I will
send out V2 to fix it.

Thanks,

Pingfan


