Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC7606A897
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iu2uBQ53;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HI5PgIFD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aItCG7v4Qzr0TgruGz6V5P+IJSYmYHHZJH5GM2ptV0c=; b=iu2uBQ53n0bSgrDMCajeL7sMHQ
	yntjBPOBEV1gYgQUuazVSQuNselSw/8Geory8Z7qID4nulcpvxWTF6/aMBISAMoAPCRiD2w9dV5Sm
	jHeuCXBW/IcWy3aTwASn/4lTpOPubssm+vJPbInhzR/qKieYNAlybSxIY8X/ybnC35UwaDP84pcfe
	kIStJApEJ9H4fQv2g/yE3uWDbXOv6jVfUFGl5HAPpttDTvm4YXU+ErTV5h6iiDlz+TtjjH1g+3Obt
	OmP93yHhZASGpQU6W54TAQ+skHuZHbqLyeNPMP893S1fykNTBXKQD1Of784UoU4iG25BF4eF+jtw8
	J/vYwFjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSLV-00000009aKo-25R9;
	Thu, 12 Nov 2026 10:47:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSLP-00000009aKQ-1iX7
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 10:47:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AA78B61166;
	Thu, 12 Nov 2026 10:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34631F00A06;
	Thu, 12 Nov 2026 10:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794480470;
	bh=aItCG7v4Qzr0TgruGz6V5P+IJSYmYHHZJH5GM2ptV0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HI5PgIFDzx9rzV7upi1V+gC0NmnaQU0tYGe/NqduMvKMfORokMA09RoFpOdFmkmGo
	 ucLG7e+u/bPCSlgjcEUfNq3WumnSDnWRLDndV8FBeXlaI4SASCIXu+cdOUPTMJivw7
	 ixwmvvj9vh828nrVxDi9FomkqogUJ7ih/ntj2JfX4Uym0r2kz0NIJ3okunSHb0VlaD
	 scwPG38GFkUofTqlwabsiSANroStpnqReO7jJVP4sBNkhlDLDL1qG+YXRmeWVFEO6V
	 jb9k5hk8gJTVhoqkKtmJ4Q2STxJtY/thfWyhoZMoYA+J5IYBoFkJTn//jbpew+Nm03
	 /xMNNzm7+TnRQ==
Message-ID: <sashiko-outbox-210969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] kho: reject zero bootmem scale
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>
Cc: "Alexander Graf" <graf@amazon.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Chen
 Pei" <cp0613@linux.alibaba.com>, "George Guo" <guodongtai@kylinos.cn>, "Kexin
 Liu" <liukexin@kylinos.cn>, "Randy Dunlap" <rdunlap@infradead.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Sourabh Jain" <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org
In-Reply-To: <20261112-kho-bootmem-sizing-v3-1-f0c8d00295d5@kernel.org>
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
 <20261112-kho-bootmem-sizing-v3-1-f0c8d00295d5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 10:47:49 +0000
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

> kho_bootmem=3D0% sets bootmem_scale to 0, and then the bootmem areas are
> sized using the explicit sizes that default to 0. KHO remains enabled,
> but there is no usable bootmem to load the next kernel.
>=20
> Reject zero scale the same way zero explicit sizes are rejected.
>=20
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-kho-bootme=
m-sizing-v3-0-f0c8d00295d5@kernel.org?part=3D1


