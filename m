Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A159CCFA05
	for <kexec@archiver.kernel.org>; Fri,  7 Nov 2025 10:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KuxhyfXWEEy9fDnOrA01HxHWTqNiuqIz80pv0iDUPpM=; b=RrHXV39PE0s6GWqVqz2zF6p7rT
	DNqxqTo8jTZsvqjhko6mrSs1z/7Tw8yxqHf6UE/cfcmmCCVzAN9bw6TacCsezZTIB8l5ArvBoOcX1
	RouaF3GRKIVVAXWQ/sQ65CD/AzXrpEzRMiAEdFLAkanIbNsXdClP4oc4zDN2niTKGDxWXnXssP6z2
	QQisgwTdc8wyB7BNt5/uu5YV35pmdxdznrc/Hz1HS1rqCTgkkTcw+9R5QdGEddzl9ijsksZLLHqji
	T70ij9UfzkCjYIA95tJ52gjzKt6RNq8okSkX3QoJbh42anIDX7LKg/fUjvzE5Cbe8lXmY05uCOepN
	m43wST6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHJeO-0000000H4QO-3MVe;
	Fri, 07 Nov 2025 10:25:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHJeN-0000000H4QC-1fq5
	for kexec@lists.infradead.org;
	Fri, 07 Nov 2025 10:24:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8C0AB601BD;
	Fri,  7 Nov 2025 10:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C1FC4CEF8;
	Fri,  7 Nov 2025 10:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762511098;
	bh=N/bCvCGjWmD/PbOgspBiiy0+tZE0wHLdpwBlXhL6rTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IHKAUit76/jqpfWIZXIuB2XUYGmzC5SCrm9uOv0Qw6KGUeJprlHvRSbAOmOuVeWUv
	 aI/BynQlBvBYWaxjnW5HY91zQ+FTYeMV3sFGnX5E/cn/1OI5xzKsnD87qEBWLzOurS
	 iiCQtJbFeEP1oS5yL4oq+LCgMxyzbc3FE2n/e6YXfFnE9UqVoF+HWQKtDHWDSFI1dt
	 tcHiAT3JjYGnh3VA3X84DE055IT7DvftFcyiif6y0GOLembjnxT+/YsHcjOf/raSSp
	 EaVasd/ZmAbYr+CudIZJA9b0w8SWrNDQaHTeJCzM1+Nio1ZVKQOKc8lgsZE4ccGjKy
	 4wuPpf/VsGELA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  rppt@kernel.org,  graf@amazon.com,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  pratyush@kernel.org
Subject: Re: [PATCH] lib/test_kho: Check if KHO is enabled
In-Reply-To: <20251106220635.2608494-1-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Thu, 6 Nov 2025 17:06:35 -0500")
References: <20251106220635.2608494-1-pasha.tatashin@soleen.com>
Date: Fri, 07 Nov 2025 11:24:55 +0100
Message-ID: <mafs0cy5ub0nc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, Nov 06 2025, Pasha Tatashin wrote:

> We must check whether KHO is enabled prior to issuing KHO commands,
> otherwise KHO internal data structures are not initialized.

Should we have this check in the KHO APIs instead? This check is easy
enough to miss.

>
> Fixes: b753522bed0b ("kho: add test for kexec handover")
>

Nit: these blank lines would probably mess up trailer parsing for
tooling.

> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202511061629.e242724-lkp@intel.com
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
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

-- 
Regards,
Pratyush Yadav

