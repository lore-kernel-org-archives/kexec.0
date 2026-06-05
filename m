Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFDDCD6E6E
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 22:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+dlFga+Oz0ksDU1MPUq6Cr6bGtopVR7dn8Q0PHzd5jE=; b=BkZXTvDOn0+V0t/nnQCDY4/Pyd
	3ef2H9r02Kf3Ki4qTM1ln63h7U5pSITNS09wqsUnaQqlXgz2+K6eOZQDy3ruYv/2VCriOOE8w2HwE
	sNj6ZQlxie80ki9TQ9OxkW23vP842JR5UPbCg+wsrW7LxR4gdvdUdzIynvRpKXoG4waVcoxAyVnIi
	qLH8a43a4cJLKka2myKmSo92qxWnYrDmXRgvYNGvmmmbOS/+h1rATEHZsxbvCsYhNpO2mNUPEiR6A
	YPHJikf0RcEo0N4R0/cgWRJYziverueB2yyJ28ysZpzgzIk2nkvKPQ1UAsENnbdh02hWQBmrmhQdN
	ajpRunQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVcgK-00000001E3N-3BNP;
	Fri, 05 Jun 2026 22:06:24 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVcgI-00000001E32-3YOx
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 22:06:23 +0000
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id B2A7C20B716A; Fri,  5 Jun 2026 15:06:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2A7C20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780697165;
	bh=+dlFga+Oz0ksDU1MPUq6Cr6bGtopVR7dn8Q0PHzd5jE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PLn4vmsu0/on3FCK4E1uJjydGEvJ31dEBCE4GBE1Xe6tfbCFog9VpNfz/Jzxs6X0S
	 IGtxK99fv5m+xh5JDAk9kx6SXi/V/w0BdxeA2K7AKomswNR6c/mQFyhRe5niMkW7NJ
	 gtLcZ+JR1R9RpKTnwafLEM0cI9bYG/82pkb49aaE=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id B07C13070552;
	Fri,  5 Jun 2026 15:06:05 -0700 (PDT)
Date: Fri, 5 Jun 2026 15:06:05 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Pratyush Yadav <pratyush@kernel.org>
cc: Mike Rapoport <rppt@kernel.org>, 
    Pasha Tatashin <pasha.tatashin@soleen.com>, 
    Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
    kexec@lists.infradead.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/18] kho: disallow wide keys in radix tree
In-Reply-To: <20260605183501.3884950-3-pratyush@kernel.org>
Message-ID: <fb7ed559-557-b8c1-1f6-5f879feab0ec@linux.microsoft.com>
References: <20260605183501.3884950-1-pratyush@kernel.org> <20260605183501.3884950-3-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_150622_937216_C8F58709 
X-CRM114-Status: GOOD (  24.39  )
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

On Fri, 5 Jun 2026, Pratyush Yadav wrote:

> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
> The KHO radix tree was designed to track preserved pages. So it does not
> provide the capability to track any 64-bit key. Instead, it limits the
> key width to how much it needs for tracking PFNs and their orders.
> Limiting the width reduces the number of levels in the tree.
>
> KHO is not expected to be the only user of the radix tree. With the API
> generalized to allow other users, now it is possible to add any key to
> the tree.
>
> Check the key width at kho_radix_add_key(), and error out if it exceeds
> what the tree can handle. Do this instead of increasing the tree depth
> since right now there are no users that need to use wider keys, so this
> avoids memory overhead and ABI breakage.
>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
> include/linux/kho/abi/kexec_handover.h |  8 ++++++++
> kernel/liveupdate/kexec_handover.c     | 12 ++++++++++++
> 2 files changed, 20 insertions(+)
>
> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
> index fb2d37417ad9..6dbb98bfb586 100644
> --- a/include/linux/kho/abi/kexec_handover.h
> +++ b/include/linux/kho/abi/kexec_handover.h
> @@ -278,6 +278,14 @@ enum kho_radix_consts {
> 			     KHO_TABLE_SIZE_LOG2) + 1,
> };
>
> +/*
> + * The maximum key width this radix tree can track.
> + *
> + * This value isn't ABI itself, but it is derived from values that are ABI.
> + */
> +#define KHO_RADIX_KEY_WIDTH (((KHO_TREE_MAX_DEPTH - 1) * KHO_TABLE_SIZE_LOG2) + \
> +			     KHO_BITMAP_SIZE_LOG2)

Love the auto-derivation of these values, this totally makes sense. That 
said, my lazy brain complained a bit when I asked it "so how many bits can 
a consumer actually use?". So I wonder:

1) Why is the value not "ABI itself"; it feels like it should as it
    determines client behavior.

2) Would you consider expanding the actual values for the most relevant
    architectures (x86-64 w/ 4kb pages, arm64 w/ 4k/16/64k page-sizes) and
    put it in a block-comment?


> + * NOTE: Currently only keys of width up to %KHO_RADIX_KEY_WIDTH are supported.
> + * This limit only exists because current users of the radix tree don't use more
> + * than that. Changing the maximum width requires changing the tree depth, which
> + * needs bumping the ABI version.

It takes longer to walk the tree. The current implementation is a good 
tradeoff.

Best,
Jork

