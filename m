Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93601606A328
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OqLvRqt1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrptcyWU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=T7rOMPplLomFK+EC05LzdPzGrXETZLxt3EvKKKVvcv0=; b=OqLvRqt1pRxORm
	yzpEJDB+Tzc6t/ekq2oxkUrKtg9w+PvwdvyL9xwD69Y+FAUW70VHV55GCyODkLB/WYpJOvctOm72Q
	+LVLn628nfJoT96YvU6gm0VlHwj/elH9IhimX6t4T+xW3WC2x1kIN/ZZA+DRZ63DC3SVGXIxl98Jl
	NOqrAZ6W3uMqal+1m3YMKuShhZ+K1YO1QGeo2NKTvA6PNzSKVutV3Fk9NCe7Q+ty6D7NCftzfvX3h
	cVh9vFiYqnxsb+Smh3/uPvpzMt4a7+h9wcPSBQ7WZ6fQa/SenSpZnmL692jEHDksqok2E4Xef9PFM
	Rom0EST78vqw3ngN0Aaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcQ4-00000005hw6-1Co5;
	Wed, 04 Nov 2026 14:56:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcQ3-00000005hvp-0Dpj;
	Wed, 04 Nov 2026 14:56:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 46D0860546;
	Wed,  4 Nov 2026 14:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CC11F000C1;
	Wed,  4 Nov 2026 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804214;
	bh=T7rOMPplLomFK+EC05LzdPzGrXETZLxt3EvKKKVvcv0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=MrptcyWUAcszN49zHQTkn3Vlr/HscV8Bl4lEC7R76+MYv7gQJXdxpylZ79fGVxJJG
	 9g2RjZrokNB6qDNHG67TRkFttmgL1t2KdGdPIq0zjGZQ2tpCDDyqj1gOxcwehdfXY+
	 WNHZuIs47sffQbdvvDUJo0zkxJB0m5g+Zo5ngvZRNdtigj8ZxmrYguaza/nDk0M3CY
	 G5c7zitroMfYhwxfXt68GtCd4yiMACIrJ5qsb2puVDshMKSWVxOz6W6kzvD8gW2gAO
	 +MF/8nKz3uZpWHQ8FC5h0nznRoxul5JcWwA09pW2w+j3axirgz6HMdNa1MuyG7qGfV
	 qv8X6UKrIz32Q==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 00/15] kexec: Fix CMA and elf header leaks and
 rework
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
 ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, 
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com, 
 leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org, 
 sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com, 
 Yeking@Red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com, 
 zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org, 
 adityag@linux.ibm.com, hui.wang@canonical.com, sohammetha01@gmail.com, 
 guoren@kernel.org, gaohan@iscas.ac.cn, kai.huang@intel.com, kas@kernel.org, 
 vishal.l.verma@intel.com, piliu@redhat.com, jbouron@amazon.com, 
 mclapinski@google.com, me@linux.beauty, graf@amazon.com, bgwin@google.com, 
 x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 kexec@lists.infradead.org
In-Reply-To: <20261026075201.699550-1-ruanjinjie@huawei.com>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
Date: Wed, 04 Nov 2026 16:56:37 +0200
Message-Id: <179380419709.28814.2122135856184991710.b4-review@b4>
X-Mailer: b4 0.16.1-dev
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jinjie,

> ARM64, LoongArch and RISC-V load the elf core header, initrd, DTB
> and cmdline parameters with almost identical code. This series fixes
> the bugs in that path. And as Mike suggested, rework the common part
> into a helper.
> 
> Patch 1 stops using the Image text_offset for arm64, which breaks CMA
> segments in both the load and release paths, and rejects images with
> a non-zero value.
> 
> Patches 2-7 fix the CMA page and elf core header leaks in the retry
> loops in arm64 and LoongArch, also fix a modified_cmdline leak
> in LoongArch.

These mix fixes that can be easily merged via arch trees and something
that depends on a change to the generic kexec code.

Besides, elf_headers leak and arm64's text_offset fixes should be
applied to most if not all stable kernels, while CMA fixes are only for
the relatively new kernels.

I'd suggest splitting

	arm64: kexec_file: Stop using the Image text_offset
	arm64: kexec_file: Fix elf_headers memory leak in retry loop

and sending as pure arm64 material, and


	LoongArch: kexec_file: Fix elf_headers memory leak in retry loop
	LoongArch: kexec_file: Fix a modified_cmdline leak

as pure LoongArch material.

And then working on CMA fixes after these land.

If there are real dependencies or potential conflicts, b4 prep can help
you with managing them.

> Patches 8-10 pass the kbuf fields to crash_prepare_headers() to
> simplfy code.
> 
> Patch 11 frees the elf core header from the generic post-load cleanup.
> 
> Patches 12-15 add kexec_load_other_segments() and convert the three
> architectures, and arch_kexec_setup_other_segments() builds
> the architecture specific boot parameters (a DTB or a command line).

I think the refactoring should go before the identical fixes in arch/
code.

-- 
Sincerely yours,
Mike.


