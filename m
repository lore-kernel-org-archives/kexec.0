Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86292C27C53
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 11:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZSlMuMdl9gD+XyKOIW241bdTKg5gj037qyxm76yjoyI=; b=OH36n/6e9I3LdX
	DoyRL+jqrcwhNNHewMlFzvwapF3FaK9zFydQmjHn4ikST2GXnQuapWBstiQZsgplIEjs9J0B7oj6B
	nMTFJE8ymgnLn7CGfXOQZOmzWakr1taD16NBCt97p+J5HCun9BcD4P0L9vZLVoutXSaVobAr8xsZl
	08+E2C0zOvY8DyQ12QkN3uRzDWvswgNrmlU9/tKwJVrMExhLa/9W+j3+cVZh+GCZhWjCJRx3w0upy
	n+hVyKGXPdypfwuNFQJj7fLYaXh5njBsjcp22FHLFCCstpCmGvThTbqPtcB/cSVxuyTe+lcTQ/Rsm
	GAvdW5KWhEBnNs+K8xpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEoWi-00000005euh-0A9y;
	Wed, 05 Jun 2024 11:09:56 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEoWd-00000005es6-2BHO
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 11:09:53 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E13B640E0176;
	Wed,  5 Jun 2024 11:09:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iJf5bq__s4gN; Wed,  5 Jun 2024 11:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717585781; bh=u8G7LlOZuSGdMErqsnXyAGVosfE3DwlKRA2nP23l5K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWYDBVHBUclEEG1gDdbe+IdXFSR610ZcoZ15fdD8wx7IG52P3H1YvEhtTtsD9nONn
	 EgachKPplm43FJBaLMC5cc6CvfKV8MA6SbwzeUu688pecrXXCwz7NgHD2A/vpnmyDI
	 RyJkAcnNA1Bcw8f8SHu++1GS8A9sSmpx7KeGtYLbr9WzqlMvWymSdqGrctv/FnXRUI
	 /v4rEcLYOYGvvAJI8FsNk9w9gkIU13OJMJIrqITMCtL4fQMOJdLywG351jw+GburS3
	 bBcRign7gnvOvXogKGlvpwebk/wxjW+WltpUQFOHnmWjW7jokjkP0FCJ6m/EvuLDTe
	 BbqVHmANcg2kg0cCHJdFwMhlxCE6azl8xwW2RkRPsTxwRItOuqsMhQDYruReg6HJyR
	 6sUhmNdlZGoCqckVBNJY7ipHisko8EqoNU/rhHcBqsr6g313/KLk9HxSbdYRTdPm8l
	 QEZSleJvDkkR2JwNGSKsLLkuvNMWSJaGpvKCmbqrVHmzI08iJxzauhUwV4ccvI/Zqr
	 hfGKSO2De6TDGnPBS6+11FvEK0QNVZDFIWT6waY8YUuOVx+tr/qnezVh6BEbypjMNU
	 E1DdG2C1jyw2gnmyh3zRSpfjkQ0ZIaHNe1mOzFZIIGKdj2pZQ1JRAAcBC7k+puZ9nn
	 A1smz3yi1mW/YVlSH/e7KPoI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5225D40E016A;
	Wed,  5 Jun 2024 11:09:11 +0000 (UTC)
Date: Wed, 5 Jun 2024 13:09:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Young <dyoung@redhat.com>, ardb@kernel.org,
	dan.j.williams@intel.com
Cc: "Kalra, Ashish" <ashish.kalra@amd.com>, Mike Rapoport <rppt@kernel.org>,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240605110904.GWZmBHUHSqCJVQYajF@fat_crate.local>
References: <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
 <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com>
 <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
 <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com>
 <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
 <CALu+AoTY2Xxs_vUzCyfsxtk-ov2mzJhzyTbbA9MYeeVkmKTMsw@mail.gmail.com>
 <CALu+AoSESmasAHqWdCGgQNbsTXfwbfhERBkaqSeaX881zqKtFg@mail.gmail.com>
 <41e085b8-2b45-40ab-9a6f-f4ad975a0b06@amd.com>
 <CALu+AoQ2jNjb+5MZfFtpT_Y=2gJRWwqEeWTpQkwNt0-U5fpO_w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALu+AoQ2jNjb+5MZfFtpT_Y=2gJRWwqEeWTpQkwNt0-U5fpO_w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_040951_735477_770EDBBD 
X-CRM114-Status: GOOD (  11.22  )
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

Moving Ard and Dan to To:

On Wed, Jun 05, 2024 at 10:28:18AM +0800, Dave Young wrote:
> Ok, thanks!  I think the right way is creating two patches,  one to
> remove the __efi_memmap_free,

Yap, that 

  f0ef6523475f ("efi: Fix efi_memmap_alloc() leaks")

needs revisiting.

So AFAIU, the flow is this:

In a kexec-ed kernel:

1. efi_arch_mem_reserve() gets called by bgrt, erst, mokvar... whatever
   to hold on to boot services regions for longer otherwise EFI
   "implementations" explode.

2. On same kexec-ed kernel, we call into kexec_enter_virtual_mode()
   because it needs to get the runtime services regions from the first
   kernel

3. As part of that call, it'll do
   efi_memmap_init_late->__efi_memmap_init():

        if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
                __efi_memmap_free(efi.memmap.phys_map,

and the memory which got allocated in step 1 is gone, thus reverting
what efi_arch_mem_reserve() is trying to fix.

IOW, we need a

	EFI_MEMMAP_DO_NOT_TOUCH_MY_MEMORY

flag which'll stop this from happening. But I'd prefer it if Ard decides
what the right thing to do here is.

> another is  skip efi_arch_mem_reserve when the EFI_MEMORY_RUNTIME bit
> was set already.

Can that even happen?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
