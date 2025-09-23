Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E730CCAC5AC
	for <kexec@archiver.kernel.org>; Tue, 23 Sep 2025 16:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xMXDQwbG36YnXlKMwzk4DpC6B2Z988FbL2ZsCj2Yxtg=; b=M9MynIS22gXKfCOK05+DCHF+Uq
	4oJ1zhejyI+Z9uTl8jnPy4VcpDCXcBfVCGIJIF9mjRnIwaCpXnVWI5jBPt30GAZG69+6wg+FpYw3d
	btJq9A3ZfvqReofypd2QCsKLia0BtzJcU9yZQLtpAFJEPrV0ZR8KqVvDxRAFYGFWesJoXRMLugKL7
	/bd12odV0d7OmX/2wbugJCDYsHZQNdFsRcCwYejltImzYSojerpFEuWMbXJOnbiQhaK3iLaLnkLMj
	0hnztyS+1Xu6T+7Lxx9G5zQV4WgPtJ50qfXCIWXwRxmI1YHuc/vrvpMohLvTCcq6qYXlu2FoFBoOA
	xPRJAS+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v16Df-0000000EJSa-2Uww;
	Tue, 23 Sep 2025 16:50:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v16De-0000000EJS3-3KaO
	for kexec@lists.infradead.org;
	Tue, 23 Sep 2025 16:50:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3F7466027B;
	Tue, 23 Sep 2025 16:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A51C4CEF7;
	Tue, 23 Sep 2025 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758646222;
	bh=NwfV7isk/q+MFxGt7WrkLmnmPvO7ZZwL3/2S98/b8ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDKcl1Q+X2ZHpDsl7juHxzvA4yKCeiq8+JvmgaZVt8f49q3jut2ga9Wyyd/Ecs/Xi
	 kAkWFVc5gJNmeTkAsMva1hwokHfy/a4/pJDECTiDJisdp278qRlNZk+84dCKh9n+W3
	 OYHVq5cQVWBi+j+Qafmdjx/txoQuZnoSgTkWTPEffXJKR2wtT/m4k/G6msQitSpZzo
	 0VxdEwb/dxDK7rUp8yZU3+Thzk9o7RpjS7YHQ9daA1r9Vg6IJ9omiQnsAHXu2Wz+Ny
	 A/yrzQy23Y7fM7tCus13186PX5ISwGBGxNhz2Ip7NZeYjTcH7HJPRWYbKqZFFHq5IQ
	 /uO5PdyA9kJNQ==
Date: Tue, 23 Sep 2025 17:50:19 +0100
From: Simon Horman <horms@kernel.org>
To: Khem Raj <raj.khem@gmail.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH v2] Make the segment base match pinned section address
Message-ID: <20250923165019.GC1084957@horms.kernel.org>
References: <20250905032252.1216827-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905032252.1216827-1-raj.khem@gmail.com>
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

On Thu, Sep 04, 2025 at 08:22:52PM -0700, Khem Raj wrote:
> ET_EXEC uses image base of 0x400000, but the build forces
> section VMAs like .text = 0x10000. LLD now errors when any
> section address is below the image base unless you explicitly
> set the base. (Older LLD tolerated it.)
> 
> To fix this
> 
> use a tiny linker script to keep .text at 0x10000 and avoid .note overlap
> 
> With hardcoded -Ttext,0x10000 and newer toolchains emitting
> .note.gnu.property before .text, the link can fail with an overlap.
> Provide a minimal linker script that:
>   - sets the image base to 0x10000,
>   - places .text first at exactly 0x10000,
>   - moves .note.gnu.property after .text,
>   - optionally fixes .bss at 0x12000.
> 
> Works with both ld.bfd and LLD 21+.
> 
> Fixes
> | x86_64-yoe-linux-ld.lld: error: section '.text' address (0x10000) is smaller than image base (0x400000); specify --image-base
> | x86_64-yoe-linux-ld.lld: error: section '.bss' address (0x12000) is smaller than image base (0x400000); specify --image-base
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
> v2: Use a tiny linker script instead of trying to use linker options like -Ttext
>     to make it portable across BFD linker and LLD

Thanks, applied.

- Make the segment base match pinned section address
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=efb97b509b1a

