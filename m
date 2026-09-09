Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ADBC79FB6
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 14:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=305fiDZR5O30XyYnejmNt8DXKRI31wkY0vRofwAAD4Q=; b=aFAs8fJIm5gX2uXPEs1d0BR4eH
	ws3ZmeEwlHxWZlhtoghw6ynVzD1Fhmx/qVy9OzJfClUk0oGx2NHE1aiV7pZrmt/mc4rTV3dEAzblv
	B3skhHojV9cFPpstyxESOm3s4uFkQFE4hjUp7Qsefl3NkK/JE8qJ7d55tgkBwu3qbfbj/KT2cxLtl
	oSVxNG8ZICOy0gUFQXeaCJPCmtq00Xla2fChBK0hFjoT9XPNUPAgygmxgildkWfgU5n+Tf1gXNZ9o
	wjJ2gFhFi+HIeEJ63PdPO7NV0ZyaOGBLFA3eUG9vRXU7qDrW8kvU+Uv8l/YWHaoWlJ7FGeRVZezhA
	3ZTW6pVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Jai-0000000C2b4-0Vqe;
	Wed, 09 Sep 2026 14:48:00 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Jag-0000000C2ar-2dRf
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 14:47:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1377C43F53;
	Wed,  9 Sep 2026 14:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8781F00A3A;
	Wed,  9 Sep 2026 14:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965278;
	bh=305fiDZR5O30XyYnejmNt8DXKRI31wkY0vRofwAAD4Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ZZFAwEJVzbtlIAGO+fnOtB5jWW+zWKG7gl4n2jkYO3JtYzVGXWG2RvQTp8NXSf30X
	 Zvl/gda0d3cgBOGxI695iMFajpKW+qwBgkqrtr0V5OmTpAxcDds2Hs+D/Kc46QThqn
	 tu/dAGPncf6jkqObNIqe+6Ty4QEkI3dwWNepx7RKLxKFT0UBT183Wx8B2RfjX88qbG
	 jHmOeJn5vYAEpERvQxET/FVb6MTuCbpquGrw6ZzfMSfTSZ9jxR2HD1a2P47k9LYfpG
	 lnepF+o9g0rXIAlSDHS1hrYbSAPfki7euioGuULEjkXR/xQBEeudn7PlQFoEJ96EsY
	 cp11YPDnYQlGw==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id A4D75198003A;
	Wed,  9 Sep 2026 10:47:54 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Wed, 09 Sep 2026 10:47:54 -0400
X-ME-Sender: <xms:lXGhalsJpXFCBjo_K3bvHiiBuzsJiOJeG96f1ivVJUtfw3ic8tAuqA>
    <xme:lXGhapSRHw_5ZqAHSvUhZJODY4NNznJyd-ClKtHphmi3uzVQ5g22quM3OXEH62ZOQ
    AtmIeQVMfPWMqpnJ5oASUy1xfuD2IayapsdLOJrcKenZyVkvisU91OS>
X-ME-Proxy-Cause: dmFkZTE6jmqC424uS50ngBXddaPLMfJzFShd+1mTL0Ixo+2iSVYras5InCqXE6NTcXbwJj
    blle7PySdPpumsjtyWm7gKb+QFtda9yypgBSD/tGgHWlaQzIaeqPqHd+JXpc+hHQ7cNnwp
    bx/EVJvlyTofZ/JA8PThZhe594JSfmn+cmcpXl9DSqaoShAAWLC7MFAwSI/Knogapul3g5
    /GpcynIMWR7hq+SLxVUK7ASoGqyAh7edjCF0RO34X2CrBuOmnHnAki9dV6WSXefxAOETRL
    Y8S58oOxIqzGZi7jKElLzjU9t9opg1Dpo8i8+I3BPclrRAeyP9iDr2SDYeKKmpYeckwzFA
    VuGG0qxaUE3VzLBKTxJ7QRsOtrnpJ7uoKpMGSGQP+lrWf5swrzuIMO15r8hWWSGi+Jq8AW
    VlQbk9QotDYCbFZkJb2X9MtFJ59KADeOlXu05UJZVjwaxHPosLKGjtE9XCPICGlkCPNlZn
    Xk7Twd21fa9s4I4jrGJ8lox7ZtGwI0CVuilgbD4HM9QyCOr3+fGlE2prt4hv9Ir0ga46UG
    GyJWCJZtIZ1NVdunaJcz//hPli6MyXJQihxpszckpaX2jT2tyd33qv2gToQ/l8FEn8R2oj
    BQyKzngPCRzo/Jwyf4v9KPdujqT7Xgsi05wMzp/XXAkbq34p7yxD6jLJsHRQ
