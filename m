Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB9AD3941E
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cafOVGJhVpKtrDApJntdDFDO00PImuG+jp56XDPXWNM=; b=3DVqj0QFyb9ZqiGgWyJoe72a4Z
	7UIIy2blD4EdbprUwjwi5/ZqK1oiU8QHLBXdAUV6Iw6tQEUmRzIJcczZTbq0syF2qfZf/9+OiW0Gl
	SxZmpEyYJ1yKRrwQHnx49MQ5d4e+v2YFXLv8sDlQplg5wcbBLriD7jUEaM/T/TI/YiN/mxP3uM45r
	6bFq+y0tBVmtO3WucZSbO3EGq6D1QCRKtqgB4HkCLLTdTjGexyz2Fo0x70EN1borkSs0xXZb2K+VM
	X6FOcKMYDTDTDUCLLljs5z6LiWOuNlXL7MnrcJMKBDfCFg7Blq/YtXeawHgvnkW/LkXWnL3U9ha+h
	vTrQ6YLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HFw-000000004F8-0YdL;
	Thu, 02 Apr 2026 12:34:40 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5iLu-00000005Il6-2Ho6;
	Thu, 26 Mar 2026 10:54:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7625D175A;
	Thu, 26 Mar 2026 03:54:06 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E50D13FB90;
	Thu, 26 Mar 2026 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774522452; bh=8IXmdtIFEytfMHYy2/zN6eUVEhDW6CUJvZu3Mba6/Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVuxS70wtA+CNyc+9Yfuu8kLdwGx0hAOW4qIgVCCdqd3eWV81ySjZ1drGGhP2OXoL
	 +ZNCcv/2wvx0wEMhP2Dp3UCFRMfOF2SBHpPH29ZkEJibdsvI0zy0/8alDG7Ivbi7i4
	 oE7duHHNhvv6uUVGYqsXoDVURWRztrpZN8osSmlg=
Date: Thu, 26 Mar 2026 10:54:01 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, will@kernel.org,
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
	saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org,
	peterz@infradead.org, pawan.kumar.gupta@linux.intel.com,
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
	kees@kernel.org, elver@google.com, paulmck@kernel.org,
	lirongqing@baidu.com, rppt@kernel.org, ardb@kernel.org,
	leitao@debian.org, osandov@fb.com, cfsworks@gmail.com,
	tangyouling@kylinos.cn, sourabhjain@linux.ibm.com,
	ritesh.list@gmail.com, eajames@linux.ibm.com,
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com,
	samuel.holland@sifive.com, vishal.moola@gmail.com,
	junhui.liu@pigmoral.tech, coxu@redhat.com, liaoyuanhong@vivo.com,
	jbohac@suse.cz, fuqiang.wang@easystack.cn, guoren@kernel.org,
	chenjiahao16@huawei.com, hbathini@linux.ibm.com,
	james.morse@arm.com, takahiro.akashi@linaro.org,
	lizhengyu3@huawei.com, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v10 6/8] arm64: kexec: Add support for crashkernel CMA
 reservation
Message-ID: <acUQSSNgxCCK5LnI@arm.com>
References: <20260325025904.2811960-1-ruanjinjie@huawei.com>
 <20260325025904.2811960-7-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325025904.2811960-7-ruanjinjie@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_035414_696744_F48AF06B 
X-CRM114-Status: GOOD (  11.26  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:23 -0700
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

On Wed, Mar 25, 2026 at 10:59:02AM +0800, Jinjie Ruan wrote:
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

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

