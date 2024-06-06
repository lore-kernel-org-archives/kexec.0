Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6583C25B76
	for <kexec@archiver.kernel.org>; Thu,  6 Jun 2024 01:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t/uF7duER/n4EstCeXmDrGeld9r6Nkj9HBHWvKXlqq4=; b=XCnaNabdEnhMjH
	0lVrtv/OpiNnEG1tCEYQPN1bq3blpnmdmEu7VphA2+Gyf7AbRPRsUkfRkkqEZ4kRz0r16OiCX/JRc
	rKD08643fNvPrP9868ugl3CavoQ5ezjCfOE1feG88iaHtRNO9m6pC532/sPy0GF/AHGav+lACLI3B
	7cwjMIEyLaI2pFJPDwPBjlrxvQ+65DNcuHZxfxgd6HoIqSRzEpO6SzJa1nSLpMu6BQOmOO7L8raor
	eme9/IlpT2DA5NRLPZhVFt/ZWgOu+SdN/vqg3RjYk8isfoZQcZTjIoBTjIORy0cG9Xq5NYlKZE3b3
	jr556+hZN7z4MRQ3hpEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF2Iu-000000085Rd-00vR;
	Thu, 06 Jun 2024 01:52:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF2Ir-000000085Pz-2Az8
	for kexec@lists.infradead.org;
	Thu, 06 Jun 2024 01:52:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717638744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xp+MGNVSlLui2uLO7pwydVnV86tn/dw5jvwhKRhoHdg=;
	b=QmUwVM+MuQfHb986lLo+awchnfOd7qQlPyB9YHA7aAyKGl2YJFjMKUcsNftVDwI9MNxOpu
	j0agOOfo1eaLd7oCOki++lXFGj8tQRWffMgvuHO03AvQ6b+Muvd/XgGQ2cZg+NROQKtNsU
	e1O1uk7kcEUvny8Wb0nA/TFjC/DbgeQ=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-z3esPMKhOmq78AsMmpqidA-1; Wed, 05 Jun 2024 21:52:23 -0400
X-MC-Unique: z3esPMKhOmq78AsMmpqidA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-374907a1f84so875475ab.0
        for <kexec@lists.infradead.org>; Wed, 05 Jun 2024 18:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717638742; x=1718243542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xp+MGNVSlLui2uLO7pwydVnV86tn/dw5jvwhKRhoHdg=;
        b=e5uoXePf5YuaP3gU1ZpsDpk1KWomi0xT/YBmmz+HtEpqU2uZQm6uDl0pF+T3blDcuT
         8Weeq2PS/BNXz5tb81u7+4jMxYOdR5PVuLdwNOdTBStHVxWLf8SOihbcIiG6XDKyrmML
         ikVH84ITZtU6LgW1YpbHTXKQJiCoJC4047q+hFkO29+2UQg0IQR7xjt8VYCbAFakvco/
         s5hTtwCgL7RC+6dwRN5TYG0OeBgKKyIFcYsXi24u07hx07muARn3Ij1qSShBOn2D5rl0
         0ww7TFUW44rPr0df+ed7l9uQVzteyc8YZehYrbI4QEcDRw3Akfq6aSmZHWfv3fdIuaxg
         gs3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8U1JtmMU30X72+E7oG4JNHv68EbLspTN4nG7rqdKjWfwBIqhGxqfKw92NmjeXcXgnJeooguYx7tw2yxfWWZFPkU1v+nk0q4Pj
X-Gm-Message-State: AOJu0Ywu0b2BoyPxYiB/EkkJC8lvyFmVbGwmD6o4G/D94mFwNC5tmFHL
	/Q792+/BfMO6KrKdTv/pxMQSel6mGbpzAk/F+TFevmB/1XhtNF1XunI6+qFrO6IqQt/bLf+WDO3
	tppV1RVVt6+FSCZr9TCWjD4GwedmKU//lmtnJbA3nQKZ/UiwmUL0rlA1JIBCv9PbE8Snl1MZvc1
	zeAQUwRxcZeTtj5Lzh4KF0hWx5zG+GIJPh
