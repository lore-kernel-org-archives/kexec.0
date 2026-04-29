Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C88FF8867
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SelA/khA7FrWueam9o72/WVBnWcERizhL66SJlVwBng=; b=GxrswwMzJ8ca1jazCF+TkOHpa5
	nYRu9R7b7wWZCSbCrIdiaWaC04jHCm+AUUSuCEyoY0MXW/xnn0jhGC6bZmjF2ozAMydeoPGdrlWzh
	m/UJSUexFGNvALIWQw2/OmfEmWFkhfnjF38P1DQUYZxNts77A2G/JVWh3AlMBqb+hnZ1tM8rQze+K
	d/iwosHFLHq5ML97wKwfXebB5DG2ruei8Jgs3hmwkJ9TYB+DUzUM8z52aOjVlDTCyu5HZkLB5O9+I
	oJIvtKgBaMTL19PO+niLXS//t/jDjYO49oYz6nYhUA61bvyXgdhY5dNYFE6aAiSYsYBKc22mSUAb2
	NUorzhYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI62Q-00000003mKl-0G90;
	Wed, 29 Apr 2026 14:37:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI62N-00000003mKK-40yr
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 14:37:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 69FA540A5B;
	Wed, 29 Apr 2026 14:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E44FC19425;
	Wed, 29 Apr 2026 14:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473435;
	bh=YScNpVH1UHOoLbbJLA0x/IkWN1FOcPoi5y7ZJUsuXFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uF9EcBM1AJ1RATA/7vKyD97zriLLgWwTV8H933WHqoz7MqKkRUxlQZslb/0qQDvF4
	 fUc2rFZ/wU6zXYdq1/9hno5d3mh9+3FZEFtLQtTIoR7Q2D25h6L/UUn0WjZ/QV96Ee
	 xjs4rkGjyecR2ElZ5DHMvoyMF0KfFteMLihspvEKWABihiV2Se6qhNaxqOWqvZXVJv
	 sKHLNWgK4wLVfVkRmQGj6138ZRAG27yazdJgceJesEUkGYyS3/p+20rmDuJ4E0FRTq
	 VLChyiSlRtTQLFdQ8Rr1mXkJGm7vjr+TVvt7h2cr8SM8Op7JbhSZ62bySSChZvF6Kr
	 jbjSqfTI4gwtw==
From: Pratyush Yadav <pratyush@kernel.org>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org,  linux-mm@kvack.org,  rppt@kernel.org,
  pasha.tatashin@soleen.com,  pratyush@kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 4/4] selftests/liveupdate: add test cases for
 LIVEUPDATE_SESSION_GET_NAME
In-Reply-To: <20260423234753.3873095-5-luca.boccassi@gmail.com> (luca
	boccassi's message of "Fri, 24 Apr 2026 00:44:23 +0100")
References: <20260423234753.3873095-1-luca.boccassi@gmail.com>
	<20260423234753.3873095-5-luca.boccassi@gmail.com>
Date: Wed, 29 Apr 2026 16:37:12 +0200
Message-ID: <2vxzwlxp3k9z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_073716_017800_09B5F772 
X-CRM114-Status: UNSURE (   6.76  )
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

On Fri, Apr 24 2026, luca.boccassi@gmail.com wrote:

> From: Luca Boccassi <luca.boccassi@gmail.com>
>
> Verify that the new LIVEUPDATE_SESSION_GET_NAME ioctl works
> as expected via new test cases in the existing liveupdate selftest.
>
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

