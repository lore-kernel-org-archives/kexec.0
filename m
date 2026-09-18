Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4218CC982E6
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ak8nh2SAnHlrH5Gov+HSivc8cOu/u80U/J5TpC+xpEQ=; b=GMej/KXnxSOuPOf/A5DgdtTGbP
	64Pzb/VPIv2KZ+UPfsukGghXWfxQjcfkIylHs1hXhxGQIQsbt/tprxHrWld/+E0eiQ1760EZnBk3O
	+iuXktAGhrfyXjkcq8kDHZBSvawI+Pgj6hoVr13EVLgkg+t08ZELntWWywb1LXe5QtXVMwyaJ+HWV
	B71HNB1EAbMOuvj8pZR5l/qSTm1+TLSXXFVOx71s0M3pomdHjfkzCTlOFHVFG03+6rzDqdWMRM/RS
	jGperkXiWQcCgbD5dLJ4VMaArFO4iHx0y69E2N9Hquw7aCWLkNSRF4kdeNXW3tZJ+bBGCqIUOZqMt
	SirNePPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4q-00000000NVL-1NLo;
	Sun, 20 Sep 2026 20:23:56 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7W3I-0000000E7ML-26e8;
	Fri, 18 Sep 2026 10:42:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ak8nh2SAnHlrH5Gov+HSivc8cOu/u80U/J5TpC+xpEQ=; b=nK+0EYK/9BTfAlJwWP6AvOQJLF
	c15I5JymFF9K2yedwWqzusksKy4eQ5viR8nw3qriMok9WWjsTGTBJqyX7vUZOYQXAgOrEVMbNrZuv
	mjim6c7AEHBA7MnJy/903HNCuWnYczSfYXW5QC0F/OBJf0dY7ju2961gPIkDrOT5ExmqAFKwzqxcC
	XiYLMxnLjQ39eErgrwFWiMno2NauveXgtxV+dkki815BfVZ5ZzLxKpclYHT585S62SVGSmWuPCJin
	9MSZjVXwRNN1boS/jdHCenBQWO8ruAfwzANSV4/t21AyyOLxCm3iTBm1RVzeREYUe38b8ciyJaWu7
	GijK2PpQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x7W1x-006f1D-2W;
	Fri, 18 Sep 2026 10:41:22 +0000
Date: Fri, 18 Sep 2026 03:41:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, 
	pratyush@kernel.org, ruirui.yang@linux.dev, kees@kernel.org, thuth@redhat.com, 
	gshan@redhat.com, ardb@kernel.org, james.morse@arm.com, yeoreum.yun@arm.com, 
	sourabhjain@linux.ibm.com, robh@kernel.org, coxu@redhat.com, tangyouling@kylinos.cn, 
	liukexin@kylinos.cn, guodongtai@kylinos.cn, maqianga@uniontech.com, 
	zhangtianyang@loongson.cn, blum@kernel.org, adityag@linux.ibm.com, chao.gao@intel.com, 
	kas@kernel.org, vishal.l.verma@intel.com, seanjc@google.com, piliu@redhat.com, 
	jbouron@amazon.com, me@linux.beauty, mclapinski@google.com, graf@amazon.com, 
	bgwin@google.com, eric.devolder@oracle.com, hbathini@linux.ibm.com, 
	takahiro.akashi@linaro.org, lizhengyu3@huawei.com, palmer@rivosinc.com, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, driver-core@lists.linux.dev, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 00/17] crash: Rework and add arm64 crash hotplug
 support
Message-ID: <aq0UR62q6gGJUQ49@gmail.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918100442.3841135-1-ruanjinjie@huawei.com>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_034244_536531_3C7F79D4 
X-CRM114-Status: UNSURE (   8.08  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:20 -0700
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

On Fri, Sep 18, 2026 at 06:04:25PM +0800, Jinjie Ruan wrote:
> When CPU or memory hotplug events occur, the elfcorehdr in the kdump
> image becomes stale, potentially leading to incomplete crash dumps.

Looking through the series, it seems to mix bug fixes with new
feature work. Would it make sense to split out the fixes so they
can land independently, and keep the new features as a separate
patchset?

I'm currently rolling out crashdump CMA across the Meta fleet, so
right now I care mostly about picking up isolated bug fixes. As it
stands, it's difficult to tell which patches are fixes and which
are features.

