Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87500C25B78
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 01:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WWLD6a1GSYbnSCOCi6TcKwJtk8rEPEHAcjY097ltgtM=; b=c6oWVJfnF/+3T6
	z69evx819yE6ANi+BLzZTJAR7NiuT9I/IdcHcXLkZ7OaYg1UFjXM0p4MaFV1Ic6REmPOsHt7LUT40
	sYh3JVVNMxYJUXjFmVN6BWs2s/gcgFb5re2m9xHxkz7IU9hBWkgg0vuVO+IezthyZOmdEc0XrYjqk
	9bGpYOjNzWpFsWkmFA8YiTOYc5nbfEhY6ZWvbx1UKSwsBgr71WvSVoNv4RSH0z1mae6CG3YVl1PVZ
	mMxlJc06hnLEk3i+yc7zG+ebvoKOZdpDsn2GDVY03g/kf4d232BO2hf0Q4agju88o3wW9DDMT8JCm
	hI/zn/bqolHdL03X7gLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEflG-00000004P0h-3MZj;
	Wed, 05 Jun 2024 01:48:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEflD-00000004Ozr-3ISh
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 01:48:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717552095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgHDm/WuX5wu8O8crNlAs4XjHwwaf5FS68CVvGmTwCU=;
	b=TRYZqzEFj/sFjXBI0B7+NtgBJ5vGZB7PUK1f44Je01D5mVlvHGRtWya4HNJX9hJtRXgPnx
	7FihK3tKaWMk3LbFPBni7dRtKYeFWjVCNKj9lDfD/P8oEPxC+etBoS/LNhzC9tbX5IkGzL
	pjyMkYF/1JzJc1IezBlrxz86lTesG7M=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-lEAjQaUbNiCh1Vn9DWccOw-1; Tue, 04 Jun 2024 21:48:13 -0400
X-MC-Unique: lEAjQaUbNiCh1Vn9DWccOw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e97da51ef0so99723939f.1
        for <kexec@lists.infradead.org>; Tue, 04 Jun 2024 18:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717552092; x=1718156892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgHDm/WuX5wu8O8crNlAs4XjHwwaf5FS68CVvGmTwCU=;
        b=jwUEOs1dH+OGvfYyESavMJb8LGhCVPLcAQxtA5JaRSURN2ZjBJHxOgW6caLsdTaILo
         lK0oJN7xN2bY7xQ0Y4F0gsab4vk7yvYYiibA28QwebSTe8Dnjjyg2NfXO0WnRqZzYau6
         t6h52MnIKxRKfBRD0aNwhwltPAiVE0c2YUaKjNZrRdv94fpgAhXuGYb8fN/n1vWtuUKD
         u2RfuNw2uP5yNihN75S17dGEUfHCNciU0KRR6AyBxuZqkqXNirya6loqcdukj8IRVz4d
         ee4qaFA0kB2pMYuZ/asLYBxduWRbhTc/O7oArzgmb+yhu95zrm/9894WBskSLoP0m4uW
         cYOg==
X-Forwarded-Encrypted: i=1; AJvYcCWzZR/pQLF6XQNWiv/FcGrGv2RYXWnMfC8mwWBYrII9mdoarCyPM/UQe17Mgtvx8XQVgNEm+6K0w0uOEImzOHevLDi6IUJRz6Tw
X-Gm-Message-State: AOJu0YxppL7FyFKjJxkSTpETq0VOOWXEN65jySNADYTydQ1yw67Twd2c
	0bQsoL5rCIAI14kPWyzyzjfkMsdYC3ePvQcLb4Hqgv3OfcqIr3JgTnlebBPyLqysoja4Wdt5xlj
	UHqkmLOkM6GJim1NzG8L2eFcSnmB/YpPvqOHePfueklNUHf77nk6aXIJYk3JH7J0mRQUIFNtja2
	f+tiWibkaGUjjbef3+cISrj2rJSJ/HVxaH
