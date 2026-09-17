Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFE4C982CF
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 10:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zPEyYPDk8EE/aISYlZkkyB6RhrWT5mJK2Kdv46y7alY=; b=4v3zcONyecpeUnr4WZK5cn1fGI
	6pgw6//PnoKbVAFgsC9S5qrjqPiRni5vuciytNyR3SywTBwoffSsRyPViqmW63gR+nzWlswcTsbTi
	27WND2pD0o7Nyg/k7yzODNn+oVgyW2uQVCk73CwF4kTeaZjhNerQml6lR43uZ6ZNbN34OAwRxNPX2
	d+aWugwAro8kJZ3/rmvgfHeaIcLmEh3KOdAZ3ljFXNmz53NRiy658/j82ZSqZaOYWpyYWjlN60RND
	yJwbZHSojSWMCe0gyAO5qxEe3ro4u+gZy1P5lwznd48HO7jSAaBQFcoL0jHCiDmhdyVd7aCRHVvlY
	6zHT0shw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x79kz-0000000B8uT-1ggP;
	Thu, 17 Sep 2026 10:54:21 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x79kx-0000000B8tW-1cfu
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 10:54:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zPEyYPDk8EE/aISYlZkkyB6RhrWT5mJK2Kdv46y7alY=; b=JrNMbJz0FRUfJExTa9QX+PN6aX
	rhxoAQEs1iGB1gBE7OpxWvUIW8oaZJ+3qq36mNpM298qJUbpa6EV1l5ropOVv08fE6+gDxVbt6av4
	Hje1sXASq15UoTMM5biKhP59WUt5uM2mWizZ94hEA12cJeo+YKdwyq+FNA7cJwVDWzLzaLdEZ1Yn7
	bI4fAjT372GztJPzZsd7s8hbZJRyvaQhKvOYlC+Wbxp8OBHWPoY+w4qH7drvLUU9cVqE9vQmnJdT2
	we/GkdA4e8zC/Yrde1HYP1gljPaqZExfeBTOr8SiZVVolX2RERZBv5A/c7kAkxWLzR1xyVPxeBfsY
	xou5+GnA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x79kQ-005tLG-0g;
	Thu, 17 Sep 2026 10:53:46 +0000
Date: Thu, 17 Sep 2026 03:53:37 -0700
From: Breno Leitao <leitao@debian.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kas@kernel.org, kexec@lists.infradead.org, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Oscar Salvador <osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, hannes@cmpxchg.or, 
	shakeel.butt@linux.dev, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, harry@kernel.org, 
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v5 3/9] mm/memory-failure: libstub: install the
 poisoned-memory EFI table
Message-ID: <aqvE5kO5x0UpRm9m@gmail.com>
References: <20260915-hwpoison-kho-v5-3-3bc7a57bd503@debian.org>
 <20260916153954.1054456-1-usama.arif@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916153954.1054456-1-usama.arif@linux.dev>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_035419_427723_E418C88D 
X-CRM114-Status: GOOD (  18.28  )
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

Hello Usama,

On Wed, Sep 16, 2026 at 08:39:53AM -0700, Usama Arif wrote:
> On Tue, 15 Sep 2026 05:53:37 -0700 Breno Leitao <leitao@debian.org> wrote:
> > +static efi_status_t efi_get_ram_range(u64 *base, u64 *top)
> > +{
> > +	struct efi_boot_memmap *map __free(efi_pool) = NULL;
> > +	u64 ram_base = ULLONG_MAX, ram_top = 0;
> > +	efi_status_t status;
> > +	int i, nr_desc;
> > +
> > +	status = efi_get_memory_map(&map, false);
> > +	if (status != EFI_SUCCESS)
> > +		return status;
> > +
> > +	nr_desc = map->map_size / map->desc_size;
> > +	for (i = 0; i < nr_desc; i++) {
> > +		efi_memory_desc_t *d;
> > +
> > +		d = efi_memdesc_ptr((unsigned long)map->map, map->desc_size, i);
> > +		if (!(d->attribute & EFI_MEMORY_WB) &&
> > +		    d->type != EFI_UNACCEPTED_MEMORY)
> > +			continue;
> > +		ram_base = min(ram_base, d->phys_addr);
> 
> Can this use the architecture's full RAM predicate?  On x86,
> setup_e820() maps EFI_LOADER_CODE, EFI_LOADER_DATA, both boot-services
> types, and EFI_CONVENTIONAL_MEMORY as E820_TYPE_RAM without requiring
> EFI_MEMORY_WB.
> 
> If a non-WB descriptor is at either end of RAM, this code omits it
> from the bitmap span.  efi_hwpoison_record_pfn() then rejects a
> poisoned PFN there, so the next kernel can allocate the bad frame.
> 
> One possible way to preserve the x86 behavior before applying the WB rule is:
> 
>     if (IS_ENABLED(CONFIG_X86) &&
>         (d->type == EFI_LOADER_CODE ||
>          d->type == EFI_LOADER_DATA ||
>          d->type == EFI_BOOT_SERVICES_CODE ||
>          d->type == EFI_BOOT_SERVICES_DATA ||
>          d->type == EFI_CONVENTIONAL_MEMORY))
>             goto include;
>     if (!(d->attribute & EFI_MEMORY_WB) &&
>         d->type != EFI_UNACCEPTED_MEMORY)
>             continue;
> include:
>     ram_base = min(ram_base, 

Sure, I had something similar in v2, but the feedback there was to
simplify this and go coarser, since the real cost is only a few extra
bits in the bitmap, so it wasn't worth the added complexity.

Happy to bring it back if saving those bits is worthwhile.

See the discussion here:
https://lore.kernel.org/all/aogvGXKH2u7JsJiS@thinkstation/

Thanks for the review,
--breno

