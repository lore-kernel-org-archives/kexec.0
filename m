Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C651D39423
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DH+iNz08X6EuAL3xC9z+JByLMXFyPiPYDRa6C8Lo498=; b=BmFTYtEpibfOeoLw81LTwWrC6V
	upG0V9vtpPbduexqYZskHVyqUAzo67bku2TZwL7CtFcIkMf0Q2LIytu/VgbnkF6UnbuBObbxkb+4d
	TBHBlzCMpCJbM9bytk6fz2WSpgySuJgj1Rd8517STgj8wRebnPXwiBeYpXObaexIoGTrPFo/l6pEq
	dYYZQHLHJd9nhvMa6q5ceUXFXfpbIdFThvKlRGfAO0rPUPomzOOoF4zrSqmT0t50G5q6PbIZE/g6p
	xaMf8MHvxAz+imqxv+Es5751kuN5Zf4hi9xPl5+Vy62HSN1EU6TRVndQ0eoSUVslQGs7YuGCx8MS3
	JIK9k1Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HFm-000000003uR-2JIo;
	Thu, 02 Apr 2026 12:34:30 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4cQo-0000000GVIn-3Gob;
	Mon, 23 Mar 2026 10:22:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=DH+iNz08X6EuAL3xC9z+JByLMXFyPiPYDRa6C8Lo498=; b=cOELZ+GzPUk5kjUi33kxf6Lu7p
	GY3nwOVi920GJ9UbvJXatjMBuQEPT0FOX4okImlD8Vj3T4hBJwuD4uVDmjAO+AoxU+1owP1yMDUJv
	6jIqukt9sJv843ocVhBm8CQf/EgCYlBeY70qonTJ07RkEANn/O90EI9F2qKxX/Ruiw+ig35xTfySr
	TCQUi13ye1jWvFFXVEayi3gPh6rq4OrCVTXd3UdB4U39KNNRni9xgjm24sZzkklawm4ICVKu9C6Bt
	6iaiADnz4fz5s6LsXVZRgEIBNtVWG99q9re5mqluxiVD7HtUILcAbo0RaYSXFH39nUpc6WAzPyJnG
	O3Zbf8gA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w4cP7-007SfO-16; Mon, 23 Mar 2026 10:20:59 +0000
Date: Mon, 23 Mar 2026 03:20:48 -0700
From: Breno Leitao <leitao@debian.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org, peterz@infradead.org, 
	feng.tang@linux.alibaba.com, pawan.kumar.gupta@linux.intel.com, dapeng1.mi@linux.intel.com, 
	kees@kernel.org, elver@google.com, paulmck@kernel.org, lirongqing@baidu.com, 
	safinaskar@gmail.com, rppt@kernel.org, ardb@kernel.org, jbohac@suse.cz, 
	cfsworks@gmail.com, osandov@fb.com, tangyouling@kylinos.cn, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, eajames@linux.ibm.com, 
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com, samuel.holland@sifive.com, 
	vishal.moola@gmail.com, junhui.liu@pigmoral.tech, coxu@redhat.com, liaoyuanhong@vivo.com, 
	fuqiang.wang@easystack.cn, x86@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [PATCH v9 4/5] arm64: kexec: Add support for crashkernel CMA
 reservation
Message-ID: <acETyW3FYaWCShUc@gmail.com>
References: <20260323072745.2481719-1-ruanjinjie@huawei.com>
 <20260323072745.2481719-5-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323072745.2481719-5-ruanjinjie@huawei.com>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_032246_895395_E6D08983 
X-CRM114-Status: GOOD (  21.55  )
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

On Mon, Mar 23, 2026 at 03:27:44PM +0800, Jinjie Ruan wrote:
> Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
> crashkernel= command line option") and commit ab475510e042 ("kdump:
> implement reserve_crashkernel_cma") added CMA support for kdump
> crashkernel reservation.
> 
> Crash kernel memory reservation wastes production resources if too
> large, risks kdump failure if too small, and faces allocation difficulties
> on fragmented systems due to contiguous block constraints. The new
> CMA-based crashkernel reservation scheme splits the "large fixed
> reservation" into a "small fixed region + large CMA dynamic region": the
> CMA memory is available to userspace during normal operation to avoid
> waste, and is reclaimed for kdump upon crash—saving memory while
> improving reliability.
> 
> So extend crashkernel CMA reservation support to arm64. The following
> changes are made to enable CMA reservation:
> 
> - Parse and obtain the CMA reservation size along with other crashkernel
>   parameters.
> - Call reserve_crashkernel_cma() to allocate the CMA region for kdump.
> - Include the CMA-reserved ranges for kdump kernel to use.
> - Exclude the CMA-reserved ranges from the crash kernel memory to
>   prevent them from being exported through /proc/vmcore, which is already
>   done in the crash core.
> 
> Update kernel-parameters.txt to document CMA support for crashkernel on
> arm64 architecture.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v7:
> - Correct the inclusion of CMA-reserved ranges for kdump
>   kernel in of/kexec.
> v3:
> - Add Acked-by.
> v2:
> - Free cmem in prepare_elf_headers()
> - Add the mtivation.
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  arch/arm64/kernel/machine_kexec_file.c          | 2 +-
>  arch/arm64/mm/init.c                            | 5 +++--
>  drivers/of/fdt.c                                | 9 +++++----
>  drivers/of/kexec.c                              | 9 +++++++++
>  5 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cb850e5290c2..afb3112510f7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1121,7 +1121,7 @@ Kernel parameters
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
>  	crashkernel=size[KMG],cma
> -			[KNL, X86, ppc] Reserve additional crash kernel memory from
> +			[KNL, X86, ARM64, PPC] Reserve additional crash kernel memory from
>  			CMA. This reservation is usable by the first system's
>  			userspace memory and kernel movable allocations (memory
>  			balloon, zswap). Pages allocated from this memory range
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index c338506a580b..cc577d77df00 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -42,7 +42,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  #ifdef CONFIG_CRASH_DUMP
>  unsigned int arch_get_system_nr_ranges(void)
>  {
> -	unsigned int nr_ranges = 2; /* for exclusion of crashkernel region */
> +	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */

You update arch_get_system_nr_ranges() to account for CMA ranges, but
prepare_elf_headers() in the same file (line 51) still has the
hardcoded:

        nr_ranges = 2; /* for exclusion of crashkernel region */

and does not exclude CMA ranges from cmem. If the generic crash core
handles CMA exclusion from vmcore, then shouldn't
arch_get_system_nr_ranges() also not need this change?

