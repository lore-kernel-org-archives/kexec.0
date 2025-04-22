Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E287C369D3
	for <kexec@archiver.kernel.org>; Tue, 22 Apr 2025 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZreUjKlu/dQC9h92l6N8/f/933XzabBi9R6XSKXnT60=; b=ZVhAM+JCkWPTCIBGyYzj6BqQ9Y
	gK+oVc4jz2Pt/AmwFfbswmQZrD8wI2O8bFY+b0BTXMosK6KsOSwmf+DG3SFB9b2KI+u0eQO8T0Q9M
	tOSINolSebUbTeb+fdiySQUwYq+zr2bvDqsSurefTER4mGINcG540/y89r7ATenHG2qFmh192JsSp
	a8IfzDZGDNzf/PiTSn1UmEfobMtVJS+5GzJU3aTiG3ihzWyXaCSmndo6/Pqeta1qu6cSXrugLHXJk
	O1NMhYqE+6XgCyacZV1/lPf58UIKR42Pveha8q/BB9cx0G3ZZ5G3+NZab2iH86X5unSyWaKZKPO5v
	sJ8/JvvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7DVb-00000007GNw-0G25;
	Tue, 22 Apr 2025 13:17:55 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7CPV-000000073V4-0Q1f;
	Tue, 22 Apr 2025 12:07:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4BC5BA4B982;
	Tue, 22 Apr 2025 12:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB08C4CEE9;
	Tue, 22 Apr 2025 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745323652;
	bh=8WW9OB6zuGleMgSTpkSvsmydzrgJKFfSC7PR7tvoUhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=n+QnN3QqdPlW9w6+THz//8BFiC/xzlKkG1GRTGM13ux+sysJWeOxftT3zB2O0Uq8K
	 +MlQxQgWanKWQtZmcLDcsLWUOnnDYT3uxQDcv2QmZ9LXBt88dZs73z7LQzhMfAF4NC
	 BDe59wLEhn37a0MKyOhpf4rBKLK3XIyLdpna36z/HqdURc/37QnTS4nV431DsVEwbx
	 lXDPDzFBeYGw5eKxZ1L2+8BzG084kHvuNyGBOgPZPsu7ynTeG4RDmqeIRUbyXzK56y
	 aoPFJSQZrX8OoU1OXHT06FqDD75L7YCqSMBTlZCJ3wmBDR40mmr9NpODuomymKD63Z
	 oUU4+U9RdhaNw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Nick Kossifidis <mick@ics.forth.gr>, Song Shuai
 <songshuaishuai@tinylab.org>, Li Zhengyu <lizhengyu3@huawei.com>,
 kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, Yixun Lan
 <yixun.lan@gmail.com>, Xianting Tian <xianting.tian@linux.alibaba.com>,
 linux-riscv@lists.infradead.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
Subject: Re: [PATCH 1/4] RISC-V: Add support for riscv kexec/kdump on
 kexec-tools
In-Reply-To: <20250422104825.GT2789685@horms.kernel.org>
References: <20250409201428.648717-1-bjorn@kernel.org>
 <20250409201428.648717-2-bjorn@kernel.org>
 <20250422104825.GT2789685@horms.kernel.org>
Date: Tue, 22 Apr 2025 14:07:28 +0200
Message-ID: <87bjso5ri7.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_050733_267124_1899104C 
X-CRM114-Status: GOOD (  30.90  )
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

Simon!

Simon Horman <horms@kernel.org> writes:

> Thanks Bj=C3=B6rn,
>
> Overall I am happy with this patchset. But there are a few minor points
> I'd like addressed, which relate strictly to build coverage and the CI.
> I can handle these myself if you prefer.

It's really up to you! What do you prefer? I can spin a v2 if that's
easier for you (and then I'll try to address all the things you pointed
out below)!


Bj=C3=B6rn