X-Received: by 2002:a05:6e02:2194:b0:374:a102:2948 with SMTP id e9e14a558f8ab-374b1f75c83mr44373055ab.3.1717638742290;
        Wed, 05 Jun 2024 18:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOj8R29jCyD6uOUyfLwEBMdBJR/YcAvObT1kSbriveNteQJnjE6dpOttRKqAAbOTQ16AYsTtRhV6iMhVxvGOw=
X-Received: by 2002:a05:6e02:2194:b0:374:a102:2948 with SMTP id
 e9e14a558f8ab-374b1f75c83mr44372615ab.3.1717638741676; Wed, 05 Jun 2024
 18:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com> <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com> <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
 <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com> <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
 <CALu+AoTY2Xxs_vUzCyfsxtk-ov2mzJhzyTbbA9MYeeVkmKTMsw@mail.gmail.com>
 <CALu+AoSESmasAHqWdCGgQNbsTXfwbfhERBkaqSeaX881zqKtFg@mail.gmail.com>
 <41e085b8-2b45-40ab-9a6f-f4ad975a0b06@amd.com> <CALu+AoQ2jNjb+5MZfFtpT_Y=2gJRWwqEeWTpQkwNt0-U5fpO_w@mail.gmail.com>
 <20240605110904.GWZmBHUHSqCJVQYajF@fat_crate.local>
In-Reply-To: <20240605110904.GWZmBHUHSqCJVQYajF@fat_crate.local>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 6 Jun 2024 09:52:39 +0800
Message-ID: <CALu+AoRvNC9zMFwC+-T7eJDcTkPNUKPdsg5PNEJc11CVb22gUg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
To: Borislav Petkov <bp@alien8.de>
Cc: ardb@kernel.org, dan.j.williams@intel.com, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Mike Rapoport <rppt@kernel.org>, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	rafael@kernel.org, hpa@zytor.com, peterz@infradead.org, 
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_185233_643851_B83CBDBB 
X-CRM114-Status: GOOD (  22.09  )
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

On Wed, 5 Jun 2024 at 19:09, Borislav Petkov <bp@alien8.de> wrote:
>
> Moving Ard and Dan to To:
>
> On Wed, Jun 05, 2024 at 10:28:18AM +0800, Dave Young wrote:
> > Ok, thanks!  I think the right way is creating two patches,  one to
> > remove the __efi_memmap_free,
>
> Yap, that
>
>   f0ef6523475f ("efi: Fix efi_memmap_alloc() leaks")
>
> needs revisiting.
>
> So AFAIU, the flow is this:
>
> In a kexec-ed kernel:
>
> 1. efi_arch_mem_reserve() gets called by bgrt, erst, mokvar... whatever
>    to hold on to boot services regions for longer otherwise EFI
>    "implementations" explode.
>
> 2. On same kexec-ed kernel, we call into kexec_enter_virtual_mode()
>    because it needs to get the runtime services regions from the first
>    kernel
>
> 3. As part of that call, it'll do
>    efi_memmap_init_late->__efi_memmap_init():
>
>         if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
>                 __efi_memmap_free(efi.memmap.phys_map,
>
> and the memory which got allocated in step 1 is gone, thus reverting
> what efi_arch_mem_reserve() is trying to fix.
>
> IOW, we need a
>
>         EFI_MEMMAP_DO_NOT_TOUCH_MY_MEMORY
>
> flag which'll stop this from happening. But I'd prefer it if Ard decides
> what the right thing to do here is.
>
> > another is  skip efi_arch_mem_reserve when the EFI_MEMORY_RUNTIME bit
> > was set already.
>
> Can that even happen?

Yes, let's say we have two different cases both go through
drivers/firmware/efi/efi-bgrt.c -> efi_mem_reserve ->
efi_arch_mem_reserve
1. normal boot (non kexec-ed)
    The bgrt region is reserved and mark as EFI_MEMORY_RUNTIME with a
new efi mem range which is inserted in the memmap, later kexec will
carry over to 2nd kernel (drop those boot service areas without
EFI_MEMORY_RUNTIME)
2. kexec-ed boot
     In the same call path, the previous kernel saved bgrt region has
already set EFI_MEMORY_RUNTIME, but it is re-reserved with a new mem
entry in memmap, this is not necessary and duplicate.   I did not
check the efi boot code if it will de-duplicate the memmap later, but
anyway this is useless and it should be skipped.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
