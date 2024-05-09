Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588EAC10F1A
	for <kexec@archiver.kernel.org>; Thu,  9 May 2024 09:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NHLX7VebDLU83kxeZN6IcjDypDyu9yd7jZGEQ5gzfyA=; b=p53zZDrokfdbZB
	X6f9D5204OimMX+nxYc6d+vW/hOVgSJt7yZiO5UGefGWJnohDWqIqKsGQAOcfAF3HLvtYgDesXU+V
	1ygMRBGxN94fmgOgwLuLgWrhQy9GOruCoFx943LndK5gpJ/to6hrQ6bKreiOLXRHKqIiIdKgpNQCT
	n0rO6qQhwCNza0vGsGOSoLLnXJVSLXh7ONvMr1xZpbJo+tZ7xcDLFi8dLgIafwHCGIyoR66NajmAf
	tJ5ekjdyOEQO5c7VR4FwmMeZBDP6xLtrsoHS6oPBXrVKnXUY3jh6wqiYkbGHCFZu8n0/Ig5WfLxnr
	TWOr8gYK2kJxni3AbSIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s50Vm-000000013A2-2BAH;
	Thu, 09 May 2024 09:56:26 +0000
Received: from out-181.mta1.migadu.com ([2001:41d0:203:375::b5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s50Vj-00000001388-1MBT
	for kexec@lists.infradead.org;
	Thu, 09 May 2024 09:56:24 +0000
Date: Thu, 9 May 2024 17:56:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715248574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eavQZFD4au3dlPwrV1ymL1bS61CYH03uO5yiejStr2A=;
	b=Ij5teho5U1KSmt4XbjvZiGl0K3hmrd0r3eKQgIMljouTYknOOI+CObgps9hz9B91cKKnTZ
	fbZuHkgVTgAEHmRoeUN43EBPkou5m/e2c0EQDfXccD73atIomUt0SUSKRAWlRoVuD1oOIi
	Aa++DYFcUXN2m0rke1ZWIsyumYluch8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ruirui Yang <ruirui.yang@linux.dev>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
	hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <Zjydu25Z26dH81NX@darkstar.users.ipa.redhat.com>
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1714148366.git.ashish.kalra@amd.com>
 <6dfe98fb95d7193ba2d692a2b6900a4d5d73db26.1714148366.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6dfe98fb95d7193ba2d692a2b6900a4d5d73db26.1714148366.git.ashish.kalra@amd.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240509_025623_633111_90C35199 
X-CRM114-Status: GOOD (  29.59  )
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

On Fri, Apr 26, 2024 at 04:33:48PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> With SNP guest kexec observe the following efi memmap corruption :
> 
> [    0.000000] efi: EFI v2.7 by EDK II
> [    0.000000] efi: SMBIOS=0x7e33f000 SMBIOS 3.0=0x7e33d000 ACPI=0x7e57e000 ACPI 2.0=0x7e57e014 MEMATTR=0x7cc3c018 Unaccepted=0x7c09e018
> [    0.000000] efi: [Firmware Bug]: Invalid EFI memory map entries:
> [    0.000000] efi: mem03: [type=269370880|attr=0x0e42100e42180e41] range=[0x0486200e41038c18-0x200e898a0eee713ac17] (invalid)
> [    0.000000] efi: mem04: [type=12336|attr=0x0e410686300e4105] range=[0x100e420000000176-0x8c290f26248d200e175] (invalid)
> [    0.000000] efi: mem06: [type=1124304408|attr=0x000030b400000028] range=[0x0e51300e45280e77-0xb44ed2142f460c1e76] (invalid)
> [    0.000000] efi: mem08: [type=68|attr=0x300e540583280e41] range=[0x0000011affff3cd8-0x486200e54b38c0bcd7] (invalid)
> [    0.000000] efi: mem10: [type=1107529240|attr=0x0e42280e41300e41] range=[0x300e41058c280e42-0x38010ae54c5c328ee41] (invalid)
> [    0.000000] efi: mem11: [type=189335566|attr=0x048d200e42038e18] range=[0x0000318c00000048-0xe42029228ce4200047] (invalid)
> [    0.000000] efi: mem12: [type=239142534|attr=0x0000002400000b4b] range=[0x0e41380e0a7d700e-0x80f26238f22bfe500d] (invalid)
> [    0.000000] efi: mem14: [type=239207055|attr=0x0e41300e43380e0a] range=[0x8c280e42048d200e-0xc70b028f2f27cc0a00d] (invalid)
> [    0.000000] efi: mem15: [type=239210510|attr=0x00080e660b47080e] range=[0x0000324c0000001c-0xa78028634ce490001b] (invalid)
> [    0.000000] efi: mem16: [type=4294848528|attr=0x0000329400000014] range=[0x0e410286100e4100-0x80f252036a218f20ff] (invalid)
> [    0.000000] efi: mem19: [type=2250772033|attr=0x42180e42200e4328] range=[0x41280e0ab9020683-0xe0e538c28b39e62682] (invalid)
> [    0.000000] efi: mem20: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x00000008ffff4438-0xffff44340090333c437] (invalid)
> [    0.000000] efi: mem22: [Reserved    |attr=0x000000c1ffff4420] range=[0xffff442400003398-0x1033a04240003f397] (invalid)
> [    0.000000] efi: mem23: [type=1141080856|attr=0x080e41100e43180e] range=[0x280e66300e4b280e-0x440dc5ee7141f4c080d] (invalid)
> [    0.000000] efi: mem25: [Reserved    |attr=0x0000000affff44a0] range=[0xffff44a400003428-0x1034304a400013427] (invalid)
> [    0.000000] efi: mem28: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x0000000affff4488-0xffff448400b034bc487] (invalid)
> [    0.000000] efi: mem30: [Reserved    |attr=0x0000000affff4470] range=[0xffff447400003518-0x10352047400013517] (invalid)
> [    0.000000] efi: mem33: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x0000000affff4458-0xffff445400b035ac457] (invalid)
> [    0.000000] efi: mem35: [type=269372416|attr=0x0e42100e42180e41] range=[0x0486200e44038c18-0x200e8b8a0eee823ac17] (invalid)
> [    0.000000] efi: mem37: [type=2351435330|attr=0x0e42100e42180e42] range=[0x470783380e410686-0x2002b2a041c2141e685] (invalid)
> [    0.000000] efi: mem38: [type=1093668417|attr=0x100e420000000270] range=[0x42100e42180e4220-0xfff366a4e421b78c21f] (invalid)
> [    0.000000] efi: mem39: [type=76357646|attr=0x180e42200e42280e] range=[0x0e410686300e4105-0x4130f251a0710ae5104] (invalid)
> [    0.000000] efi: mem40: [type=940444268|attr=0x0e42200e42280e41] range=[0x180e42200e42280e-0x300fc71c300b4f2480d] (invalid)
> [    0.000000] efi: mem41: [MMIO        |attr=0x8c280e42048d200e] range=[0xffff479400003728-0x42138e0c87820292727] (invalid)
> [    0.000000] efi: mem42: [type=1191674680|attr=0x0000004c0000000b] range=[0x300e41380e0a0246-0x470b0f26238f22b8245] (invalid)
> [    0.000000] efi: mem43: [type=2010|attr=0x0301f00e4d078338] range=[0x45038e180e42028f-0xe4556bf118f282528e] (invalid)
> [    0.000000] efi: mem44: [type=1109921345|attr=0x300e44000000006c] range=[0x44080e42100e4218-0xfff39254e42138ac217] (invalid)
> ...
> 
> This EFI memap corruption is happening with efi_arch_mem_reserve() invocation in case of kexec boot.
> 
> ( efi_arch_mem_reserve() is invoked with the following call-stack: )
> 
> [    0.310010]  efi_arch_mem_reserve+0xb1/0x220
> [    0.311382]  efi_mem_reserve+0x36/0x60
> [    0.311973]  efi_bgrt_init+0x17d/0x1a0
> [    0.313265]  acpi_parse_bgrt+0x12/0x20
> [    0.313858]  acpi_table_parse+0x77/0xd0
> [    0.314463]  acpi_boot_init+0x362/0x630
> [    0.315069]  setup_arch+0xa88/0xf80
> [    0.315629]  start_kernel+0x68/0xa90
> [    0.316194]  x86_64_start_reservations+0x1c/0x30
> [    0.316921]  x86_64_start_kernel+0xbf/0x110
> [    0.317582]  common_startup_64+0x13e/0x141
> 
> efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
> EFI memory map and due to early allocation it uses memblock allocation.
> 
> Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
> in case of a kexec-ed kernel boot.
> 
> This function kexec_enter_virtual_mode() installs the new EFI memory map by
> calling efi_memmap_init_late() which remaps the efi_memmap physically allocated
> in efi_arch_mem_reserve(), but this remapping is still using memblock allocation.
> 
> Subsequently, when memblock is freed later in boot flow, this remapped
> efi_memmap will have random corruption (similar to a use-after-free scenario).
> 
> The corrupted EFI memory map is then passed to the next kexec-ed kernel
> which causes a panic when trying to use the corrupted EFI memory map.
> 
> Fix this EFI memory map corruption by skipping efi_arch_mem_reserve() for kexec.
> 
> Additionally, skipping this function for kexec altogther makes sense
> as for kexec use case need to use the the EFI memmap passed from first
> kernel via setup_data and avoid any additional EFI memory map
> additions/updates.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/platform/efi/quirks.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index f0cc00032751..af7126d9c540 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -258,6 +258,26 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>  	int num_entries;
>  	void *new;
>  
> +	/*
> +	 * efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
> +	 * EFI memory map and due to early allocation it uses memblock allocation.
> +	 * Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
> +	 * in case of a kexec-ed kernel boot. This function kexec_enter_virtual_mode()
> +	 * installs the new EFI memory map by calling efi_memmap_init_late() which
> +	 * remaps the efi_memmap physically allocated here in efi_arch_mem_reserve(),
> +	 * but this remapping is still using memblock allocation.
> +	 * Subsequently, when memblock is freed later in boot flow, this remapped
> +	 * efi_memmap will have random corruption (similar to a use-after-free scenario).
> +	 * The corrupted EFI memory map is then passed to the next kexec-ed kernel
> +	 * which causes a panic when trying to use the corrupted EFI memory map.
> +	 * Additionally, skipping this function for kexec altogther makes sense
> +	 * as for kexec use case need to use the the EFI memmap passed from first
> +	 * kernel via setup_data and avoid any additional EFI memory map
> +	 * additions/updates.
> +	 */
> +	if (efi_setup)
> +		return;
> +

efi_mem_reserve is used to reserve boot service memory eg. bgrt, but
it is not necessary for kexec boot, as there are no boot services in
kexec reboot at all after the 1st kernel ExitBootServices().

The UEFI memmap passed to kexec kernel includes not only the runtime
service memory map but also the boot service memory ranges which were
reserved by the 1st kernel with efi_mem_reserve, and those boot service
memory ranges have already been marked "EFI_MEMORY_RUNTIME" attribute. 

Take example of bgrt, the saved memory is there only for people to check
the bgrt image info via /sys/firmware/acpi/bgrt/*, and it is not used in
early boot phase by boot services.

Above is the reason why the efi_mem_reserve can be skipped for kexec
booting.  But as I suggested before I personally think that checking
EFI_MEMORY_RUNTIME attribute set or not looks better than checking
efi_setup.

>  	if (efi_mem_desc_lookup(addr, &md) ||
>  	    md.type != EFI_BOOT_SERVICES_DATA) {
>  		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
> -- 
> 2.34.1
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
