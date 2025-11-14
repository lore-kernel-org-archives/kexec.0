Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5513CE8D60
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 17:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0TVgXqLqg97YQ/m1CXUTN7T2KTMv0q/tzdoKWytqb20=; b=XbkNB0UStoMoVWpJE5QJe/LV6z
	A1TK3nU6HLfxKiBo+tWVOtPjcMtilxI/vuDCWT7fZLzNGLVFrTPlA6pwMROLIyx9WBvJlSs1hkHvv
	N575+YVfPOGJDzgMwfQSb562hbh2XbZ1IRK4DwOPLC3Rv8QMHSW1VAMKDBr7vuBop14VpXIkdllGw
	sGf9kpThEprA5GpxV1OdywkI1vv7GS9JZLDAmkT+LVlZvl20ZVzuDi473WVxLxvHG4OMRInDlp5Ti
	DAfMiGtiJHEg71K1G79ZEGWXv2vb91VMLf+IZ2T9tL7x929fNgDDgmiupxhItbtBfToJKjjCOQ4NA
	tssih59w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxUp-0000000CpYL-0VPo;
	Fri, 14 Nov 2025 17:22:03 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxUm-0000000CpXo-2xYH
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 17:22:01 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so4090316a12.0
        for <kexec@lists.infradead.org>; Fri, 14 Nov 2025 09:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763140919; x=1763745719; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TVgXqLqg97YQ/m1CXUTN7T2KTMv0q/tzdoKWytqb20=;
        b=XN3e+H2/o2AXHgRKaAMkv0r5wVq8b7S+ul4yI3pUccizuo+0jE1MZlabNrYDhECNQy
         wmaDrA5jspWgDXdwHVLjCpPjtdQPqzRPgM4i5SeVY+CNBowL+FpiXOdMyFMO3xedlIJt
         D3J9c0Fr/eTFBYiRtaNlWPTp49Ap3ou4VvOi3l7XJE1xUW0wr7YQes9IUpBF/PPCjVls
         na97DUl9DxznJMf+J18Bc83SMaRxsMMN3jybk5+N1lu/56GiHuBViKoNGDsrFVBW1kO8
         06K1XI8mRfZWUUxI/71dFMZOq5v1hIPdBg7Sa4A0ZYxbG6kSILctti8IV2GtTZLpYrZq
         TLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763140919; x=1763745719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0TVgXqLqg97YQ/m1CXUTN7T2KTMv0q/tzdoKWytqb20=;
        b=jZF20fGrcgsCympQPul/IDHBjoRklQNJ0NtAofOhM5RqPDQlzl+H4GUVj9LJGtgS0K
         w/DX3yK2MZmEQetHispPdl1ZtyfH/CLEuBOp8kDiIr5wIcehLaRkdIvydyjikmwQdFTj
         k5rzdb/tD1TNqU0CULI9N3D94r1qzx1iKT+rvrDEJAmWC71DLFXmJkgg0+jT1rBmXadk
         Qv9T9RaCIfQOtqjQq+IBS/7mU2bZxq2a9ZBCPg7octJsfD40gLrZ3SHhq6VTQT0pclh9
         QnBVRF0uSJU3fePGrQH1Zj+yFbGVc4df52bo+25mGSTnKHXjJt4guRhSLiCuED70/Z/m
         L8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXwL925/QduEFzY7lDfcLBjB7whX4mHcvVMN0h97AKAHglreTrOY3KGycy0GARNvQobkAXu6w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4ZanOvma9V4HY7vCKvUcLIEaBRItRNEiBxPX2vgbzv2up3ej+
	QeiVf/+BO0UDx0EhZ4yhlay420Wh/gbH0rXSs0jIaDSvg3j91Fqm9YyX9sKnr6yFeWF3Npgskfb
	61EJqGwYrgunAp8xievPbmdAwj7mu9uusgxQT43wR2w==
X-Gm-Gg: ASbGncuL/xvFvVLIsm7rMvh0OLKnYVRlXpbWYV6muMcrDID4maXKsQu0s1gp6rpehDb
	wijPl8a4QFU1rIG3wB1yYDJTwjFXffiMO/yA9uvXFjPYEFxAnjsc0cEt/P50P6qChPDSeXQxMNy
	BjSYn6zOaodWCPYEwGsh/FaC8c+uEx5WPB7LTvl3pFc2UpxMqtTTkZORISjJJZczPwEKOXVRhXv
	L4RqrNYRBeDThYzewXLm7phoqDFG8U5Q88+VM8NQeklvf8jHnkgyet7mq/QAsFl7T9ApQ+WDb2h
	Xcg=
X-Google-Smtp-Source: AGHT+IHYCGe5EZttu74Kr7Wh87nzjge4/R6w5u4bJFNP5Xp7DoWHA3m+n/3j2Vr/nlr7+Zv6hOy2EF3HxmxGzlfQyHg=
X-Received: by 2002:a05:6402:42c8:b0:640:abd5:863d with SMTP id
 4fb4d7f45d1cf-64350e869b2mr3251200a12.20.1763140918227; Fri, 14 Nov 2025
 09:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
 <20251114155358.2884014-5-pasha.tatashin@soleen.com> <mafs0tsyw7e0a.fsf@kernel.org>
