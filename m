Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441DD606A32D
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i4ACgcN6;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q80U/Jse
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dPKDQBCBYQNiMfvrFyD8dFjYAwa7Jdg7sOpNKNrqofY=; b=i4ACgcN67LtLe8qi0aFDP8au4L
	k3xwsHkDWuBUfkSnot3tOh/fHz2D3o68L2XRHcETMma2uPOmPOk383jKtE8tWNW25uIj+11Pdy4I5
	CK99byYatuVlqhQUVlFlqZsSBMEQyd3xwroJNRn2tf0DK+ncgFgPxwtG3ENQd7Qa55dLRYUe/QDWp
	+lT6NnKAiM1dlabL+7ijRUfmuuNBqMdWVkFUjPQYTYsd30RWD7iKPuOqv52JhC4IAS2Rp7x/Pp9Et
	ApDYiomdN9KHp3eDBsdOf43mhPyOUsxn5yfB0JaO7nNI4YO67S9QF5x4IdobWNCK5hc52GduhLO9d
	YCVi9dyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOtji-00000008IsE-0CFZ;
	Thu, 05 Nov 2026 09:26:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOtjd-00000008Iqb-2OFy
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 09:26:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 08F41605FF;
	Thu,  5 Nov 2026 09:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A621D1F00919;
	Thu,  5 Nov 2026 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793870776;
	bh=dPKDQBCBYQNiMfvrFyD8dFjYAwa7Jdg7sOpNKNrqofY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q80U/JsetB0EGKNlhWAcY1cZ1tYtokLqJ+h6xwcw+jOr5gyZcw9/4tQvSIhTM/KpN
	 cZJ+dUR7XWwP74J1yWKuFgMMtpArg4ZXiWdUEayzYfx9+TXmQycQcdp4Wr9Fy6dqM/
	 pY9+hmLZbu8HnyPDdkMOYKeOVI6BXNEFxrAoI57F26PUd2vqYsPwYAshjzx+DJtN6B
	 yXX9uurlUAQOJgmMAZJ+G2fzglJR5LzaU1IVo7W7XaA84eAFhJSXvssj5DMShq1KGX
	 AS/AyLlA5yRHvzbHPZdTB6YC6Q97/Igw54dI0RoGTag/do/m1n6nAX/4shIrbluaWj
	 AVVyfXJ+30Wkw==
Date: Thu, 5 Nov 2026 11:26:10 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Pei <cp0613@linux.alibaba.com>,
	George Guo <guodongtai@kylinos.cn>, Kexin Liu <liukexin@kylinos.cn>,
	Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] kho: fix bootmem sizing
Message-ID: <auxLssVxRqlgMFRt@kernel.org>
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
 <20261104-kho-bootmem-sizing-v2-3-b0d1a834780f@kernel.org>
 <179381862329.2089669.11972657670874869389.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179381862329.2089669.11972657670874869389.b4-review@b4>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 01:57:03PM -0500, Pasha Tatashin wrote:
> > -
> > -	return round_up(size, BOOTMEM_ALIGNMENT_BYTES);
> > +	for_each_node_state(nid, N_MEMORY)
> > +		bootmem_size_node[nid] = round_up(bootmem_size_node[nid],
> > +						  BOOTMEM_ALIGNMENT_BYTES);
> 
> Nit, but I prefer to avoid multi-line indented statements without 
> braces. Just put a braces around the above.

Yep, I'll fix it up while applying.
 
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> -- 
> Pasha
> 

-- 
Sincerely yours,
Mike.

