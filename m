Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AF1FD3762
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B+KvzGktl0ZDAEDtD8V6fB+I7vhLmiBdZuB2qUwdvR0=; b=n3i0oN9uaw2HeL6/CaFf9yTdGU
	x/XS9EeXv7HH1TvosVC33HeFOmPiwi/EpPRuWElHAiRpfR0UN2sl5OZQJWUIwUaflI00L4r6wizTl
	RPHbc7rd4bPRUj3vbgqrKenhkv1YJICeapqDNnSbM3eddKQYXPKWRFgkuPIXme5S+ngoGEQD5fFSl
	siFDGp/fx1xZPlJfKTvKtxAh+E/lop2+GOlwQij8ROby77u4aoF8czLJzAK2HQwGVbCqBLUuWpFlG
	+3hq7KMQZC9DHinOH+4eN2C6x08KiGRfBNit7Gu5cIUSNTTn5D4Hu73nPmzYsZpSVJv2vsrLKbZL5
	/XZWoViA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvHAH-00000004Pxa-3ZSS;
	Wed, 25 Feb 2026 15:51:05 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvHAF-00000004PwS-3GIQ;
	Wed, 25 Feb 2026 15:51:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4ABB04327E;
	Wed, 25 Feb 2026 15:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187F0C116D0;
	Wed, 25 Feb 2026 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772034663;
	bh=X8g+EKJL0vZnYgJbnZJBCkMj0KCIXHLnrvIicphTvcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8o8c6fx7S2iXqLGrOBHQYvcEjWQG5022FEv9UcaDkP34xHM0E5ber/YhVZZJ7TDJ
	 CmonH3kI+u7XPVDT6HakxUNk6XaTfLiUErrtz15xA+amKw+aR7DLJxX5crqo3Vj23y
	 ha8ymHj5xiUMc7OdnyEepYVJrN8Xo9CXha27eWqxeexBZWgLI8h5Se7XX6MsM3qOYC
	 PueqjmhMJa59WDVNHonUx88k63SjrdKBN71BGuIPR/BImGSF37PiacUkuArAzcg6zs
	 7txFnlhhrz7LlIGf8EGIHyQZ/UYqfI6d9lioag4Y/n6KbkRjxo5SIKImiSdoeutd6u
	 yWRrawVpZN9Sw==
Date: Wed, 25 Feb 2026 17:50:45 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, akpm@linux-foundation.org, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org,
	pmladek@suse.com, dapeng1.mi@linux.intel.com, kees@kernel.org,
	paulmck@kernel.org, lirongqing@baidu.com, arnd@arndb.de,
	ardb@kernel.org, leitao@debian.org, cfsworks@gmail.com,
	ryan.roberts@arm.com, sourabhjain@linux.ibm.com,
	tangyouling@kylinos.cn, eajames@linux.ibm.com,
	hbathini@linux.ibm.com, ritesh.list@gmail.com,
	songshuaishuai@tinylab.org, samuel.holland@sifive.com,
	kevin.brodsky@arm.com, vishal.moola@gmail.com,
	junhui.liu@pigmoral.tech, coxu@redhat.com, liaoyuanhong@vivo.com,
	fuqiang.wang@easystack.cn, jbohac@suse.cz, brgerst@gmail.com,
	x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Subject: Re: [PATCH v6 0/5] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-ID: <aZ8aVU8qIHue-khK@kernel.org>
References: <20260224085342.387996-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224085342.387996-1-ruanjinjie@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_075103_855936_B3C3BA12 
X-CRM114-Status: GOOD (  15.38  )
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

On Tue, Feb 24, 2026 at 04:53:37PM +0800, Jinjie Ruan wrote:
> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> And add support for crashkernel CMA reservation for arm64 and riscv.
> 
> Rebased on v7.0-rc1.
> 
> Basic test were performed on QEMU platforms for x86, ARM64, and RISC-V
> architectures with the following parameters:
> 
> 	"cma=256M crashkernel=256M crashkernel=64M,cma"
> 
> Changes in v6:
> - Update the crash core exclude code as Mike suggested.
> - Rebased on v7.0-rc1.
> - Add acked-by.
> - Link to v5: https://lore.kernel.org/all/20260212101001.343158-1-ruanjinjie@huawei.com/
> 
> Changes in v5:
> - Fix the kernel test robot build warnings.
> - Sort crash memory ranges before preparing elfcorehdr for powerpc
> - Link to v4: https://lore.kernel.org/all/20260209095931.2813152-1-ruanjinjie@huawei.com/
> 
> Changes in v4:
> - Move the size calculation (and the realloc if needed) into the
>   generic crash.
> - Link to v3: https://lore.kernel.org/all/20260204093728.1447527-1-ruanjinjie@huawei.com/
> 
> Changs in v3:
> - Exclude crash kernel memory in crash core as Mike suggested.
> - Add acked-by.
> 
> Jinjie Ruan (4):
>   crash: Exclude crash kernel memory in crash core
>   crash: Use crash_exclude_core_ranges() on powerpc
>   arm64: kexec: Add support for crashkernel CMA reservation
>   riscv: kexec: Add support for crashkernel CMA reservation
> 
> Sourabh Jain (1):
>   powerpc/crash: sort crash memory ranges before preparing elfcorehdr

Overall LGTM, I had a comment about arm64 and riscv patches, but other than
that

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