X-Received: by 2002:a92:c262:0:b0:374:a021:f1a7 with SMTP id e9e14a558f8ab-374b1f3e6a6mr12844185ab.2.1717552092177;
        Tue, 04 Jun 2024 18:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPrmPkKSu7/bxuxQb+vlDcaLfqSrYDwnUemokY5ej5EoiQIxPBQbV1auEQzBdw6MeFuxEabhfdUThXIdgkd3I=
X-Received: by 2002:a92:c262:0:b0:374:a021:f1a7 with SMTP id
 e9e14a558f8ab-374b1f3e6a6mr12843705ab.2.1717552091682; Tue, 04 Jun 2024
 18:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local> <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org> <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local> <Zl3hwYL2GDiyUfGo@kernel.org>
 <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com> <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com> <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
 <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com>
In-Reply-To: <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 5 Jun 2024 09:48:30 +0800
Message-ID: <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240604_184819_945996_B1B11315 
X-CRM114-Status: GOOD (  26.70  )
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

On Wed, 5 Jun 2024 at 06:36, Kalra, Ashish <ashish.kalra@amd.com> wrote:
>
> Re-sending as the earlier response got line-wrapped.
>
> On 6/3/2024 12:12 PM, Borislav Petkov wrote:
> > On Mon, Jun 03, 2024 at 12:08:48PM -0500, Kalra, Ashish wrote:
> >> efi_arch_mem_reserve().
> > Now it only remains for you to explain why...
>
> Here is a detailed explanation of what is causing the EFI memory map corruption, with added debug logs and memblock debugging enabled:
>
> Initially at boot, efi_memblock_x86_reserve_range() does early_memremap() of the EFI memory map passed as part of setup_data, as the following logs show:
>
> ...
>
> [ 0.000000] efi: in efi_memblock_x86_reserve_range, phys map 0x27fff9110
> [ 0.000000] memblock_reserve: [0x000000027fff9110-0x000000027fffa12f] efi_memblock_x86_reserve_range+0x168/0x2a0
>
> ...
>
> Later, efi_arch_mem_reserve() is invoked, which calls efi_memmap_alloc() which does memblock_phys_alloc() to insert new EFI memory descriptor into efi.memap:
>
> ...
>
> [ 0.733263] memblock_reserve: [0x000000027ffcaf80-0x000000027ffcbfff] memblock_alloc_range_nid+0xf1/0x1b0
> [ 0.734787] efi: efi_arch_mem_reserve, efi phys map 0x27ffcaf80
>
> ...
>
> Finally, at the end of boot, kexec_enter_virtual_mode() is called.
>
> It does mapping of efi regions which were passed via setup_data.
>
> So it unregisters the early mem-remapped EFI memmap and installs the new EFI memory map as below:
>
> ( Because of efi_arch_mem_reserve() getting invoked, the new EFI memmap phys base being remapped now is the memblock allocation done in efi_arch_mem_reserve()).
>
> [ 4.042160] efi: efi memmap phys map 0x27ffcaf80
>
> So, kexec_enter_virtual_mode() does the following :
>
>         if (efi_memmap_init_late(efi.memmap.phys_map, <- refers to the new EFI memmap phys base allocated via memblock in efi_arch_mem_reserve().
>                 efi.memmap.desc_size * efi.memmap.nr_map)) { ...
>
> This late init, does a memremap() on this memblock-allocated memory, but then immediately frees it :
>
> drivers/firmware/efi/memmap.c:
>
> int __init __efi_memmap_init(struct efi_memory_map_data *data)
> {
>
>         ..
>
>         phys_map = data->phys_map; <- refers to the new EFI memmap phys base allocated via memblock in efi_arch_mem_reserve().
>
>         if (data->flags & EFI_MEMMAP_LATE)
>                 map.map = memremap(phys_map, data->size, MEMREMAP_WB);
>         ...
>         ...
>         if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB)) {
>                 __efi_memmap_free(efi.memmap.phys_map,
>                                 efi.memmap.desc_size * efi.memmap.nr_map, efi.memmap.flags);
>         }

