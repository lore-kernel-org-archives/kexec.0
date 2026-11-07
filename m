Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3E0606A32C
	for <kexec@archiver.kernel.org>; Sat,  7 Nov 2026 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qVQtpLxx;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFJ68Weq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3SbSLWa3/UK6mexUVV8tIWXqS/MPcEGjXIMKd9XhGv8=; b=qVQtpLxxQuRmz/yguRuQ+cNMEG
	RnXm3LNRLP9/V9MzCvEZtlYCgkOotvrF5CebOaHSlHZLzlgl6QOwRCDy+aLt8FThK2HJnD1bquosd
	8czhIi3yFgp11xj35SepbQbBeN/zfUXFyWNQzZDNxs4XGQY540d2agd1MmZkm/CWDDB6p9/3Ms+w/
	QyMrYxtQ2vZgA/863u5dYu+OcVraPSQwJPvZd/hDQCkUdswUFxJDyd4Iu0g/afx7Pqj1KcOabvEW3
	byuir33+3xI/o+yX3A5aoFfFr0/T0po5w0fTuctDop0MtnORnFPJEuCOpomxMVcCItpDbmsl4fEyg
	KV6l7EVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPaeN-0000000EIy5-0Gzb;
	Sat, 07 Nov 2026 07:15:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPaeI-0000000EIwx-0G2j
	for kexec@lists.infradead.org;
	Sat, 07 Nov 2026 07:15:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0369660D96;
	Sat,  7 Nov 2026 07:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2408E1F0089F;
	Sat,  7 Nov 2026 07:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794035736;
	bh=3SbSLWa3/UK6mexUVV8tIWXqS/MPcEGjXIMKd9XhGv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VFJ68WeqWYitNyeCi5PUjkN16i88RbK5kDjWj+Frxv8u5vLELEPkwYVL4+MOWM3mj
	 HTjweX0X+Jbj9n/0c90Elv/eusJtlTTKfWVr0/iQfozkruHj6fvx+XAhYT5Jb45gbk
	 oEWcR28IAu1xsbc+06tchQRwlPoU/tfPkdG58crryfzeObAbzAe/FoJdiB46dIFTpl
	 qGl3uv6DUBnv2NOJC6RqqE+hxi8qXQiml1B6y4T2WKKWc++qJ+E90vLXILudIRaqcr
	 9swFZcb/0EFeAlrZ1yvXXqzuai2eYpr3TrDBw/444WO+ckq6KGlQugAMimEGhNMZBq
	 l5yqMAFZDm9FQ==
Message-ID: <sashiko-outbox-202685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] selftests: liveupdate: Add riscv support
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261106071459.2003-5-cp0613@linux.alibaba.com>
References: <20261106071459.2003-1-cp0613@linux.alibaba.com>
 <20261106071459.2003-5-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 07:15:35 +0000
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

> Teach the live update vmtest runners about riscv64, so the LUO tests can
> be run on this architecture.
>=20
> LIVEUPDATE depends only on KEXEC_HANDOVER, enabled for riscv64 by the
> previous commit, so nothing in the tests stood in the way.
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106071459.2003=
-1-cp0613@linux.alibaba.com?part=3D4


