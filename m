Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3516FED9EF
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 17:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RFQ4/Uk0OnU8Uzn96aCwudKt9KCdVYsJEmnR9W6qol8=; b=iv9gaKmvirKmwIgfoiawWGdtHN
	PI1Yb15NT57iG56DvkPsEczflfjYUS16GfRLdjKdpUXXUH+nqRGuE5SgrBtCLd1VNwa6g5bleuhw0
	eF4lhri9z5pLsw2b6YAb1TZymYeSa13WpW2eB8RfPy1h2fl7COqLck83Mk85/iBZ2qMWLkPj+dD7J
	BPsqVk2mbox2DGdSliBdWE2d7qtgQ7ykfsagEq0qdy/k8N53b9BefiimGSy2XtctiXzp0TgMPG3bE
	2nSE7KCfGKIo2FnABmr6J0DTabJL+oEVL4PFVWa46bqGgpthTsOH6OrTpvvE5X9P0Odzi+KV5oPw8
	Cp7lioUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2YUt-00000006xn6-3w65;
	Tue, 17 Mar 2026 17:46:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2YUt-00000006xmz-1NB8
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 17:46:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6B42460126;
	Tue, 17 Mar 2026 17:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0109C19424;
	Tue, 17 Mar 2026 17:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773769586;
	bh=Neeh7yEwpO7wPq33nH/ZwuuqV0Bm2MY9dbkvHmC0dwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kr5RM9wUs9ATcTy0zc7o/9tj1vXw0pknsUZz1SYg0K99Vlr9lS/Ia+Owmfhrgjqwu
	 dyYMJekdmpSa/pcHBmElTxRq1UbiMiFNtJyc8BjkVOFFbjLF5xUMX/LYtLBfyYVa/z
	 FEF+TzW61e9+urqFy74VxpjQI0qWtx5Kmgr7eo3Q=
Date: Tue, 17 Mar 2026 10:46:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, Pratyush
 Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, Samiullah
 Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] kho: add support for deferred struct page init
Message-Id: <20260317104625.fd6a006871dcceaceafe990b@linux-foundation.org>
In-Reply-To: <20260317141534.815634-1-mclapinski@google.com>
References: <20260317141534.815634-1-mclapinski@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 17 Mar 2026 15:15:31 +0100 Michal Clapinski <mclapinski@google.com> wrote:

> When CONFIG_DEFERRED_STRUCT_PAGE_INIT (hereinafter DEFERRED) is
> enabled, struct page initialization is deferred to parallel kthreads
> that run later in the boot process.
> 
> Currently, KHO is incompatible with DEFERRED.
> This series fixes that incompatibility.

Thanks, I've added this series to mm.git's mm-new branch for testing. 
All being well I'll move it into the mm-unstable branch (and hence
linux-next) in a few days.  All being well I'll move it into the
non-rebasing mm-stable branch a few weeks hence.  Then into mainline
during the merge window!

[1/3] and [2/3] aren't showing any review at this time, but the
well-reviewed [3/3] is the meat of this series.


