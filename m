Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7939606A31C
	for <kexec@archiver.kernel.org>; Fri, 13 Nov 2026 03:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WjbBA/2A;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akJvFzgj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/lhy3mQAcxc5Y5NULZ0nT1g8k3EgLv5L4Umye4uqBkA=; b=WjbBA/2A/FrDv9TzeXaPd4E1oc
	CVzzTqNLj2z2cF1XTllD3G1SquY2WNqk6UOij2ZTVEPLgtcSQpnTrCSMpSr6BnJQ5PZZIKmvKigb9
	+5vwhnxlxoE7YyjMIQjXuaN4iSLxVd945FkTJYhTkBZpDYprMKnjziqjqRiY6QadL+Xiv2nbmB4uD
	Ch9xBmOdgv5noc40hxAPl3fjCsJNq5O+OViMJLUrcBya9Y5k6Fur9zL1pI7RfpDBMdJS8F9hCtUww
	ehPhzdeRl+tYI0rFyEvDyCsI/w4H5WuLWIBCmm83mNr+Zg1CTa2kPsie4nHv6wM+kI7EeMHYtP2JN
	iyp0eGEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRiQT-0000000BcHN-1R79;
	Fri, 13 Nov 2026 03:58:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRiQS-0000000BcH6-14fa
	for kexec@lists.infradead.org;
	Fri, 13 Nov 2026 03:58:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9EAEC43DB8;
	Fri, 13 Nov 2026 03:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA6E1F000C4;
	Fri, 13 Nov 2026 03:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794542287;
	bh=/lhy3mQAcxc5Y5NULZ0nT1g8k3EgLv5L4Umye4uqBkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=akJvFzgjWxx2yC9UVlAvukso2qFNL/Z4aHLD+nf6YGt2iaqiXHl5ng2CKgvV359Z5
	 l1kKSIqHsybVCpnjvl97EGetZR+dJYuDuV8TkV8LernTww04NR5dtpaX+ZdrobYklh
	 t6R97CIqVCClar/oZ6JpomLvJvTnIyjWq7jAnJo/nc+m/XqIpv6i/cCHpGWNmVBnMY
	 VHgxxkUgrw6NDWPqwek2uGu2K//susdURJDs2toQuNpFmJ0OwrMzHBgoKpxua48pn4
	 l8AVRwxy0JTPsOoG8wKcVlRSE/vHRPT6oNSCY3TXWcFKHWLp1Mlt/MQqPI5hjNRTfm
	 OSc4+DT/KsSWw==
Message-ID: <sashiko-outbox-212141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] x86/crash: Disable SGX in the kdump kernel
To: "Yuanhe Shu" <xiangzao@linux.alibaba.com>, jarkko@kernel.org, dave.hansen@linux.intel.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc: x86@kernel.org, kexec@lists.infradead.org, challvy.tee@gmail.com
In-Reply-To: <20261113035019.3747461-1-xiangzao@linux.alibaba.com>
References: <20261113035019.3747461-1-xiangzao@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 03:58:06 +0000
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
> Clear X86_FEATURE_SGX from an x86 early handler for elfcorehdr=3D, which
> only the capture kernel receives, so sgx_init() bails out on its
> existing capability check and no kdump knowledge leaks into the SGX
> code.  Like nosgx, it has to be an early parameter: clearing a feature
> after alternatives are patched is too late.
>=20
> Reported-by: Challvy Tee <challvy.tee@gmail.com>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113035019.3747=
461-1-xiangzao@linux.alibaba.com?part=3D1


