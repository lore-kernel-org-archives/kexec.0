Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0088C10F1A
	for <kexec@archiver.kernel.org>; Thu,  9 May 2024 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EWaZq81tA7LamvFyByakn7FkbSws8ZO/qU3OSiF20BM=; b=BTWHclWFxkNvkP
	n+9bLfl29pLSlgorIsVywzNfhcV8GssUHg6pCo8XWdPluTBHopjE5FxZMEnsOcXKUXr36LConAI65
	ysIgDolqUuEDEagmQLUWBkHKQpyfAeAaFy9jZ3zNsHJNj2oCYuJQKgkMisiOil5meEgh8RNzMg/Qn
	t1YbUaUjoeHbOGPp3Vo6fbAOhLnhzwMYBEiNSvWfk1mVlTwPKbJkEYEsG5utzqvFkDRVoQgFNgckY
	QvjSy1mk/jTFmMZ6oEP8EdhAXm4Tp+wzBDfn4zZDIMV15VCiUrvMF4QSrWhN79+ftfpeNn29v2UZZ
	xGyevLUgZPCoizMYcBLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s50Zf-000000013lZ-11cO;
	Thu, 09 May 2024 10:00:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s50Zc-000000013kF-2gkj
	for kexec@lists.infradead.org;
	Thu, 09 May 2024 10:00:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715248821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WzXeEK6f1cKA7Dkjnpf3lp68VbxazSREN8UjDp493lg=;
	b=a6za7p/sY1DSEcn935lvzSRkaPIFFbp7wwxwcGa47tCiPu+a1R2BUq9SN9/nGxS79neRHH
	sKWpm3cp/d4x2Yq7uBvObYNzf3xwd03V9Of2N+zhV9jQ3WJKYpkmIdxrmd1Pvqa+4KyQ6Y
	mLKaCb150IhaQ1IBJneGeg/sfmyuBms=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-lQJBdrx3O2q8FFR_PJ3mvw-1; Thu, 09 May 2024 06:00:19 -0400
X-MC-Unique: lQJBdrx3O2q8FFR_PJ3mvw-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c7b1dc524so1376385ab.0
        for <kexec@lists.infradead.org>; Thu, 09 May 2024 03:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715248819; x=1715853619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzXeEK6f1cKA7Dkjnpf3lp68VbxazSREN8UjDp493lg=;
        b=KEkGfdhes8Dgu/QmgS2XTPdHnP4F6USCJgAzG34rpHkKmghU10WxH/npnps1bpY1y/
         UDNcuNa5XB8OyYF3YbnkAtWVtBSUXeE2uH+KwGRZCX2BkJ1k+cB4UVKK3u3t+TAyhh3J
         BTwoIcAce9tl/cMbIlBcXMTj2P79fTSkiwYHpQ22HjpxYe0yXvi/U0BhLikpisttqSIf
         4LHPOIYFfnOAFF2wrFyQ+Uraw8C3xoDq5U/IOv4O0GAJ8IBJfKkH39Pkqbg5eaiXxZpB
         jLa02O/n9bUOx2n0bdXMTe/3VCFT4HBzOFQim6BjteVOvb2VqMWk0HFMnM+FeN6S0xIX
         wKiw==
X-Forwarded-Encrypted: i=1; AJvYcCWyE2VXW80iNi8v+GLqEmu01EDVVSXfU3oEKFrIb6Jlbz1O9HOwc7h606EDWye9v5WRlD+FO3i99WKUlksboZO7QxlmM0Oq/Ems
X-Gm-Message-State: AOJu0YxuEEokel8kBOrMCRYQAOYMMdwTbhrWzNTIRyDDBq5/Qr+h2RRy
	V0H8QpjkJUVNsbpQ5RmkcAeVDvU4RnqKy+dn6UfY1x1jvHRrKgHKhvu4uzpCvy95u9KGWlpF569
	IYoRsSbpyAqQEm7Pr+8NuVXzYSWNA2NocZ9hpxznh43Wg9+K/m6t+9lfWlvPaYCS5KmCAJh84jQ
	byMhcHDGOdg8tzFD4f/5oSGlKnsjy72GYX
