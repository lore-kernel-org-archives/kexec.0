Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3563606A33C
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KoChjvAL;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9z5ralE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hJLlZx2YIS9DHlasCEnfXFVk3g+evmE5pSTCKI3NJ7c=; b=KoChjvALUny7GOn4GmBm/b+oJQ
	NmNco2+PD3j98wjNGk5/v/Iqgzgum6D9mW26tDF+t6QRW5huZbaZlsquVUrijkT0aqu8KXR6eWpft
	Dp9NHOfmVuxUV6rtELZSLXQNouheUlQNw8zSSBEEf90dPM6M5zgR0U3yEpymGLHfKvwXC8H1nhDwp
	+XSCT+HsVO8J53AqosbM0CP7NeGzQwgBi8MiEj7OH8Ji5ryuFSPwdI8Mn8XQ+w7tB543vjmOYdLXt
	FKS8AUPcWwAcEU9I8mRt/XXuGjhcC8hxxDS3M6L8m4iBSANiFDOa5bdZGoJOli1fZeF6kcCbKoifu
	bDMts5fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOW4d-00000004eZ8-3B9D;
	Wed, 04 Nov 2026 08:10:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOW4c-00000004eYh-3z66
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 08:10:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B15AC40BAC;
	Wed,  4 Nov 2026 08:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D501F0093A;
	Wed,  4 Nov 2026 08:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793779822;
	bh=hJLlZx2YIS9DHlasCEnfXFVk3g+evmE5pSTCKI3NJ7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g9z5ralErCaK/y8yw52tn0JdzvEnjp+Sft75nzmAj9waOflPUHW5G73nn9ctvnmuF
	 qikWlBeISYYkQkffTOFnD8TyHZZ3nXSiPp5Z6ZNcvXc2ExFNb9+IXeGbUxIeUZ7EWX
	 lZ5Vfyh5t0jGu1ERWqkKYkNpzkyqAaAUAW87pL7Zf768CAqBaG2FxrEuwfAbVeFa6i
	 XBIWwhbq7hjN20Js7F5SsAsaUTCUYxbvoWLkLcN0AWvsCfVuuNvRFtOhvzprzBINQ+
	 VBUGEDUQiVFlz1MFLsrYSYm7aSyfJQGG6w2uLjCkc7/Qy4+z/FWmdZZCcK4Qtk29Wb
	 MKrDEeq8NuFjQ==
Message-ID: <sashiko-outbox-196855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] kho: Do not translate the handover FDT address
 in is_kho_boot()
To: "Chen Pei" <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org
Cc: guoren@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261103080926.2079-2-cp0613@linux.alibaba.com>
References: <20261103080926.2079-1-cp0613@linux.alibaba.com>
 <20261103080926.2079-2-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 08:10:21 +0000
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

> is_kho_boot() only has to say whether a handover FDT was recorded, but
> it asks kho_get_fdt() for one and so converts kho_in.fdt_phys with
> phys_to_virt() just to throw the pointer away. Both callers use it as a
> boolean and never dereference the result.
>=20
> On riscv64 that conversion is not valid yet when efi_init() reaches it:
> setup_vm() leaves kernel_map.va_pa_offset at 0 and setup_bootmem()
> assigns it later, so a handover boot that came through UEFI panics in
> linear_mapping_pa_to_va(). Only debug builds fail -- without
> CONFIG_DEBUG_VIRTUAL __va() degenerates to "phys + 0" and the boolean
> stays correct -- but the panic also goes unnoticed without an earlycon.
>=20
> Check the physical address instead. Nothing needs the translation, and
> architectures stay free to bring their linear mapping up whenever they
> like.
>=20
> Fixes: d6d511639185 ("kexec: introduce is_kho_boot()")
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080926.2079=
-1-cp0613@linux.alibaba.com?part=3D1


