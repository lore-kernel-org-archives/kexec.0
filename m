Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6A5CD4F45
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TE+A8gVsi33ADWPRsTq1jFWiY76eVCOBjR9gXM5fMfY=; b=Y5/nOTmJ3oNEQ++Ioyn5JcMvGJ
	DMQu3GQpm6BWOo37Hbym23Fr4otXw8CzwIYzPWKBocwG2Ns9jBm0mTNddPkZpfPmF13l2AbjOnen7
	1kIsiGfK1BD5h5ThTxSrb/2dW0iXMTKVoyUGxmfwj8qHLx8Cw7+hG5hlBzDw6gSlByUlg03C2wue1
	KqYKQsZq6vPCG5V0LgKyg1jjbIq2l7VtpO71btsgzrrzPTQm37cDxLKMl8knexLvSFysSPKYiKrbT
	2Xl2vGkge84iS40QKJ6r6/NeoM4ul8VyZ+uDnu2jD0SPbWCsq87HiZse7qLJrTXkrSGF3Z2Kb9wHN
	KhZI7YZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMrLM-000000001BU-0f1a;
	Tue, 12 May 2026 17:56:32 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNGC-0000000D0I5-32Dp;
	Mon, 11 May 2026 09:49:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TE+A8gVsi33ADWPRsTq1jFWiY76eVCOBjR9gXM5fMfY=; b=iJ89i0F6NFZsu5G0fxn0HLYT+r
	l0SLLEDLG/yPloRHV0v1HlL5Yc01WpUF7lWffNA1KFgex0k3+bKbm0zzSupULh+T5t4eluweHQo9j
	KONzV42jkP7COLxrhglXtoOrqeqKupykQcuDBWXlXTFdmgrp/0e6EKUyXkYNAaPD5wqH7A75PO6XF
	yxQ5UuXHCKGt/3yK7FkKYGJo+BpAX/OGsR6mPO0bp/LCIi37AD//k/7owe+QOGFpJx+fFlLJM7FPy
	Gn4D99g4S4bjwfYMkgC9jwdc9OCVfhBC8G4M6jOz+mJb7qKKoa9+ZukNTqJvhkRjgX4s1RX0VDpnX
	fPtEV+WQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMNE5-001VdZ-2m;
	Mon, 11 May 2026 09:47:02 +0000
Date: Mon, 11 May 2026 02:46:43 -0700
From: Breno Leitao <leitao@debian.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	ruirui.yang@linux.dev, rdunlap@infradead.org, pmladek@suse.com, 
	dapeng1.mi@linux.intel.com, kees@kernel.org, elver@google.com, kuba@kernel.org, 
	ebiggers@kernel.org, lirongqing@baidu.com, paulmck@kernel.org, 
	sourabhjain@linux.ibm.com, coxu@redhat.com, jbohac@suse.cz, ryan.roberts@arm.com, 
	osandov@fb.com, cfsworks@gmail.com, tangyouling@kylinos.cn, 
	ritesh.list@gmail.com, adityag@linux.ibm.com, guoren@kernel.org, 
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com, vishal.moola@gmail.com, 
	junhui.liu@pigmoral.tech, wangruikang@iscas.ac.cn, namcao@linutronix.de, 
	chao.gao@intel.com, seanjc@google.com, fuqiang.wang@easystack.cn, ardb@kernel.org, 
	chenjiahao16@huawei.com, hbathini@linux.ibm.com, takahiro.akashi@linaro.org, 
	james.morse@arm.com, lizhengyu3@huawei.com, x86@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [PATCH v13 04/15] arm64: kexec_file: Fix potential buffer
 overflow in prepare_elf_headers()
Message-ID: <agGkvrg06KNDNfDi@gmail.com>
References: <20260511030454.1730881-1-ruanjinjie@huawei.com>
 <20260511030454.1730881-5-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511030454.1730881-5-ruanjinjie@huawei.com>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_024912_766124_B4DAA10F 
X-CRM114-Status: GOOD (  18.45  )
X-Mailman-Approved-At: Tue, 12 May 2026 10:56:26 -0700
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

On Mon, May 11, 2026 at 11:04:43AM +0800, Jinjie Ruan wrote:
> There is a race condition between the kexec_load() system call
> (crash kernel loading path) and memory hotplug operations that can
> lead to buffer overflow and potential kernel crash.
> 
> During prepare_elf_headers(), the following steps occur:
> 1. The first for_each_mem_range() queries current System RAM memory ranges
> 2. Allocates buffer based on queried count
> 3. The 2st for_each_mem_range() populates ranges from memblock
> 
> If memory hotplug occurs between step 1 and step 3, the number of ranges
> can increase, causing out-of-bounds write when populating cmem->ranges[].
> 
> This happens because kexec_load() uses kexec_trylock (atomic_t) while
> memory hotplug uses device_hotplug_lock (mutex), so they don't serialize
> with each other.
> 
> Add the explicit bounds checking to prevent out-of-bounds access.

It seems you have a TOCTOU type of issue, and this seems to be shrinking
the window, but not fully solving it?

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: stable@vger.kernel.org
> Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
> Closes: https://sashiko.dev/#/patchset/20260323072745.2481719-1-ruanjinjie%40huawei.com
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index e31fabed378a..a67e7b1abbab 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -59,6 +59,11 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  	cmem->max_nr_ranges = nr_ranges;
>  	cmem->nr_ranges = 0;
>  	for_each_mem_range(i, &start, &end) {
> +		if (cmem->nr_ranges >= cmem->max_nr_ranges) {
> +			ret = -ENOMEM;

-ENOMEM seems to be the the wrong errno. This isn't an allocation
failure; it's a transient race. -EBUSY or -EAGAIN would be more honest

