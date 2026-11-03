Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29852606A337
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vSHDEU8G;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKtjJVF3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rk/q4Jj7lVrhNw2rMbFmAGjXQkJt7MP/x4+rKDQwa5U=; b=vSHDEU8Gr5I/ZdNgP2ZoahPe38
	LeLUURezRJqPvUeYikiDZMUzXEhr2S46P4MZqSina3qB02+DTp0jSz2KjdlvSRSDNU1NAxj/hTKEM
	eclNsFpbzWfuc4y20ZjittjvMvzITTm66uuVzbqRCTGVoYHnVNYnnnyqhKJyEelTSuCGxMSeZQcIk
	rTXD7QxoC5DFJUVs7qgjpitvUfUzZoKDy02al8vqOLGJxfcu2/n8/wtxtNaMAZZm6WIWK4IzdPOnN
	bOoPWBvgZinieJJtq/TuFQiztzSed65CdvJdZ1u6fwiSZCCYAHryjKUeKFMGDNuPTjJj+vDIM83JX
	7C/+0gOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGyn-000000033W2-3G2V;
	Tue, 03 Nov 2026 16:03:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGym-000000033VD-2ekX
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 16:03:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C004860416;
	Tue,  3 Nov 2026 16:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381C41F00919;
	Tue,  3 Nov 2026 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793721799;
	bh=rk/q4Jj7lVrhNw2rMbFmAGjXQkJt7MP/x4+rKDQwa5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MKtjJVF3S87PSHcYjNkgzTrAeqm6OrMtJwCT5s9T/sYs066BaLjxMYdj/6j33x6De
	 WuToMC40DOZ7uBxBe8D0gMm0wGakVv9zT6DP2CNqufeJw7ZjR2XUJYLk77Cy0VlyLZ
	 3GvEJy8YLfHpPHREegsD7QyiVJdV4YkYeV0atQZI/m5lUW/eo+SnMBGyd67a1OdUj8
	 KmoNO5DW/LjE2ZnxbGgSDEZhpIzrTc0fp7psLoKoMysYEZmQwgrFHMmBhfsHIBaFpu
	 ZaNap+me0hIXuKHmBtmp5qRCyMtUJSzl2XVO4U4OAo6OPalB+32l97qgGX0dx8gY5m
	 G7UZymNnsy3UQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] liveupdate: check for duplicate session before growing
 block set
In-Reply-To: <20261103153928.716753-1-christian.aurichzm@gmail.com> (Christian
	Aurich Zanettini Martins's message of "Tue, 3 Nov 2026 12:39:28 -0300")
References: <20261103153928.716753-1-christian.aurichzm@gmail.com>
Date: Tue, 03 Nov 2026 17:03:16 +0100
Message-ID: <2vxz1p91nbqz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03 2026, Christian Aurich Zanettini Martins wrote:

> luo_session_insert() grows the outgoing block set before checking for a
> duplicate session name. On -EEXIST the new block stays in the set.
>
> If the session count is an exact multiple of the per-block capacity (51
> with 4K pages), that block stays empty. It is serialized with count 0,
> which kho_block_set_restore() rejects in the next kernel:
>
>   luo: Block contains invalid entry count: 0
>   Kernel panic - not syncing: The incoming tree failed to initialize properly [-EINVAL], disabling live update
>
> Check for the duplicate before growing the block set, as
> luo_preserve_file() does with the token.
>
> Fixes: 2a441a14c2c0 ("liveupdate: Remove limit on the number of sessions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

