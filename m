Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1151BC77B7C
	for <kexec@archiver.kernel.org>; Tue, 24 Jun 2025 09:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jq16SD8O0dNI00goPell092SApaLPI0+pr0dFCE+svA=; b=AkiAtNwOvCP/tfJPwEHS5Nb/pp
	ztrCObIWSs7ZO5aBk4Lx5FTPAoiiqZiadoEtak6c177mutia5RyZmFVcWenmNZGrukjHX3XTDDT4V
	RLIwpARIBrSVuBx0SA2laz187cF7Tcg5sqkiKiI5WtgnIG1Ks7f5rWU2liCspgzbaCHx6hOlhDbmq
	P9TLPj5lNgWz1NVAeEO8AJjqFONEx2mbDeJQKK5BauR3EyOZ4BKjn8aLRm3j7z8EAuu4iUHGDEbnh
	qnPdlgBu5fNtAjlBQuJqfdQGWoPlyBRF0juDGq91koTkGKmZ3CYDtPG9EbqqHiduhRRYXd7VVj/cv
	jAgS6jXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTzaL-000000057Qt-10S1;
	Tue, 24 Jun 2025 09:04:57 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTzRw-000000056A9-0LGH
	for kexec@lists.infradead.org;
	Tue, 24 Jun 2025 08:56:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2CB03A4FFDD;
	Tue, 24 Jun 2025 08:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB7DC4CEE3;
	Tue, 24 Jun 2025 08:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750755374;
	bh=a8eU2AWlYYd01z+cecKG61efUWzlcdZbF2IGngs+7/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfGXucivwIgjCe7rbBF1xq8aJa307Wztf41U0HXsWR5eMx7gMIlJnLpXhf1cWz2St
	 UafEpbli7v5mADFl2/Qq0fsKVWLcRlGYtPRKoyJ89uMA/AI1zNjHyc/OwHyfABE3mc
	 /8mOpz3d/ViAId6LXbM0euVSLIXc44o6Q6wfIuoddNdpvRc6spbO8LV7RlmTjKXYSt
	 RMsCRBhHm0r1Rwj7dLXiYiysv448f/jTr62pwyhLOUFpdNN8HkgvHqVLPEhSoIUWpK
	 zdSN/CFLFIlG6BqSju8dDcHp38ZPqwCubUmy1xtn8YIFxg6Y9KZrCfWfBNp4YAfm2d
	 osLTaGtWzUSRw==
Date: Tue, 24 Jun 2025 09:56:11 +0100
From: Simon Horman <horms@kernel.org>
To: Dylan Yudaken <dyudaken@gmail.com>
Cc: kexec@lists.infradead.org, linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH] selftests/kexec: ignore selftest binary
Message-ID: <20250624085611.GA3815@horms.kernel.org>
References: <20250623232549.3263273-1-dyudaken@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623232549.3263273-1-dyudaken@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_015616_190680_EDDB9EDC 
X-CRM114-Status: UNSURE (   5.94  )
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

On Tue, Jun 24, 2025 at 12:25:49AM +0100, Dylan Yudaken wrote:
> Add a .gitignore for the test case build object.
> 
> Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


