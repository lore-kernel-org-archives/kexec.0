Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAE1606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DAx3oW/r;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0j0ykaK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=agY1ETCyQoba1/v/GqxeoqOZ1g8oW5mdZRdy+racjUk=; b=DAx3oW/r/W6D6cWuuru/t4tS36
	4ZXbts0JpvatJrJ4bf/76N2N9SaFCZbsZv00G4dzoG8fqxENEUxdwBPKWGQdmLYdYTIVXnI5xvDBY
	bNMBkDzHIiopbizpnVA4Uqr0vgPhgod6MbKFgSR8nOdWLtDK6tTpCm14/MLEfWG521yDwmjZT4Xak
	M9xQiDsOS6aDzDgOQQ8+vELK14T+Er0V4J51kqotkz0X6N7UzHA4fOWJjEXFooti66Auj7n5uj7ex
	3Jj1wjofc21LEmFghgw35uTfsHqityJX5ugojdykkGdNmu8k9IDSxnwY3l1JtrZ2x1DKvzDpRepMm
	8ZiNmsgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLI7j-00000002HA0-3MDk;
	Mon, 26 Oct 2026 10:40:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLI7i-00000002H9u-2kOa
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 10:40:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B6699601EF;
	Mon, 26 Oct 2026 10:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFB31F01825;
	Mon, 26 Oct 2026 10:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011213;
	bh=agY1ETCyQoba1/v/GqxeoqOZ1g8oW5mdZRdy+racjUk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Q0j0ykaKBuGb3D1ZyfmtnfYGVcyJOho8LvIpc+1qnvZNNx+JRJf14MmsmdOKSV+Xj
	 yI3cELlgHfr+YIawPuFKaVUrHap5DuoVCT8snWerTb5dfTm3mAWPzLSmXb/xNT8jKP
	 b0EGB7IlHDFf03FdH45Ubp/fLoETAPimddIqtVkpBEWCM8SWvH4jIu3i+/f/W2yNcv
	 QpBAfLkMDKDo2UmHX9s4NRi0UHPphmRDFiE9+CaM5LDRCNvlkmpLzWqHG8aqpPdBxe
	 2yiFtyfcyQkdIOMyyOAT7v7CUf1TS5hDMqwNCCL+Y/1O2fCELH9c1nLCKdNFHS9rnD
	 bvnW/eYjzcfmw==
Message-ID: <sashiko-outbox-184977@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/15] LoongArch: kexec_file: Simplify
 load_other_segments()
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, vishal.l.verma@intel.co
 m, piliu@redhat.com, jbouron@amazon.com, mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-10-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <20261026075201.699550-10-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:40:10 +0000
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Pass the kbuf fields to crash_prepare_headers() and set
> elf_headers before kexec_add_buffer(), so the error path needs
> no vfree() because arch_kimage_file_post_load_cleanup() will do it.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026075201.6995=
50-1-ruanjinjie@huawei.com?part=3D9


