Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4B0C982F8
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UDxOdOM4SxQI/SRvITcvClpR4kJ1LyTAVJnnNy5mOjQ=; b=KGtSxVnUUIoq0v2T/eZPo0UtoQ
	FHWDd3/sVLtksvh1v5rfD14WinfYArmFjOf2TuRVGEQfsNDO2knjfWgwMCJruf8ZGfZoW2y5iOH+w
	yogJ1cGXyFJMUR3ycs4d8HeOwmNuCiBNDj7XubGk+eA+mv3N2VJM6IOyCz4u+8x++dqkWZxZtrlzy
	NT3lLCNt5BLhClVqsrirXAH4tBPwUSdphVn/xET8X9XVSQ4nk6EoIn8td0TKFcAMIq+juHh2WkihI
	T+0SZCmkubiP1LNEVjSdgSUwpOMoGsWgAHxvXFQmrF11Qjt/7L6IUbJ8oVxZuAfLP6HE9oIw2j4Ev
	ClbxCtgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4Y-00000000MnA-1wKf;
	Sun, 20 Sep 2026 20:23:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Ve9-0000000E4yN-40ye;
	Fri, 18 Sep 2026 10:16:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6584A60A5F;
	Fri, 18 Sep 2026 10:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27101F00898;
	Fri, 18 Sep 2026 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726605;
	bh=UDxOdOM4SxQI/SRvITcvClpR4kJ1LyTAVJnnNy5mOjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qh+PxjuhUYtQuTeeOL6D5uiL1736me4lgCC18Dyr540KpX1gn7g2viekAqDkINVeW
	 V16ZuYKknpyPGGG3APdOEwuMAA9Mi2X01p1YlM68ibSO/A8gHWKdpYguVle1KPxGUW
	 SwSHBlhTwmXypnGgRbnUrfbCkHZj8vLURNJsaxUScCCy2zq0L8WhG7YW/LanxlaQ30
	 Y9ixgrAUskPcxu43UTAsVmm1yKlQoJ86LJsqXWxWO2wBCStypE1LKZLL4qmNA3jhPT
	 N93ecpuLle22qWqJDfk1PgsNhWBnUkKlE/ktYVKnz6zp5EwRIw2pWOt96ZTKfbwF6+
	 Dj/abVCxxaFWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/17] kexec: Record allocated CMA pages to fix
 release size mismatch
To: gregkh@linuxfoundation.org, dakr@kernel.org, maddy@linux.ibm.com, mingo@redhat.com, bp@alien8.de, ruanjinjie@huawei.com, ardb@kernel.org, robh@kernel.org, vishal.l.verma@intel.com, me@linux.beauty, kas@kernel.org, bgwin@google.com, linux-kernel@vger.kernel.org, chleroy@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, will@kernel.org, rafael@kernel.org, lizhengyu3@huawei.com, hpa@zytor.com, yeoreum.yun@arm.com, tangyouling@kylinos.cn, graf@amazon.com, eric.devolder@oracle.com, sshegde@linux.ibm.com, kernel@xen0n.name, loongarch@lists.linux.dev, gshan@redhat.com, thuth@redhat.com, linux-mm@kvack.org, sourabhjain@linux.ibm.com, hbathini@linux.ibm.com, ritesh.list@gmail.com, mark.rutland@arm.com, adityag@linux.ibm.com, guodongtai@kylinos.cn, catalin.marinas@arm.com, maqianga@uniontech.com, seanjc@google.com, kees@kernel.org, dave.hansen@linux.intel.com, ruirui.yang@linux.dev, x86@kernel.org, palmer@rivosinc.com, piliu@redhat.com, pratyush@kernel.org, james.morse@arm.com, tglx@kerne
 l.org, jbouron@amazon.com, zhangtianyang@loongson.cn, driver-core@lists.linux.dev, linux-arm-kernel@lists.infradead.org, chao.gao@intel.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, liukexin@kylinos.cn, linux-fsdevel@vger.kernel.org, blum@kernel.org, npiggin@gmail.com, leitao@debian.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, pasha.tatashin@soleen.com, mclapinski@google.com, chenhuacai@kernel.org, coxu@redhat.com, takahiro.akashi@linaro.org, akpm@linux-foundation.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-3-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:16:41 +0000
Message-Id: <20260918101641.D27101F00898@smtp.kernel.org>
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:20 -0700
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
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D2


