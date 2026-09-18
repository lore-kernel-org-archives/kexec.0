Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5CBC982EB
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LUkDSbiAS248nMrWXNTNmtWkBultYX6rVLee+4HO2Ss=; b=cVEfCcf3HCpdr8o0D9NHhGAi9d
	6VbLtaZuIUaAYOhO3a/ee+3MvrGZdaI1ns8t7ElrW8JbqkmUGVNHhxwOur5Wq7EVP8NwxO/EO7MkV
	OyoZu/2vbCJouxbv0088JiPDze7RgAVmCZOUtK9awLioN1RcQcu/PYQLs+sr8TEL0i3NAFdTzh2dQ
	P2KU9q06EEIG5J7b+Fu/ovVOHTDdbM895aoR25jRQg1GT6rIO/zdxha1JV1YKeShcmh91K+fEpC84
	m8CURh25PLF3lVFScnod73F//rYATxTK11lbx90JBDFyi1huoK3/s+Ga4Lbt5OPAr0hQFrgGxjEjw
	kru3ClGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4m-00000000NKD-0OFT;
	Sun, 20 Sep 2026 20:23:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7VoQ-0000000E5ku-0WIh;
	Fri, 18 Sep 2026 10:27:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C4F5142E96;
	Fri, 18 Sep 2026 10:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789961F000FF;
	Fri, 18 Sep 2026 10:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727241;
	bh=LUkDSbiAS248nMrWXNTNmtWkBultYX6rVLee+4HO2Ss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Du4xoU7XjcM1TU6N/dTK544nfxc5Xy4BGBBLWmcwaBcwvbxAkfkHsVFrdqrAPsSNR
	 Snp5SQgQywMHtT1ZKAD43KdCSFT61Wt+I/i//Tba+e+t/o/RERKfZj8UnuqflMPSL5
	 ZmWlhVxdVtD7qwnw/a2BcP2WEBdw1L0n1RWhDgC0dZMVpk5r1PDqcihr9V0X5Zr8Be
	 O7jQ7y50yEdU+BmUnsJ/aCm5tAaCmg21Vg6fHxN3SuCeKnMkicaeMaKAlCbh1TiAVS
	 /bUGsZMlSdpCGcZHfnhBCEDyjCUSVrCSdPi1aHOlrHCZfjUtHuUzjSKPie2NGP+BB3
	 ZbhYbBud2KtTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/17] arm64: kexec_file: Simplify
 load_other_segments()
To: npiggin@gmail.com, vishal.l.verma@intel.com, kernel@xen0n.name, rafael@kernel.org, james.morse@arm.com, tangyouling@kylinos.cn, sourabhjain@linux.ibm.com, leitao@debian.org, coxu@redhat.com, palmer@rivosinc.com, linux-arm-kernel@lists.infradead.org, blum@kernel.org, baoquan.he@linux.dev, x86@kernel.org, jbouron@amazon.com, lizhengyu3@huawei.com, hbathini@linux.ibm.com, seanjc@google.com, dakr@kernel.org, sshegde@linux.ibm.com, pasha.tatashin@soleen.com, gshan@redhat.com, ritesh.list@gmail.com, piliu@redhat.com, chao.gao@intel.com, driver-core@lists.linux.dev, kees@kernel.org, kas@kernel.org, bp@alien8.de, mingo@redhat.com, bgwin@google.com, linux-kernel@vger.kernel.org, chenhuacai@kernel.org, linux-fsdevel@vger.kernel.org, maqianga@uniontech.com, zhangtianyang@loongson.cn, catalin.marinas@arm.com, maddy@linux.ibm.com, akpm@linux-foundation.org, yeoreum.yun@arm.com, loongarch@lists.linux.dev, ruirui.yang@linux.dev, graf@amazon.com, takahiro.akashi@linaro.org, mpe@ellerman.id.au, g
 uodongtai@kylinos.cn, linux-mm@kvack.org, gregkh@linuxfoundation.org, pratyush@kernel.org, liukexin@kylinos.cn, robh@kernel.org, dave.hansen@linux.intel.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, rppt@kernel.org, ruanjinjie@huawei.com, mclapinski@google.com, thuth@redhat.com, adityag@linux.ibm.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, mark.rutland@arm.com, will@kernel.org, hpa@zytor.com, me@linux.beauty, ardb@kernel.org, eric.devolder@oracle.com, tglx@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-17-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-17-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:27:18 +0000
Message-Id: <20260918102718.789961F000FF@smtp.kernel.org>
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

> Use `kbuf` fields directly in crash_prepare_headers() to eliminate
> the local variables "headers" and "headers_sz"..
>=20
> Advance the assignment to image->elf_headers before
> calling kexec_add_buffer(). If kexec_add_buffer() fails, the explicit
> vfree() in the error path can be removed, as the global infrastructure
> in arch_kimage_file_post_load_cleanup() will handle the cleanup.
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Breno Leitao <leitao@debian.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D16


