Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7359C79FA0
	for <kexec@archiver.kernel.org>; Mon,  7 Sep 2026 14:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ICYiSV43kYcKi3w/xRQ/Uas9brIt0oFdfmwI0JjU7/I=; b=nq2tjMbwpHuP7S9bw0OuxTodEQ
	Gmbufvjp49GSX0Gjd0MEscRPQpkZYzCbxTdaSJS0oOANI5zNaXSGwSin4kZXKXIz/DrczsCo4xP5b
	UHhFZXTMDco12XTG0ZrZ9Q/M0NgF/EkfrCIhzD2/Cjo6enwebI0RDADrc0Lb1JBKGgTn8K5rv9Dho
	OBLfBcQgtkNaHTCMA2hyobVzox8WcXb/1LqATlBm7YzAt6dLMb+Vxww2Tt4/TVEFGJCx42Xcjb6Is
	5WmOcXPHMqT+CS96e3YCf5DO3vW0wNIaDa0CjV0jXpuxn4SyjZ6soWxMQ8Dj3K/ujkS5nXb/dWCIr
	i04sLcIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3adh-000000074vr-3S1J;
	Mon, 07 Sep 2026 14:48:05 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3adf-000000074uw-0KFi
	for kexec@lists.infradead.org;
	Mon, 07 Sep 2026 14:48:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ICYiSV43kYcKi3w/xRQ/Uas9brIt0oFdfmwI0JjU7/I=; b=LEdbSJ1vptFInpVZGgZaULk+vd
	DQo37X+q6ZRORyORTGdTprPmHsz6SWYLBydsnmvcR/ypYchTuPBNEz5dEaaQ/IlL9wG3KF84rhmLc
	tYOJUtnytxIrIUK91YfkX+U6C5DRjmsM/tF8IFi+i3g11jArKPgR/nAHRe9gSguz3O3uP4ltR70Hw
	p5dNMZ6wBrYxBXHx9Mt+/rGGGk6OOAc6v7KTPJJef7+pNWMRkHPIUiQsJx+UD6l0EZz191tpJvWU0
	m7txRONOs2qSVH/PVsXEBeWVTCCewenoKvSngeUrN2XTnxwZLGCfA5b+3kqhCVoIXvhLnPGWnYAJP
	+2NnDqtQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x3adP-001a5u-0c;
	Mon, 07 Sep 2026 14:47:47 +0000
Date: Mon, 7 Sep 2026 07:47:41 -0700
From: Breno Leitao <leitao@debian.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, 
	kernel-team@meta.com
Subject: Re: [PATCH v3 2/5] mm/memory-failure: libstub: install the
 poisoned-memory EFI table
Message-ID: <ap7OBwOs8BKGUJh8@gmail.com>
References: <20260826-hwpoison-kho-v3-0-6f79c4b605bc@debian.org>
 <20260826-hwpoison-kho-v3-2-6f79c4b605bc@debian.org>
 <apGSy78NoCov0MWr@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apGSy78NoCov0MWr@thinkstation>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_074803_199428_B95AE4AE 
X-CRM114-Status: GOOD (  21.20  )
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

On Fri, Aug 28, 2026 at 02:59:43PM +0100, Kiryl Shutsemau wrote:
> On Wed, Aug 26, 2026 at 05:03:53AM -0700, Breno Leitao wrote:
> > A EFI config table can only be installed while boot services are still
> > up, so the stub has to create it; the running kernel can only flip bits
> > in a table that already exists.
> > 
> > Size the bitmap from the top of usable RAM, which efi_get_ram_top()
> > works out by walking the UEFI memory map, since the stub has no max_pfn.
> > Bit N covers unit N counting from address 0, so the table tracks
> > max_pfn. Memory the firmware hot-adds later sits above it and is not
> > carried across a kexec.
> > 
> > One table has to serve every architecture, so efi_get_ram_top() takes
> > the union of the memory types they turn into RAM: what setup_e820() maps
> > to E820_TYPE_RAM on x86, plus the EFI_ACPI_RECLAIM_MEMORY and
> > EFI_PERSISTENT_MEMORY that is_usable_memory() accepts on arm64. Sizing
> > wide only costs bitmap bytes; sizing narrow silently drops the records
> > for every frame above the top.
> 
> x86 and ARM doesn't seem to agree what RAM is. On x86 it is by ->type
> and on ARM it is by ->attribute (anything WB/WC/WT).
> 
> is_usable_memory() only decides nomap. Everything is_memory() lets in
> lands in memblock.memory, and max_pfn is PFN_DOWN(memblock_end_of_DRAM()),
> so the top of RAM there can be a type that is not on your list.

Thanks. I will just ignore the memory types and get the base and top
based on the memory map descriptors.

Now that I need to get the phys base (from previous patch discussion),
I will need to get the range, doing something like:

	static efi_status_t efi_get_ram_range(u64 *base, u64 *top)
	{
	       struct efi_boot_memmap *map __free(efi_pool) = NULL;
	       u64 ram_base = ULLONG_MAX, ram_top = 0;
	       efi_status_t status;
	       int i, nr_desc;
	
	       status = efi_get_memory_map(&map, false);
	       if (status != EFI_SUCCESS)
	               return status;
	
	       nr_desc = map->map_size / map->desc_size;
	       for (i = 0; i < nr_desc; i++) {
	               efi_memory_desc_t *d;
	
	               d = efi_memdesc_ptr((unsigned long)map->map, map->desc_size, i);
	               ram_base = min(ram_base, d->phys_addr);
	               ram_top = max(ram_top,
	                             d->phys_addr + d->num_pages * EFI_PAGE_SIZE);
	       }
	       if (!ram_top)
	               return EFI_NOT_FOUND;
	
	       *base = round_down(ram_base, EFI_POISON_UNIT_SIZE);
	       *top = round_up(ram_top, EFI_POISON_UNIT_SIZE);

	       return EFI_SUCCESS;
	}

is it what you had in mind?

Thanks,
--breno

