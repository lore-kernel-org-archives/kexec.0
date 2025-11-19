Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AECCF2588
	for <kexec@archiver.kernel.org>; Wed, 19 Nov 2025 07:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NQrgpy8JjaEHyZqJA8eDLgJamo/HVbJwYqaGe1sVdzM=; b=g5HUV279BICf89/KwRBHMrHCSr
	7S8wU3tXSpXQFbJzFKuEul72Hj8JDJAQVtwOZcJdAYM0v5uWCA3sup/zZhSbyAeY0Kxm4iIkUyMCG
	p0Nzcw1sqqfsQIscW3l7jD5UvuZJK+yLNZy4WLI5Vv4aORltCrMBv1qSRd/D5lE1ffiLN99OEzbVL
	asp57GutwlmjtBRfTfCGTGgjI00cTaHQZ60VRXxK2RyyCq2p7IP6JrTsQTZcA67HiYaLzo1bl/mDM
	mk2Llh9QF1WSDEeIet4LmiI0UkMZbArXpozw5fNZndzOxa5K+EqHrblAV1TI2nWLluD+AwDn5e+PR
	u+HToKDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcOq-00000002gNL-3lyQ;
	Wed, 19 Nov 2025 07:14:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLcOo-00000002gN7-3ck8
	for kexec@lists.infradead.org;
	Wed, 19 Nov 2025 07:14:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4AD3360123;
	Wed, 19 Nov 2025 07:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE36AC16AAE;
	Wed, 19 Nov 2025 07:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763536481;
	bh=KnK2LwaTVxpBAnGwrP0tBXDqK6jOFJ6w3qTM2i6eO4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYCBeCyDe0Hmh4FfKgfEdzfAO4ZrQf8bQrN0P2JurnGdjoWncjpN00tOiseNAHhyD
	 pr2K27K7CR068BZewS9sL54E9liZKy8YPv0UZDU1S233GRIVK5kmL3wE2xnqvhYFx7
	 qEOnarB+NxZFiQU5OWNtyj8q2WMAr6MTS1UDc3l2JfBFKyn1N8fgnKyFh4WDZBhbEA
	 00KFkpNarLFddOUnoDL4rgiEcaRLIL09Y1Sefcpdrl416oYCEc26BTywiDxOBwFVDP
	 ie684kTjlQMNESnMb239J95/Sj6TLRC3DNn4exOGC4YZ1MhWuqHxh2Dy6kpxiJCjHc
	 xu2xYl817psIg==
Date: Wed, 19 Nov 2025 09:14:34 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: free chunks using free_page() instead of kfree()
Message-ID: <aR1uWvLu5Hlneppp@kernel.org>
References: <20251118182218.63044-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118182218.63044-1-pratyush@kernel.org>
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

On Tue, Nov 18, 2025 at 07:22:16PM +0100, Pratyush Yadav wrote:
> Before commit fa759cd75bce5 ("kho: allocate metadata directly from the
> buddy allocator"), the chunks were allocated from the slab allocator
> using kzalloc(). Those were rightly freed using kfree().
> 
> When the commit switched to using the buddy allocator directly, it
> missed updating kho_mem_ser_free() to use free_page() instead of
> kfree().
> 
> Fixes: fa759cd75bce5 ("kho: allocate metadata directly from the buddy allocator")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Notes:
>     Commit 73976b0f7cefe ("kho: remove abort functionality and support state
>     refresh") made this bug easier to trigger by providing a deterministic
>     method to trigger freeing of the chunks.
> 
>  kernel/liveupdate/kexec_handover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 515339fa526e0..6497fe68c2d24 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -360,7 +360,7 @@ static void kho_mem_ser_free(struct khoser_mem_chunk *first_chunk)
>  		struct khoser_mem_chunk *tmp = chunk;
>  
>  		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
> -		kfree(tmp);
> +		free_page((unsigned long)tmp);
>  	}
>  }
>  
> 
> base-commit: f0bfdc2b69f5c600b88ee484c01b213712c63d94
> prerequisite-patch-id: f54df1de9bdcb4fe396940cdcc578f5adcc9397c
> prerequisite-patch-id: 800ec910c37120fd77aff1fad8ec10daaeaeddb1
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

