Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592D606A32E
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NA8Z8xGL;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQ1mHGE8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RwKYe1FZ8TSRCRSLvx8CKLmwrOieUAZJ4xTeOLFE+8c=; b=NA8Z8xGLC9aCcDPlP/hBmud38M
	WeyDoDy/JEaypOd5Smu0TxyZnmGk5PriS7MGdgyFs9flDWexNF5l6eJKCBrR49OemAWB57uZXvy9W
	FOuD01w4FZmp+fO1kvNSyfbyVMkx9dLb8Bx3gf8Q3YO+DCvy9SmIssqVM6Q+qQDtUrL2EEOofxlmh
	toM5fcmSxeRcNhlbSLdTMSPPdg57DfHikGQueVbhRYL9gZZzbUlonG20V57/7fK4un7Gdw7zoxgjZ
	T7Oc67XnAuwPQZwuhCc2AZ3JWGglBKVQXMmDpdsMzjMckvGyjdccIE1EY8Heg9PR1TF3Vk7KAqeuf
	JN6JJCxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQp54-00000004bTL-09sQ;
	Tue, 10 Nov 2026 16:52:22 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQp50-00000004bTE-3e0a
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 16:52:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 536AA408D4;
	Tue, 10 Nov 2026 16:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168DC1F008A1;
	Tue, 10 Nov 2026 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329538;
	bh=RwKYe1FZ8TSRCRSLvx8CKLmwrOieUAZJ4xTeOLFE+8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=KQ1mHGE8yDsko9wqUMNuJqUyMQU4njRf7yvHVhukpRSCc6PfyquBs5m7hxr5sSArv
	 Tz8v81Y+mNybeIkmWrNBMgDD9oQ10c/9DglWEo/UyBsKq6CBzKGGuoTcSIsqaaE3QR
	 gVzEFTQlk6hiVis6FVdj/oDJDlYfn5eWHLkvd8qT1JfzgN47Pw+nI4hgwwz12QLrhx
	 qS9fzK0IwYyzeuJLa1vs0fum+PP8qXejEMm2XhWTfYuirC0gKU49ervzU1QbDPfflC
	 3b+22qhaH+s1qqA4SNiPRV9k0uOtKXH2ZOvAWqhCJ5Ddns6r6RDq7kEEJwT7QHNe6o
	 Wo8L2+30e0TbQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chen Pei <cp0613@linux.alibaba.com>,  George
 Guo <guodongtai@kylinos.cn>,  Kexin Liu <liukexin@kylinos.cn>,  Sourabh
 Jain <sourabhjain@linux.ibm.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] kho: walk bootmem areas in address order
In-Reply-To: <20261104-kho-bootmem-sizing-v2-1-b0d1a834780f@kernel.org> (Mike
	Rapoport's message of "Wed, 04 Nov 2026 18:50:09 +0200")
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
	<20261104-kho-bootmem-sizing-v2-1-b0d1a834780f@kernel.org>
Date: Tue, 10 Nov 2026 17:52:14 +0100
Message-ID: <2vxz7bikiq81.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04 2026, Mike Rapoport (Microsoft) wrote:

> kexec_add_buffer() users may depend on the order in which memory holes are
> searched. For instance, arm64 places the kernel bottom-up and then
> requires the DTB to be above the kernel.
>
> kho_walk_bootmem() walks the bootmem areas in the order they were
> reserved, so if the kernel lands in a small area at the top of the memory
> there is no room left for the DTB and kexec fails. For example, on an
> arm64 VM with 2G of RAM and kho_bootmem=8M,64M,64M, the lowmem area is
> reserved first at the top of the memory, the kernel image takes most of
> it and kexec fails with
>
>   kexec_file(Image): Could not find any suitable kernel location!
>
> Sort the bootmem areas by address and walk them in ascending order, or in
> descending order for top-down searches, like kexec_walk_resources() does.
>
> Fixes: 3bdecc3c93f9 ("kexec: add KHO support to kexec file loads")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

