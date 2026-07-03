Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB14C43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 06:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t2GSIPSxJh8EZqC8ezwABY7VMBVdrUEd4MP2m61kMJg=; b=4wKZqOWm9bK7WNOafLEFqJVyft
	N35N0iqvTr0/sQ6OzApa01FmN4T5yj2vvt1bo20bUsHKHREjlaqygAfgPPsTeSsCnG2prIfQMWpEn
	7mt/AEwutWihJyjl/0b+6cqAKq8fonpyyfl78FKM31071x+rJcXrb4UK+1sCCRrANMMpv5x43Pgrb
	soY2MyVKguLPGJNNS8etlmBry4yF9bxFaSn1HOobhj15Z5oEtoaPSZcmvR4CM16PAmNgR9r3UogCg
	hJ70cTOUn8ehef+Tf8uZyP8v793xG+2HwHEyXPid4yzosVJl0b8LRfoNqn+JVYRDlPvAY1HrBxSV2
	la44onNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfWyC-000000067WV-1FKC;
	Fri, 03 Jul 2026 06:01:48 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfWy8-000000067Vi-10lP;
	Fri, 03 Jul 2026 06:01:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783058498; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=t2GSIPSxJh8EZqC8ezwABY7VMBVdrUEd4MP2m61kMJg=;
	b=tiDsjNnNqSvZ/CyTME4CuSBijI+klf9Z/2knJUndaJ2B37FCiCzSiiHkhjiZ0i6uABFr2kpPqKkj6npEsUzMOUFN29GCBxOAJVc9QCYyMyVG/n0TZoHC//kapqY3gm6UTWRM7Z/ZmKdWLFy4nvjNpDdA/QqDl415AmqCIIjHL8Q=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fengwei_yin@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X6I6p2n_1783058494;
Received: from U-V2QX163P-2032.local(mailfrom:fengwei_yin@linux.alibaba.com fp:SMTPD_---0X6I6p2n_1783058494 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jul 2026 14:01:37 +0800
Date: Fri, 3 Jul 2026 14:01:33 +0800
From: YinFengwei <fengwei_yin@linux.alibaba.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Puranjay Mohan <puranjay@kernel.org>,
	Usama Arif <usama.arif@linux.dev>, Breno Leitao <leitao@debian.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Lecopzer Chen <lecopzer@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: Re: [PATCH v5 0/4] arm64: cross-CPU NMI via SDEI
Message-ID: <akdQPbs8ImQbhMuM@U-V2QX163P-2032.local>
References: <cover.1782744912.git.kas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1782744912.git.kas@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_230144_957338_F57B3D55 
X-CRM114-Status: GOOD (  12.70  )
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

Hi Kirill,

On Mon, Jun 29, 2026 at 04:07:14PM +0100, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> A class of debug/observability features needs to interrupt a CPU that has
> its interrupts locally masked: the all-CPU backtrace behind sysrq-l /
> RCU-stall / hung-task / hard-lockup dumps, and crash_smp_send_stop()
> capturing a stuck CPU's state into the vmcore. On arm64 these need a
> mechanism that reaches a CPU spinning with DAIF masked, which a normal IPI
> cannot.
> 
V> arm64 has two such mechanisms today:
> 
>   - GICv3 pseudo-NMI (interrupt priority masking). The cost lands on the
>     interrupt mask/unmask hot path: local_irq_enable() becomes an
>     ICC_PMR_EL1 write, and exception entry/exit save and restore the PMR,
>     paid on every CPU whether or not an NMI is ever delivered.
> 
>     Measured on Grace (Neoverse V2; ICC_CTLR_EL1.PMHE=0, so the PMR-sync
>     DSB is already patched to a NOP), pseudo_nmi=0 vs pseudo_nmi=1:
> 
>         gettid() loop:              178 -> 253 ns/call  (+42%, ~74 ns)
>         will-it-scale sched_yield:  0.705x throughput, flat from 1 to 72 cores
>         will-it-scale page_fault1:  within ~5%
> 
>     The ~74 ns is a fixed per-syscall entry/exit tax -- it reproduces at
>     +73.5 ns on Neoverse N2 -- so the hit tracks syscall/exception density
>     and is unacceptable on syscall-bound fleet workloads, which therefore
>     run with pseudo-NMI disabled.
> 
This patchset works perfectly on our Neoverse N2 ARM64 platform. So
 Tested-by: Yin Fengwei <fengwei_yin@linux.alibaba.com>

Regards
Yin, Fengwei


