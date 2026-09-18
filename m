Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2944C982FA
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ifyrwe6h27+ZjrRKqNws8Hoy5jINQJxAWqPe8NSyJco=; b=J1qlYJknpzogxDAfVh7hxNf4VB
	3RjOnVh9Zt039UwrCj+snBR2tdAkd5SQRtoBxBf/tgJe+tseKoz9RAsyrrI48G41sHQm1e8d3ySsW
	TbrCD+AVsA0NZeg+EGgpInZQpi6h658hTAy0UQBFK2QOVKdzT7yW9AyOm7EPED2/aAHfFKnHLL7/i
	obhfCFGVF+ahrf6pZZIkDCTJBATisbpeyGpIZ3pOj93fmzbDZDpP1Ce1i1OZlxnD774zKZztfwWWb
	hQipXluFVm/8rnKZDu+JZn0LYK6VR7MueoKCdza0mRoOAB2FDUzGCTTbO1pYDzuYSb2fmrPsDqlA4
	qU5G4fUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4d-00000000Mxn-3gHs;
	Sun, 20 Sep 2026 20:23:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7VeM-0000000E51F-0pH2;
	Fri, 18 Sep 2026 10:16:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B9FF843CCC;
	Fri, 18 Sep 2026 10:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667AE1F00899;
	Fri, 18 Sep 2026 10:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726617;
	bh=ifyrwe6h27+ZjrRKqNws8Hoy5jINQJxAWqPe8NSyJco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BMj01AlhbDDpoLoXxwn9PPhookstPQzvNzHcu3cfhmO/Vm1xskm1uSEn1VcRtOM63
	 v4FbuEGxl6N6K4hGy9mp3VPfdcYEi9Lt7ZAbiZrOOZJ0H76sH7Yfj41EFFY4kifUUJ
	 U1nyr9h3Wc6OFP7bzybInQVTbPMdB7n385RxAbDMpf0E0z2qmIOuSmMJLA0mzCgRn0
	 REbqAaRoOj6TTCGDA3UVM3ORDYou5nsQBAirRmO25yhfVyCRZefWSTyLWDBVZMDXh7
	 ivKDTJnqkoWlyNwdABc2086K40l/8qfUK9FEg1TIu4WwHLNY/RUoSJ/8Qc7TZFokWg
	 jmShFPclYOnug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/17] LoongArch: kexec_file: Fix CMA page leaks in
 segment placement retry loops
To: maqianga@uniontech.com, mpe@ellerman.id.au, akpm@linux-foundation.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, graf@amazon.com, vishal.l.verma@intel.com, me@linux.beauty, mclapinski@google.com, hpa@zytor.com, sshegde@linux.ibm.com, yeoreum.yun@arm.com, pratyush@kernel.org, eric.devolder@oracle.com, gshan@redhat.com, bgwin@google.com, guodongtai@kylinos.cn, ruirui.yang@linux.dev, ruanjinjie@huawei.com, kernel@xen0n.name, piliu@redhat.com, driver-core@lists.linux.dev, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, lizhengyu3@huawei.com, james.morse@arm.com, chenhuacai@kernel.org, sourabhjain@linux.ibm.com, adityag@linux.ibm.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, robh@kernel.org, npiggin@gmail.com, dakr@kernel.org, ritesh.list@gmail.com, takahiro.akashi@linaro.org, thuth@redhat.com, linux-mm@kvack.org, liukexin@kylinos.cn, palmer@rivosinc.com, rppt@kernel.org, x86@kernel.org, coxu@redhat.com, loongarch@lists.linux.dev, bp@alien8.
 de, ardb@kernel.org, zhangtianyang@loongson.cn, chleroy@kernel.org, chao.gao@intel.com, linuxppc-dev@lists.ozlabs.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, maddy@linux.ibm.com, blum@kernel.org, seanjc@google.com, gregkh@linuxfoundation.org, baoquan.he@linux.dev, pasha.tatashin@soleen.com, rafael@kernel.org, tglx@kernel.org, kas@kernel.org, hbathini@linux.ibm.com, tangyouling@kylinos.cn, jbouron@amazon.com, kees@kernel.org, will@kernel.org, leitao@debian.org, mingo@redhat.com
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-7-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:16:54 +0000
Message-Id: <20260918101654.667AE1F00899@smtp.kernel.org>
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

> During kexec image placement retry loops, any midway failure causes
> the loader to truncate `image->nr_segments` back to its initial state
> to purge the failed segments.
>=20
> However, this truncation introduces a memory leak. The CMA pages
> allocated via kexec_add_buffer() during the failed attempt are tracked
> in the `image->segment_cma` array. Because the subsequent cleanup paths
> only iterate up to the truncated `nr_segments` boundary, these allocated
> CMA pages outside the new boundary are permanently leaked.
>=20
> Fix this by explicitly releasing the associated CMA buffers in
> the failure paths before `image->nr_segments` is reduced.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Youling Tang <tangyouling@kylinos.cn>
> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Fixes: 55d990f0084c ("LoongArch: Add EFI binary support for kexec_file")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D6


