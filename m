Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672A9606A31C
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2y2skYKW;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2E+xgKb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bA1vgK2W/Ee/fME19KIKTLyTNbbmAg5iHvGtvRAoK24=; b=2y2skYKWsy6fCMEUb+Hdywi37t
	Q+xwL9AfBebzgHYssED3M7UkbciD9h51sn+nqPiTIfHKO0r07ZtO0vp6L1T0zVUwfwMRg4ERnNKPZ
	6JLaoNEwHaVEvFtgYm3xGcc+YyTrKGcN9ETuCJ9rfJFtkZXZSi1ipvs1B+6DDXIm327UOhxB8xW8d
	oWs69+LDNCY6cCtNz7DfhrXdKAAswxTV5RKElqcBUcp3hk5XTaSnpfpHnjtDrQ910HqhZTw7Zu4BB
	04v1a7qCDQidrBoNsGau0dRMrr1GDC6NvIfacbsM/lFe8XujegslrGPAeL9Ck6ogXFPh3wU1iqcLt
	ZoPUxTbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR7q3-00000006jV4-3Tia;
	Wed, 11 Nov 2026 12:54:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR7q2-00000006jUl-2Xss
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 12:54:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C584161246;
	Wed, 11 Nov 2026 12:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067B01F00A05;
	Wed, 11 Nov 2026 12:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794401645;
	bh=bA1vgK2W/Ee/fME19KIKTLyTNbbmAg5iHvGtvRAoK24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S2E+xgKbBy0B/eQzJY20w15dr63RSglpuXFDsl24gbGUu50c2HQallFLgjk73sKw1
	 p9N3hy0JG8JWyBzDhDPSHJ3+wPdBovODYP5QN2Jw/ArVeXXujkPCS9ZLzTU6zhwtTT
	 VDwe1maVGGlnww55Tre0Bng0JsTSIXxYhaSF64bUAjH38sf807JQXs3YNda4tb798d
	 djS1MPPGfOIxjff9oygrahAn/FRF016Vk/oud3lLaaOl4QKHeHr7gKIMQKNznaici7
	 hFFrs14R3dJcj0fP4SIhjeV9T6fFkcPpVnZGCOR5ZGsuN7hAZF39v4z4ZW3LeLZomn
	 jg5z9jRXaHViw==
Message-ID: <sashiko-outbox-209022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/sgx: Skip EPC initialization in the kdump kernel
To: "Yuanhe Shu" <xiangzao@linux.alibaba.com>, jarkko@kernel.org, dave.hansen@linux.intel.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc: x86@kernel.org, kexec@lists.infradead.org, challvy.tee@gmail.com
In-Reply-To: <20261111123942.3842771-1-xiangzao@linux.alibaba.com>
References: <20261111123942.3842771-1-xiangzao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 12:54:04 +0000
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

> The kdump capture kernel cannot use SGX: EPC memory is e820-reserved,
> so it is not part of the crash dump, and no enclave will ever run
> during dump capture.  Yet sgx_init() runs unconditionally and pays the
> full EPC bookkeeping: sgx_setup_epc_section() allocates one struct
> sgx_epc_page (32 bytes) per 4K EPC page, i.e. EPC/128, plus a memremap
> of the whole EPC range.
>=20
> The capture kernel has no memory other than the crashkernel
> reservation.  On a VM with 15.5G EPC the bookkeeping alone costs
> 124 MB of vmalloc - nearly half of the stock crashkernel=3D256M -
> and the cost scales with EPC size, not RAM.
>=20
> That is enough to break kdump outright: with the default 256M the
> capture kernel OOMs in early userspace (udevadm and journald are killed
> before the root device is enumerated) and no vmcore is produced, while
> 512M works.  With this change the same 256M reservation captures a
> complete vmcore; SGX initializes as usual on normal boots.
>=20
> Reported-by: Challvy Tee <challvy.tee@gmail.com>
> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111123942.3842=
771-1-xiangzao@linux.alibaba.com?part=3D1


