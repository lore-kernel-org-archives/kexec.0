Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26061C88E7F
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lDBTit4NoXLRMGpd4sVgLpWCd4j9Sa9yMZ+BGUjsUHM=; b=HoWnNGKK9dPmQT5N9KG9zYAP30
	eno3PjGR2P9c1BERqrpQQJ1wqIUdNpGmTBpL/4QIIfTSvQGpbS7Gb3jwyKdSpP5S8mN3v2NsSpn+G
	3Y6ZakeUNkJU4+Cy8je6STk9k3UM+ato/CISjcPggIjB43ITaGefLWCc6O0F9l5JczL7oi0zp8jyx
	ObOA3lk5HfOs+Pg2UZqNshvXYss86YHyArJyR8G0zG5bXbIcpkHXx3Mzl0eJEUfiNZ05bPCCpoCxz
	kj0tP+cujgu2vby46EnCSgwUK2I9cTxTuIsEWI4Vog4S+iRMO2jm4sHwQRPPobVHhxk3wL4zl27El
	Za4b9w0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6UFK-00000006xGg-40D9;
	Tue, 15 Sep 2026 14:34:54 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6UFH-00000006xFj-2H8s
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 14:34:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lDBTit4NoXLRMGpd4sVgLpWCd4j9Sa9yMZ+BGUjsUHM=; b=rxIZo+ME/rnXqtE9cMmhwEEDF8
	herFmWck0rdzUOYTwXmZp0pi2WTQkMtFZNmZgCe0aEf9jVCe0Fu1nbdZWoIal6/iUa2akZj1+HXbC
	+GLyz8VgoecklgzBC+RQ0T30hnVb2tPPJHlVdbwNN12DbSHBCszNGMMRvZDagv7QXAylN+YTwSUpT
	EKdKzj8I1gZugRwDY3wWMw3szm63xr/sJAZZ9dyFVm//APAxrwVmHwFgeCM7y89NHhxaUXsVXvy/7
	0aLs3fr2d8hoF0rhzA/vk7+SaxeIokLEUqWp9SqGvSmnLn5m+JK1SaAXp6Ycl37ZbKo9tDy/xHHr/
	i7HszdgA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6UEZ-004Scw-23;
	Tue, 15 Sep 2026 14:34:07 +0000
Date: Tue, 15 Sep 2026 07:33:59 -0700
From: Breno Leitao <leitao@debian.org>
To: sashiko-reviews@lists.linux.dev
Cc: David Hildenbrand <david@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, kas@kernel.org, Zi Yan <ziy@nvidia.com>, hannes@cmpxchg.or, 
	shakeel.butt@linux.dev, "Liam R. Howlett" <liam@infradead.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Johannes Weiner <hannes@cmpxchg.org>, Danilo Krummrich <dakr@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Oscar Salvador <osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mike Rapoport <rppt@kernel.org>, kernel-team@meta.com, kexec@lists.infradead.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-mm@kvack.org, rmikey@meta.com, driver-core@lists.linux.dev, riel@surriel.com, 
	harry@kernel.org
Subject: Re: [PATCH v5 5/9] mm/memory-failure: efi: record hardware-poisoned
 frames into the poisoned-memory table
Message-ID: <aqlVkbx8j5cQ3eNX@gmail.com>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <20260915-hwpoison-kho-v5-5-3bc7a57bd503@debian.org>
 <20260915133629.700EE1F000FF@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915133629.700EE1F000FF@smtp.kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_073451_734862_BA747805 
X-CRM114-Status: GOOD (  35.48  )
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

On Tue, Sep 15, 2026 at 01:36:29PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] efi: memblock_add() with PAGE_ALIGN_DOWN forces adjacent MMIO into system RAM
> - [High] efi: ABI breakage in linux_efi_poisoned_memory due to native word size
> - [Medium] mm: hard memory failures on soft-offlined pages are omitted from EFI table
> --
> 
> commit e69689c81050c18119d69206dc9a7cb1e2fa4eeb
> Author: Breno Leitao <leitao@debian.org>
> 
> mm/memory-failure: efi: record hardware-poisoned frames into the poisoned-memory table
> 
> This commit hooks memory_failure() hard offline reports into the EFI
> poisoned memory table so that they persist across kexec. Soft-offlined
> pages are deliberately excluded to prevent predictive offlining from
> becoming a permanent loss.
> 
> > diff --git a/drivers/firmware/efi/poison.c b/drivers/firmware/efi/poison.c
> > index 3f12db3dc9b84..847592862f01d 100644
> > --- a/drivers/firmware/efi/poison.c
> > +++ b/drivers/firmware/efi/poison.c
> > @@ -91,3 +91,30 @@ void __init efi_poisoned_memory_reserve(void)
> >  	memblock_add(start, end - start);
> >  	memblock_reserve(start, end - start);
> 
> [Severity: Critical]
> Does this forcefully override the firmware's memory map for adjacent 4KB
> chunks on larger page architectures? 
> 
> On architectures like ARM64 where the kernel page size can be 16KB or
> 64KB, EFI memory descriptors remain 4KB. If the EFI poisoned memory table
> occupies a 4KB region within a 64KB page, rounding down to the kernel
> page boundary expands the range.
> 
> This could force adjacent 4KB EFI regions containing firmware MMIO or
> reserved non-RAM regions into system RAM via memblock_add(). If the
> kernel later maps these regions with Write-Back caching attributes in the
> direct map, could this cause fatal Machine Check Exceptions or SError
> panics during speculative CPU accesses?