In-Reply-To: <mafs0tsyw7e0a.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 12:21:22 -0500
X-Gm-Features: AWmQ_bkwQNcWIMU2RTcQ4saxk90WtRQeCs4SP12Mj6QMS9uqJrYZtq9AM6guyhU
Message-ID: <CA+CK2bALea-5wDyaU2gMYo==yOvrdj=V6FKc4g7G8KV_vgV6Mw@mail.gmail.com>
Subject: Re: [PATCH v1 04/13] kho: Verify deserialization status and fix FDT
 alignment access
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org, 
	jasonmiu@google.com, arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca, 
	ebiggers@google.com, graf@amazon.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_092200_770157_20F8A80F 
X-CRM114-Status: GOOD (  29.47  )
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

On Fri, Nov 14, 2025 at 11:52=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Fri, Nov 14 2025, Pasha Tatashin wrote:
>
> > During boot, kho_restore_folio() relies on the memory map having been
> > successfully deserialized. If deserialization fails or no map is presen=
t,
> > attempting to restore the FDT folio is unsafe.
> >
> > Update kho_mem_deserialize() to return a boolean indicating success. Us=
e
> > this return value in kho_memory_init() to disable KHO if deserializatio=
n
> > fails. Also, the incoming FDT folio is never used, there is no reason t=
o
> > restore it.
> >
> > Additionally, use memcpy() to retrieve the memory map pointer from the =
FDT.
> > FDT properties are not guaranteed to be naturally aligned, and accessin=
g
> > a 64-bit value via a pointer that is only 32-bit aligned can cause faul=
ts.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 32 ++++++++++++++++++------------
> >  1 file changed, 19 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index a4b33ca79246..83aca3b4af15 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -450,20 +450,28 @@ static void __init deserialize_bitmap(unsigned in=
t order,
> >       }
> >  }
> >
> > -static void __init kho_mem_deserialize(const void *fdt)
> > +/* Return true if memory was deserizlied */
> > +static bool __init kho_mem_deserialize(const void *fdt)
> >  {
> >       struct khoser_mem_chunk *chunk;
> > -     const phys_addr_t *mem;
> > +     const void *mem_ptr;
> > +     u64 mem;
> >       int len;
> >
> > -     mem =3D fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
> > -
> > -     if (!mem || len !=3D sizeof(*mem)) {
> > +     mem_ptr =3D fdt_getprop(fdt, 0, PROP_PRESERVED_MEMORY_MAP, &len);
> > +     if (!mem_ptr || len !=3D sizeof(u64)) {
> >               pr_err("failed to get preserved memory bitmaps\n");
> > -             return;
> > +             return false;
> >       }
> > +     /* FDT guarantees 32-bit alignment, have to use memcpy */
> > +     memcpy(&mem, mem_ptr, len);
>
> Perhaps get_unaligned(mem) would have been simpler?

Hm, it certainly more descriptive. I will see if I can use it.

>
> > +
> > +     chunk =3D mem ? phys_to_virt(mem) : NULL;
> > +
> > +     /* No preserved physical pages were passed, no deserialization */
> > +     if (!chunk)
> > +             return false;
>
> Should we disallow all kho_restore_{folio,pages}() calls too if this
> fails? Ideally those should never happen since kho_retrieve_subtree()
> will fail, so maybe as a debug aid?

Right, my thinking was that they should never happen, as they do not
have a way to know the location of folios to be restored. So,
preventing FDT access that we do does that.


>
> >
> > -     chunk =3D *mem ? phys_to_virt(*mem) : NULL;
> >       while (chunk) {
> >               unsigned int i;
> >
> > @@ -472,6 +480,8 @@ static void __init kho_mem_deserialize(const void *=
fdt)
> >                                          &chunk->bitmaps[i]);
> >               chunk =3D KHOSER_LOAD_PTR(chunk->hdr.next);
> >       }
> > +
> > +     return true;
> >  }
> >
> >  /*
> > @@ -1377,16 +1387,12 @@ static void __init kho_release_scratch(void)
> >
> >  void __init kho_memory_init(void)
> >  {
> > -     struct folio *folio;
> > -
> >       if (kho_in.scratch_phys) {
> >               kho_scratch =3D phys_to_virt(kho_in.scratch_phys);
> >               kho_release_scratch();
> >
> > -             kho_mem_deserialize(kho_get_fdt());
> > -             folio =3D kho_restore_folio(kho_in.fdt_phys);
> > -             if (!folio)
> > -                     pr_warn("failed to restore folio for KHO fdt\n");
> > +             if (!kho_mem_deserialize(kho_get_fdt()))
> > +                     kho_in.fdt_phys =3D 0;
>
> The folio restore does serve a purpose: it accounts for that folio in
> the system's total memory. See the call to adjust_managed_page_count()
> in kho_restore_page(). In practice, I don't think it makes much of a
> difference, but I don't see why not.
>
> >       } else {
> >               kho_reserve_scratch();
> >       }
>
> --
> Regards,
> Pratyush Yadav

