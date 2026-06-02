Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F42CD5BD1
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ukUSWAZT5k7G7XbzmUvOStOIMgWiMG+ApVUWmOXYOU=; b=01B1ZBbw2QG4Z6++yTZsIA0lWK
	hdZC4oSTUjiFtKvQHzKs/HGCE+2kFgYHCor4XYcLt6JOdzFa9U9FApNVQl3SRi1/RMU5J7+XUgRp0
	9jBvWzXWVzJhG92DAilGKBDl+zV01gsNLk7kAtSX0Ji0L2ZiK9Fj1ZETeHJjrcwvh2JzTbpow6O2u
	Jftwd6ao8/+LY121A86yJvuG01S3q0T9h5R2FuoKhlmG+hCbpO4ChoX5eT+BFB/qVwU0+PpSt6URF
	HymAxcCFf4s+5Hh7Ab2hV4+fp1yTf4l9JD7rfiBdN3dVukCc7RxM9T7gC3oYVS1IoHtgihyNGpW0D
	YhjBYViw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSZU-0000000DXfF-0DpH;
	Tue, 02 Jun 2026 17:06:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSZS-0000000DXdp-0i80
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 17:06:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DE4A440245;
	Tue,  2 Jun 2026 17:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DDD1F00893;
	Tue,  2 Jun 2026 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780419989;
	bh=0ukUSWAZT5k7G7XbzmUvOStOIMgWiMG+ApVUWmOXYOU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Vgo5MSpd5rLUICJbwSXXMHlNmtOE98kKio8rRf5wUvLCLyHS64u01h5uZF23YS35Y
	 ul23hEGvUhCtar+qiJ8TDD0D/rb//t/aJ5trAIHCY70bhUOKdEuH+hRiD8YDcjiWZT
	 dTHQQnx0Olyuc2ChrMBZn+VGnoUSWkc8GoSr5jw/RXHv8bo1SMy1jEUdLuU52Nibei
	 khBSic3ISmOTQ7SYPfSHyNNnjeHN8cbs3C6YSjFY4eeCU4lWx9JihATLPpPW3ytYgL
	 jAPs1BmEuxsiiYf8dHovSR7nOwG1R7v6QZgPCsEH6zfrWECQAgq5NchWuIbFMdEexY
	 JhISPenXLwOVg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  corbet@lwn.net,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH v5 08/13] liveupdate: defer session block allocation and
 PA setting
In-Reply-To: <20260602031717.197696-9-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Tue, 2 Jun 2026 03:17:12 +0000")
References: <20260602031717.197696-1-pasha.tatashin@soleen.com>
	<20260602031717.197696-9-pasha.tatashin@soleen.com>
Date: Tue, 02 Jun 2026 19:06:25 +0200
Message-ID: <2vxzv7c0dg8e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_100630_237774_1C65060A 
X-CRM114-Status: GOOD (  15.95  )
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

On Tue, Jun 02 2026, Pasha Tatashin wrote:

> Currently, luo_session_setup_outgoing() allocates the session block and
> sets its physical address in the header immediately. With upcoming
> dynamic block-based session management, this makes the first block
> different from the rest. Move the allocation to where it is first needed.
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  include/linux/kho_block.h        | 22 +++++++++++
>  kernel/liveupdate/luo_core.c     |  4 +-
>  kernel/liveupdate/luo_internal.h |  2 +-
>  kernel/liveupdate/luo_session.c  | 68 ++++++++++++++++++++------------
>  4 files changed, 67 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/kho_block.h b/include/linux/kho_block.h
> index 505bf78409f2..0a8cda2cbfb5 100644
> --- a/include/linux/kho_block.h
> +++ b/include/linux/kho_block.h
> @@ -70,6 +70,28 @@ int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa);
>  void kho_block_set_destroy(struct kho_block_set *bs);
>  void kho_block_set_clear(struct kho_block_set *bs);
>  
> +/**
> + * kho_block_set_head_pa - Get the physical address of the first block header.
> + * @bs: The block set.
> + *
> + * Return: The physical address of the first block header, or 0 if empty.
> + */
> +static inline u64 kho_block_set_head_pa(struct kho_block_set *bs)
> +{
> +	return bs->head_pa;
> +}
> +
> +/**
> + * kho_block_set_is_empty - Check if the block set has no allocated blocks.
> + * @bs: The block set.
> + *
> + * Return: True if there are no blocks in the set, false otherwise.
> + */
> +static inline bool kho_block_set_is_empty(struct kho_block_set *bs)
> +{
> +	return list_empty(&bs->blocks);
> +}
> +

Are these intended to be here or should they go in patch 7?

>  void kho_block_it_init(struct kho_block_it *it, struct kho_block_set *bs);
>  void *kho_block_it_reserve_entry(struct kho_block_it *it);
>  void *kho_block_it_read_entry(struct kho_block_it *it);
[...]

-- 
Regards,
Pratyush Yadav

