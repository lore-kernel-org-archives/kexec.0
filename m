Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839F7C28B27
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 20:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WwetGvKo+lcC6ngzIF9eSVEkBLv/4MJDE4MC+lAtZiI=; b=wDjWSzR6htCsaGWCZKY9wtMpso
	NaVpmjJn7o4iqcreJN2z/oGlyuvuluEYlFi0vELH9u4QxOZEJLR9tNc22Z2eQtrttLsB38x+BjClP
	ZVyDryeLQdENAoxyF62B5+GgBXZpPoeiAohfcWz/nzu0umSG/lzWyIq2bsG2OQ1jJzFOkPhcHYuw7
	KkPbgmpesU/pNMUCeuwnCX8H0SsCQZITgtt4HwgYy3bRLBfOxu1q3E8O+r6WHIGDARuNzPDXTnEue
	+/Qkcc3ufp9lHEOk7nF02N+o2EP5l1YyJsbUBJvnCnYEft4HPjZkuPUgGCjCCitsDYGIRbDbWbg5S
	bomow6KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqeOJ-0000000FUrc-0Q7U;
	Fri, 07 Mar 2025 20:33:55 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqeFJ-0000000FTv6-0IRq
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 20:24:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0012D5C5F44;
	Fri,  7 Mar 2025 20:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E810C4CEE7;
	Fri,  7 Mar 2025 20:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741379075;
	bh=KjWnEu/K+zIr63GaIVtY3k/dYFtNoqLKDVJtEmyg/K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=do/9ebNc+rpBe5CQ6DPq2GR6Fnmntp/gZhzzwMuVGgCSiDRUHeqfU+RBMP8jUA6T7
	 nU7/Q3ts7fWi29aZfyr0vRNe/BtrO2k8aaKExndfYPajbft8GJVfl+NFt7PR36rAAP
	 cxb+BUxhPTwFE3tLauXt5DUQbNS49KKbS+tN6FFM75K4J0cI1bz4tW8/XzzYnBQWu/
	 +KJITztuQ4W+u9u/P197DqS8zrGB3L2kE3kfFyHYjekoORDRr7LpL1om5csGbTEXHB
	 94EtWTxIah2ptDO/FJNWvDlrDqXtmXJPhaQD/cwQtzLZHdUIu3bsuQve4tkf3Yf6fa
	 RlI7+pof1gr4g==
From: Kees Cook <kees@kernel.org>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Jessica Yu <jeyu@redhat.com>,
	binutils@sourceware.org,
	Timur Tabi <ttabi@nvidia.com>
Cc: Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] elf: add remaining SHF_ flag macros
Date: Fri,  7 Mar 2025 12:23:58 -0800
Message-Id: <174137903607.1472989.15422208420067527885.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307171417.267488-1-ttabi@nvidia.com>
References: <20250307171417.267488-1-ttabi@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_122437_154397_D07F578D 
X-CRM114-Status: UNSURE (   7.30  )
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

On Fri, 07 Mar 2025 11:14:17 -0600, Timur Tabi wrote:
> Add the remaining SHF_ flags, as listed in the "Executable and
> Linkable Format" Wikipedia page.  This allows drivers to load and
> parse ELF images that use some of those flags.
> 
> In particular, an upcoming change to the Nouveau GPU driver will
> use some of the flags.
> 
> [...]

I added a reference to:
https://refspecs.linuxfoundation.org/elf/gabi4+/ch4.sheader.html#sh_flags

Applied to for-next/topic/execve/core, thanks!

[1/1] elf: add remaining SHF_ flag macros
      https://git.kernel.org/kees/c/b0db1ed17645

Take care,

-- 
Kees Cook