X-ME-Proxy: <xmx:mnGham6Acb4iT1vA9qm3Lr1t9oU8OIUGoheuL9VEG-DiTldY1xj-8g>
    <xmx:mnGham2EsdJWyC2SA5GUYRnyfpV1ifoldQMroELi1I1DvNyAWROEXA>
    <xmx:mnGhar77y1ix8YaN9_NS8HZiCq8iec08hm6soV_k0sIRr-bnd_U0Jw>
    <xmx:mnGhahrtoSs6QcVfrl1Xz9fNDcOgGZ8pPKcg4brx7CnunmDkZjKbXg>
    <xmx:mnGharV_tFyeApxnmSPSCH6YG4Pam3hCsuzLELRJML0H6O-x9MSms6l9>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A5932F8007D; Wed,  9 Sep 2026 10:47:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Wed, 09 Sep 2026 16:47:27 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Breno Leitao" <leitao@debian.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Miaohe Lin" <linmiaohe@huawei.com>,
 "Naoya Horiguchi" <nao.horiguchi@gmail.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>, kexec@lists.infradead.org,
 "David Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>,
 "Brendan Jackman" <brendan.jackman@linux.dev>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, harry@kernel.org,
 kernel-team@meta.com
Message-Id: <2c9a7bef-3189-4f78-a6cb-61d2f7afd643@app.fastmail.com>
In-Reply-To: <20260909-hwpoison-kho-v4-2-359313564495@debian.org>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
 <20260909-hwpoison-kho-v4-2-359313564495@debian.org>
Subject: Re: [PATCH v4 2/5] mm/memory-failure: libstub: install the poisoned-memory EFI
 table
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Hello Breno,

Apologies for chiming in late.

On Wed, 9 Sep 2026, at 15:05, Breno Leitao wrote:
> A EFI config table can only be installed while boot services are still
> up, so the stub has to create it; the running kernel can only flip bits
> in a table that already exists.
>

This is true, but that also means a config table could have a 'next' field
pointing to an allocation that was added later.

There is a EFI memreserve table based on this principle: this is a hack
that we added for the arm64 GICv3 LPI table handling, which is a braindead
piece of kit that must use the same physical allocation as the previous
kernel. It is not currently enabled on x86.

Please consider whether or not that is more suitable, and can be repurposed
or shared. (Feel free to make changes to the current format if needed).

I don't have a strong preference either way, but I feel the 2M granularity
may be a bit wasteful, no?

