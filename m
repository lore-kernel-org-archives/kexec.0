Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F06C982ED
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ci45NQJUg16aZt0y5PeWLAJ6VMj1xm674PK6gI0wb/I=; b=EK0lGqAmoO8x4ifTEGv+uihe7S
	xo2ObEMr6P5XByF/thIVX+mluGpSddFSws02sZzTsvsMX8BBADqv/1dw7X5ji/cYDgW3b9OLkzwVW
	4X3AWb9UCo86oCYkZ8IEpX8XTJgjPBGKjoiXNeobrTIQKyZaBuYgCZaj/ozO1/tDqqof9UZ6by1Do
	fUeNfo4b11FDZ6TiHelOgAe++9H+zFysBO9lXWLbXxRBmCiqM5m9JgNXqsN5JxKa6bVhg1u9WD3OL
	NpxkTDvIx1A5+7421NEQwPkaIR/QR0IS3+W91fSDmBr4pawwhNBs9lcw+rjp1qlc81MxEBpD2H6Tq
	T7JinAdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ad9-00000001ZYV-0A3l;
	Mon, 21 Sep 2026 09:48:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8a5c-00000001TGN-3UPI;
	Mon, 21 Sep 2026 09:13:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D7ED42A4E;
	Mon, 21 Sep 2026 09:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7991F000FF;
	Mon, 21 Sep 2026 09:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982012;
	bh=ci45NQJUg16aZt0y5PeWLAJ6VMj1xm674PK6gI0wb/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BQm7ODC9zYGHKV67q4Nfd43WItBUGZ+KMMxaKTqYb5AhTE8ADj41mMaTjg3RxBvWI
	 glxoDGBTc459VqLuYagv74owIjybea8BCkEyHEdwCmH/VGab6tEu/+hGad9cF4E+ue
	 xDuvLwRpwfVs5i/zBUDnnOntEVtA5B9SkCoPsl4itcUYjcAYbm9Hf9Rp7M8PO1dSc/
	 KFDzRwjifRSqZchkKanhAtrLnZM5sa5GozgtkNjqy+1fiUofkSE87lzR6WP99e4rDC
	 04xzaQbnncwm12YgbDEScupqgAvEzFrU8YDNxRun5O3k9l5kAvSR6W5ZWdMEB6okYN
	 1cZfCEFxPvvyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/14] kexec: Extract kexec_free_segment_cma() from
 kimage_free_cma()
To: dakr@kernel.org, hbathini@linux.ibm.com, npiggin@gmail.com, maqianga@uniontech.com, vishal.l.verma@intel.com, baoquan.he@linux.dev, piliu@redhat.com, ruirui.yang@linux.dev, linuxppc-dev@lists.ozlabs.org, pratyush@kernel.org, maddy@linux.ibm.com, bgwin@google.com, robh@kernel.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, mingo@redhat.com, me@linux.beauty, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, yeoreum.yun@arm.com, mark.rutland@arm.com, eric.devolder@oracle.com, coxu@redhat.com, chao.gao@intel.com, ritesh.list@gmail.com, kees@kernel.org, liukexin@kylinos.cn, leitao@debian.org, sourabhjain@linux.ibm.com, tglx@kernel.org, kernel@xen0n.name, bp@alien8.de, loongarch@lists.linux.dev, rafael@kernel.org, seanjc@google.com, dave.hansen@linux.intel.com, palmer@rivosinc.com, pasha.tatashin@soleen.com, rppt@kernel.org, driver-core@lists.linux.dev, kai.huang@intel.com, graf@amazon.com, jbouron@amazon.com, guodongtai@kylinos.cn, thuth@redhat.com, chenhuacai@kernel.org, linux-arm-kernel@lists.infradead.org, hpa@zytor.com, gregkh@linuxfoundation.org, akpm@linux-foundation.org, sshegde@linux.ibm.com, will@kernel.org, x86@kernel.org, mpe@ellerman.id.au, chleroy@kernel.org, mclapinski@google.com, tangyouling@kylinos.cn, zha
 ngtianyang@loongson.cn
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-4-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:13:29 +0000
Message-Id: <20260921091330.2D7991F000FF@smtp.kernel.org>
X-Mailman-Approved-At: Mon, 21 Sep 2026 02:47:56 -0700
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> kimage_free_cma() relies on image->nr_segments to iterate over segments.
> When an architecture loader (e.g., arm64) truncates nr_segments on a
> mid-way failure, CMA pages allocated beyond the new boundary become
> unreachable, causing silent memory leaks.
>=20
> Extract the per-segment freeing logic into the exported helper
> kexec_free_segment_cma(), so that architecture loaders can release
> individual segments before nr_segments is truncated. Refactor
> kimage_free_cma() to loop over the new helper, preserving existing
> behavior.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Breno Leitao <leitao@debian.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D3


