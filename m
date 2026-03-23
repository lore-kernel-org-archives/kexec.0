Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99585D39424
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BOjG5Ty6h1juqTAjGNHoKX4nftQIFtN1pMEnmQKVI5I=; b=K68IHxr7S9pa4FB31MYO870Tjf
	QOcN67y3Z1PXNCx17Lmv4vFPQgPISQEVRwbGa7zz8nWCrdzaG8DOZWA+4kppqR0MzWjuCXv3sixwY
	ogSWdSFQCmg3qn3FZb+MlYRWZ82dCfg85yfCuWBDdAE7z01pKsO/eDVQaR28awbRWtWc7lSnfFBhM
	5H5zQW7GgMlHH6e9ciHqBiRffMfE1+v9seQMI0cpWCOjupGh849S9V+dOxu98JlxLK+D+e2VICKKB
	7kfKYMwtkGiHI/4DGnaKvESrt8LJ+0iK7XKJu75iBo/8v13ecAkwoE4G8pE2j0HZUuOlBVLh6cOCE
	k+sZpkTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HFn-000000003wb-2ytq;
	Thu, 02 Apr 2026 12:34:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4iZE-0000000HB3q-2HPN;
	Mon, 23 Mar 2026 16:55:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4B45C60120;
	Mon, 23 Mar 2026 16:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F2FC2BC9E;
	Mon, 23 Mar 2026 16:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774284951;
	bh=0LuJYoTQTDvWV9NTWOPFuNPtv2UN3kOMEh+jhXWnc2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qgGXTep1YmJrPSvqa0ycQRzl2NPgm4AaiOcjYyoeytss6axGtvgS0EzKKZIBsxxsA
	 V6fyRWqr/ZIWLg5r94g6isrv7Lul5Ery6vKJi/XjccJ0tkvgqlQUYmdi/KPsKX+oSy
	 WOcrfjFCALXA7q5Zf2q/7NKZNQeM2jvJT0tXbqY8=
Date: Mon, 23 Mar 2026 09:55:48 -0700
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
 <feng.tang@linux.alibaba.com>, <pawan.kumar.gupta@linux.intel.com>,
 <dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
 <paulmck@kernel.org>, <lirongqing@baidu.com>, <safinaskar@gmail.com>,
 <rppt@kernel.org>, <ardb@kernel.org>, <leitao@debian.org>,
 <jbohac@suse.cz>, <cfsworks@gmail.com>, <osandov@fb.com>,
 <tangyouling@kylinos.cn>, <sourabhjain@linux.ibm.com>,
 <ritesh.list@gmail.com>, <eajames@linux.ibm.com>,
 <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
 <samuel.holland@sifive.com>, <vishal.moola@gmail.com>,
 <junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <liaoyuanhong@vivo.com>,
 <fuqiang.wang@easystack.cn>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <kexec@lists.infradead.org>
Subject: Re: [PATCH v9 0/5] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-Id: <20260323095548.fa4e13d6e8ae5005ae585e13@linux-foundation.org>
In-Reply-To: <20260323072745.2481719-1-ruanjinjie@huawei.com>
References: <20260323072745.2481719-1-ruanjinjie@huawei.com>
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

On Mon, 23 Mar 2026 15:27:40 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> And add support for crashkernel CMA reservation for arm64 and riscv.

Thanks.  AI review has completed and it asks questions:
	https://sashiko.dev/#/patchset/20260323072745.2481719-1-ruanjinjie@huawei.com

