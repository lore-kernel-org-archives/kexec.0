Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B2EC7114A
	for <kexec@archiver.kernel.org>; Fri, 13 Jun 2025 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LVWLApUmyiy+LEgrenHhTmW11dCxTVqVcCTPoZUN4wE=; b=mRK+RzJ9xpQTG27pWqnxU9KJXg
	EQ4Ner1P5bso/z888lVo75Dnl0E6C5dujigIQZVEQzlktmzVqfmIJlygoZN/q09Y0SlZkfOtbdcx7
	aLDaJjtcAKd/O0gSrmI0X+ycTaDUFvll7MKTB/Qls++6tB4OGH4sGA6r/w6DBnHOSkOXcLO6lyWLl
	/rM0Ypp2OkElwaP338DV0UHjtvd+rZ37e9ybOybL1b8BtttTvszTVCzXTZESXgx9+1d+C5TNvGdG1
	eE4gP2Fdp4T0rLBFjCFMwHUHEoFgLEqKhRLwTrEQ5iA2xYbcbWz//7E4pcpkPHhbiqzNGKj6S6lWz
	FKQSfIfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ8xy-0000000HGxd-2hJL;
	Fri, 13 Jun 2025 18:17:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ6rF-0000000Gzbf-1qed
	for kexec@bombadil.infradead.org;
	Fri, 13 Jun 2025 16:02:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LVWLApUmyiy+LEgrenHhTmW11dCxTVqVcCTPoZUN4wE=; b=QIYbXkwEAlvY35Ype8PgTHCn2I
	PIMGJs8hZQuaf7SXBBjGAwSID97uI07F5lY0C9aFjiuSywUpj8hXjEqXX/OCT99PXJn41kN1zXkwc
	rFp49lCCqjFNidzEuj9X25X4cPqVxhD66Ig5vgeYsdvZTvOco03T8Le1xH+mzQo++VjKY6uRaSBWz
	nPxNCSWjpO+qN45uEdwSC9tOYpuTgxH5ijYRGGcOTEcBZVI0u3eT339WqWCYwMymCpS+D+xRwt0xS
	lEMhqrikwG9e6idooaaueGcrVauHMN36NkKAJXLvABv5khss0Bwf0m8xJ4+imechjRAQwW4i4oqsx
	x5AWHVAw==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ6rD-000000032Kz-21jB
	for kexec@lists.infradead.org;
	Fri, 13 Jun 2025 16:02:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AA21543650;
	Fri, 13 Jun 2025 16:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632DAC4CEF3;
	Fri, 13 Jun 2025 16:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749830533;
	bh=jPCR+LaBbmEVU4VOICWsIxHc0vZRsHldHenJthMW508=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnZZPTDdkoWT2wctmLLuh3mC8dVrKFZ2Z8qXDRG51qvd7juxbjBkGtoL1a1JQJ+cv
	 nlKRQVKXOpnZlz7pso+b3fsbiknZvc6fVpcXleAIX3QarFksaH3wioVPWjCVVHcQk4
	 W6mq8YjUKBzcPeea9S1P0myPE0cb6LAfqnxJfF0vD+cs9UHF4y8cYzGY8trztQns8E
	 OlrK0NAWP8ws1v0brH+qGLsMpQFJQdBg/XBRQr5+BAltVlutwsjreiNsnOvh4pUAEa
	 mk4Cop8gxdLouJcF9YyVRkS/f+N5lRWW1nLBlfDV0QJz6cU8Pa8Lwc40a2FGhf0MYj
	 dr6Y0K/l/a0Nw==
Date: Fri, 13 Jun 2025 19:02:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Pratyush Yadav <ptyadav@amazon.de>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: add linux-mm@ list to Kexec Handover
Message-ID: <aExLfnFrpgoJBjTA@kernel.org>
References: <20250613131917.4488-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613131917.4488-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_170219_741281_26A862FE 
X-CRM114-Status: GOOD (  14.60  )
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

On Fri, Jun 13, 2025 at 03:19:14PM +0200, Pratyush Yadav wrote:
> From: Pratyush Yadav <ptyadav@amazon.de>
> 
> Along with kexec, KHO also has parts dealing with memory management,
> like page/folio initialization, memblock, and preserving/unpreserving
> memory for next kernel. Copy linux-mm@ to KHO patches so the right set
> of eyes can look at changes to those parts.
> 
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 99fbde0077927..7a0bc21d906bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13346,6 +13346,7 @@ M:	Alexander Graf <graf@amazon.com>
>  M:	Mike Rapoport <rppt@kernel.org>
>  M:	Changyuan Lyu <changyuanl@google.com>
>  L:	kexec@lists.infradead.org
> +L:	linux-mm@kvack.org
>  S:	Maintained
>  F:	Documentation/admin-guide/mm/kho.rst
>  F:	Documentation/core-api/kho/*
> -- 
> 2.47.1
> 

-- 
Sincerely yours,
Mike.

