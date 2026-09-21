Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2F5C982E1
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zko84IbjSpSVbu6MJAXmtfMpiKo1YS8MUshdlf8j2Mg=; b=l4Ou6n21nJL5WR6AtKRjXLCEEf
	1NJTM7QBfaBs/4STX0Ots9Se+xO+vah3A7ey86WdSaCASRBrZygqEc5eybHNrckCHYzOJzPEsdhvm
	u1s/2S9TElA3fmD6y7Xz3lhMhTS+KNZuLeILGZK+/zENigVVmhEFuene2J0S+3FkCwLnycutiXEnJ
	6mMPsSRnyGpOV3YEbDsjwiHSVSmHEyCCdosZ+v+M2TWCExXFCVW7OQBktNAg3vfl+90a19T7B4KPu
	5Z8Ew04QAI0A7kuYwa+r0/8a6jhfjBIH3o+gxOQ/JEmkFhiWzJUMsQr9XFZEJU4GpGaGVo+N9//KC
	A+R0ZLdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ad9-00000001ZaK-2oRj;
	Mon, 21 Sep 2026 09:48:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8a6r-00000001TSf-1wXA;
	Mon, 21 Sep 2026 09:14:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 37C2341ABC;
	Mon, 21 Sep 2026 09:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2761F00893;
	Mon, 21 Sep 2026 09:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982089;
	bh=Zko84IbjSpSVbu6MJAXmtfMpiKo1YS8MUshdlf8j2Mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YbmDc19pVl41nW9kuv93uhEHlhM/v+WaAWJ9m4SLnKvh1aNqKldO2WFZ8RlKUoo8K
	 ja8gNwEoFhEQED3ytCk8w6m78nujcqwmcNnvwUN937QUOBieV6pzw66CaVyATAvKWv
	 Wov7dlZAhGobnHj2/fsSFSgUeP9eDxTIivOPU6PyMvkjZtz42Nc7pgA+fy+Z5zOxjL
	 3F8jNT0HdjMOArL/aDzdaJBnTUsvZBBPGyGt6/T8i6E6yRBo/gjXO3LQeVxXqh1+pb
	 FzpD5+KAnowSeF0962ABOLblenxsOgdlhBPpVmj4XHZhZC/ZMAr3p1bAAlQTOh6y9b
	 E7cZo208OqNHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/14] kexec: Record allocated CMA pages to fix
 release size mismatch
To: rafael@kernel.org, eric.devolder@oracle.com, chao.gao@intel.com, ritesh.list@gmail.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, leitao@debian.org, sshegde@linux.ibm.com, kees@kernel.org, robh@kernel.org, loongarch@lists.linux.dev, chleroy@kernel.org, liukexin@kylinos.cn, x86@kernel.org, hbathini@linux.ibm.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, maddy@linux.ibm.com, guodongtai@kylinos.cn, mclapinski@google.com, gregkh@linuxfoundation.org, me@linux.beauty, pratyush@kernel.org, palmer@rivosinc.com, hpa@zytor.com, bp@alien8.de, vishal.l.verma@intel.com, bgwin@google.com, takahiro.akashi@linaro.org, chenhuacai@kernel.org, seanjc@google.com, dave.hansen@linux.intel.com, tglx@kernel.org, yeoreum.yun@arm.com, akpm@linux-foundation.org, sourabhjain@linux.ibm.com, driver-core@lists.linux.dev, mpe@ellerman.id.au, will@kernel.org, tangyouling@kylinos.cn, dakr@kernel.org, baoquan.he@linux.dev, graf@amazon.com, kai.huang@intel.com, pasha.tatashin@soleen.com, jbouron@amazon.com, mingo@redhat.com, ruirui.yang@linux.dev, rppt@kernel.org, kernel@xen0n.name, thuth@redhat.com, coxu@redhat.com, catalin.marinas@arm.com, npiggin@gmail.com, linux-arm-kernel@lists.infradead.org, maqianga@uniontech.com, piliu@redhat.com, linuxppc-dev@lists.ozlabs.org, james.morse@arm.com, zhangtianyang@loongson.cn
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-3-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:14:45 +0000
Message-Id: <20260921091446.3F2761F00893@smtp.kernel.org>
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

> The CMA pages allocated for a kexec segment are released using the
> segment's memsz to calculate the number of pages. However, some
> architecture loaders modify the segment's memsz after allocation
> (e.g. arm64 subtracts text_offset), causing the release function to
> free fewer pages than were originally allocated, leaking the remaining
> CMA pages.
>=20
> Add a per-segment `segment_cma_pages` array to store the number of
> pages actually allocated from CMA. Populate it during
> kexec_add_buffer() using the aligned memsz, and use it in
> kimage_free_cma() to accurately release all allocated pages.
>=20
> This avoids relying on the potentially modified segment->memsz and
> prevents silent CMA memory leaks.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Brian Mak <makb@juniper.net>
> Cc: Pingfan Liu <piliu@redhat.com>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Justinien Bouron <jbouron@amazon.com>
> Cc: Li Chen <me@linux.beauty>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D2


