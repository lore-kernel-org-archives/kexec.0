Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008E606A31C
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3zGEWh1A;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqPcCaF5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MXKA7Lhy3ZJNDjxfGFebHTx4UQI2cu9qz5i4buDKwpc=; b=3zGEWh1AD3aSVloan4NdpZkozL
	bwjOdiZiJJpn1JqiMZRnwvIV0cpsOTx79/iJi6TrmRWP5wqLCts3AuWAPVAr/9BI2Fx3ODOAc/KKf
	bWxcitqH4pFuQlVV1fy2zAS4uWo/AlLsRtM9K5gXsfA5amydOUtqLyEfX+Rk/1G5OJapR6AhxKWOM
	sJvVGr0oRmSXBkUPjHC4dsrSzYd6beRZVEmJmOrMlm4YkPTHffEarmv9uG67EY3mkyPqgj9Qw6/Go
	Z7HtA4p9RaefW4yP27y13HllkAWXLa7py8G68wZ9CHx2J810rlX+QnfrLoumjZeCZGgI4Nj4mpgR8
	bsVUd7vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMMDH-00000008olR-3lGB;
	Thu, 29 Oct 2026 09:14:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMMDG-00000008olL-0pgp
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 09:14:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6BDA643662;
	Thu, 29 Oct 2026 09:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E342C1F01825;
	Thu, 29 Oct 2026 09:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265261;
	bh=MXKA7Lhy3ZJNDjxfGFebHTx4UQI2cu9qz5i4buDKwpc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YqPcCaF5bpxObU/xQXwEhh8K1pV0+cDCBbPXjlaW3Ux3RLNTxOi80H93PGQ3Sv7gC
	 1mpbSumivoLMwlPwZAYVKkFfjfyOg4wRoUN62qcco625tbkhxsqsku9AH+osNqstUx
	 yQZ7hzWvHU1jU/kxVV5C6TAtmZClcAG7BsTtICewJrf6RFn0CyygByYqCalWQP+Wtr
	 UZphswv7iZQptWOEhBlIbYf52C6BGsm6eu9oF5tDXFVQGEaw9TZ/XDxdqJWAhjPbHU
	 tovUaII8UDNJErHKjHzBU/FDFnSGz8G2rBPz1BTLguGI51uMvZrlwbN6A/emhzeGiI
	 wDWEP5gc2d+lg==
Message-ID: <sashiko-outbox-189009@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/liveupdate: Preserve VM workspaces with
 run-vmtests.sh -k
To: "George Guo" <dongtai.guo@linux.dev>, pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org, shuah@kernel.org
Cc: guodongtai@kylinos.cn, kexec@lists.infradead.org
In-Reply-To: <20261029090542.13283-1-dongtai.guo@linux.dev>
References: <20261029090542.13283-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:14:20 +0000
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
> run-vmtests.sh -k keeps the test output logs, but vmtest.sh still
> removes its workspace and qemu.serial, losing the guest output needed
> to debug failures.
>=20
> Forward -k to vmtest.sh when keeping logs and update the help texts to
> match.
>=20
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029090542.1328=
3-1-dongtai.guo@linux.dev?part=3D1


