Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9884C47DAF
	for <kexec@archiver.kernel.org>; Sat, 20 Jan 2024 21:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Date:
	Message-Id:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bmElkJUM6JIMB4TUnnqKX9HOM9hFsYK2g6oKgtkLLk0=; b=LT0Sm6mkaw4xmR
	7NI5vrDr/VaYIoy+ZuXP1D4HTpIL6QCBXDxoP5OhpfJuQ1YIb3Jh/Cxw3cKl0/I+djk/fcjLBlGhS
	WZ4FTcNkHWHVNalBtNrPDnAEEFYLJPLULJzcvhoaHgOtk03rTbld6lrq4m7fki9ahygYJNVUx3wbO
	rRQypfJQTEYEhnzfCnhfQMclWYXfkm1M1iJrb+ZXuRCmulM0ghZWWbChqUJKhue/rqy/s/BBgsZfK
	THhYnn3bpjRYDycY+BehgGIDd/CE5mCyTy1fohyHNsjZceZYshAHi2aduwnFfc7zko54QH7Xa8s5R
	kwk4TvEf058/6dlF6zrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRIbC-008OAT-34;
	Sat, 20 Jan 2024 21:09:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRIb8-008O90-1Z;
	Sat, 20 Jan 2024 21:09:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1769F60C24;
	Sat, 20 Jan 2024 21:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D89D9C43141;
	Sat, 20 Jan 2024 21:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784988;
	bh=2UTuaFwcqkRBRMR5A80pWR7ePvnb57nQBapA7qClW9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GCFgON7je9PmSZ4JWW4H7qhf2jXKJufA9RJF+aDPsUTPyFRTwt8720JgNMYl1nQOx
	 5z96haFqCw4cJpkp/avsXwPOKPdGDhbXj2SmyVhUYirkdEWnRHr87oAbbTzbU2lToI
	 XVGVCKWCtTJrgSY9ixOL95af/XN2w43U589ETZIDlAN7m5HYoAGz86IeUTqr7ON/B+
	 SqUIGruWhHRoCJ3gX7h5s2NQCBRKIHV8+a7D51Uy6QB2F1x7hQECHLOdB+4mPO2C60
	 jbnIPDaQPRrqq91pz4HFZIDD7ULmwvSv70Uq+YKiq4r8sUWZetzmMK1BBqbX1hUZZm
	 OUJDHPoC6B8Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C48C5D8C96C;
	Sat, 20 Jan 2024 21:09:48 +0000 (UTC)
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] riscv, crash: don't export some symbols when CONFIG_MMU=n
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <170578498880.24348.17790461588886369808.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:48 +0000
References: <ZW03ODUKGGhP1ZGU@MiWiFi-R3L-srv>
In-Reply-To: <ZW03ODUKGGhP1ZGU@MiWiFi-R3L-srv>
To: Baoquan He <bhe@redhat.com>
Cc: linux-riscv@lists.infradead.org, rdunlap@infradead.org,
 sfr@canb.auug.org.au, akpm@linux-foundation.org, ignat@cloudflare.com,
 linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, eric_devolder@yahoo.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240120_130950_572658_555C1F65 
X-CRM114-Status: UNSURE (   5.77  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Mon, 4 Dec 2023 10:19:36 +0800 you wrote:
> When dropping select of KEXEC and dependency on ARCH_SUPPORTS_KEXEC
> from CRASH_DUMP, compiling error is reported when below config items are
> set:
> -----------------------
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_CRASH_DUMP=y
> ......
> 
> [...]

Here is the summary with links:
  - [1/2] riscv, crash: don't export some symbols when CONFIG_MMU=n
    https://git.kernel.org/riscv/c/c41bd2514184
  - [2/2] riscv, kexec: fix dependency of two items
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
