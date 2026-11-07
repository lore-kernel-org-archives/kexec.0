Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C55606A33A
	for <kexec@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4xoJU+sl;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTWOVJsq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rDic6n19p+tKm6gJFnHdWsLjkBC8J9A48hzVn2p0tWE=; b=4xoJU+sl/RyJz6
	ZXCm4rnxEHGPUcX0yrkVMvpyyNPQ1NrHsNBkM0ArX3gO0QSGLqpYplJTBf0jFU9Wfh02UqfWpymiS
	cmK7Uu3HZ3byV7IAo4rMNLZ5hiCm6l5gr2LQL/MNyoUgm4TzSPCsY9TIpiDnUZFihpSvCvX6BXDP1
	yqsGAeUA+dCBH9b1OY+1XbRIRMmeCq2ij6f6xDY2xZbpPK2lMgg71gc8Yv9cYndAMYLTcYUvqpa7Z
	pewNLi3cdQvvxvVyYiElKTTcpbfSXxc/pL3r/PkkEz0N4KyzxSap0rghTJ0bnoNgS+KS1W09ngQUi
	IkPa/COsT6O6KXg0wmrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPe90-0000000EaGz-3gMh;
	Sat, 07 Nov 2026 10:59:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPe90-0000000EaGr-1JAw
	for kexec@lists.infradead.org;
	Sat, 07 Nov 2026 10:59:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 966016111F;
	Sat,  7 Nov 2026 10:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB361F0089F;
	Sat,  7 Nov 2026 10:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049173;
	bh=rDic6n19p+tKm6gJFnHdWsLjkBC8J9A48hzVn2p0tWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dTWOVJsqhmVHIkNdc9lhq8nOLai44lu0V2WeVfW9gl6t3I7xD0yUIQwDEr36UwZSi
	 1790g7LlB9CVojVs/V0Xk8rk+AZWZ4lgLVJOfUz+xe2Vf/YapPByxkmWZvcznfp7td
	 yFmcnA/YTioNEdIvWa+qeOyWMO4zZsze8dETZs0/jBKMMYZv496Y0FW8CCU6OF2OeJ
	 ycKToyQ8GqcUc3l7caQsFHWgfETCZGqUTvqL9p2wuUNL0S2EwhGISaUA5CKTTEvLa0
	 ilurnve3o0c3suUa41vAwtpH+00CS4z5dPQQmcB8MNb9WWu4AiEo24pw8MZCmCbljy
	 k+B7NOE+I1liA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	baoquan.he@linux.dev,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	jbohac@suse.cz,
	david@kernel.org,
	hbathini@linux.ibm.com,
	leitao@debian.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] crash: keep crashkernel CMA pages reserved if activation fails
Date: Sat,  7 Nov 2026 12:59:22 +0200
Message-ID: <179404912275.1474561.15279136626327905378.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104145600.3708886-1-usama.arif@linux.dev>
References: <20261104145600.3708886-1-usama.arif@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Wed, 04 Nov 2026 06:56:00 -0800, Usama Arif wrote:
> reserve_crashkernel_cma() adds each crashkernel CMA area to
> crashk_cma_ranges[] as soon as it is declared. If the area later fails
> activation, e.g. because movablecore= put the ZONE_MOVABLE boundary
> inside it, cma_activate_area() releases the pages to the buddy allocator
> as ordinary memory. The range is still handed to the crash kernel and
> excluded from the vmcore, so kernel data that lands there is overwritten
> by the crash kernel and missing from the dump.
> 
> [...]

Applied to kexec-next branch of liveupdate/linux.git tree, thanks!

[1/1] crash: keep crashkernel CMA pages reserved if activation fails
      commit: e2b6a999e1df5bda2100262397260664655cd47c

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: kexec-next

--
Sincerely yours,
Mike.


