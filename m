Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A72606F2F9
	for <kexec@archiver.kernel.org>; Sun,  1 Nov 2026 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ht3f0USi;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cL00EPsP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jzfy/KnMU5oTCU0ghJzGH4xThVN6V3NlG6Cfjo/7zcg=; b=Ht3f0USi2u+b9A
	zTx/t8Kwo6+2exEskCcWBT1lCLgYI8MlZMVQiFA2KsyURHN6zcNX6dvttJBI4wW0Nbp1oXx2KVsPw
	tbnaRQaMRM9suP1pyuGc1M9pDJ6fBZbP747EAexqaxFSAqF9UXoCTsGXykX8VeCjnh1H5LA/yTrJX
	/uW7SB4BG3pxgHlbveJ6yRx/JCdSpQQbtwSZSrDEbMYwXVkDGZW5O6W/XsEReJAKlOIg4B/cc7h6p
	rIxF/W+zgFHCoWYpCfUHNA6h0VAYQOFEqQHEEfL3EGL6YB+U5xYsFxWiSQPHNfAdIB/moPzkJx4Pz
	QNAbf2HaG6cVV5MpDhKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNdrn-0000000F3ew-0P6F;
	Sun, 01 Nov 2026 22:17:31 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNdrJ-0000000F1wh-22wU;
	Sun, 01 Nov 2026 22:17:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E598D43BCE;
	Sun,  1 Nov 2026 22:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C481E1F000C1;
	Sun,  1 Nov 2026 22:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571420;
	bh=jzfy/KnMU5oTCU0ghJzGH4xThVN6V3NlG6Cfjo/7zcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cL00EPsPLeRdjz0LaK8ylDMEtIvjhzaleh+eVK9p2LoFB48SNf3bWyOtNpuPL7Xp+
	 iQ8FRynHbDCt7dRIj9ntbJ2MWZXRGPy92K8RA5bq4Ifo8iWZN9/R/eU0xVHVm+ThTh
	 vqVrjMZTqZKwtlUQOt7Y44XayBTarPJ9db+S+UgJzxIMMpb96lGyL/F1/sX3REPElB
	 mQ401ESlhtJ5By24BWWO5iHvbckmoAjyDvIewmVcYYEwsFFzkn2TwMyRJ8j7snmUlx
	 4xhq9r6s/mwIVIqVTJWtdSQMEes3gxh7FUKQKvB1E9wNXb/MC6dtyf7RsDYnGsqwVQ
	 riUzUbHX7vr/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA40938003B8;
	Sun,  1 Nov 2026 22:17:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] kexec_file: remove unused arch_kexec_locate_mem_hole
 hook
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <179357141929.2624073.17874579803717871005.git-patchwork-notify@kernel.org>
Date: Sun, 01 Nov 2026 22:16:59 +0000
References: <20260905145835.501635-1-sourabhjain@linux.ibm.com>
In-Reply-To: <20260905145835.501635-1-sourabhjain@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 aou@eecs.berkeley.edu, akpm@linux-foundation.org, rppt@kernel.org,
 palmer@dabbelt.com, pasha.tatashin@soleen.com, pjw@kernel.org,
 pratyush@kernel.org, kexec@lists.infradead.org, baoquan.he@linux.dev,
 mpilaniy@redhat.com
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
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This patch was applied to riscv/linux.git (fixes)
by Mike Rapoport (Microsoft) <rppt@kernel.org>:

On Sat,  5 Sep 2026 20:28:35 +0530 you wrote:
> No architecture provides an implementation of
> arch_kexec_locate_mem_hole(). Use kexec_locate_mem_hole() directly
> and remove the unused fallback wrapper from the kexec header.
> 
> This simplifies the kexec memory allocation path without changing
> its behavior. No functional changes intended.
> 
> [...]

Here is the summary with links:
  - [v2] kexec_file: remove unused arch_kexec_locate_mem_hole hook
    https://git.kernel.org/riscv/c/06ce2863e7d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



