Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61657C982FF
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 09:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P6ZIStLe13F9+IEhFgWAmfeV8KvN9bBmU0oNpKNZKz0=; b=fMGgc4EPTVV88Fc6dmjfwePzJ1
	R0LP1DNY3HTsO1MtXsSXTuw3i6IvSjyyB9KAYH01uahM/TU9dTtZUgotsLXGJVZ/TxjKiBqjvYa11
	MzZFGkme8vQ05/fyvNpKoUYzk7zf+VJA2OcyKAAKshJMqF2IxfltgAyOJA4zywfrOwMEs5CFOJ8Se
	aXCqvknrlhRuuZd9wn7l/AfEQ/CXLyEZIrYoTEXywRzmwOM0erfNQ+ymKqU6BQBJPLSWBV/sLfyNF
	5/0RBVu612K2vf/dlhE8b8PkiPhD6cPl0j+CSyqEgRMJLmW8IBIarH6MzR9AbPQ599FXKbb7wwO8/
	a/+ToXBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8ad8-00000001ZXu-2uqi;
	Mon, 21 Sep 2026 09:48:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8a5G-00000001TDa-31xE;
	Mon, 21 Sep 2026 09:13:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C55B0447BF;
	Mon, 21 Sep 2026 09:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0A81F00899;
	Mon, 21 Sep 2026 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789981989;
	bh=P6ZIStLe13F9+IEhFgWAmfeV8KvN9bBmU0oNpKNZKz0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PppuWxQJKHoapfcOZ30hzQM6stx9pvdYb0iP5RCVos4bWWyMp2tUc+UKk78wNflkr
	 mAcR+1udALmuvYeXt3XZ68KLQruIJp5QseLO8HmvvZRjI50jC3vPIw76Z9/rQ1BdL7
	 Tv7UqqrkClXkDZgXM27TcTKF74zd419tu0rkSqQKNbbOXP5lyJXxkwhYciODTmZqoP
	 dRuKoxXt/D0AtemjRV1cM6kg3SBzTbtbGCqWys71V/5YyBHFWj9t1EWpxhCEAjNwUg
	 OfFRkvzI3+0ZHWw0TJjJ9X3syCl+J3H2W+X5qUE6Mf95lC+mJKuoe1BZvZWZqJb654
	 G4GynZC1CxzKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/14] LoongArch: kexec_file: Fix CMA page leaks in
 segment placement retry loops
To: npiggin@gmail.com, ritesh.list@gmail.com, sshegde@linux.ibm.com, piliu@redhat.com, guodongtai@kylinos.cn, will@kernel.org, eric.devolder@oracle.com, vishal.l.verma@intel.com, maddy@linux.ibm.com, mpe@ellerman.id.au, bp@alien8.de, kai.huang@intel.com, chao.gao@intel.com, robh@kernel.org, seanjc@google.com, dakr@kernel.org, pasha.tatashin@soleen.com, kernel@xen0n.name, rppt@kernel.org, zhangtianyang@loongson.cn, hbathini@linux.ibm.com, baoquan.he@linux.dev, james.morse@arm.com, thuth@redhat.com, loongarch@lists.linux.dev, yeoreum.yun@arm.com, coxu@redhat.com, chenhuacai@kernel.org, akpm@linux-foundation.org, kees@kernel.org, jbouron@amazon.com, pratyush@kernel.org, me@linux.beauty, mark.rutland@arm.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, sourabhjain@linux.ibm.com, linux-arm-kernel@lists.infradead.org, graf@amazon.com, gregkh@linuxfoundation.org, liukexin@kylinos.cn, x86@kernel.org, mclapinski@google.com, ruirui.yang@linux.dev, takahiro.akashi@linaro.org, hpa@zytor.c
 om, rafael@kernel.org, palmer@rivosinc.com, dave.hansen@linux.intel.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, maqianga@uniontech.com, tangyouling@kylinos.cn, bgwin@google.com, driver-core@lists.linux.dev, catalin.marinas@arm.com, tglx@kernel.org, mingo@redhat.com, leitao@debian.org, linux-kernel@vger.kernel.org
Cc: ruanjinjie@huawei.com, kexec@lists.infradead.org
In-Reply-To: <20260921090450.807575-7-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:13:06 +0000
Message-Id: <20260921091306.BE0A81F00899@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D6


