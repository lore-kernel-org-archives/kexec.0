Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D673C5DF80
	for <kexec@archiver.kernel.org>; Sat, 15 Aug 2026 07:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=orBYolOiVh8P+Gs6dp8/inZibU5jKERhYsBdgyU7ewg=; b=V76Wp5dcvzlZmJmtfttc5vnul2
	eo6zOIywA1yWU28P+KR1DVZCIZ7ZZh3vuuumYoL7hBNJuvyYder6/uc78B2RnigK5HTYTjNpy7USz
	SmAIs7q7Vksr/cPV74XMa6AKU+202x1I2Jrcutbq7onREnBQ66VYDrmyOM49EY/kTei6cLNBIjABv
	/wNbTax3qx8sfj0BtF+lrTtQFiHuGg0E/hjhCwSBHO2+yq90s3Jgy9rsBz5MrujMw2nGF2pS3Nerw
	ga2FFXvbI22PquLe5NfvFRSLT3ly0nwvhHPQ+d0ks0lcswjn5hy8DXxWQuwRRFYaOsBtWOHbQXzXI
	FFKQF2hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv95M-00000003d0K-46iH;
	Sat, 15 Aug 2026 07:45:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weaj4-0000000HPfo-2Y3h;
	Tue, 30 Jun 2026 15:50:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id ED39040314;
	Tue, 30 Jun 2026 15:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272C01F00A3A;
	Tue, 30 Jun 2026 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782834617;
	bh=orBYolOiVh8P+Gs6dp8/inZibU5jKERhYsBdgyU7ewg=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=hYaFsO0FH9QTvOvjL+VAVldlJ2YPFGk7Uv9Z6QoYCVHtTYFvz5GLpT1JPoGmvuzja
	 MTy6IgtdK2zMOgBks1ci94yQnYzuxOJiLmpU/slEb508GaEKc1CAdIz3+/Zq6Bt0w9
	 2FVSSC8lyJ1ZeKB8y1XDpUIRQvZEcPOZths6ZliY3SggfKoZOFKnqpC88EFu33XLTW
	 sn6AnFxz4EW0LATrsCAmY8ssBo7Q13rik2AkR7zp8ALgguCfUFUhwRyu2d3NhQu+/K
	 Y2AM6LawUcaWvPp3WCkTdmmqcN+TndJjAv7WwB1TzTqCVHBCGCID2JuhETb5Xb/WQQ
	 rTUnWQuYsWNdQ==
From: Mike Rapoport <rppt@kernel.org>
To: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
 will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
 chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
 aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, 
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org, 
 saravanak@kernel.org, akpm@linux-foundation.org, baoquan.he@linux.dev, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
 rdunlap@infradead.org, peterz@infradead.org, feng.tang@linux.alibaba.com, 
 dapeng1.mi@linux.intel.com, elver@google.com, enelsonmoore@gmail.com, 
 kuba@kernel.org, ebiggers@kernel.org, lirongqing@baidu.com, 
 leitao@debian.org, kees@kernel.org, coxu@redhat.com, cfsworks@gmail.com, 
 jbohac@suse.cz, osandov@fb.com, ryan.roberts@arm.com, 
 tangyouling@kylinos.cn, sourabhjain@linux.ibm.com, ritesh.list@gmail.com, 
 gaohan@iscas.ac.cn, david@kernel.org, wangruikang@iscas.ac.cn, 
 muchun.song@linux.dev, vishal.moola@gmail.com, junhui.liu@pigmoral.tech, 
 guoren@kernel.org, namcao@linutronix.de, rick.p.edgecombe@intel.com, 
 djbw@kernel.org, liaoyuanhong@vivo.com, fuqiang.wang@easystack.cn, 
 vishal.l.verma@intel.com, chenjiahao16@huawei.com, x86@kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, kexec@lists.infradead.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260629094746.191843-1-ruanjinjie@huawei.com>
References: <20260629094746.191843-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH v17 00/10] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-Id: <178283459765.548295.14688999641870037803.b4-ty@b4>
Date: Tue, 30 Jun 2026 18:49:57 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 15 Aug 2026 00:45:40 -0700
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, 29 Jun 2026 17:47:36 +0800, Jinjie Ruan wrote:
> arm64/riscv: Add support for crashkernel CMA reservation
> 
> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> [...]

Applied to crashkernel-cma branch of liveupdate/linux.git tree, thanks!

[01/10] riscv: kexec_file: Fix crashk_low_res not exclude bug
        commit: 5fc6e7d45373571d03cd04fd4c6069c0a97fa75a
[02/10] powerpc/crash: sort crash memory ranges before preparing elfcorehdr
        commit: 202b5de3ec34317d6a8944239fe227ef8f6853ec
[03/10] crash: Add crash_prepare_headers() to exclude crash kernel memory
        commit: 5beabef0cffaa1ea6e27e85dbd526b7a28e0e7c7
[04/10] arm64: kexec_file: Use crash_prepare_headers() helper to simplify code
        commit: 201b561cbc6c594aa1ef718a1204dd45720d96dd
[05/10] x86/crash: Use crash_prepare_headers() helper to simplify code
        commit: a8f09f2a7485956c3653696f6cb94faadd243645
[06/10] riscv: kexec_file: Use crash_prepare_headers() helper to simplify code
        commit: 7b078a0aa2753dcf5cae88e5349a25ac39998a9b
[07/10] LoongArch: kexec_file: Use crash_prepare_headers() helper to simplify code
        commit: 51ed0950adf05c99e393818887a2616dd4ab3e34
[08/10] powerpc/kexec_file: Use crash_exclude_core_ranges() helper
        commit: b0e06c5a30742bc6bc8523fe9c71c1a043a7661d
[09/10] arm64: kexec_file: Add support for crashkernel CMA reservation
        commit: c12c63d05dfe7088aa8b1b872fe261e25537c823
[10/10] riscv: kexec_file: Add support for crashkernel CMA reservation
        commit: a037fe3c58ed489ca8ad8531bd7e16b90a84badc

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: crashkernel-cma

--
Sincerely yours,
Mike.



