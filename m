Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5AECCF9F8
	for <kexec@archiver.kernel.org>; Thu,  6 Nov 2025 10:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hr+IrPZu54jtoYs0y4pJPw8+metTYxP5F0Z/JHnlZZI=; b=oRCkZn/t2ZS6CmS4dGY+oWFFO5
	IZGWw+hLJ2f5BlPIzCt8xETJN+RBWhBSUQWBVHpy0hFyjBw0bKi0cQwv5vwaeTPAMjzTN0hw/dmP2
	X9lmatOyXCRyDegkENjOqEgv4sv00YeDUY/waCJwXIyLC7FJ06WTtbjlqRlEkJbQAs4YrV9jOlZND
	6nYQ4uueiinCB193S94AznR5WYnGX3cMr0AHvPPykU6cBNbVeODkSLI8h9Yi/s2CJpj8M+jB0ah3H
	fs7p3gbe/O5nkSVs1A5SO753Rv9Od0X9BlZrHrwJIqBoBXYqMqH582ITO1sbeAmv8bAZNjnhSxtUK
	/SGMFhlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGwob-0000000FEQ5-1qTY;
	Thu, 06 Nov 2025 10:02:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGwoX-0000000FEPI-0vNs
	for kexec@lists.infradead.org;
	Thu, 06 Nov 2025 10:02:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762423315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hr+IrPZu54jtoYs0y4pJPw8+metTYxP5F0Z/JHnlZZI=;
	b=XlxyrlLeGbKxLSNsaCRYfOqC0rpmOMmXtwNgeNb+a0HCqhGPlsaie/MKU5PxjmLxYaPPIr
	1vsmFYARLp6jABC061BfLfimuv92QlAE+tXw3d9pYovNr27RabHs5K9mR+oPaRM99Zj5rP
	ZC6TJT4jeI1KwTPwZTH0jFiJNg7gwVw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Cl1itsE0OUWVJxbaJfgx0Q-1; Thu, 06 Nov 2025 05:01:54 -0500
X-MC-Unique: Cl1itsE0OUWVJxbaJfgx0Q-1
X-Mimecast-MFC-AGG-ID: Cl1itsE0OUWVJxbaJfgx0Q_1762423313
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295592eb5dbso11435695ad.0
        for <kexec@lists.infradead.org>; Thu, 06 Nov 2025 02:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423313; x=1763028113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr+IrPZu54jtoYs0y4pJPw8+metTYxP5F0Z/JHnlZZI=;
        b=eXPzew8vln2nTTzbmQftAt8iRWVRl1oOLTuWnjC8EwUedonwnjqb/1UcddMOozxyy8
         f1SBmNGnK9xgez33isAFhepF4r6Q15o45toWJr92ps4f2qJ1hzGejnI3fRJI+X76SFvh
         qF2/Na/+SEkgjc+ZDuuTz8qt8mMFXwVSd8tC1u9h4IdPFffWyeZiv1qIidtpChjRx6Mg
         d55pXos2HnCcKB1QqeAE+aqmae+5hC8Ar5rwpfMctsKNXDteBbiE9ggY0qC6YexvsXiM
         miE2GqZDQFNOPPLnbiln4XTKMvGyu1/CpMCjFhFGVkfIT3DVGTZuHhSRTIBGD/KkSrIf
         JzTg==
X-Gm-Message-State: AOJu0Yzd6tHEwxoCJ7S+qHBHMWiTo4SA1kIyvPVpR0MGRZF95I/A5brE
	7LmsIEzuemLDnvN0V6VnZYTGgczepuzBkV5JvVAv7CiF3WjcIr8gvCVpSlo4lTSEUPxoigwGJFq
	DJ46NMEzRHhZpqoapkYYERah1NnLgEVSvlwpE8SFBAJnGzrndEqbVbz1UlICh312eTKb2U24g+U
	bMHTt+Y7QEa2o3nAt5oxYR7LE9/Dj6vLhBdAXa0eOfLE9I8ZY=
X-Gm-Gg: ASbGncsmCySDMPoJ1gdgTETDscaMjGQQHXt2+NN0VRpCldz5LNlHTjSwzkWourOR/bJ
	3fHCdI/XneHJ6NRJKu6qnnA71KCAOMEQab2eiLN2BzjUZ5vtDhL10prMp8evIP4/V0721oUKdv2
	ct9xg742M+NbXXdfwnA+JlpQhT+hBOS/Ng5Ya3kUEnts4gOY005fEVh5lh
X-Received: by 2002:a17:902:d48c:b0:294:ccc6:ccfd with SMTP id d9443c01a7336-2962ad1bdffmr91649335ad.24.1762423313110;
        Thu, 06 Nov 2025 02:01:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW3KVhLVq482NdCe7C1dgbyTYFG/2bSxtBHpewavKdNS1gj51nLasKmnsU0eaoXCfCFgVktlKV3Z5WRrEjvJ4=
X-Received: by 2002:a17:902:d48c:b0:294:ccc6:ccfd with SMTP id
 d9443c01a7336-2962ad1bdffmr91649025ad.24.1762423312666; Thu, 06 Nov 2025
 02:01:52 -0800 (PST)
MIME-Version: 1.0
References: <20251106065904.10772-1-piliu@redhat.com> <20251106065904.10772-2-piliu@redhat.com>
 <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv>
In-Reply-To: <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 6 Nov 2025 18:01:41 +0800
X-Gm-Features: AWmQ_bkaQwEAwJSjgkaHYwD9xdB2_CzxgOPAM8h5-6gfOG4JNmJZCcRMLtwCKcw
Message-ID: <CAF+s44TyM7sBVmGn7kn5Cw+Ygm02F93hchiSBN0Q_qR=oA+DLg@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UEXehS514VI7yQOoQIkqDXsMq264nMlV1KCCtESlQHk_1762423313
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_020157_330672_3FF8ECFE 
X-CRM114-Status: GOOD (  26.16  )
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

On Thu, Nov 6, 2025 at 4:01=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 11/06/25 at 02:59pm, Pingfan Liu wrote:
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
>
> Well, you didn't update the log accordingly.
>

I am not sure what you mean. Do you mean the earlier content which I
replied to you?

> Do you know why cma area can't be mapped into vmalloc?
>
Should not the kernel direct mapping be used?

Thanks,

Pingfan
> >
> > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: linux-integrity@vger.kernel.org
> > Cc: <stable@vger.kernel.org>
> > To: kexec@lists.infradead.org
> > ---
> > v1 -> v2:
> > return page_address(page) instead of *page
> >
> >  kernel/kexec_core.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 9a1966207041..332204204e53 100644
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
> > +     if (cma)
> > +             return page_address(cma);
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


