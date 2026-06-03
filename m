Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B329ACD6E55
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 06:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=crii+t0f5mzLnKlzu0e4yXBuyqmERcK5UbHB2D3ZF4g=; b=VVakF+rivYppC/gkwwZv4+lCrm
	q8Ica5uq25agElO7NlIApELqawydOddtLg18qNAB8hhv+GrzV613CaNSMkqwtdIAp3IC2WM6RGalu
	W6k20VJauqFh9xFVQK4eCYQvrqaeZexRf7aEAfl4iuA8k+flbLAtht90r30YUPF4rjux5Wxf6ILAi
	YLbZ/Z/b0n9pYki71d4TjCRKucMi2I8XyliSXNYrZavKn+x8wjWbLk+CygcI+yH0U263t25P1Qys4
	dVO2eIo5gxJWQ1nKeDcdudmqpFY8u27eek0F0a96mRKDfXgXyTptszVg70INFlkcxiEo/YD1k0FuJ
	8888jmsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUfQ6-0000000EPRG-15oQ;
	Wed, 03 Jun 2026 06:49:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUfQ4-0000000EPQm-2Wdi
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 06:49:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 63BAC41B66;
	Wed,  3 Jun 2026 06:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CC71F00893;
	Wed,  3 Jun 2026 06:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780469379;
	bh=crii+t0f5mzLnKlzu0e4yXBuyqmERcK5UbHB2D3ZF4g=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=N6Nv8rIKWJBny+CHLiEfswo8B9CE6GjbB4f082oZIvjQ8x4U2vZ6xI4MHdiYNadWW
	 aRJI/wiJ0z7XfcH80+ROET0WcWq8NGYl4RDxly+Pb1XHHCQiqM5qEaHxFfuRQYnfqV
	 ki/xPPZvgT5zld1kiNumyNIi9YhUw3Lg+LEpb1RvGlu3YCPPXEtyVmtd+a/V0TiD3E
	 Jfh0HQAtBZZMBw6fQsXQfV3NbrknaVB7bySHC9TNM6ZlwDHNQetxeSGTD8D45ewtUr
	 vIZaa3Mb1KveYE3YbiZLbvohTU30lsNDXy2+sBISlTbxMq6UogIcfLWQcCN61tq8HA
	 x2Lfj7vA5Kiog==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 07/13] kho: add support for linked-block
 serialization
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 akpm@linux-foundation.org, linux-mm@kvack.org, skhan@linuxfoundation.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 skhawaja@google.com, graf@amazon.com
In-Reply-To: <20260603032905.344462-8-pasha.tatashin@soleen.com>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
 <20260603032905.344462-8-pasha.tatashin@soleen.com>
Date: Wed, 03 Jun 2026 09:49:31 +0300
Message-Id: <178046937151.468621.13398573538792303093.b4-review@b4>
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_234940_669238_DE14A57C 
X-CRM114-Status: GOOD (  19.88  )
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

On Wed, 03 Jun 2026 03:28:58 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
> new file mode 100644
> index 000000000000..8641c20b379b
> --- /dev/null
> +++ b/include/linux/kho/abi/block.h
> @@ -0,0 +1,56 @@
> [ ... skip 25 lines ... ]
> +#define _LINUX_KHO_ABI_BLOCK_H
> +
> +#include <asm/page.h>
> +#include <linux/types.h>
> +
> +#define KHO_BLOCK_ABI_COMPATIBLE	"kho-block-v1"

It's never used by block set and after looking at the following patches I
found that it's appended to LUO compatible string.

While this works for LUO, I think it should be kho_block_set_restore()
responsibility to verify the compatibility.

>
> diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
> new file mode 100644
> index 000000000000..4f147c308e6b
> --- /dev/null
> +++ b/kernel/liveupdate/kho_block.c
> @@ -0,0 +1,411 @@
> [ ... skip 121 lines ... ]
> +/**
> + * kho_block_set_grow - Expand the block set to accommodate the target count.
> + * @bs:    The block set.
> + * @count: The target number of valid entries to accommodate.
> + *
> + * Acts as a runtime notifier when new resources (such as files or sessions)

Not sure I understand what "runtime notifier" means in this context.

> [ ... skip 11 lines ... ]
> +
> +	while (count > bs->nblocks * bs->count_per_block) {
> +		int err = kho_block_set_grow_one(bs);
> +
> +		if (err)
> +			return err;

This leaks memory if more than one block is added.

> [ ... skip 31 lines ... ]
> + * unregistered, allowing the block set to release and unallocate redundant
> + * preserved memory blocks. Checks if the last block in the set can be removed
> + * because the remaining entry count is fully accommodated by the preceding blocks.
> + *
> + * Note: It is the caller's responsibility to ensure that entries are removed
> + * in LIFO (last-in, first-out) order (the reverse order of their insertion).

I think "in LIFO order" is sufficient :)

> [ ... skip 173 lines ... ]
> +		it->i = 0;
> +	}
> +
> +	entry = kho_block_entry(it, it->i++);
> +	it->block->ser->count = it->i;
> +	return entry;

This looks way better than the previous version :)
Thanks!

-- 
Sincerely yours,
Mike.