arm64 already rounds every EFI descriptor outward via
memrange_efi_to_native(), so it adds no new class of over-mapping, and
reserve_regions() adds and reserves this WB ACPI-reclaim table anyway
moments later.

So, it doesn't seem relevant?!

> > diff --git a/include/linux/efi.h b/include/linux/efi.h index
> > dd3263456dd4a..56402fdccd114 100644 --- a/include/linux/efi.h +++
> > b/include/linux/efi.h @@ -1288,8 +1288,10 @@ struct
> > linux_efi_poisoned_memory {
> 
> [Severity: High] Does the linux_efi_poisoned_memory ABI structure
> break on architectures where the native word size differs from the
> firmware? 
> 
> The struct uses an unsigned long flexible array for the bitmap, which
> alters the element size depending on the kernel bitness (4 bytes on
> 32-bit and 8 bytes on 64-bit). efi_poison_geometry_valid() rejects
> tables where the size is not a multiple of sizeof(unsigned long). 
> 
> If a 32-bit EFI firmware generates this table, it will use 4-byte
> alignment and a 32-bit word array. Because CONFIG_EFI_POISONED_MEMORY
> is 64-bit only, the 64-bit kernel will evaluate sizeof(unsigned long)
> as 8 and reject perfectly valid 32-bit firmware tables as malformed. 
> 
> Since bit array layouts also differ across word sizes on big-endian
> architectures, should this firmware-to-kernel ABI boundary use
> fixed-size types like u32 or u64 instead?

That is not the case, because this feature depends on 64-bits and
!BIG_ENDIAN.

In fact, CONFIG_EFI is depends on OF && !CPU_BIG_ENDIAN
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c index
> > a2ca8df501cae..d9b8be696aac3 100644 --- a/mm/memory-failure.c +++
> > b/mm/memory-failure.c
> [ ... ]
> > @@ -1326,6 +1327,8 @@ static int action_result(unsigned long pfn,
> > enum mf_action_page_type type, if (type != MF_MSG_ALREADY_POISONED
> > && type != MF_MSG_PFN_MAP) { num_poisoned_pages_inc(pfn);
> > update_per_node_mf_stats(pfn, result); +		/* Only hard
> > offlines are carried over to the next kernel. */
> > +		efi_hwpoison_record_pfn(pfn); }
> 
> [Severity: Medium] Does placing efi_hwpoison_record_pfn() inside this
> conditional block unintentionally skip recording hard errors on
> previously soft-offlined pages? 
> 
> Soft-offline marks a page with PageHWPoison but intentionally does not
> record it in the EFI table to avoid permanent loss for predictive
> errors. 
> 
> If a genuine hard, uncorrectable error later occurs on that same page,
> memory_failure() will see the existing PageHWPoison flag and pass
> MF_MSG_ALREADY_POISONED to action_result(). 
> 
> By coupling the EFI recording to the meminfo stat increments, genuine
> hard errors on soft-offlined pages are omitted from the EFI table.
> Could this allow the next kernel to map and crash on physically broken
> RAM?

Yes, this one is real, thanks.

soft_offline_page() reaches num_poisoned_pages_inc() through
page_handle_poison() and never calls action_result(), so the hook does
not need the MF_MSG_ALREADY_POISONED guard to keep soft offlines out of
the table. That guard is there for the stats, and coupling to it drops a
hard error on a page that was soft-offlined earlier.

The frame is not lost for good -- the next kernel hands it out, the error
comes back and is recorded then -- but that is one machine check per
kexec that this series exists to avoid.

I will move the call out of the stats guard in v6, keeping MF_MSG_PFN_MAP
excluded since that path is not System RAM