> Firstly, it would be really great if the following could be included at t=
he
> end of the series, so there is some build coverage of RISC-V in the CI.
> (Feel free to rewrite or attribute however you see fit - it is a trival o=
ne
> liner.)
>
> From: Simon Horman <horms@kernel.org>
> Subject: [PATCH] workflow: Add riscv64
>
> Add riscv64 to matrix of build architectures.
>
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  .github/workflows/build.yml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
> index fd9ea6c8eca7..d1b3e74391ff 100644
> --- a/.github/workflows/build.yml
> +++ b/.github/workflows/build.yml
> @@ -19,6 +19,7 @@ jobs:
>          - powerpc
>          - powerpc64
>          - powerpc64le
> +        - riscv64
>          - sh4
>          - s390x
>          - x86_64-x32
>
> ...
>
>> diff --git a/kexec/arch/riscv/Makefile b/kexec/arch/riscv/Makefile
>> new file mode 100644
>> index 000000000000..f26cc9025e77
>> --- /dev/null
>> +++ b/kexec/arch/riscv/Makefile
>> @@ -0,0 +1,35 @@
>> +#
>> +# kexec riscv
>> +#
>> +riscv_KEXEC_SRCS =3D  kexec/arch/riscv/kexec-riscv.c
>> +riscv_KEXEC_SRCS +=3D kexec/arch/riscv/kexec-elf-riscv.c
>> +riscv_KEXEC_SRCS +=3D kexec/arch/riscv/crashdump-riscv.c
>> +
>> +riscv_MEM_REGIONS =3D kexec/mem_regions.c
>> +
>> +riscv_DT_OPS +=3D kexec/dt-ops.c
>> +
>> +riscv_ARCH_REUSE_INITRD =3D
>> +
>> +riscv_CPPFLAGS +=3D -I $(srcdir)/kexec/
>> +
>> +dist +=3D kexec/arch/riscv/Makefile $(riscv_KEXEC_SRCS)			\
>
> kexec/arch/riscv/iomem.h also needs to be added to dist
> so that it shows up in the distribution tarball.
>
>> +	kexec/arch/riscv/kexec-riscv.h					\
>> +	kexec/arch/riscv/include/arch/options.h
>
> Also, it would be nice to sort these lines alphabetically.
>
>> +
>> +ifdef HAVE_LIBFDT
>> +
>> +LIBS +=3D -lfdt
>> +
>> +else
>> +
>> +include $(srcdir)/kexec/libfdt/Makefile.libfdt
>> +
>> +libfdt_SRCS +=3D $(LIBFDT_SRCS:%=3Dkexec/libfdt/%)
>> +
>> +riscv_CPPFLAGS +=3D -I$(srcdir)/kexec/libfdt
>> +
>> +riscv_KEXEC_SRCS +=3D $(libfdt_SRCS)
>> +
>> +endif
>> +
>
> ...
>
>> diff --git a/kexec/dt-ops.c b/kexec/dt-ops.c
>> index 0a96b75f65aa..3e285ab2043b 100644
>> --- a/kexec/dt-ops.c
>> +++ b/kexec/dt-ops.c
>> @@ -4,9 +4,11 @@
>>  #include <libfdt.h>
>>  #include <stdio.h>
>>  #include <stdlib.h>
>> +#include <stdbool.h>
>>=20=20
>>  #include "kexec.h"
>>  #include "dt-ops.h"
>> +#include "mem_regions.h"
>
> As dt-ops.c will now use symbols that are implemented in mem_regions.c
> when the former is compiled the latter now must be compiled too.
>
> In practice it is only mips where that is not the case.
> And I believe that can be addressed by squashing the following into
> this patch.
>
> diff --git a/kexec/arch/mips/Makefile b/kexec/arch/mips/Makefile
> index 1fe788608fbe..fa87fbdb7897 100644
> --- a/kexec/arch/mips/Makefile
> +++ b/kexec/arch/mips/Makefile
> @@ -11,6 +11,8 @@ mips_FS2DT_INCLUDE =3D \
>  	-include $(srcdir)/kexec/arch/mips/crashdump-mips.h \
>  	-include $(srcdir)/kexec/arch/mips/kexec-mips.h
>=20=20
> +mips_MEM_REGIONS =3D kexec/mem_regions.c
> +
>  mips_DT_OPS +=3D kexec/dt-ops.c
>=20=20
>  include $(srcdir)/kexec/libfdt/Makefile.libfdt
>
> FTR, I believe this is the same mem_regions_alloc_and_add issue that
> I flagged in the thread [2].
>
> And at the link below you can see a build failure with this patch, but not
> the fix above, applied:
>
> https://github.com/horms/kexec-tools/actions/runs/14591381633/job/4092721=
9243

