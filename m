Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4136606A31C
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3OGkFuBn;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M/4Jl9ek
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kfSBBnGxSjLrvTHN/Ds7hv3IQF3K7WsEHZpavk/9GtI=; b=3OGkFuBnVYIKRF9BDPb/+ozCuy
	ODOSVPGIYymTlKion+UD+gvZsO/C3Kpk1TFU1Ad4WzmGpWmlY62cbCUlvzvQIm/3S1n57xRRPWjD2
	7vISzqobPePZCDVgEEaT+upjDNx+P5si4RjV3fq14HUgos+3bNiK0xNxx6cFQYAFbzLCP7nQ3Uq0+
	D2jlIR3UtnllOdFjmqL+gEDogzxKGqVBF2GEBI6oeksCI0SESAKldSsAwCiKhCNXPYzl8tH2bc2J3
	Kr4vVmHMx3UkOMuOHeiR1KErd62luD+x5VgF7puddx6k9Dfl/oGOW5H0UQDxFHrSLkLPvJ0EC7jOV
	2sdScKiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDi-0000000A0Ma-25h0;
	Thu, 29 Oct 2026 17:47:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMUDf-0000000A0Ji-45JY
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 17:47:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6162B605C4;
	Thu, 29 Oct 2026 17:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2FC1F01816;
	Thu, 29 Oct 2026 17:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793296039;
	bh=kfSBBnGxSjLrvTHN/Ds7hv3IQF3K7WsEHZpavk/9GtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M/4Jl9ekeOJkY8vY+08lrM/8iZbxSfUrUKQDbuCfyspnFB3oIvMi+U02TZyuqSm9L
	 IMVT0K18XZClDYeP/mNfYh/7vyWUTEZR3ygr9L2upRUnVTts+SNKl83t8IB/pZM89o
	 lgsywgvqsMxK70CJutqgHsgqs4jNNcRbbaJbPFuBDQ0H383fJH2Y/DFQkMJNoGQgx2
	 /HpMvPqOkxY30oNASZjs0cjmgOc/0kQretN3KXEwQ1KldM/OmvccMLVqH9mkL64LLQ
	 CIddCDVsgwMmqypW/DztgaCfDD1wlCq/EhYaxgc1KKOQGzihY/MElm530FR+YOZCEO
	 gJ4VXzSg1QQQg==
Message-ID: <sashiko-outbox-189749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/8] LoongArch: Enable kexec handover (KHO)
To: "George Guo" <dongtai.guo@linux.dev>, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, chenhuacai@kernel.org, ardb@kernel.org, shuah@kernel.org
Cc: ilias.apalodimas@linaro.org, akpm@linux-foundation.org, baoquan.he@linux.dev, ruirui.yang@linux.dev, guodongtai@kylinos.cn, kernel@xen0n.name, graf@amazon.com, liukexin@kylinos.cn, kexec@lists.infradead.org
In-Reply-To: <20261029172956.20791-7-dongtai.guo@linux.dev>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
 <20261029172956.20791-7-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:47:18 +0000
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
> Enable ARCH_SUPPORTS_KEXEC_HANDOVER on 64-bit LoongArch with EFI_STUB.
> KHO state is passed through an EFI configuration table installed by
> the stub.
>=20
> Disable KHO at boot if the table is missing, since the kernel cannot
> pass KHO state to the next kernel without it.
>=20
> Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029172956.2079=
1-1-dongtai.guo@linux.dev?part=3D6


