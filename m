Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DB0C369D8
	for <kexec@archiver.kernel.org>; Wed, 23 Apr 2025 17:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6IXCMUb2kBaypBhK1E9/jBAgwvvd2mUR0F/oKSn3hIg=; b=BsxqZdX18mz15uZ0L1JCItfxOg
	25jF6TYREUou/1pADbMrysVTuZNbWCkjC5ARILeOV/hIxP6Uk1uff0fphzxtkTnp3Sbu9nwn4xGgV
	pkeeERFAHcIT2AW20NyBZWoPKgUpjEDnB4YvDeqaFEUkNkr81Rr18zyZilNyI+FCvrGtKQt1hVMz7
	dz21EjNUTuaRiFzEXWrcL+kgXWZhMQvKqOtBvf45rJ6TEjtN09gZppq85TfASB+tviHECo9NFD0NK
	w0caCeKu6WuziZ5xm9y5r0bWLq2z1SqEUn5s0JCDi1r6AbHadm2VSvz/wTsHfQKLlxKONL9G4cuNd
	3LeeJzPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7e8c-0000000BNgn-3Fyt;
	Wed, 23 Apr 2025 17:43:58 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7cii-0000000B54V-3Yb2;
	Wed, 23 Apr 2025 16:13:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0F0A0A4BD0E;
	Wed, 23 Apr 2025 16:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CBEC4CEE2;
	Wed, 23 Apr 2025 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745424787;
	bh=qPSQAD2Y9bqIez7eGCC7SKF6Tbh2sTpbA4yJxoW7bq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQiUG03EYGwTvFI3DcCHA6nOyTKie3dRrnZmNXRmy5GurLVN5HcsXW78RZOmrxRGm
	 7c3RgNw9XV/+D8i0JJcaJNsBpN4jVI73YjUjHxZPSH8ezk8NnOw1C8wsSnAVbaP3gy
	 KW5pLaDI30qxa0OLrg97SLLMtinva9njxKbvgWWRkVllE5N/9XKd3B7/zNqjALB6XI
	 coGhXOyFjiWE/V87L/WEojik/n9Zi9KhDSZCgcxRzeLVpCxQTmgvZmKZ4dqLdOVY0H
	 4BPXEiwCSojI+i5yFP22Qb8oiOHHWCXrA+kbR3+mFS49pZXdrerwSfx4hCArEa6xov
	 nzVpeXfizsLcA==
Date: Wed, 23 Apr 2025 17:13:03 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Nick Kossifidis <mick@ics.forth.gr>,
	Song Shuai <songshuaishuai@tinylab.org>,
	Li Zhengyu <lizhengyu3@huawei.com>, kexec@lists.infradead.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Dave Young <dyoung@redhat.com>, Yixun Lan <yixun.lan@gmail.com>,
	Xianting Tian <xianting.tian@linux.alibaba.com>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/4] kexec-tools RISC-V port
Message-ID: <20250423161303.GZ2843373@horms.kernel.org>
References: <20250422162304.169431-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422162304.169431-1-bjorn@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_091308_953506_8358C7A2 
X-CRM114-Status: UNSURE (   8.16  )
X-CRM114-Notice: Please train this message.
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

On Tue, Apr 22, 2025 at 06:22:56PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Hi!
> 
> *Patch history*
> 
> v1: https://lore.kernel.org/kexec/20250409201428.648717-1-bjorn@kernel.org/
> v2: Added Github Actions support for riscv64 (Simon)
>     Sorted filenames in Makefile (Simon)
>     Added missing dist files (Simon)
>     Fixed mips build (Simon)
> 
> Here's a passed CI run with this series on master:
> https://github.com/bjoto/kexec-tools/actions/runs/14597988952/job/40948715214

Thanks Björn, and everyone who got us here.

I have applied this patch-set for inclusion in v2.0.32.

- x86_64: Use the x86-64 level for purgatory
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=14f48ea80e51
madeliefje ~/projects/kexec-tools/kexec-tools git kexec-tools-applied-log  -4
- RISC-V: Support loading Image binary file
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=b257f311f5f0
- RISC-V: Separate elf_riscv_find_pbase out
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=363087cd156f
- RISC-V: Enable kexec_file_load syscall
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=027e6e237427
- RISC-V: Add support for riscv kexec/kdump on kexec-tools
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=b3fd54b022fe