X-Received: by 2002:a05:6e02:1647:b0:368:974b:f7c7 with SMTP id e9e14a558f8ab-36caeb48b66mr61416805ab.0.1715248817909;
        Thu, 09 May 2024 03:00:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8o7D67Q2BZ/V4u6B6QZd+yWTOPQKvS4q4E5XTW9jC90dfP9XAlBUu5L4fxKLchDB0PdAey6VLTz3eGYh6Pw4=
X-Received: by 2002:a05:6e02:1647:b0:368:974b:f7c7 with SMTP id
 e9e14a558f8ab-36caeb48b66mr61415825ab.0.1715248816153; Thu, 09 May 2024
 03:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1712694667.git.ashish.kalra@amd.com> <cover.1714148366.git.ashish.kalra@amd.com>
 <6dfe98fb95d7193ba2d692a2b6900a4d5d73db26.1714148366.git.ashish.kalra@amd.com>
 <Zjydu25Z26dH81NX@darkstar.users.ipa.redhat.com>
In-Reply-To: <Zjydu25Z26dH81NX@darkstar.users.ipa.redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 9 May 2024 18:00:35 +0800
Message-ID: <CALu+AoRVoYPjvAgkO0cpCVxvPv48BBar8Kuwc12b0XJ9wDeVRA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] efi/x86: Fix EFI memory map corruption with kexec
To: Ruirui Yang <ruirui.yang@linux.dev>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org, 
	hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com, 
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com, 
	seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, ardb@kernel.org, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240509_030024_783171_8960C838 
X-CRM114-Status: GOOD (  35.19  )
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

