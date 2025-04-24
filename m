Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AB7C369DC
	for <kexec@archiver.kernel.org>; Thu, 24 Apr 2025 11:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RVoyz9hNO52DhsL4gjW38POoYotEH3IRaPr4/7rvZco=; b=dUK88hxSNjWWwmfkd4dA1LZYNh
	WTsz8cf7JLKsRbe9VqN8SnClzLjRHiFCp3tCHDbBc2IGqs4gmIW696ZeWD26aDkiv6SnCtRlhYM6q
	cl2hRo5TPi4WjrZfsqklT5rOF6bR8WZTnHJUQNYRb1s4mj4h5cmY43Gkloa981lfWf5gMOw2lVTcG
	83OB6JO5zBhq0prFl00YrQrYZbTSBqcH/Vy/7zXSupXd7mwqspUFKBIWG0LABxOQZ4A1gUaHe3bjW
	IJ6BRsKtXzPZUAyx/tFYn37BP/8gaWNOEafUo+uXh5GSyIkb0Ya/oFVfQxGjR3URX1hnBS5TLC2JL
	hyQ19oqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7uQQ-0000000Dnhz-3S2J;
	Thu, 24 Apr 2025 11:07:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7so9-0000000DURv-2YN2
	for kexec@lists.infradead.org;
	Thu, 24 Apr 2025 09:23:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CEDA35C5FDA;
	Thu, 24 Apr 2025 09:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE357C4CEE3;
	Thu, 24 Apr 2025 09:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745486628;
	bh=wuAGatnekiiKeyZxayhIFl+BETI1JkPzVLJOix1FXRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTLu3Bmw5/R5xsMffASSreafRiQ2D60Koj59TitTCCcgNRyppbSSkVxzlc0J0FzSR
	 irScHG8vKiZ2gVv+12n6DT5OMXs1yoMm63K3sWLuaf5A7X8kVsFnQ9SAeQdSVa5sIo
	 Z34CvbYDnuSjTm9bDq1EiMEe5M5fgSYCV2fRxS7XjmFVp9jADZm51BHgYPZ4isUhb1
	 Hs/6KLRWSL75o+8tWU8D9VofD/sUHFSDWldxBat/kDJRVClmTgeENZMkpZxh8Rl2qQ
	 cMNq5wXGCMBK0yNFPn2n0w17qVtr3Mj6JA3xO6gxm99Gpaq36+xbl1DgfbX1HC8OCf
	 fu94eNnzvtkvg==
Date: Thu, 24 Apr 2025 10:23:44 +0100
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: include asm/early_ioremap.h
Message-ID: <20250424092344.GC3042781@horms.kernel.org>
References: <20250423162924.2213664-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423162924.2213664-1-arnd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_022349_704985_2EFCD0CA 
X-CRM114-Status: GOOD (  11.29  )
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

On Wed, Apr 23, 2025 at 06:29:18PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The early_memremap() function is decleared in a header that is only indirectly
> included here:
> 
> kernel/kexec_handover.c:1116:8: error: call to undeclared function 'early_memremap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>  1116 |         fdt = early_memremap(fdt_phys, fdt_len);
>       |               ^
> 
> Fixes: 4bfe738ce89a ("kexec: add KHO support to kexec file loads")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

I didn't try to reproduce this problem. And perhaps this isn't particularly
important. But, naively, I would have expected the following as it is
the commit the introduces calls to early_memremap() in exec_handover.c.

Fixes: b0a311dba688 ("kexec: add KHO parsing support")

