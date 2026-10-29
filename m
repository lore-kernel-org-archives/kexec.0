Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84733606A31D
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AwzibBH0;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtJrzK+T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ic+1dc5Kuj9YU3DoyLM5etao2DsyQKY49+UZwFz79tk=; b=AwzibBH0hG3SjGXjLiww62FIg7
	aekxgZoH21Rfujsz1TllMwWLr5l4/YEnJzWU2fPFuXrEFS1Joj587TgPqOhmx72gXGEP1h2CeCcsB
	YiSlr8JRZ6DcjLOjOlTeYQk+uTOAoSkiIpNIUuHgZyKPYif92cGV6XPwlULZwUK11lgEw0EL7YlT/
	GkAW93pwkx6rB1jEAna74BVsJRAR2GhB7svjkCvOJBlAndoEVqxMUcQR09qbSMAUgRyNJ9kO8nrG4
	R1ehsTz207k5/a99+BzX8sISQSkdk65gLUskc7qmGjFt1qa1wZDuT93ub2ijK7ubLqeng7dz4e4Qf
	R+CXhl9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDf-0000000A0In-0BbN;
	Thu, 29 Oct 2026 17:47:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDc-0000000A0GG-1MWU
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 17:47:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 809CF43FEF;
	Thu, 29 Oct 2026 17:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C5E1F01816;
	Thu, 29 Oct 2026 17:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793296035;
	bh=ic+1dc5Kuj9YU3DoyLM5etao2DsyQKY49+UZwFz79tk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UtJrzK+TqRu5QHMxE+Gij8m7bBA0fDNX0Rw5VRDJ7TK7Q9D0432+k3NQm2o3r2v7h
	 MNR62SjfVaEVH4i2o0Iqq4mAE9RZi+Q9HauzF0Si++4Kaj2jmw9a4TxvlTfSyxun3e
	 VsjIQvw+XSo/1L6lgIvj9Y9l2nIf/+E9CK8JwwTwtGuR8ft+tFPM/KC6hKnecvxNRO
	 60kTNRZAkVr8UqGjpMnzm31TT3NwAsp3X0aIbF6iG7qd/6mTNFyKq+t1Nh/pStIQR6
	 F0qex5m+rdLhC/sGTP7GT7mbWqwk8a+wXCi6uuSwvfZheD32EEX1uSbRDHHlDaFpez
	 fSDAd8zXt9jQg==
Message-ID: <sashiko-outbox-189746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/8] kho: Include linux/mm.h in kho_block.c
To: "George Guo" <dongtai.guo@linux.dev>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, chenhuacai@kernel.org, ardb@kernel.org, shuah@kernel.org
Cc: ilias.apalodimas@linaro.org, akpm@linux-foundation.org, baoquan.he@linux.dev, ruirui.yang@linux.dev, guodongtai@kylinos.cn, kernel@xen0n.name, graf@amazon.com, liukexin@kylinos.cn, kexec@lists.infradead.org
In-Reply-To: <20261029172956.20791-4-dongtai.guo@linux.dev>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
 <20261029172956.20791-4-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:47:14 +0000
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> From: George Guo <guodongtai@kylinos.cn>
>=20
> kho_block.c calls virt_to_phys() and phys_to_virt(). With CONFIG_KFENCE=
=3Dy,
> the LoongArch implementations use offset_in_page() and page_address(),
> which are provided by <linux/mm.h>.
>=20
> Include <linux/mm.h> explicitly to avoid implicit-declaration build
> errors for these helpers.
>=20
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029172956.2079=
1-1-dongtai.guo@linux.dev?part=3D3


