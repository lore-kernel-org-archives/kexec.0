Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5024CCCFA13
	for <kexec@archiver.kernel.org>; Sun,  9 Nov 2025 07:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NZHZFA3ZUXg5pX0IdCS+JtthjhsvRZNVO/U2SsvdjJg=; b=g1FZn2HNWVFZvlQLpH4AcXJuEj
	l2Bqz4nd2Rvoa/vgywNvedCvhT4sIJ5m4isRjldBZcygqdgSPaEdD/GzC11uvKmfegqoETmMY35k4
	pOPnfEZZDEzsxi3XqgalqPVq+tqVoovNKK1szee+haYwDe6u3r85t4iVDjQYjdD+6ehdvL2ZlC+Dr
	jAcdBz7QjlW7xNv++Y+ioOYSrZs6o9eBd6Wao1eX+R1hEzHW0lyLymBx76e6V8Pj3SGqyaCjq76m7
	ILdhXOY2FcgV2H/skKzZYO2nbc0tNn6wGjdKGwM4zYNWC/dItRp1pad76uztWSMsAIQglRGYWpuNP
	QgyTqJOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHztr-00000003qWa-35kc;
	Sun, 09 Nov 2025 07:31:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHztp-00000003qVp-0rGt
	for kexec@lists.infradead.org;
	Sun, 09 Nov 2025 07:31:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CFA3140805;
	Sun,  9 Nov 2025 07:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EEAC4CEF7;
	Sun,  9 Nov 2025 07:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762673500;
	bh=7DqEHCeqS1xGa8GegeWUZP4LFVgKnIB0Dv0EsIJO1Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZontPJPkPYCIdi+5VQmQhqNqY1ysdg3DrEwbQZUca9ddTzNzaHPKEibsgVNYWgEC
	 4jeHIEeHWqS/GCn/FweRN1R5+rvD7uiD29Vk0HT3oOzLaUNOR2bsAOgoLzHJow78Zo
	 LtSHj3lqLqfL0q9sr9dffxv+BCHr1XcK4xBeKUnIzoSwlIBdc1eF/7xJzbSP4GQ7KU
	 MYLEzCi6PioXg5D8uDGBLLdWVow2lZJJDuDMUlLFMZO51WK/hCS94TpcuctSZQgo6X
	 r+Fa90kkklaBYAkVmH63SE9w3V1O97V8XqjRcGg9Cybzg1RrdHsWfDFOvThpfSKdiS
	 KN1uypl9Xgo0Q==
Date: Sun, 9 Nov 2025 09:31:34 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, graf@amazon.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, pratyush@kernel.org
Subject: Re: [PATCH] lib/test_kho: Check if KHO is enabled
Message-ID: <aRBDVkQbEDR4KILs@kernel.org>
References: <20251106220635.2608494-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106220635.2608494-1-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_233145_289994_830FB68C 
X-CRM114-Status: GOOD (  15.56  )
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

On Thu, Nov 06, 2025 at 05:06:35PM -0500, Pasha Tatashin wrote:
> We must check whether KHO is enabled prior to issuing KHO commands,
> otherwise KHO internal data structures are not initialized.
> 
> Fixes: b753522bed0b ("kho: add test for kexec handover")
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202511061629.e242724-lkp@intel.com
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  lib/test_kho.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/test_kho.c b/lib/test_kho.c
> index 025ea251a186..85b60d87a50a 100644
> --- a/lib/test_kho.c
> +++ b/lib/test_kho.c
> @@ -315,6 +315,9 @@ static int __init kho_test_init(void)
>  	phys_addr_t fdt_phys;
>  	int err;
>  
> +	if (!kho_is_enabled())
> +		return 0;
> +
>  	err = kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys);
>  	if (!err)
>  		return kho_test_restore(fdt_phys);
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 

-- 
Sincerely yours,
Mike.

