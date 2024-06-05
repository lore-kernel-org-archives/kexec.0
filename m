Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D425C25B78
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 02:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZoRWLgFAcyUpiIU5k1f0/wXmk91KIDxguv8m7p31EuQ=; b=wXRx/4pJMndfEb
	Ob9F8vzOq9xxK3sul/c/739Yd78/njqb3fb0v4EquL6HK4gXnF9q6kVucTfgboyP97huq22DNfda5
	qbguBK6sVCJEFZFFgXo/jCTFslu0Zp5nL/TkPHOv35O3krzLtpgj+Tdvkj7+lcso1/4xjMnszkABV
	X7zwYnSTKD1HBAax1deLlpH0TwRyldB7xUPet+OTZ+E2+HWy3a9m+OuwovPOKOU2H/Kq0isNpV7KG
	VugviDIuz26T9Pe5cKTcTdvKss5L3S5doh+UjI2tSAR0GujPdX8+ItrLLk2FUOPQAIDO9rQgMVeol
	FQ70mOc7L6QEmuS8wdAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEgNn-00000004ScT-0Dug;
	Wed, 05 Jun 2024 02:28:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEgNj-00000004SbC-1GDc
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 02:28:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717554486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOA1MCZJzoxt6GCkNRp4+h7p2tW8g2r7m2il3+oTwSQ=;
	b=bKIMh9zkliGGhF7Lnm6bIOcsU80w6fnb1BsSHV1//kdxXTzhNDtuc4Z2bGF7sGpXVk8PFn
	Xru0XseEGuz7elxV42nAykDWmP8RY3YieT+/+oS9Vp4BCk4wXmLKHMbO+wc+H4JK1W0KGS
	U68xn4h955UoxuieRn3B635lC5GLzBw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-a9rQJaiXOp2Hw5d9baJbPw-1; Tue, 04 Jun 2024 22:28:01 -0400
X-MC-Unique: a9rQJaiXOp2Hw5d9baJbPw-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-374ae94e856so2181775ab.0
        for <kexec@lists.infradead.org>; Tue, 04 Jun 2024 19:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717554480; x=1718159280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOA1MCZJzoxt6GCkNRp4+h7p2tW8g2r7m2il3+oTwSQ=;
        b=GrYhITtRw8NTPz6UffVVnzX6qrj8AlzNH4fbpLZs4mY2p/nYe+5E1DJJxaJJekErGG
         yNqC441SNhJvo/PvhxXEOhstzxwlUIJhRcvQ2mNo352axzyhxpjMfo++TaAxHdVzDtYF
         qwUPV3R/NBNW/6VVg/jpwQPgfsIGvirFnZ6y2gYPxC8SvMhpoyTMQPZCGj+EIGEyww8A
         pikY4b3f4QcEpZx0sdf23ut60lhNJUxk1XoQXJIu3ZZT4POqeEtxXOkkehqn/Mb1lJjd
         SAg8DrBj3AKKtJ1pcoLhvWY8GweiApw/+Q+aVCgWL3zdjAv1dRtTbGwy9NTnf8DjPlOR
         gc0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUx48YKzjYiBrA8TYILkeoRSDdl44R8/PiugOVPG7K398MvUa2PjK0LNTpDzck6RnQxAT3UVarQWjWgwJZWy6uqKasi+H4YV5p
X-Gm-Message-State: AOJu0YzJny7NWqKXRMcyY+V0AciqRkF6g0kkMJiJsTj/liB4DnRw6m8x
	Whonlk+/HavF1G7JM8I0wFCfzu0dXksUtyzEXkxs7FOiZhCnx82DosNcUTMT8KOqAC9u5FwldLP
	5bSZDCny14GIh9xf5G3dDsc9D44OUkNwRwGSUcTqKSwkSBLTdTdBqIpKhJEGp2aOZYTVEqDqsSs
	Cu0+avYrIwLp9i52sMeGxPY/fh7DXYG14L
X-Received: by 2002:a05:6e02:2186:b0:374:9916:67 with SMTP id e9e14a558f8ab-374b1f581b2mr11523835ab.3.1717554480543;
        Tue, 04 Jun 2024 19:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLK8Z8K1Sf1VYEaO2jfZNFyTUIy/6PgZmMDleVpuyW8h0jbW5z86MOXD9UJxh2ksU0GUTW5kdRKx56WX70gCg=
X-Received: by 2002:a05:6e02:2186:b0:374:9916:67 with SMTP id
 e9e14a558f8ab-374b1f581b2mr11523595ab.3.1717554480186; Tue, 04 Jun 2024
 19:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local> <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org> <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local> <Zl3hwYL2GDiyUfGo@kernel.org>
 <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com> <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com> <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
 <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com> <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
 <CALu+AoTY2Xxs_vUzCyfsxtk-ov2mzJhzyTbbA9MYeeVkmKTMsw@mail.gmail.com>
 <CALu+AoSESmasAHqWdCGgQNbsTXfwbfhERBkaqSeaX881zqKtFg@mail.gmail.com> <41e085b8-2b45-40ab-9a6f-f4ad975a0b06@amd.com>
In-Reply-To: <41e085b8-2b45-40ab-9a6f-f4ad975a0b06@amd.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 5 Jun 2024 10:28:18 +0800
Message-ID: <CALu+AoQ2jNjb+5MZfFtpT_Y=2gJRWwqEeWTpQkwNt0-U5fpO_w@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240604_192807_445688_0A73F82D 
X-CRM114-Status: GOOD (  19.05  )
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

On Wed, 5 Jun 2024 at 10:09, Kalra, Ashish <ashish.kalra@amd.com> wrote:
>
> Hello Dave,
>
> On 6/4/2024 8:58 PM, Dave Young wrote:
> > On Wed, 5 Jun 2024 at 09:52, Dave Young <dyoung@redhat.com> wrote:
> >>>>         ...
> >>>>         if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB)) {
> >>>>                 __efi_memmap_free(efi.memmap.phys_map,
> >>>>                                 efi.memmap.desc_size * efi.memmap.nr_map, efi.memmap.flags);
> >>>>         }
> >>> From your debugging the memmap should not be freed.  This piece of
> >>> code was added in below commit,  added Dan Williams in cc list:
> >>> commit f0ef6523475f18ccd213e22ee593dfd131a2c5ea
> >>> Author: Dan Williams <dan.j.williams@intel.com>
> >>> Date:   Mon Jan 13 18:22:44 2020 +0100
> >>>
> >>>     efi: Fix efi_memmap_alloc() leaks
> >>>
> >>>     With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
> >>>     updated and replaced multiple times. When that happens a previous
> >>>     dynamically allocated efi memory map can be garbage collected. Use the
> >>>     new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
> >>>     allocated memory map is being replaced.
> >>>
> >> Dan, probably those regions should be freed only for "fake" memmap?
> > Ashish, can you comment out the __efi_memmap_free see if it works for
> > you just confirm about the behavior.
>
> Yes, i have already tried and tested that, if i avoid __efi_memmap_free(), then i don't see this memory map corruption.

Ok, thanks!  I think the right way is creating two patches,  one to
remove the __efi_memmap_free, another is  skip efi_arch_mem_reserve
when the EFI_MEMORY_RUNTIME bit was set already.  But the first one
should be the fix for the root cause.

efi fake mem is only for debugging purposes,  the "memleak" mentioned
in commit 0f96a99dab36 should be solved in another way if needed (are
they really leaked? or just not useful anymore)

Anyway this is my opinion, please wait for x86 and efi reviewer's inputs.

>
> Thanks, Ashish
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
