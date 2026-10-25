Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0619606A31A
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=urfWzTP0;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kS3iWlB8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=X6fHibwq+GoTvdSaeokyH8sgxjyTLqYN9YXJxFkTs5k=; b=urfWzTP0kCbd+WGWzbHcIi6HzM
	MsQfIloyc817ZGyOU7FTLhBiCtiI3AoxhrxfB+8G8fCCx5drV8JImDAYOcBK81+SI+db5RRE9T69P
	SXrKXfYSeGbtaLdCkQbEWRwcmI62kxQcmS3mcaCLNQm2mGbcXMsYfjwqWsQWyupghksoXYOEgFQFp
	Tgzx3oEpsPuaJvzosF02HhuYopukL996aJS9oaYypeWlMTG0PZWuH/qpiqv5RPIRZQgGDuI+1Fy2P
	uTgmoDV9ExeFgbmqeunHGP52KVcROlMjoKxG+vGu0geeaItJIahVqyhrKXW55D7uItklk2BJqsKjo
	VqNXGHlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Ss-00000001GiO-2tq3;
	Sun, 25 Oct 2026 17:57:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Sr-00000001Ggl-08iQ
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:57:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6AB5543F36;
	Sun, 25 Oct 2026 17:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8841F01825;
	Sun, 25 Oct 2026 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792951020;
	bh=X6fHibwq+GoTvdSaeokyH8sgxjyTLqYN9YXJxFkTs5k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kS3iWlB88S2UGP0VuQQwQ9wMLDYXDRP2up0I9zfS05a/CMsTkwBtWlQzbeHJ9R81k
	 840XKtm1zU9LMBh1h9vkSQNNbcDVtSbU/nwX3SapWPzwCdDMBDEv02MzlPwirZ1oRJ
	 NJ5EnPYzdTtWcC5sXGBWlnDX5ma5+Xoa9ygMcymdfjLBrFJ1PBJs/MpOqbg8ZHWoVT
	 5ZdD6XbQvdlupZqyoC3KvlCzlZil2IC5gjf6cedgT6XZRm/VlaGHmp5ltr+iMDKzuX
	 ZdkULP+QgBbgAxCLXrhc3ohcEZKVPqDIPfP7vtOM2tLfQ7lv2rtRfQa7678bVaUFYd
	 E5Kacjg0AzrQw==
Message-ID: <sashiko-outbox-184304@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] kho: do not modify incoming serialized blocks
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261025174017.3870481-5-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
 <20261025174017.3870481-5-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 17:56:58 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> When restoring an incoming block set via kho_block_set_restore(), the
> physical chain of blocks is already linked and bs->head_pa is already
> set. However, kho_block_add() unconditionally rewrites last->ser->next
> and bs->head_pa, and kho_block_set_shrink_one() clears
> new_last->ser->next even when operating on an incoming block set.
>=20
> In the upcoming KHO read-only mode, incoming serialized blocks are
> mapped read-only and must not be modified. Guard the ser->next and
> bs->head_pa updates in kho_block_add() and kho_block_set_shrink_one()
> with !bs->incoming.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025174017.3870=
481-1-pasha.tatashin@soleen.com?part=3D4


