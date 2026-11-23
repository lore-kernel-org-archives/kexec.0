Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13DB606A31A
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lnxIrmGc;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpLzDEcT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=h9uZWjOaD8ZCOrYoUsyMoNBzk/upzevP+ABmfN9jiDY=; b=lnxIrmGcUgdCH5G7xKO4CLM1X7
	3uslVDh11yTmraIv5kLUeBWKuwCQaSIDu7o+9WYAYHgg5w0kt5wmlwVTZVXPo6qsyVn2dhPSBAs6B
	99fSz9YXdgzQwwDWg2NZNQ68mWVtlLneKmHl9AHyruxQDh1c41SHSi/65qjuAcfeLSJQCVRskwX6F
	M7bm/6sDfZxs/Jnsy8iz1Tm0gg5h/aRP/qiDaE9Pco23aYGozeGMNZ57M89M6fZ9EHyml+c/febH/
	l6muVRB8UfS4M96nf9qQp3uK7gnImOv2kLBUD/GGxaMKOBFLYJVcPDb9egGXCpr4VjTwS5KnNAPm7
	9x/v5NhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTrx-00000003Xc8-0f7i;
	Mon, 23 Nov 2026 13:14:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVTrv-00000003Xbu-3vxB
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 13:14:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 97C3E442BC;
	Mon, 23 Nov 2026 13:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD6E1F000CF;
	Mon, 23 Nov 2026 13:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795439643;
	bh=h9uZWjOaD8ZCOrYoUsyMoNBzk/upzevP+ABmfN9jiDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OpLzDEcTxeGu2S25OmBZlfRZkq0kcuku7rC2KSwim3Gf3t+4qi1vJnVKQGnRo4bRY
	 QanZbGrvyfKYpw3O225M6v3FVUPjxIqoJG0QDg5WqxFW7eNuPL9bkmeLtdxnsv1vvo
	 LCq27061d5XQrIYW1ynlx+52EeP0VnqexfRW2P8cb4J4vawei5GOS+vFLN3yZwqvyw
	 hvWixs1SZG49i+ATMX9veZnZlQMkCcSu2IEAh6sQ1zq7gM74P5JOrEe/K9MmxOvffF
	 zoPftk7h2g9LG45agaWTa0vHgewhyD34Po4xbdSTBk8BbhploGFmGSdVJleesYAMnD
	 iGjZHiPKWwBNQ==
Message-ID: <sashiko-outbox-229299@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 0/2] memfd_luo: keep memfd frozen until finish
To: "Pratyush Yadav" <pratyush@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Chris Down" <chris@chrisdown.name>
Cc: kexec@lists.infradead.org
In-Reply-To: <20261123130509.4032642-1-pratyush@kernel.org>
References: <20261123130509.4032642-1-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 13:14:02 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123130509.4032=
642-1-pratyush@kernel.org

