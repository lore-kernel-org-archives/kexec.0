Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E90D606A33E
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KmdV/kS6;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jP4OKh7H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PPiBMtJIKW/moYswxjinN6dVXaSLhaP7OGRjSGdQY6k=; b=KmdV/kS6sMJxOq15wUMiDZApTB
	OlIFTtKHM1w/ejp4Ah3OHS7qb7VCxRqpUY49n+JD89EhGnEIY0YWLqBYF9KfVJf024q360eW458yA
	WZedhD0VUk8/ul7h70VxS2fKMC2/V06XP1Ppq7wEu4SxoSb7tWpyUDCSXUZjRil8YRTur67TOWC2z
	hYk9fyZD1z2rPXbxvwqXE3uTarj7rr87hjUoIuGkn3aGk0dM/AH05i+wY+bc9lpOa7TNCfPK/byq2
	ERxdhQlzoy/dP3AdYzMSL/ehuqGuir7VzlZfFcp9RIjNQAGP5dyxyUexIzz2jPUgIyJbIod/FbUgA
	/xjv5x3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSLW-00000009aM5-0wTO;
	Thu, 12 Nov 2026 10:47:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSLQ-00000009aKV-0jlD
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 10:47:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AAA4245111;
	Thu, 12 Nov 2026 10:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B851F00A06;
	Thu, 12 Nov 2026 10:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794480471;
	bh=PPiBMtJIKW/moYswxjinN6dVXaSLhaP7OGRjSGdQY6k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jP4OKh7HK6XFNFcvXRxCGaB1HKFn9CWFrMMX4D45tNsv1DrJSgolIJ/Mn9OyH5cI1
	 yU5hReLm5qilFH1YPf265Ncb4Lj4fjCMB82jHPNp2auHCyGrmg+dASpLn88NDEk7hu
	 Mu8MLQGxBP2ww/ZjOriwIlcB8wQ1+MkkByoXFOacCnfJvDu+DrLRAHUCCzGnWpohoS
	 aIMkpRDtTxsBMBPCGWoyiDyDgtWxeftjm4C8xEekuKUv04AJ4lV4pCpmSgpjQRjhXz
	 AhVnLyEvXOj4UeIaKhVYjc/33RDTjrFzltUVIQBFDmaptW7YkqdT7lzd6zac7xbPKW
	 zBbJ/RpQTT9dw==
Message-ID: <sashiko-outbox-210970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] kho: walk bootmem areas in address order
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>
Cc: "Alexander Graf" <graf@amazon.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Chen
 Pei" <cp0613@linux.alibaba.com>, "George Guo" <guodongtai@kylinos.cn>, "Kexin
 Liu" <liukexin@kylinos.cn>, "Randy Dunlap" <rdunlap@infradead.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Sourabh Jain" <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org, "Jose
 A. Perez de Azpillaga" <azpijr@gmail.com>, "Mukesh Pilaniya" <mpilaniy@redhat.com>
In-Reply-To: <20261112-kho-bootmem-sizing-v3-2-f0c8d00295d5@kernel.org>
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
 <20261112-kho-bootmem-sizing-v3-2-f0c8d00295d5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 10:47:50 +0000
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

> kexec_add_buffer() users may depend on the order in which memory holes are
> searched. For instance, arm64 places the kernel bottom-up and then
> requires the DTB to be above the kernel.
>=20
> kho_walk_bootmem() walks the bootmem areas in the order they were
> reserved, so if the kernel lands in a small area at the top of the memory
> there is no room left for the DTB and kexec fails. For example, on an
> arm64 VM with 2G of RAM and kho_bootmem=3D8M,64M,64M, the lowmem area is
> reserved first at the top of the memory, the kernel image takes most of
> it and kexec fails with
>=20
>   kexec_file(Image): Could not find any suitable kernel location!
>=20
> Sort the bootmem areas by address and walk them in ascending order, or in
> descending order for top-down searches, like kexec_walk_resources() does.
>=20
> Fixes: 3bdecc3c93f9 ("kexec: add KHO support to kexec file loads")
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Reviewed-by: Mukesh Pilaniya <mpilaniy@redhat.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-kho-bootme=
m-sizing-v3-0-f0c8d00295d5@kernel.org?part=3D2


