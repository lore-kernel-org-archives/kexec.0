Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79665C3ABB0
	for <kexec@archiver.kernel.org>; Mon,  5 May 2025 11:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Su0CB7E4HC9/WWlzbe2XIcJkiCWHl72oeizXvrKmz4=; b=QX8O9Uy7DVXi/GHgcgzcH2q5v6
	loWMIBm+T8pNLXVA0+z6OlX4CiCrs3uAYGh17xy3nKzxGeIZD+HiUtT/pOWzylTzfOzmcLWRlflYX
	xBCIjX4divfJdzq6JaxEh/pZbWV23G8wlJ3PW2ofrAwJXoqVVhGr2L7YHJbALpqm/hWsfMS2mclPl
	OGvTiFH7nOcZuSPhhN402Y91qJAga1VwbZbrClIDrdhwhyaf+TJpsD93/huYbCJe75zXy7HuI4hsI
	j0AVn+rXp+51qkgh2Ioe42kgr6PYhrjhDc8DZSrFlU8r3kZtIuaCJoeGY2pCiyJS1aOA4wCaBl0oc
	mz/Rt5oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBtbq-000000076JM-3gjm;
	Mon, 05 May 2025 11:03:42 +0000
Received: from mailgate-4.ics.forth.gr ([139.91.1.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBtbi-000000076I2-44mr
	for kexec@lists.infradead.org;
	Mon, 05 May 2025 11:03:39 +0000
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
	by mailgate-4.ics.forth.gr (8.16.1/ICS-FORTH/V10-1.8-GATE) with ESMTP id 545B3Ev41638301
	for <kexec@lists.infradead.org>; Mon, 5 May 2025 14:03:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
	q=dns/txt; i=@ics.forth.gr; t=1746442994; x=1749034994;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/SZ9Avu0vKWcNbLi+LaanXc+moBJXBj6ksLSRUR8oHc=;
	b=Fx6gBNHobNIQn0ItDj/3C8fPX7nWTGtb0CtOwN827/9vZviPLaFPhXERChoo1lbR
	272ogFUe9LqToUMg2xLJtSFECk/SbICB8/88gp01D/fKj/Xd1/i/CQsIPAi0eEI1
	nWuBqX6B0AkW+0D9OvbMCYerKG5tOKhdkMb94bxiUmgP/9PUXaBEk7XhBsmTf3cf
	7T8uVO1G6Esxn0uU0ri20dq9KawCGcQYzREbiczwcPgj3hksVGscybrh/thVXMa3
	DTCMk3Zb3nO55jKP62kYAPZqPLvYlOa8Rec1qUut4tYWze8wKxTvpjvN+S1pI8co
	L6tf4rsbLp0Z9vnkB1YK3g==;
X-AuditID: 8b5b014d-b8599640001fc5c4-f8-68189af2e145
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
	by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 89.56.50628.2FA98186; Mon,  5 May 2025 14:03:14 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <d7cff5d9-e36a-4b7f-95c4-9f5d170f2c46@ics.forth.gr>
Date: Mon, 5 May 2025 14:02:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] kexec-tools RISC-V port
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Simon Horman <horms@kernel.org>, Simon Horman <horms@verge.net.au>,
        Song Shuai <songshuaishuai@tinylab.org>,
        Li Zhengyu <lizhengyu3@huawei.com>, kexec@lists.infradead.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Dave Young <dyoung@redhat.com>, Yixun Lan <yixun.lan@gmail.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linux-riscv@lists.infradead.org
References: <20250422162304.169431-1-bjorn@kernel.org>
Content-Language: en-US, el-en, el-GR
From: Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <20250422162304.169431-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsXSHT1dWffTLIkMg5fbxC22vl/FYvH2xitG
	i4aJDSwWj/pPsFk0b/3KaLH79Fcmi22fW9gsrv8MtPj+5w6Lxf6OhWwWX7fNZXbg9tg56y67
	R8uRt6wem1Z1snnsfGjpsXlJvcf7fVfZPG7MivDY03ua1WPOz28sAZxRXDYpqTmZZalF+nYJ
	XBmNi76yF5zQqti/8CxzA+NqhS5GTg4JAROJKed/sHcxcnEICRxllFi8o4cVImEpsfnTSxYQ
	m1fAXmJz83uwOIuAisS/09OZIeKCEidnPgGrERWQl7h/awbQIA4OYQFjiYeTXEFmigj8Y5R4
	s+cqE4jDLPCcUeLd9A6wBiEBM4nnZyeBDWIWUJWY/2wT2AI2AU2J+ZcOgtVwCphLbPj8hQmi
	xkyia2sXI4QtL9G8dTbzBEaBWUjumIVk1CwkLbOQtCxgZFnFKJBYZqyXmVysl5ZfVJKhl160
	iREcP4y+Oxhvb36rd4iRiYPxEKMEB7OSCG8LMMaEeFMSK6tSi/Lji0pzUosPMUpzsCiJ856w
	XZAsJJCeWJKanZpakFoEk2Xi4JRqYNI44fvkpcXPsh6pvVs3BBsIJs5lXZkqH70uzFjiyUYJ
	QYXZD6dk7m9zWu1j97s5Or1Ok8Nmx/8M8c7OUrfe1ylqj7xfVKoHXZ15g0OvoHLer7UnSmec
	3fC17N8LgSQdiZirVlOf2rstfnHN8sPf14XaNzw/f3i/T7NJWqO6bUuq3/2JzYwl9j2T7I/M
	Fdz40sG693FxJ39HnLHafHe7mSZXhW6/eWbVfPlt5fe8fQd+Lve/cE9ryWmBKW0qYTz5Ta6m
	tlN2Z9V1pe2X/RbmKZjoFvhncq7HierFBYYmC7TmGXfsaZk6J3+69AGxyAemIULbvnBM5T6x
	dK/l/hMZya63VzSef+tn4txYdaj6gRJbcUaikamZFnNRcSIAmtwzDhADAAA=
X-Greylist: inspected by milter-greylist-4.6.2 (mailgate-4.ics.forth.gr [139.91.1.7]); Mon, 05 May 2025 14:03:16 +0300 (EEST) for IP:'139.91.1.77' DOMAIN:'av3in.ics.forth.gr' HELO:'av3.ics.forth.gr' FROM:'mick@ics.forth.gr' RCPT:''
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mailgate-4.ics.forth.gr [139.91.1.7]); Mon, 05 May 2025 14:03:16 +0300 (EEST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_040336_080913_6EAF918E 
X-CRM114-Status: GOOD (  30.85  )
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

On 4/22/25 19:22, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Hi!
> 
> *Patch history*
> 
> v1: https://lore.kernel.org/kexec/20250409201428.648717-1-bjorn@kernel.org/
> v2: Added Github Actions support for riscv64 (Simon)
>      Sorted filenames in Makefile (Simon)
>      Added missing dist files (Simon)
>      Fixed mips build (Simon)
> 
> Here's a passed CI run with this series on master:
> https://github.com/bjoto/kexec-tools/actions/runs/14597988952/job/40948715214
> 
> 
> *Cover*
> 
> This is an attempt to finally get the RISC-V patches for kexec-tools
> upstream.
> 
> Simon suggested in [1] that:
> 
>> In my mind the big question is how to move RISC-V support from that
>> branch, to being merged into main.
>>
>> IIRC there were some issues that needed to be addressed. Perhaps they
>> are all addressed by this series, and with some appropriate squashing
>> we can move forwards with a series based on main?
> 
> I talked to Nick last week, and he suggested that we'd work the RISC-V
> collab Github [2], but I think it's just easier to do it on the list.
> 
> I've been collecting a number of different trees out there, and tried
> to group them in a series.
> 
> Given that there is not support for RISC-V upstream yet, I didn't see
> the need to carry all the fixes/updates ("development history") as
> separate commits -- it doesn't help bugtracking/bisectability.
> 
> Instead the first commit message is a big one, and tries to give
> attribution to all involved parties. Input/thoughts are very much
> welcome!
> 
> To properly test this on RISC-V, the upstream Linux kernel has most
> things in 6.15-rc1, e.g.:
> commit 28093cfef5dd ("riscv/kexec_file: Handle R_RISCV_64 in purgatory relocator")
> commit 3f7023171df4 ("riscv/purgatory: 4B align purgatory_start")
> 
> To cross-build kexec-tools:
>    | ./bootstrap
>    | ./configure --host=riscv64-linux-gnu
>    | make
> 
> For some tests, additional kernel patches are needed, that as of today
> is not in 6.15-rc1:
>   * To test "kexec -s -l Image", kexec_file_load with Image support is
>     needed [3]
>   * To test "kexec -c -l vmlinux" with CONFIG_RELOCATABLE, a kbuild fix
>     is needed [4]
>   * Typically if you load initrd, or a large kernel [5] (since a bunch
>     of Reserved regions are not properly exposed).
> 
> I've tested combinations with crashkernel (-p), and regular (-c/-s + -e) for:
>   * ACPI/UEFI
>   * DT/UEFI
>   * DT
>   * w/ initrd
>   * w/o initrd
>   * ELF (userland loader + kexec_load, and kexec_file_load)
>   * Image (userland loader + kexec_load, and kexec_file_load)
> 
> I'm sure there are combinations I've missed, but at least from my POV
> we're in a pretty good shape.
> 
> All authors: Please let me know if you prefer another split of the
> patches. Or something else for that matter! ;-)
> 
> 
> Let's get the ball rolling!
> Björn
> 
> [1] https://lore.kernel.org/kexec/20230920115634.GG224399@kernel.org/
> [2] https://github.com/riscv-collab/kexec-tools.git
> [3] https://lore.kernel.org/linux-riscv/20250409193004.643839-1-bjorn@kernel.org/
> [4] https://lore.kernel.org/linux-riscv/20250408072851.90275-1-alexghiti@rivosinc.com/
> [5] https://lore.kernel.org/linux-riscv/20250409182129.634415-1-bjorn@kernel.org/
> 
> Li Zhengyu (1):
>    RISC-V: Enable kexec_file_load syscall
> 
> Nick Kossifidis (1):
>    RISC-V: Add support for riscv kexec/kdump on kexec-tools
> 
> Song Shuai (2):
>    RISC-V: Separate elf_riscv_find_pbase out
>    RISC-V: Support loading Image binary file
> 
>   .github/workflows/build.yml             |   1 +
>   configure.ac                            |   3 +
>   include/elf.h                           |   1 +
>   kexec/Makefile                          |   1 +
>   kexec/arch/mips/Makefile                |   2 +
>   kexec/arch/riscv/Makefile               |  38 ++
>   kexec/arch/riscv/crashdump-riscv.c      | 140 +++++++
>   kexec/arch/riscv/image-header.h         |  88 ++++
>   kexec/arch/riscv/include/arch/options.h |  43 ++
>   kexec/arch/riscv/iomem.h                |  10 +
>   kexec/arch/riscv/kexec-elf-riscv.c      | 184 +++++++++
>   kexec/arch/riscv/kexec-image-riscv.c    |  95 +++++
>   kexec/arch/riscv/kexec-riscv.c          | 526 ++++++++++++++++++++++++
>   kexec/arch/riscv/kexec-riscv.h          |  53 +++
>   kexec/dt-ops.c                          | 442 +++++++++++++++++++-
>   kexec/dt-ops.h                          |   7 +
>   kexec/kexec-syscall.h                   |   7 +
>   purgatory/Makefile                      |   1 +
>   purgatory/arch/riscv/Makefile           |   7 +
>   19 files changed, 1648 insertions(+), 1 deletion(-)
>   create mode 100644 kexec/arch/riscv/Makefile
>   create mode 100644 kexec/arch/riscv/crashdump-riscv.c
>   create mode 100644 kexec/arch/riscv/image-header.h
>   create mode 100644 kexec/arch/riscv/include/arch/options.h
>   create mode 100644 kexec/arch/riscv/iomem.h
>   create mode 100644 kexec/arch/riscv/kexec-elf-riscv.c
>   create mode 100644 kexec/arch/riscv/kexec-image-riscv.c
>   create mode 100644 kexec/arch/riscv/kexec-riscv.c
>   create mode 100644 kexec/arch/riscv/kexec-riscv.h
>   create mode 100644 purgatory/arch/riscv/Makefile
> 
> 
> base-commit: 14f48ea80e510e5af79ca6c46fa28e99a3695d1c


Thanks for doing this :-)

Regards,
Nick

