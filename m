Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E64CEB2CA
	for <kexec@archiver.kernel.org>; Sat, 15 Nov 2025 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xHB08IvKUjp6VSgzon31v8zdn+VKIBB5Ms0B5usaIp0=; b=F5ROagOl/Rl/gx8Jt2whS5gGY7
	EIShTdl0imHEdrGep5/JKaMyUQ6zVGoFgBMVyupP8rRH7nElQpwXgJBC8jGxq5F//ShdtcL+bp8no
	lbWKvVcqFpPnRBnBtzFrHIWjaGnLhy38aOF9IO0/Z+7BwK0Ns1nhbzGBC+u+bsM69dkLbX89lVKIt
	VNuwi/5VpuuUC6kvPqh+vwV3BFuxmpgN0/MAxvlg2WIH1BFABQrtGFZBOrfoXpqNt8DZ9N/uhecWD
	uqzhW2SWxzITLOn7G58RgYKCYWADBv26m80QxxxJzTUw8F7gVh7LgyrmXKtWKvlTgD62qlxrLwhfI
	0wxm01Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKClX-0000000DesL-1Ng2;
	Sat, 15 Nov 2025 09:40:19 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKClW-0000000DesF-2UaX
	for kexec@lists.infradead.org;
	Sat, 15 Nov 2025 09:40:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0605B60052;
	Sat, 15 Nov 2025 09:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59544C19423;
	Sat, 15 Nov 2025 09:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763199617;
	bh=Ftwq9aXcMX9LHqwm1OwdhNRh26BPiUZtjHSBKYdzc7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnACPYRGa0Ckp5lRrrDfhH+1W1avXDf7QG3tmJb6TLgF0IHMUoQub3f+z+duHfIlw
	 b3gL1NefLvwN1CxaW6GeiptTvPo9pITddyzIcyre1y2CFr4GcAJmOefxYcb/zUT3tg
	 kVQGBlQPZveH0FwA0jWK4VvlubuTgK2pR247Qzd8X8RW0TQLJwWsqFY0G09jrAjqCA
	 xxhfGO91qX5kNCEkcPzb/pZiqnWDaZmCBSktt7qH7Uv67WM4xSL0FUal1b5JBMO98w
	 7S3RIA2pWrvzpC5HIR57S71tJf5pGjYLJ5MbgFnNzdru+jx7kYJxJu+mt8a7TlLnr+
	 3W6qQcwJ5i53w==
Date: Sat, 15 Nov 2025 11:40:09 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, jasonmiu@google.com,
	arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca,
	ebiggers@google.com, graf@amazon.com, kees@kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 10/13] kho: Update FDT dynamically for subtree
 addition/removal
Message-ID: <aRhKeXM5iAswD7oe@kernel.org>
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
 <20251114190002.3311679-11-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114190002.3311679-11-pasha.tatashin@soleen.com>
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

On Fri, Nov 14, 2025 at 01:59:59PM -0500, Pasha Tatashin wrote:
> -	struct kho_sub_fdt *sub_fdt;
> +	phys_addr_t phys = virt_to_phys(fdt);
> +	void *root_fdt = kho_out.fdt;
> +	int err = -ENOMEM;
> +	int off, fdt_err;
>  
> -	sub_fdt = kmalloc(sizeof(*sub_fdt), GFP_KERNEL);
> -	if (!sub_fdt)
> -		return -ENOMEM;
> +	guard(mutex)(&kho_out.lock);
> +
> +	fdt_err = fdt_open_into(root_fdt, root_fdt, PAGE_SIZE);
> +	if (fdt_err < 0)
> +		return err;
>  
> -	INIT_LIST_HEAD(&sub_fdt->l);
> -	sub_fdt->name = name;
> -	sub_fdt->fdt = fdt;
> +	off = fdt_add_subnode(root_fdt, 0, name);

Why not
	fdt_err = fdt_add_subnode()

as I asked in v1 review?

> +	if (off < 0) {
> +		if (off == -FDT_ERR_EXISTS)
> +			err = -EEXIST;
> +		goto out_pack;
> +	}

-- 
Sincerely yours,
Mike.

