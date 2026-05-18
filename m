Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEA7CD4F3C
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 16:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nIV21zxhdvGXqAMmjYx4bL1kFAoimC+TZkGVo03Khfc=; b=FtPcMxDB+3aQZ/cszEuaJpYvfV
	vUB1auMw1PX+9dAvr0pRepDM7ljh79Zei00eATKiTbrm3qELfbkrENAJ2PZNJ64dDkC1wu+H8piX0
	MVLX35VxkUD61G2vhoV6Q8hingGKWo7vLeK0eTogH95Z7r7sIkqzJCiGsFgKqmLlP7AndReFGBvxK
	oo7ux5a8yvQFh/ZXCs+tTeT3rmf+MOUNU+jL1amodgwf7pHMz/8r7sUvWMpCtA9Dl46P7SN6ok6Nq
	Bg50qNc6ibnUollxbAp48KHqGeD+s0ty1X1geXIjI2AKRG1gWOc4QZzhjV8EYwYcuPSrpBPJMI2s8
	juMQdSjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP0lR-0000000GI3Z-2ND9;
	Mon, 18 May 2026 16:24:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP0lP-0000000GI36-3OQu
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 16:24:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E9176600CB;
	Mon, 18 May 2026 16:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403B7C2BCB8;
	Mon, 18 May 2026 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121458;
	bh=AgKZohJ4UvHWGRQR2XDplp4d6aaMpzNqY4yQBb+FLIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RguwjGZ++BfuIc9X88m+ukYcdKN6GlROkw1uMP1KDwnUipPipt25rZXOu84rbt1Id
	 nrr1h/jue3Cf1O9gf7oPp3MJFKTR5BUAzvj/YU9AtsrVCrYKbOO71PkHCqK6fi7Gx+
	 gmCOWToc6XyFMAqTx7qTc5/gw5l3MDNAjig53JPdZ6UZANHUPsoNHIeQmZtBHaguC5
	 g5T8eKcqX1Q9lczrLxPV9DVcnqEIq32N54s5IvdbHimulBkhL9oaEgJEZCWjWEyIsg
	 KYkA48xDdDicJu/Ip6HrbU0dYsY7xSCCT+MR0vg0w80kVpKcdV/BzJsfxgOJYhUxsn
	 S4WqTjZzlFjPQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: rppt@kernel.org,  sourabhjain@linux.ibm.com,  jbouron@amazon.com,
  akpm@linux-foundation.org,  bhe@redhat.com,
  linux-kernel@vger.kernel.org,  dan.carpenter@linaro.org,
  rafael.j.wysocki@intel.com,  piliu@redhat.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com,  mario.limonciello@amd.com
Subject: Re: [PATCH v5 4/5] liveupdate: fix u-a-f in
 luo_file_unpreserve_files() and luo_file_finish()
In-Reply-To: <20260518125459.1092373-5-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Mon, 18 May 2026 12:54:58 +0000")
References: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
	<20260518125459.1092373-5-pasha.tatashin@soleen.com>
Date: Mon, 18 May 2026 18:24:14 +0200
Message-ID: <2vxzwlx08z4h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, May 18 2026, Pasha Tatashin wrote:

> In luo_file_unpreserve_files() and luo_file_finish(), reorder
> module_put() and xa_erase() to ensure the file handler module remains
> pinned while its operations are being accessed.
>
> Specifically, luo_get_id() dereferences fh->ops->get_id, so the module
> reference must be held until after xa_erase() (which calls luo_get_id)
> completes.
>
> For luo_file_finish(), this requires moving the module_put() call out of
> the luo_file_finish_one() helper and into the main loop of
> luo_file_finish() itself.
>
> Fixes: 00d0b372374f ("liveupdate: prevent double management of files")
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

