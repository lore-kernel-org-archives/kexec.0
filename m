Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3478ECD4F54
	for <kexec@archiver.kernel.org>; Wed, 20 May 2026 05:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7/jZW1N9MI/xVxMIZT7q6FGbksoc2YLmCYf5xpAjm9s=; b=WkyGwiErhlv+4cE1Waui/iTsOn
	zNM83L44RxZT0PuNIoByAHjemN4Lk3yzymHOiQqFNCvxuNP2Uk/+vJ8nJgqBjfFDVDEOQpOIWgohn
	XsO/FUMejitCnL3Cc9aWwx1nMIEfXT58FMU8ZKJZnsk9aBMWhMOthyeOLNGTO8uRsARo0vbMaAURb
	DPjoPH6jtJizgi8zV43uLJL2jJRbvgz1boF9CD+4FBXnWxLk7sxgNjqhHWuo8wLKONhd2b31MUXAZ
	tzzZKs5JX1oOhEmkMs1CeKNsYwKTPW7xTeqe89WVxUCAgm4n2eUCQeOKlLVUe7h6lHPYAKknvr220
	9ji31qDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPZBh-00000003XX8-4Bby;
	Wed, 20 May 2026 05:09:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPZBg-00000003XWy-2abg
	for kexec@lists.infradead.org;
	Wed, 20 May 2026 05:09:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A27C160120;
	Wed, 20 May 2026 05:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E478B1F000E9;
	Wed, 20 May 2026 05:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779253783;
	bh=7/jZW1N9MI/xVxMIZT7q6FGbksoc2YLmCYf5xpAjm9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L/DWnFDfeVPs6tLar6fdfdg7BrzlH3ea97UPQmkAHb07Irdej/Mq8D1gq90TU4oU2
	 I6RvfgNnKkNiHQG+reepBNBDRoq9Htwo6TWcEXda8oEOUIF+AD7all8JDsqMS8MLNu
	 pM8Ork79MF8VciT07zLXLI1B/+HV1y3IrLD1nRdHVg6G4m/eA7tkqB+hgsDkifWcys
	 bmwwp7E3YwSHR+A4/KL/nC2szgUuEJu3/CUmEJt4A/McTcpHCpDp0nEJmk/lHaaHgb
	 WESlMs4MMvAv5nCZEsF5xvchPkLEf+di6+w+2Dr70gxaVgyBNUW2l9TwmYL7ddGPMe
	 7ryaAnUAOXalg==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] kho: fix order calculation for kho_unpreserve_pages()
Date: Wed, 20 May 2026 08:09:26 +0300
Message-ID: <177925371880.3535040.4659421700056655477.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519133332.2498092-1-pratyush@kernel.org>
References: <20260519133332.2498092-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 19 May 2026 15:33:30 +0200, Pratyush Yadav wrote:
> Commit 91e74fa8b1bc ("kho: make sure preservations do not span multiple
> NUMA nodes") made sure preservations from kho_preserve_pages() do not
> span multiple NUMA nodes. If they do, the order is reduced and tried
> again.
> 
> The same logic was not implemented for kho_unpreserve_pages(). This can
> result in unpreserve calculating a different order than preserve, and
> thus not actually unpreserving the pages.
> 
> [...]

Applied to fixes branch of liveupdate/linux.git tree, thanks!

[1/1] kho: fix order calculation for kho_unpreserve_pages()
      commit: ec4084bc445027a52f600e30a976928be1ba1950

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: fixes

--
Sincerely yours,
Mike.


