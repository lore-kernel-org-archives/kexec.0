Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D018D39422
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qniXyQQp8BhF/swyXeMAfDNlEpa6S16iQqUUNsxIcDE=; b=Q2GzVGPBdc0a15WDjTCdmy6ijG
	EQ1ZKnGUZ5qsfhE6DnhfYU+DiErtF2C5c51MVzZHqdGr7Ehe6oHyoRloJ+Kewjp/44fx0pSRpWNVK
	5Xt9HdNY/g9830ROJKjNKIeJZ9awRaIajkpWv5qIBxG+cYPRBbIozOsX+UCfD23mMjmLde5sG5Av0
	PuGvo5Q5IikpQpOL6Wppbjd/eDElFzaoyqjfE15M5MEB4q2BpowMu7HH82O882s3Dm0L0CvlGp2Pu
	vR4O47uR541RGyx1nupsXAT3TKAi2+0dtQH5bGYPFcGGmFP0UUHu4sjO3+PIX6X/oCu+sANUZBkge
	D1H8svDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HFu-000000004Bw-31vb;
	Thu, 02 Apr 2026 12:34:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5btu-00000004eIZ-22Zi;
	Thu, 26 Mar 2026 04:00:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5CC7760053;
	Thu, 26 Mar 2026 04:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADB9C19424;
	Thu, 26 Mar 2026 04:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774497652;
	bh=a9nj8mR0F2lI5537jnvwaS2ZWg+dPzAdFfkxncY9zlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h2qifna9aaXJnfak9+pSw26tlqsP2LAwzpD3dGgF05NQHoCHdNDKGEZMoI/Wk5xcR
	 KnLZv/LqxdRIns2Nlqb3FxRXxGoEPhC72JtyPQx0VyGaV3MLE4ojcsuotrtL3JM21n
	 PkhEdBR8W4hregCpzSCNr/8OKlRFhBrzKXyzsukU=
Date: Wed, 25 Mar 2026 21:00:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
 <kernel@xen0n.name>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
 <npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
 <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
 <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <robh@kernel.org>,
 <saravanak@kernel.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
 <dyoung@redhat.com>, <rdunlap@infradead.org>, <peterz@infradead.org>,
 <pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
 <dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
 <paulmck@kernel.org>, <lirongqing@baidu.com>, <rppt@kernel.org>,
 <ardb@kernel.org>, <leitao@debian.org>, <osandov@fb.com>,
 <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
 <sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
 <eajames@linux.ibm.com>, <songshuaishuai@tinylab.org>,
 <kevin.brodsky@arm.com>, <samuel.holland@sifive.com>,
 <vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
 <liaoyuanhong@vivo.com>, <jbohac@suse.cz>, <fuqiang.wang@easystack.cn>,
 <guoren@kernel.org>, <chenjiahao16@huawei.com>, <hbathini@linux.ibm.com>,
 <james.morse@arm.com>, <takahiro.akashi@linaro.org>,
 <lizhengyu3@huawei.com>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <kexec@lists.infradead.org>
Subject: Re: [PATCH v10 0/8] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-Id: <20260325210049.28cca592a001e745954b3241@linux-foundation.org>
In-Reply-To: <20260325025904.2811960-1-ruanjinjie@huawei.com>
References: <20260325025904.2811960-1-ruanjinjie@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:24 -0700
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

On Wed, 25 Mar 2026 10:58:56 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> And add support for crashkernel CMA reservation for arm64 and riscv.

So who is patchmonkey for this.

>  .../admin-guide/kernel-parameters.txt         |  16 +--
>  arch/arm64/kernel/machine_kexec_file.c        |  39 ++-----
>  arch/arm64/mm/init.c                          |   5 +-
>  arch/loongarch/kernel/machine_kexec_file.c    |  39 ++-----
>  arch/powerpc/include/asm/kexec_ranges.h       |   1 -
>  arch/powerpc/kexec/crash.c                    |   7 +-
>  arch/powerpc/kexec/ranges.c                   | 101 +----------------
>  arch/riscv/kernel/machine_kexec_file.c        |  38 ++-----
>  arch/riscv/mm/init.c                          |   5 +-
>  arch/x86/kernel/crash.c                       |  89 ++-------------
>  drivers/of/fdt.c                              |   9 +-
>  drivers/of/kexec.c                            |   9 ++
>  include/linux/crash_core.h                    |   9 ++
>  kernel/crash_core.c                           | 105 +++++++++++++++++-

Me, I guess, with as many arch acks as I can gather, please.

I'm seriously trying to slow things down now, but I guess I can make an
exception for non-MM material.

AI review asks a few questions:
	https://sashiko.dev/#/patchset/20260325025904.2811960-1-ruanjinjie@huawei.com

Can you please check these?  And I'm interested in learning how many of
these are valid.  Thanks.

