Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0E5E6F093
	for <kexec@archiver.kernel.org>; Tue, 23 Dec 2025 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SCw2xOoCGMv9XI4vkf/eEiR8q/3R3I2p+RcR2Oh0c+M=; b=x6Up5D4nglPI3aSkNwZsqE9cfb
	LR8LeXY0toscBPwq/9z15LKYTBXRBS8mF0WQwrkL4QuCUmNpAcmGh61WUoOOfk/vKBdrjJu4ahvJ8
	qTEeKwU/YDroDVeG2fAJ4th8a0O/lswHU2v6vrytIgVdnGvX+W9+4fM+M4dNtlHba9K4Blihnl7L7
	BxtvweUk78KVac7pVqDNPP0WelWPPpMWczK5Swq7wCf4OlwUr42CIFpO1p3FnPk5V3p2W58klCq8i
	EPHy0+ptA2X9BIv3VJfKV3fMdJez/8ukCc/LVznFkMdCozNNp8RwaAfnlxxp6q7vWtUU1/DpYhvrf
	Jm9atBVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY36l-0000000FaNY-1CIc;
	Tue, 23 Dec 2025 14:11:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY36i-0000000FaN6-2owk
	for kexec@lists.infradead.org;
	Tue, 23 Dec 2025 14:11:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1BA1542DB2;
	Tue, 23 Dec 2025 14:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA65C113D0;
	Tue, 23 Dec 2025 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766499084;
	bh=dZ53vjUX1HpldK0KbUzIHXXkt9MCtOBq99PLYBLG+Vo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ud+384l+yB+aELzmFdX7l8ibIN7y+5+njLdeHK50/JSiAcJyiiGlkjjdtAKjHeBD4
	 hoQuD1jM3uSCM4t9yQgEceDsegFq6IHknfeOcqrWnRbDrmwKbx/RA2TtkB+W9AIaWW
	 voxc3Piq7yG30t/8HGvKwdBisNooq4awkV/1xR9nwZDAn86BqbV+te3BncQtbUoll3
	 MjnbP3UmazmSq+nS4COmTb0OMtg5b2lQ0qM6+wFgaUOohKM9E/7DLArNeo0fBID4QC
	 GXqFpHbnzeiMJN9E79HfRc+ILd9QLcZVOFEqn6kc68RQBGIYIJXCqWSpdHOreAc7RR
	 jNwu3Li3A/NVA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  rppt@kernel.org,  graf@amazon.com,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  pratyush@kernel.org,
  ricardo.neri-calderon@linux.intel.com
Subject: Re: [PATCH v4] kho: validate preserved memory map during population
In-Reply-To: <20251223140140.2090337-1-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Tue, 23 Dec 2025 09:01:40 -0500")
References: <20251223140140.2090337-1-pasha.tatashin@soleen.com>
Date: Tue, 23 Dec 2025 15:11:18 +0100
Message-ID: <86y0mtb855.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_061124_735791_731C2CDC 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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

On Tue, Dec 23 2025, Pasha Tatashin wrote:

> If the previous kernel enabled KHO but did not call kho_finalize()
> (e.g., CONFIG_LIVEUPDATE=n or userspace skipped the finalization step),
> the 'preserved-memory-map' property in the FDT remains empty/zero.
>
> Previously, kho_populate() would succeed regardless of the memory map's
> state, reserving the incoming scratch regions in memblock. However,
> kho_memory_init() would later fail to deserialize the empty map. By that
> time, the scratch regions were already registered, leading to partial
> initialization and subsequent list corruption (freeing scratch area
> twice) during kho_init().
>
> Move the validation of the preserved memory map earlier into
> kho_populate(). If the memory map is empty/NULL:
> 1. Abort kho_populate() immediately with -ENOENT.
> 2. Do not register or reserve the incoming scratch memory, allowing the new
>    kernel to reclaim those pages as standard free memory.
> 3. Leave the global 'kho_in' state uninitialized.
>
> Consequently, kho_memory_init() sees no active KHO context
> (kho_in.mem_chunks_phys is 0) and falls back to kho_reserve_scratch(),
> allocating fresh scratch memory as if it were a standard cold boot.
>
> Fixes: de51999e687c ("kho: allow memory preservation state updates after finalization")
> Reported-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Closes: https://lore.kernel.org/all/20251218215613.GA17304@ranerica-svr.sc.intel.com
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