From your debugging the memmap should not be freed.  This piece of
code was added in below commit,  added Dan Williams in cc list:
commit f0ef6523475f18ccd213e22ee593dfd131a2c5ea
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Mon Jan 13 18:22:44 2020 +0100

    efi: Fix efi_memmap_alloc() leaks

    With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
    updated and replaced multiple times. When that happens a previous
    dynamically allocated efi memory map can be garbage collected. Use the
    new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
    allocated memory map is being replaced.


>
>         ...
>         map.phys_map = data->phys_map;
>
>         ...
>
>         efi.memmap = map;
>
>         ...
>
> This happens as kexec_enter_virtual_mode() can only handle the early mapped EFI memmap and not the one which is memblock allocated by efi_arch_mem_reserve(). As seen above this memblock allocated (EFI_MEMMAP_MEMBLOCK tagged) memory gets freed.
>
> This is confirmed by memblock debugging:
>
> [ 4.044057] memblock_free_late: [0x000000027ffcaf80-0x000000027ffcbfff] __efi_memmap_free+0x66/0x80
>
> So while this memory is memremapped, it has also been freed and then it gets into a use-after-free condition and subsequently gets corrupted.
>
> This corruption is seen just before kexec-ing into the new kernel:
>
> ...
> [   11.045522] PEFILE: Unsigned PE binary^M
> [   11.060801] kexec-bzImage64: efi memmap phys map 0x27ffcaf80^M
> ...
> [   11.061220] kexec-bzImage64: mmap entry, type = 11, va = 0xfffffffeffc00000, pa = 0xffc00000, np = 0x400, attr = 0x8000000000000001^M
> [   11.061225] kexec-bzImage64: mmap entry, type = 6, va = 0xfffffffeffb04000, pa = 0x7f704000, np = 0x84, attr = 0x800000000000000f^M
> [   11.061228] kexec-bzImage64: mmap entry, type = 4, va = 0xfffffffeff700000, pa = 0x7f100000, np = 0x300, attr = 0x0^M
> [   11.061231] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M <- CORRUPTION!!!
> [   11.061234] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061236] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061239] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061241] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061243] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061245] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061248] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061250] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061252] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061255] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061257] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061259] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061262] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061264] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061266] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061268] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061271] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061273] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061275] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061278] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061280] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061282] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061284] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061287] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061289] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061291] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061294] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061296] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061298] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061301] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061303] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061305] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061307] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061310] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061312] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061314] kexec-bzImage64: mmap entry, type = 14080, va = 0x14f29, pa = 0x36c0, np = 0x0, attr = 0x0^M
> [   11.061317] kexec-bzImage64: mmap entry, type = 85808, va = 0x0, pa = 0x0, np = 0x72, attr = 0x14f40^M
> [   11.061320] kexec-bzImage64: mmap entry, type = 0, va = 0x14f4b, pa = 0x65, np = 0x1, attr = 0x0^M
> [   11.061323] kexec-bzImage64: mmap entry, type = 85840, va = 0x0, pa = 0x2, np = 0x69, attr = 0x14f59^M
> [   11.061325] kexec-bzImage64: mmap entry, type = 0, va = 0x14f65, pa = 0x6c, np = 0x0, attr = 0x0^M
> [   11.061328] kexec-bzImage64: mmap entry, type = 85871, va = 0x0, pa = 0x0, np = 0x7a, attr = 0x14f7f^M
>
>
> ...
>
> This EFI phys map address 0x27ffcaf80 is being mem-remapped and also getting freed and then in use after free condition (while setting up the EFI memory map for the next kernel with kexec -s) in the above logs confirm the use-after-free case.
>
> Looking at the above code flow, it makes sense to skip efi_arch_mem_reserve() to fix this issue, as it anyway needs to be skipped for kexec case.
>
> Thanks, Ashish
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