> Size the bitmap from the span the UEFI memory map describes, which
> efi_get_ram_range() walks since the stub has no max_pfn. Bit 0 covers
> the bottom of that span, recorded in phys_base, so a machine whose RAM
> starts high does not pay for the hole below it. Memory the firmware
> hot-adds later sits outside the span and is not carried across a kexec.
>
> One table has to serve every architecture, and they do not agree on what
> becomes RAM: x86 decides by descriptor type, arm64 by attribute. So
> efi_get_ram_range() does not filter at all and spans every descriptor in
> the map. Sizing wide only costs bitmap bytes; sizing narrow silently
> drops the records for every frame outside the span.
>
> At one bit per 2M that is 64K per TiB, and 256M at the 4PB x86
> architectural maximum. The 2M granule is called "unit" here, and the
> table carries it so the granule can change later without breaking the
> kernels already reading it.
>
> Allocate it as EFI_ACPI_RECLAIM_MEMORY so the next kernel does not take
> it for free RAM, and install it empty.
>
> A table installed by an earlier boot rides the system table across kexec
> and is reused as-is.
>
> x86 does not go through efi_stub_common(), so the generic stub and the
> x86 stub each need the call; on x86 it has to come before exit_boot(),
> which is the last point a configuration table can be installed.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 100 +++++++++++++++++++++++++
>  drivers/firmware/efi/libstub/efi-stub.c        |   1 +
>  drivers/firmware/efi/libstub/efistub.h         |   6 ++
>  drivers/firmware/efi/libstub/x86-stub.c        |   2 +
>  4 files changed, 109 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c 
> b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 48f93f7758e9e..5cbe675491333 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -774,3 +774,103 @@ void efi_remap_image(unsigned long image_base, 
> unsigned alloc_size,
>  			efi_warn("Failed to remap data region non-executable\n");
>  	}
>  }
> +
> +#ifdef CONFIG_EFI_POISONED_MEMORY
> +/*
> + * Find the base and top of the memory, so, we can create the bitmap 
> for
> + * the full range.
> + */
> +static efi_status_t efi_get_ram_range(u64 *base, u64 *top)
> +{
> +	struct efi_boot_memmap *map __free(efi_pool) = NULL;
> +	u64 ram_base = ULLONG_MAX, ram_top = 0;
> +	efi_status_t status;
> +	int i, nr_desc;
> +
> +	status = efi_get_memory_map(&map, false);
> +	if (status != EFI_SUCCESS)
> +		return status;
> +
> +	nr_desc = map->map_size / map->desc_size;
> +	for (i = 0; i < nr_desc; i++) {
> +		efi_memory_desc_t *d;
> +
> +		d = efi_memdesc_ptr((unsigned long)map->map, map->desc_size, i);
> +		ram_base = min(ram_base, d->phys_addr);
> +		ram_top = max(ram_top,
> +			      d->phys_addr + d->num_pages * EFI_PAGE_SIZE);
> +	}
> +	if (!ram_top || ram_base == ULLONG_MAX)
> +		return EFI_NOT_FOUND;
> +
> +	*base = round_down(ram_base, EFI_POISON_UNIT_SIZE);
> +	*top = round_up(ram_top, EFI_POISON_UNIT_SIZE);
> +
> +	return EFI_SUCCESS;
> +}
> +
> +/* The size of the bitmap */
> +static u64 efi_poison_bitmap_size(u64 span)
> +{
> +	u64 bytes = DIV_ROUND_UP(DIV_ROUND_UP(span, EFI_POISON_UNIT_SIZE),
> +				 BITS_PER_BYTE);
> +
> +	return round_up(bytes, sizeof(unsigned long));
> +}
> +
> +static struct linux_efi_poisoned_memory *efi_poison_alloc(u64 
> phys_base,
> +							  u64 bitmap_size)
> +{
> +	struct linux_efi_poisoned_memory *pm;
> +	efi_status_t status;
> +
> +	status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
> +			     sizeof(*pm) + bitmap_size, (void **)&pm);
> +	if (status != EFI_SUCCESS)
> +		return NULL;
> +
> +	pm->version = 1;
> +	pm->unit_size = EFI_POISON_UNIT_SIZE;
> +	pm->phys_base = phys_base;
> +	pm->size = bitmap_size;
> +	memset(pm->bitmap, 0, bitmap_size);
> +
> +	return pm;
> +}
> +
> +/* This needs to be done while boot service is still active */
> +void install_poisoned_memory_table(void)
> +{
> +	efi_guid_t poisoned_memory_table_guid = 
> LINUX_EFI_POISONED_MEMORY_TABLE_GUID;
> +	struct linux_efi_poisoned_memory *pm;
> +	u64 ram_base, ram_top, bitmap_size;
> +	efi_status_t status;
> +
> +	/* A table installed by an earlier boot rides the system table across 
> kexec. */
> +	pm = get_efi_config_table(poisoned_memory_table_guid);
> +	if (pm) {
> +		if (pm->version != 1)
> +			efi_err("Unknown version of poisoned-memory table\n");
> +		return;
> +	}
> +
> +	if (efi_get_ram_range(&ram_base, &ram_top) != EFI_SUCCESS) {
> +		efi_err("Failed to size the poisoned-memory table!\n");
> +		return;
> +	}
> +
> +	bitmap_size = efi_poison_bitmap_size(ram_top - ram_base);
> +	pm = efi_poison_alloc(ram_base, bitmap_size);
> +	if (!pm) {
> +		efi_err("Failed to allocate poisoned-memory table!\n");
> +		return;
> +	}
> +
> +	status = efi_bs_call(install_configuration_table,
> +			     &poisoned_memory_table_guid, pm);
> +	if (status != EFI_SUCCESS) {
> +		efi_bs_call(free_pool, pm);
> +		efi_err("Failed to install poisoned-memory config table!\n");
> +	}
> +}
> +#endif
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c 
> b/drivers/firmware/efi/libstub/efi-stub.c
> index 235c9738da2d6..22a315e2814a1 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -179,6 +179,7 @@ efi_status_t efi_stub_common(efi_handle_t handle,
>  			 EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP);
> 
>  	install_memreserve_table();
> +	install_poisoned_memory_table();
> 
>  	status = efi_boot_kernel(handle, image, image_addr, cmdline_ptr);
> 
> diff --git a/drivers/firmware/efi/libstub/efistub.h 
> b/drivers/firmware/efi/libstub/efistub.h
> index fd91fc15ec810..44436869c4efe 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -1169,6 +1169,12 @@ efi_enable_reset_attack_mitigation(void) { }
> 
>  void efi_retrieve_eventlog(void);
> 
> +#ifdef CONFIG_EFI_POISONED_MEMORY
> +void install_poisoned_memory_table(void);
> +#else
> +static inline void install_poisoned_memory_table(void) { }
> +#endif
> +
>  struct sysfb_display_info *alloc_primary_display(void);
>  struct sysfb_display_info *__alloc_primary_display(void);
>  void free_primary_display(struct sysfb_display_info *dpy);
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c 
> b/drivers/firmware/efi/libstub/x86-stub.c
> index 0bae0f06b6763..3136132b9628a 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -1024,6 +1024,8 @@ void __noreturn efi_stub_entry(efi_handle_t 
> handle,
> 
>  	setup_unaccepted_memory();
> 
> +	install_poisoned_memory_table();
> +
>  	status = exit_boot(boot_params, handle);
>  	if (status != EFI_SUCCESS) {
>  		efi_err("exit_boot() failed!\n");
>
> -- 
> 2.53.0-Meta

