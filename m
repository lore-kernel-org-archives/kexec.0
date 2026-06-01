Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5869FCD6E4C
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 07:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sG16cqjI7FhoaRWQp7sfIsmBPD55jpILyYPNhzH0HJM=; b=MN4nlRJx08y0T9XGlpFSz5wTEw
	W7nxrFvbLy9noL1mGM3ljR9a3nW5Meoz5xFyePNnLjuJydrvoJpca00W5iAyJ39kXTwEMbLTVCsSe
	DeyJlTSoxe0nY2sIMh4oarotygyJSGc4/k5nCUaSUOIuf8HUl/1ipjkNLaNddcl7u7WuVl/rIG+4a
	gqKOMZoEybnXHapU/NZwi30rHj9j5pM9vEYE53MQ1NSvo2bUwwYfCz0l0qK574xUoTHGAQOZz2GO6
	dNdtE/aBdF9sqDwgG2fojWJrWKLbrcQ0WWydp6r01EMy5rJecmSQKN43cVeL4zeHyBDj3RWLm92mB
	JgM8jzVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwdE-0000000AGG0-3YJg;
	Mon, 01 Jun 2026 07:00:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwdB-0000000AGEp-1Wum
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 07:00:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 47A3E42B92;
	Mon,  1 Jun 2026 07:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12161F00893;
	Mon,  1 Jun 2026 07:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780297212;
	bh=sG16cqjI7FhoaRWQp7sfIsmBPD55jpILyYPNhzH0HJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PhLYx2Wu8AgTfIz+jj0OOGnKXyOUYFMO3olfikldAJMNFROAGoFnSULgR+6dK0TU7
	 viL3jQ7WOK2r7TEvDxUsJaz7URycqhGazOzUqppWDH13wwUjO/llcMYRMbXOsRR+mf
	 ZwtYjWfIJWhx4t1ci56omI7yOOP3g39irVqlNA+ZDkrsqdeZQmCnMHVj03vx+eVVBZ
	 lEy/HQoSI2vKDGlObWJaPri3DRUxUTiHZaPykrpML67YpTk7622Dmvloewu9DQIfEI
	 tKqvElZXCO+sU2Xt1dEAGvcoruBnDPNRwhJZR0r2i1t/cUhLtOHLn2pP68JB87oBFs
	 yLl3d/zUPTkCw==
Date: Mon, 1 Jun 2026 10:00:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	David Matlack <dmatlack@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>,
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 0/3] kho: Add support for kunit mocking KHO restore API
Message-ID: <ah0t9Ss_S-5iOM59@kernel.org>
References: <20260521193202.746810-1-skhawaja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521193202.746810-1-skhawaja@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_000013_456061_561AC9F7 
X-CRM114-Status: GOOD (  21.86  )
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

Hi Samiullah,

On Thu, May 21, 2026 at 07:31:59PM +0000, Samiullah Khawaja wrote:
> To write kunit tests for preservation and restoration of liveupdate
> state in various subsystems without triggering the actual kexec, the KHO
> restore API needs to be mocked by the test writer. The mocking is done
> to allow testing of the individual components or functions in isolation.
> 
> The patch series adds the following to support kunit testing when using the KHO
> API:
> 
> - Add static stub hooks to mock the KHO restore API so the restore path
>   can be tested without triggering kexec.
> - Add helper function that can be used by the test writer to check if
>   memory is preserved in KHO tree.
> 
> Finally, it adds a KUnit test for the KHO API that verifies the allocation of
> preserved memory, and the preservation/restoration of pages and folios.

I looked at the tests for preservation and apparently they don't add
coverage beyond the existing KHO selftest. How hard and/or intrusive would
be adding tests for example for error paths?

Do you have an example of a kunit test for another subsystem that would
benefit from mocking of KHO APIs?
 
> KHO Kunit test run:
> 
>  KTAP version 1
>  1..1
>      KTAP version 1
>      # Subtest: kho_test
>      # module: kexec_handover_test
>      1..3
>      ok 1 kho_test_alloc_preserve
>      ok 2 kho_test_preserve_pages
>      ok 3 kho_test_preserve_folio
>  # kho_test: pass:3 fail:0 skip:0 total:3
>  # Totals: pass:3 fail:0 skip:0 total:3
>  ok 1 kho_test
> 
> v2:
>  - Move kunit header includes above linux header includes.
>  - Use the __kho_preserve_pages_order() to get the order of preserved
>    pages instead of open order calculation math.
> 
> Samiullah Khawaja (3):
>   kho: Add kunit static stubs
>   kho: Add helper function to check if pages are preserved
>   kho: Add kunit test to verify preserve/restore pages and folio
> 
>  include/linux/kexec_handover.h          |   5 +
>  kernel/liveupdate/Kconfig               |  10 ++
>  kernel/liveupdate/Makefile              |   1 +
>  kernel/liveupdate/kexec_handover.c      |  63 +++++++++++-
>  kernel/liveupdate/kexec_handover_test.c | 131 ++++++++++++++++++++++++
>  5 files changed, 209 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/liveupdate/kexec_handover_test.c
> 
> 
> base-commit: ec4084bc445027a52f600e30a976928be1ba1950
> -- 
> 2.54.0.746.g67dd491aae-goog
> 

-- 
Sincerely yours,
Mike.

