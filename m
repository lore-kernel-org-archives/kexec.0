Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8239C25B78
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 01:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V4/aMe9c+lnBeshKV+TL/RPwmgmhLh+Jq9dg+TSUvFs=; b=RzqQe5RIta5Bwh
	5Y9E0QNeR2y57EY1kKS+Eo4K/k/EmhmZzkljtfsnYDozZm1IOT2/fwjzoZElWsHzgDAiGTr3Se66G
	zjqa8Juqc7ZIBDEeAkLkvdE3BasNz7A8oGZTB6T++y2YdYKtoy+cljEM+ELgZGcFGa3wBpuUYh7B1
	Ls5xutGRlTTg+2Lw6P/cMW1b3ruw9oKd3QlKoM23PcZDu/oaPN4hz+k+U6FPznwkGMvPqEOCAJqiB
	2eaPEnXdtuN5U91246UPvwMJeukL3Y/vRN0eYwKcG/EfJVVp1+Xk+qYaazbvU3WFm32K4A+SfU3WY
	7kIFLAC5Nc0B0JGnCPMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEfvM-00000004Pqw-2Q9b;
	Wed, 05 Jun 2024 01:58:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEfvJ-00000004Pps-2Z0b
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 01:58:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717552723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bDq7LAUeG1zx3wFqxyw1+1sNdwa7aIwSKaoX8NuYSHg=;
	b=XeGlqOrQhT0xoBx3VybHSAnA5MVeJmKlKQe91TyQlcvPpLE9tfaCXJYPyIDap3vuTddH1C
	87W+4EdKBr5MP1fay/T0GN1bMdWfN/as4itQi4jVfjqBNWg1NPSk848OhBLuMrivLaP2FE
	blbzGN+2p0myhBhf574D0/tKgQQq+7Q=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-6niBqC-bP-mpzlITR-a5sQ-1; Tue, 04 Jun 2024 21:58:40 -0400
X-MC-Unique: 6niBqC-bP-mpzlITR-a5sQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2bdfe86f8b6so1074475a91.1
        for <kexec@lists.infradead.org>; Tue, 04 Jun 2024 18:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717552719; x=1718157519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDq7LAUeG1zx3wFqxyw1+1sNdwa7aIwSKaoX8NuYSHg=;
        b=uIgPvfy6xkiAmRP+nVQv1tpeOCmC7FREmgVEq539PyBb/9XjMl4x3mUSXLavYg41S1
         pU39aKN9qj1V+xxBdo1HH8RNP+hjPAd7ckTqRo7LMnULWR6EEXpN/bniBWMWSse44YLS
         94Hy+jYnFgfkgbrLBMj4G+u02GBhGT5JlS0z/SgkEQXxyxnG46OdehNYht/KW0MJDPau
         v/+frD6241PhYdFnMqL6IB5I6Lmcxi1pZuc65ZT/sWADJoT3LloZ212KwRqKMaXzK6CZ
         qnHJVKIeswlw/MG4PMj16VxlOZ4QDxEybPYskFU+pRdE4NZodTaryK5Tqu8gFQvJeflQ
         kXFw==
X-Forwarded-Encrypted: i=1; AJvYcCV91g2mEW6YE1neaJkvELYJ9y73pmNuViq+SzgCaFNlb0lRrGv+aAz2XtWLiGmVuvJKH6dylRTw9FXDl3Jmf8pjbsL2RKB/cK9t
X-Gm-Message-State: AOJu0YyIVEc0UcWzHTUGtJBJJcd6FUT0hhyZL+OuHS10ombDQHQeaaNh
	7pMls0GwHSG1SqdRtHuiCftM56Ei+/YCUOuGCr5Q632cA2gQSc/OLkv6sPe14PTrKB769hIWOjn
	JfDSTSr0WyFNnA4vKxrXbB+CpxeB4Earq5yBkBam+eww8t2mUhMYdyGj7Akyy/b4V8an+87jwgE
	xTzaijsx73JgjfAHWBbMFzVHEERJNM4FOC
X-Received: by 2002:a17:90b:484e:b0:2bd:76ee:48c2 with SMTP id 98e67ed59e1d1-2c27da2df29mr1268700a91.0.1717552719022;
        Tue, 04 Jun 2024 18:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxFVHjC8YnYbmOndJJgwEmwIfgEgBgMUDA8Tq6Gici14Z5tLZpocEb/9zJxsxUZ9G0QoldR1eiR4+UpxuGzgo=
X-Received: by 2002:a17:90b:484e:b0:2bd:76ee:48c2 with SMTP id
 98e67ed59e1d1-2c27da2df29mr1268665a91.0.1717552718628; Tue, 04 Jun 2024
 18:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local> <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org> <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local> <Zl3hwYL2GDiyUfGo@kernel.org>
 <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com> <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com> <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
 <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com> <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
 <CALu+AoTY2Xxs_vUzCyfsxtk-ov2mzJhzyTbbA9MYeeVkmKTMsw@mail.gmail.com>
In-Reply-To: <CALu+AoTY2Xxs_vUzCyfsxtk-ov2mzJhzyTbbA9MYeeVkmKTMsw@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 5 Jun 2024 09:58:56 +0800
Message-ID: <CALu+AoSESmasAHqWdCGgQNbsTXfwbfhERBkaqSeaX881zqKtFg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Mike Rapoport <rppt@kernel.org>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, adrian.hunter@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com, 
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com, 
	seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, ardb@kernel.org, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, dan.j.williams@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_185845_746506_28946EBC 
X-CRM114-Status: GOOD (  14.16  )
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

On Wed, 5 Jun 2024 at 09:52, Dave Young <dyoung@redhat.com> wrote:
>
> > >         ...
> > >         if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB)) {
> > >                 __efi_memmap_free(efi.memmap.phys_map,
> > >                                 efi.memmap.desc_size * efi.memmap.nr_map, efi.memmap.flags);
> > >         }
> >
> > From your debugging the memmap should not be freed.  This piece of
> > code was added in below commit,  added Dan Williams in cc list:
> > commit f0ef6523475f18ccd213e22ee593dfd131a2c5ea
> > Author: Dan Williams <dan.j.williams@intel.com>
> > Date:   Mon Jan 13 18:22:44 2020 +0100
> >
> >     efi: Fix efi_memmap_alloc() leaks
> >
> >     With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
> >     updated and replaced multiple times. When that happens a previous
> >     dynamically allocated efi memory map can be garbage collected. Use the
> >     new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
> >     allocated memory map is being replaced.
> >
>
> Dan, probably those regions should be freed only for "fake" memmap?

Ashish, can you comment out the __efi_memmap_free see if it works for
you just confirm about the behavior.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