On Thu, 9 May 2024 at 17:56, Ruirui Yang <ruirui.yang@linux.dev> wrote:
>
> On Fri, Apr 26, 2024 at 04:33:48PM +0000, Ashish Kalra wrote:
> > From: Ashish Kalra <ashish.kalra@amd.com>
> >
> > With SNP guest kexec observe the following efi memmap corruption :
> >
> > [    0.000000] efi: EFI v2.7 by EDK II
> > [    0.000000] efi: SMBIOS=0x7e33f000 SMBIOS 3.0=0x7e33d000 ACPI=0x7e57e000 ACPI 2.0=0x7e57e014 MEMATTR=0x7cc3c018 Unaccepted=0x7c09e018
> > [    0.000000] efi: [Firmware Bug]: Invalid EFI memory map entries:
> > [    0.000000] efi: mem03: [type=269370880|attr=0x0e42100e42180e41] range=[0x0486200e41038c18-0x200e898a0eee713ac17] (invalid)
> > [    0.000000] efi: mem04: [type=12336|attr=0x0e410686300e4105] range=[0x100e420000000176-0x8c290f26248d200e175] (invalid)
> > [    0.000000] efi: mem06: [type=1124304408|attr=0x000030b400000028] range=[0x0e51300e45280e77-0xb44ed2142f460c1e76] (invalid)
> > [    0.000000] efi: mem08: [type=68|attr=0x300e540583280e41] range=[0x0000011affff3cd8-0x486200e54b38c0bcd7] (invalid)
> > [    0.000000] efi: mem10: [type=1107529240|attr=0x0e42280e41300e41] range=[0x300e41058c280e42-0x38010ae54c5c328ee41] (invalid)
> > [    0.000000] efi: mem11: [type=189335566|attr=0x048d200e42038e18] range=[0x0000318c00000048-0xe42029228ce4200047] (invalid)
> > [    0.000000] efi: mem12: [type=239142534|attr=0x0000002400000b4b] range=[0x0e41380e0a7d700e-0x80f26238f22bfe500d] (invalid)
> > [    0.000000] efi: mem14: [type=239207055|attr=0x0e41300e43380e0a] range=[0x8c280e42048d200e-0xc70b028f2f27cc0a00d] (invalid)
> > [    0.000000] efi: mem15: [type=239210510|attr=0x00080e660b47080e] range=[0x0000324c0000001c-0xa78028634ce490001b] (invalid)
> > [    0.000000] efi: mem16: [type=4294848528|attr=0x0000329400000014] range=[0x0e410286100e4100-0x80f252036a218f20ff] (invalid)
> > [    0.000000] efi: mem19: [type=2250772033|attr=0x42180e42200e4328] range=[0x41280e0ab9020683-0xe0e538c28b39e62682] (invalid)
> > [    0.000000] efi: mem20: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x00000008ffff4438-0xffff44340090333c437] (invalid)
> > [    0.000000] efi: mem22: [Reserved    |attr=0x000000c1ffff4420] range=[0xffff442400003398-0x1033a04240003f397] (invalid)
> > [    0.000000] efi: mem23: [type=1141080856|attr=0x080e41100e43180e] range=[0x280e66300e4b280e-0x440dc5ee7141f4c080d] (invalid)
> > [    0.000000] efi: mem25: [Reserved    |attr=0x0000000affff44a0] range=[0xffff44a400003428-0x1034304a400013427] (invalid)
> > [    0.000000] efi: mem28: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x0000000affff4488-0xffff448400b034bc487] (invalid)
> > [    0.000000] efi: mem30: [Reserved    |attr=0x0000000affff4470] range=[0xffff447400003518-0x10352047400013517] (invalid)
> > [    0.000000] efi: mem33: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x0000000affff4458-0xffff445400b035ac457] (invalid)
> > [    0.000000] efi: mem35: [type=269372416|attr=0x0e42100e42180e41] range=[0x0486200e44038c18-0x200e8b8a0eee823ac17] (invalid)
> > [    0.000000] efi: mem37: [type=2351435330|attr=0x0e42100e42180e42] range=[0x470783380e410686-0x2002b2a041c2141e685] (invalid)
> > [    0.000000] efi: mem38: [type=1093668417|attr=0x100e420000000270] range=[0x42100e42180e4220-0xfff366a4e421b78c21f] (invalid)
> > [    0.000000] efi: mem39: [type=76357646|attr=0x180e42200e42280e] range=[0x0e410686300e4105-0x4130f251a0710ae5104] (invalid)
> > [    0.000000] efi: mem40: [type=940444268|attr=0x0e42200e42280e41] range=[0x180e42200e42280e-0x300fc71c300b4f2480d] (invalid)
> > [    0.000000] efi: mem41: [MMIO        |attr=0x8c280e42048d200e] range=[0xffff479400003728-0x42138e0c87820292727] (invalid)
> > [    0.000000] efi: mem42: [type=1191674680|attr=0x0000004c0000000b] range=[0x300e41380e0a0246-0x470b0f26238f22b8245] (invalid)
> > [    0.000000] efi: mem43: [type=2010|attr=0x0301f00e4d078338] range=[0x45038e180e42028f-0xe4556bf118f282528e] (invalid)
> > [    0.000000] efi: mem44: [type=1109921345|attr=0x300e44000000006c] range=[0x44080e42100e4218-0xfff39254e42138ac217] (invalid)
> > ...
> >
> > This EFI memap corruption is happening with efi_arch_mem_reserve() invocation in case of kexec boot.
> >
> > ( efi_arch_mem_reserve() is invoked with the following call-stack: )
> >
> > [    0.310010]  efi_arch_mem_reserve+0xb1/0x220
> > [    0.311382]  efi_mem_reserve+0x36/0x60
> > [    0.311973]  efi_bgrt_init+0x17d/0x1a0
> > [    0.313265]  acpi_parse_bgrt+0x12/0x20
> > [    0.313858]  acpi_table_parse+0x77/0xd0
> > [    0.314463]  acpi_boot_init+0x362/0x630
> > [    0.315069]  setup_arch+0xa88/0xf80
> > [    0.315629]  start_kernel+0x68/0xa90
> > [    0.316194]  x86_64_start_reservations+0x1c/0x30
> > [    0.316921]  x86_64_start_kernel+0xbf/0x110
> > [    0.317582]  common_startup_64+0x13e/0x141
> >
> > efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
> > EFI memory map and due to early allocation it uses memblock allocation.
> >
> > Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
> > in case of a kexec-ed kernel boot.
> >
> > This function kexec_enter_virtual_mode() installs the new EFI memory map by
> > calling efi_memmap_init_late() which remaps the efi_memmap physically allocated
> > in efi_arch_mem_reserve(), but this remapping is still using memblock allocation.
> >
> > Subsequently, when memblock is freed later in boot flow, this remapped
> > efi_memmap will have random corruption (similar to a use-after-free scenario).
> >
> > The corrupted EFI memory map is then passed to the next kexec-ed kernel
> > which causes a panic when trying to use the corrupted EFI memory map.
> >
> > Fix this EFI memory map corruption by skipping efi_arch_mem_reserve() for kexec.
> >
> > Additionally, skipping this function for kexec altogther makes sense
> > as for kexec use case need to use the the EFI memmap passed from first
> > kernel via setup_data and avoid any additional EFI memory map
> > additions/updates.
> >
> > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > ---
> >  arch/x86/platform/efi/quirks.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> > index f0cc00032751..af7126d9c540 100644
> > --- a/arch/x86/platform/efi/quirks.c
> > +++ b/arch/x86/platform/efi/quirks.c
> > @@ -258,6 +258,26 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
> >       int num_entries;
> >       void *new;
> >
> > +     /*
> > +      * efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
> > +      * EFI memory map and due to early allocation it uses memblock allocation.
> > +      * Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
> > +      * in case of a kexec-ed kernel boot. This function kexec_enter_virtual_mode()
> > +      * installs the new EFI memory map by calling efi_memmap_init_late() which
> > +      * remaps the efi_memmap physically allocated here in efi_arch_mem_reserve(),
> > +      * but this remapping is still using memblock allocation.
> > +      * Subsequently, when memblock is freed later in boot flow, this remapped
> > +      * efi_memmap will have random corruption (similar to a use-after-free scenario).
> > +      * The corrupted EFI memory map is then passed to the next kexec-ed kernel
> > +      * which causes a panic when trying to use the corrupted EFI memory map.
> > +      * Additionally, skipping this function for kexec altogther makes sense
> > +      * as for kexec use case need to use the the EFI memmap passed from first
> > +      * kernel via setup_data and avoid any additional EFI memory map
> > +      * additions/updates.
> > +      */
> > +     if (efi_setup)
> > +             return;
> > +
>
> efi_mem_reserve is used to reserve boot service memory eg. bgrt, but
> it is not necessary for kexec boot, as there are no boot services in
> kexec reboot at all after the 1st kernel ExitBootServices().
>
> The UEFI memmap passed to kexec kernel includes not only the runtime
> service memory map but also the boot service memory ranges which were
> reserved by the 1st kernel with efi_mem_reserve, and those boot service
> memory ranges have already been marked "EFI_MEMORY_RUNTIME" attribute.
>
> Take example of bgrt, the saved memory is there only for people to check
> the bgrt image info via /sys/firmware/acpi/bgrt/*, and it is not used in
> early boot phase by boot services.
>
> Above is the reason why the efi_mem_reserve can be skipped for kexec
> booting.  But as I suggested before I personally think that checking
> EFI_MEMORY_RUNTIME attribute set or not looks better than checking
> efi_setup.
>

I recently applied the linux.dev mail with my Chinese pinyin name  for
use when I do not have vpn access.   So just to clarify a bit, I'm the
same person here :)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
