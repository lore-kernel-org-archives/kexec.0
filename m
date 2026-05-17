Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5049ACD4F4A
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U/85E8d1BoxEQjGDBBe9ZPjDbaxTJxayaXmtPrM0VxQ=; b=4XkxCCWE1c4OUm+Fr1tHg76EnC
	ctj+Cc/StsmxBDevhKTzMhQpc2GseXDgaf7Q8NXZGh71dDWFB08Y1Y62zOdKIaipl1wffbfpejgLn
	zAvj/BG/WD1jwYBB0GcKpTL+9JxrNY7YeEA5Hjk7DURUKPaljHvlwFx6TA/yMC6O7nz5OEIuNk1fM
	OPD9jW+2+Q6HMh8yZkvARY+L370h7cEIbtZp72vivxREjae+AixGctMSJBNxQBby81MSO7U+PYNy2
	kW+MOgonGPJKMtAvLLZ25dE+qDJDUKFeK3DHevJ5273fWTocUPgbIplxnlgcLjvyhvbt4mGbpB4vw
	uc8D9TSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfEJ-0000000D6To-25OX;
	Sun, 17 May 2026 17:24:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfEI-0000000D6Tb-2LFL
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 17:24:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EBB3F60125;
	Sun, 17 May 2026 17:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80395C2BCB0;
	Sun, 17 May 2026 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779038681;
	bh=18wU4AaA8QQO+xGJ2kIhTsunkndrM76R9Ox2d9eFd5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pTx0Mu1I8DpGHA2aJuMI7NKp8xzGNMC0P0k63npy00s0iHZlPGlMRb+FwVyDrnWf9
	 NUv4DcxtPx7aMQ4I2Kx34VcOi65DjSVPQJnL/GETiVIvTnA8tGowjq2iazzDert6P0
	 RK0J9ayNhloK1k5Kg+LkgpODxR6Rrq0lAM1fXAjqbK5uL1GtOz72KXhepk0qmzD3/7
	 wPPI4rJnRp8cqjgVyAn3OmyWAF2jncHX60DelW3kF2fNLKgHRQILWN0vhHIQO8Trkj
	 FNPtfWIYKop/JzvEoixE1K+Ya35mFMRgPDLEeVJ5ADOZx7cU3UeQ+H+GQpsn4PrOUZ
	 +FwOpkeLN/CBg==
Date: Sun, 17 May 2026 20:24:33 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com
Subject: Re: [PATCH v2 02/10] liveupdate: Extract luo_file_deserialize_one
 helper
Message-ID: <agn50TRvhDpGm_9v@kernel.org>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
 <20260514222628.931312-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514222628.931312-3-pasha.tatashin@soleen.com>
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

On Thu, May 14, 2026 at 10:26:20PM +0000, Pasha Tatashin wrote:
> Extract the logic for deserializing single entries for files into
> separate helper functions. In preparation to a linked-block
> serialization for files.

It would be nice to mention that this is a pure code movement without
indented changes.
 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/luo_file.c | 77 ++++++++++++++++++++----------------
>  1 file changed, 44 insertions(+), 33 deletions(-)

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

