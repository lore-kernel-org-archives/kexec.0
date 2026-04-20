Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6A3F36C31
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 07:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/OOkxXT314zgkCbMJVgR33WQVdo5yDJLfeSxoAafAnE=; b=OlvJUne8+ubIHs5u+0Tfz0k244
	AWwFDyVmnLvtJ5eOM0NpktLOZ71zuxlP0K8LNMjsajjPEgFh4Vgdm8uf9R82leb4rhobnnk4i+Mlf
	S5GMy+lSfAI1dIqnuUGWCWyq+m3HlbXXGvyT/kMFBZ0xnnhZMvT8j6ap4Qn/oYEAov2AzDXaot9zK
	L0wTdKa9SMW6CdLF2jlFWZoTx8J3uMEbEODCjyHpETiAWt2Rk6kG5Ji2UlAjFr9wfnHUbf3+GBh0l
	uEGcgpcnbiJnumAPABmU5bxHSQkSY27wBrtx9UT+/4dOCczuWTBLQiMcy2GHBSXUfki/E4j+igU7v
	IH4c1MIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEip4-00000006XJg-0OEv;
	Mon, 20 Apr 2026 07:13:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEip0-00000006XJ4-0rw2
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 07:13:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id F020641A25;
	Mon, 20 Apr 2026 07:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC7FC19425;
	Mon, 20 Apr 2026 07:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776669208;
	bh=9eukM2C8gRicLu7CaCXCE0c9KR81w7+tGO0F3PmCFCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5Km2TZeIdwP4xKxqDr3zA22JtgWHKuj5SC7f1P8o2qQ/+RpiiJTKY0wBk/oVmbdS
	 UV89bWG569ImZtIfED9Lyi/NcDP1Zd9YBc98hc/TOpngY6F2VbOReUTjjQ7xyCbi1H
	 Wc6s9x+1rpVRUVPfyG4cSZWb6f/RQQ2gFQn37ORUDhj55ckIP0lhN7y5LFL0z/gVOy
	 /QVCpveNacFpeWvBaOy/lIVtv7HOMm7WDd2+yESQAOHw+xPoIJGKbJmTRAVDozLFQj
	 wXBtjEQOT5LuqxXG3IYtez2S/K3Xd6wVpmEP7uuBL3e3c9RsiSCnISfaMu95brIyB/
	 xwusZV7SuUMZQ==
Date: Mon, 20 Apr 2026 10:13:21 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, dmatlack@google.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com
Subject: Re: [PATCH 1/5] liveupdate: Remove limit on the number of sessions
Message-ID: <aeXSEe9Bo-vsSkMH@kernel.org>
References: <20260414200237.444170-1-pasha.tatashin@soleen.com>
 <20260414200237.444170-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414200237.444170-2-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_001330_625296_8166C710 
X-CRM114-Status: GOOD (  25.44  )
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

On Tue, Apr 14, 2026 at 08:02:33PM +0000, Pasha Tatashin wrote:
> Currently, the number of LUO sessions is limited by a fixed number of
> pre-allocated pages for serialization (16 pages, allowing for ~819
> sessions).
> 
> This limitation is problematic if LUO is used to support things such as
> systemd file descriptor store, and would be used not just as VM memory
> but to save other states on the machine.
> 
> Remove this limit by transitioning to a linked-block approach for
> session metadata serialization. Instead of a single contiguous block,
> session metadata is now stored in a chain of 16-page blocks. Each block
> starts with a header containing the physical address of the next block
> and the number of session entries in the current block.
> 
> - Bump session ABI version to v3.
> - Update struct luo_session_header_ser to include a 'next' pointer.
> - Implement dynamic block allocation in luo_session_insert().
> - Update setup, serialization, and deserialization logic to traverse
>   the block chain.
> - Remove LUO_SESSION_MAX limit.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/kho/abi/luo.h      |  19 +--
>  kernel/liveupdate/luo_internal.h |  12 +-
>  kernel/liveupdate/luo_session.c  | 237 +++++++++++++++++++++++--------
>  3 files changed, 197 insertions(+), 71 deletions(-)

...

> +/**
> + * struct luo_session_block - Internal representation of a session serialization block.
> + * @list: List head for linking blocks in memory.
> + * @ser:  Pointer to the serialized header in preserved memory.
> + */
> +struct luo_session_block {
> +	struct list_head list;
> +	struct luo_session_header_ser *ser;
> +};
> +
>  /**
>   * struct luo_session_header - Header struct for managing LUO sessions.
>   * @count:      The number of sessions currently tracked in the @list.
> + * @nblocks:    The number of allocated serialization blocks.
>   * @list:       The head of the linked list of `struct luo_session` instances.
>   * @rwsem:      A read-write semaphore providing synchronized access to the
>   *              session list and other fields in this structure.
> - * @header_ser: The header data of serialization array.
> - * @ser:        The serialized session data (an array of
> - *              `struct luo_session_ser`).
> + * @blocks:     The list of serialization blocks (struct luo_session_block).
>   * @active:     Set to true when first initialized. If previous kernel did not
>   *              send session data, active stays false for incoming.
>   */
>  struct luo_session_header {
>  	long count;
> +	long nblocks;
>  	struct list_head list;
>  	struct rw_semaphore rwsem;
> -	struct luo_session_header_ser *header_ser;
> -	struct luo_session_ser *ser;
> +	struct list_head blocks;

Don't we need some sort of locking for blocks?

>  	bool active;
>  };
  
> @@ -147,15 +222,6 @@ static int luo_session_insert(struct luo_session_header *sh,
>  
>  	guard(rwsem_write)(&sh->rwsem);
>  
> -	/*
> -	 * For outgoing we should make sure there is room in serialization array
> -	 * for new session.
> -	 */
> -	if (sh == &luo_session_global.outgoing) {
> -		if (sh->count == LUO_SESSION_MAX)
> -			return -ENOMEM;
> -	}
> -
>  	/*
>  	 * For small number of sessions this loop won't hurt performance
>  	 * but if we ever start using a lot of sessions, this might

For ~8.1 million sessions this comment does not seem valid anymore ;-)

-- 
Sincerely yours,
Mike.

