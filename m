Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8F9606A338
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T0u958Bp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nAhVXvzC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ylMAasGLBe1UBExKZfXHtgaSjDMzOhHHdLoDYukBrDI=; b=T0u958BpMp8yU8RLdJSpHdLbhx
	HlImf5m9w85+r/asRP1+46GMU6ARPt7jJn2vse6deX+y3Dsrr6UWHHTvqIfhz1M4I9MX7IQvBoHQL
	vfiZnTnq0BrfatW5IoWxgzB9LYjh119MWEWjHkDp2R06MVvjQNMbqpSQerjhXyCkSlOXiU/T8iuo0
	2qgU9Ah+l80BkGY+D5aZh7taKWvX8QOaN8uMapqfmvFABht3xKhXjt7H5/ob/aomJvGWePmRzLS0+
	+fsKNThanHrXnNs9mrIHVGz092bedIu90RbGfDyr0Px3nggFITsnrsMq77xpCOkAbwsLY0lOd1OSG
	3c4jfH+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdj-00000008z14-1Z2H;
	Thu, 12 Nov 2026 07:54:35 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdQ-00000008ynM-21hD
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 07:54:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E1338638DB;
	Thu, 12 Nov 2026 07:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D62A1F00A05;
	Thu, 12 Nov 2026 07:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470055;
	bh=ylMAasGLBe1UBExKZfXHtgaSjDMzOhHHdLoDYukBrDI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nAhVXvzCGhoYHnBvNc9kPKTs57KxAG8vTK/RkQSxezJs7bKftUf3+nZuvVvsDuVNL
	 TcIZRHiRnjm08Y/HfhKPQnCTUCOrvfxb6a+OMCK5dSeEl130FpY7O00vthO1xfpRSp
	 Kdx20OZOG+G3ARh2LQuKhm3EvBBCzDpteciAXyvlzVS/fNHc9E/ciH3q7v3LqqF+vB
	 JhHhErpkG0TBzPki5MfGpRaYd1rKmu2aRHehwtnLR87vPiLM2k2naME1075CAVRaj7
	 YjXT8t8mQ45PfDsaqKhCXYY8amxkuhNSU+7P0LUp9QbqUTlvXKGlS8u3zRNmO08JxD
	 PeW52ZZGnJYTg==
Message-ID: <sashiko-outbox-210645@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] selftests/liveupdate: Check handover revival,
 sequence and memory stats
To: "Chris Down" <chris@chrisdown.name>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>
Cc: "Alexander Graf" <graf@amazon.com>, "Baoquan He" <baoquan.he@linux.dev>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, kexec@lists.infradead.org, kernel-team@meta.com
In-Reply-To: <738fbfd19034ce495de9b22c705a7815a236907d.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
 <738fbfd19034ce495de9b22c705a7815a236907d.1794383544.git.chris@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:54:14 +0000
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

> Extend the handover stats test to cover the new files. On the first
> boot, kho_incoming/state should be none, liveupdate_num 0, and both KHO
> sizes 0. After the kexec, the handover should be revived and
> liveupdate_num should be 1.
>=20
> restored_size should grow by at least a page each time a memfd is
> retrieved or dropped. The memfd in the unclaimed session is retrieved
> last, once everything else is done.
>=20
> Signed-off-by: Chris Down <chris@chrisdown.name>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794383544.gi=
t.chris@chrisdown.name?part=3D9


