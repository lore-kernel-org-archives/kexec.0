Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF32CF2567
	for <kexec@archiver.kernel.org>; Wed, 19 Nov 2025 07:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/HwSoJupxiBjdrEJ3BFAF9vO8gdttxSiMNIuAwnCgjg=; b=gsxIkT9Ijk3YsD7rKHbRQau8Ph
	4qWrtFAGyosk+sP7KSyfsEA7o2kQSnM3NwsLD4yTUGNFVq2sg/fuzvO/s/mHz3TLhyjmgS8ommyoi
	PJ+tu1+oNXGGnGlP2aZ0v+Lp/VpHFB5G++40XDfXRu9eO56cqwBYlyswXnReVsovcGUmvmL2bmWt+
	Qrk5P0bY6c+oNjkztFL775N8FOaj66+4255gzLzUhBs1RjmiAl63HSvLGAlgsXObyaerZnZ5QPMn4
	IbHXpRqFNenNaRIi84hN1ERbm9QMwOMa2++Ql+Kz9DQzrpWMfjofMFoZRbrHohyVXhTxbm+aWCDaK
	J5xf/WJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcNQ-00000002gC9-0dOY;
	Wed, 19 Nov 2025 07:13:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcNO-00000002gC0-3JeW
	for kexec@lists.infradead.org;
	Wed, 19 Nov 2025 07:13:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A500C601F1;
	Wed, 19 Nov 2025 07:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A60C19422;
	Wed, 19 Nov 2025 07:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763536393;
	bh=1k3b91TeAw0rzeU6aDRybMO0nK66XkCSomfBz/2p4/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPA2nBzs0EQuHRPga+czJDN2TOO9kpazfniyGqFJxmNxnxfJwR5SurOBwHdtQQ2FK
	 3Tks6jG1OTjIr6lfWvlEuLWHouOCFg9iNUHUZa/MtonM+vzFTQHXZNoIBByrExM78l
	 c7SEeT7cR1y7KWxPyUkTtFDvVvidoqnV1msIC00pABA2sFbXyWXafa4UJtSsf/HETL
	 /jOhHTqJwYRyjeCHILkKsFf0gdocpw+Yk8EVZVYU8Jd0AkAZ2vse757aGXnjmVnl+I
	 pG3ErNtARklGA27Ecgy9jNDA804XkfgHGjKSZabTXxlGN+mapPEeMIC7bEkv8KOk7D
	 8NjBVLxskNdMg==
Date: Wed, 19 Nov 2025 09:13:05 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] test_kho: always print restore status
Message-ID: <aR1uASSp6VWY72kN@kernel.org>
References: <20251118181046.23321-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118181046.23321-1-pratyush@kernel.org>
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

On Tue, Nov 18, 2025 at 07:10:45PM +0100, Pratyush Yadav wrote:
> Currently the KHO test only prints a message on success, and remains
> silent on failure. This makes it difficult to notice a failing test. A
> failing test is usually more interesting than a successful one.
> 
> Always print the test status after attempting restore.
> 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  lib/test_kho.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/test_kho.c b/lib/test_kho.c
> index 85b60d87a50ad..47de562807955 100644
> --- a/lib/test_kho.c
> +++ b/lib/test_kho.c
> @@ -306,7 +306,6 @@ static int kho_test_restore(phys_addr_t fdt_phys)
>  	if (err)
>  		return err;
>  
> -	pr_info("KHO restore succeeded\n");
>  	return 0;
>  }
>  
> @@ -319,8 +318,15 @@ static int __init kho_test_init(void)
>  		return 0;
>  
>  	err = kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys);
> -	if (!err)
> -		return kho_test_restore(fdt_phys);
> +	if (!err) {
> +		err = kho_test_restore(fdt_phys);
> +		if (err)
> +			pr_err("KHO restore failed\n");
> +		else
> +			pr_info("KHO restore succeeded\n");
> +
> +		return err;
> +	}
>  
>  	if (err != -ENOENT) {
>  		pr_warn("failed to retrieve %s FDT: %d\n", KHO_TEST_FDT, err);
> 
> base-commit: f0bfdc2b69f5c600b88ee484c01b213712c63d94
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

