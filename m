Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE98BC5DF94
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 13:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O2Scpyty4GH+eqGEvARQTzFRBjvGNIS26XjXcBDeF/Q=; b=bkfRL4GnvJCX3fXn3UX8h6Eyf+
	RKUh+foP11+UJCyjYUM9GCApPlNfmmr06wAVQ1QEG+HWMhT1BtQutOJD7oZNALiSCW07n949fDwMu
	ukc6OwySzkn3MvKuTtRM6kj8Y9Tm/+0sHeTIzDL22TQsUvmoiFwhHghMcFtMxAMEHbrB4VChSX70d
	t9ra34Sugl4cvO8SWlgkw9WWoruaUIIbjQSExrOraox21gQlJ4qhdko47wqTSYnOHNKuRmPrUnpnk
	sxXsicR9wsZb4ZUpdHXmk20DmdsGvViDX72dYpDH8CorEWmLVxfqvpcuzy9qA5PGYct5u/Ohsrn8A
	y2LAyHFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyUKw-0000000Geu3-3ArF;
	Mon, 24 Aug 2026 13:03:38 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyUKu-0000000GetQ-3fTo
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 13:03:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O2Scpyty4GH+eqGEvARQTzFRBjvGNIS26XjXcBDeF/Q=; b=PRPwI+mHCGcb2sHUsdpeaL+JJu
	X3E4qrt0g1rrtHtkSflkI1EemlwQRZ8iOqWSvqBogthUK9dhLZogyMr0jo+ItJbTizL89gETEgzuG
	13nVdZUvGjF8Z5eSjawkUQnXJTsPV6x4TZGUE5LGoBQi3Rhr7WCV+kpjXmKl0OMh6g04nAr7eOeg2
	Y5CUxEqpoQSOVIoqbbCw1+PeRZUIb+M+Zv6r6UztlHIE8ye/dwTGLkruOj8UbGdI+rgE8Lc9wgbaD
	RjSKX9Y9usd0EAi2ip5o4l/8WMxB1XLzMKBu66AoOcL0VznfvBary2dneWvHkOqGwsd1lBYpwnmuC
	y6uoGmlQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wyUKV-00DgAo-09;
	Mon, 24 Aug 2026 13:03:11 +0000
Date: Mon, 24 Aug 2026 06:03:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rmikey@meta.com, riel@surriel.com, kexec@lists.infradead.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 6/6] efi: respect the poisoned pages coming from
 previous kernel
Message-ID: <aow_bfUQWZWh7Kxb@gmail.com>
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
 <20260821-hwpoison-kho-v2-6-5743791e48e6@debian.org>
 <aog_uH5fTsJzXjjx@thinkstation>
 <aohIF6MmjiQpbz5j@gmail.com>
 <aohldTtzE2GJ76md@thinkstation>
 <aoh-3XJw82O8SmsA@gmail.com>
 <aowcYuXEeqdfHmn6@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aowcYuXEeqdfHmn6@thinkstation>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_060336_921499_1A1AA2F2 
X-CRM114-Status: GOOD (  11.60  )
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

On Mon, Aug 24, 2026 at 11:32:35AM +0100, Kiryl Shutsemau wrote:
> I wounder if the fix would be to make page allocator consume the table
> and not do memblock_reserve() here? So we would allocate struct pages
> for the memory and poison them on init. And your fix by the link below
> would do the rest.

Makes sense. Probably dropping memblock_reserve() altogether, for the
units and the table, and poisoning the recorded frames at
mm_core_init(), right after memblock_free_all().

Roughly what I have in mind:

        memblock_free_all();
        hwpoison_init_boot();
        mem_init();

and hwpoison_init_boot() drives it from the table, walking the bitmap on
the EFI side where the geometry lives:

        for_each_set_bit(bit, map, nbits) {
                u64 unit = off * BITS_PER_BYTE + bit;
                unsigned long pfn, i;

                pfn = PHYS_PFN(phys_base + unit * unit_size);
                for (i = 0; i < unit_size >> PAGE_SHIFT; i++)
                        hwpoison_boot_pfn(pfn + i);
        }

mm/memory-failure.c gets the per page primitive:

        bool __init hwpoison_boot_pfn(unsigned long pfn)
        {
                struct page *page = pfn_to_online_page(pfn);

                if (!page || PageHWPoison(page))
                        return false;

                if (!is_free_buddy_page(page) || !take_page_off_buddy(page))
                        return false;

                SetPageHWPoison(page);
                page_ref_inc(page);
                atomic_long_inc(&num_poisoned_pages);

                return true;
        }

Yea, this seems better in fact. Let me know if that matches what you
had in mind.

Thanks!
--breno

