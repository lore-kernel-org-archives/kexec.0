Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405E3CF2590
	for <kexec@archiver.kernel.org>; Wed, 19 Nov 2025 07:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wtaO5Ys1AQZRms0CqHXkRockgCcFIcP4Xe8jI7gJBUM=; b=PtniWcmKxddf9qptTpXON3O0/B
	yNU+tvAU8Su5upZyBkjyl1uGKtWcJeHIoI/QIhboC/r2VN2r2gGRBdTfmlAQcM9x61tuKUokYlUeZ
	XqAidndA3o5EbbsMadW7D3vRS7epO5r/b94RepK3Lk+hPth7YX/GajX0XBG7u7pUjv+Ew3l/aMRkE
	QdpyzIvr9Nzp7tvrpZ4JMQ5ekDjl3kgCRbt5STcf3UUpJpXPbYVubMyim/ynq680q1IszvQULtbKy
	OP/wkLYWGNWZGWz78gZ9bo9hSS/GUqLDZh49aSbIke0KWLl6OZ54snfWSqk8AMaCWNez9+H/hvjwk
	yzZ3VN8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcPF-00000002gRA-0wq0;
	Wed, 19 Nov 2025 07:15:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcPC-00000002gQl-0hCd
	for kexec@lists.infradead.org;
	Wed, 19 Nov 2025 07:15:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0EA8B40448;
	Wed, 19 Nov 2025 07:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EE0C116D0;
	Wed, 19 Nov 2025 07:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763536503;
	bh=85Q1fxYUc90RG8bi1kmn3NZavgBysfdLuTimKjiXkxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhzsuhQdkBNdpM22TohLCYrXugC3eqDOXwXSBlT2Kqn3T0x4zqom5ZBKDLT8BMYcL
	 6YjA/CQWCkydZGaSHPQc/q+Z3Kxfy7J8YOr1WDi2DmKmY81Ci7gFp+Ft8KZecP6JY7
	 eFDAnJU4Oo0EwGBEfylOcOpNeKIF6JFIQ5ncSJO5AeU8FZEM91xrIcFatDtPT3YIRD
	 MIrDg8lEUxqdPGLROzLl62TPJ8iZkgCjN0kYBFCAL9ATf4MN0V0mOtik9ylXL0rtzO
	 GgAHV4jY8JH51UsCRL0d8teCKcEt/nhsXWQFExg19GOxd9eVcQfO2Neu/ZPkJhs/9g
	 8pnwd6obqtSzw==
Date: Wed, 19 Nov 2025 09:14:56 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add test_kho to KHO's entry
Message-ID: <aR1ucHaX8z9qV_oi@kernel.org>
References: <20251118182416.70660-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118182416.70660-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_231506_226201_98EB3A54 
X-CRM114-Status: GOOD (  15.71  )
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

On Tue, Nov 18, 2025 at 07:24:15PM +0100, Pratyush Yadav wrote:
> Commit b753522bed0b7 ("kho: add test for kexec handover") introduced the
> KHO test but missed adding it to KHO's MAINTAINERS entry. Add it so the
> KHO maintainers can get patches for its test.
> 
> Cc: stable@vger.kernel.org
> Fixes: b753522bed0b7 ("kho: add test for kexec handover")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 05e336174ede5..b0873f8ebcda6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13799,6 +13799,7 @@ F:	Documentation/admin-guide/mm/kho.rst
>  F:	Documentation/core-api/kho/*
>  F:	include/linux/kexec_handover.h
>  F:	kernel/liveupdate/kexec_handover*
> +F:	lib/test_kho.c
>  F:	tools/testing/selftests/kho/
>  
>  KEYS-ENCRYPTED
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

