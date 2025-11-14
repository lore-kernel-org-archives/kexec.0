Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75127CE8D51
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 16:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LzmaurRwXd/FUfjWlIvyc9JKRHbFyjNcTaJdND6zQwk=; b=yxpa1BIqlEfCCNlLqYDp/0ZCse
	Xz/3nF++8ubp762PQlX4NxGEqjicYar/afylrnLJbrDfvLLfWowcYlABGgI/l8S68GhTmNc3kTVhX
	bOuoS5yb6zksPZ5W2Lif2QU5wu6s/RAgjouq35X90oukBPcEvzBHOIAgkq54bXpDH0Bcv+RG6vfUU
	j5+A81baA3Aj+03oThKUBj7vsk+SMcA4ASi4Kkm5T0U6ZGQRZvD12GDiGzRCmLRga2xY+s/6Cy/nT
	gI4cOLEYwkU4sPRTAWB4CwAMrckNdMZ8xJjkSZi12sCR/GBuW83SwJADIg/qTpu+VcBJFWPFSMmni
	43MEL0wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwUT-0000000Ciu1-48Xo;
	Fri, 14 Nov 2025 16:17:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwUS-0000000Citc-1E7X
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 16:17:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AFFA960150;
	Fri, 14 Nov 2025 16:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFD7C4CEF5;
	Fri, 14 Nov 2025 16:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763137055;
	bh=1TP2PBihBm/xACDWaGTPWhNWAdDdBhE5Owp0RpW0KBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwrPhz/H4pWI6GRx+uoYSdBmXA78z+aVv88xUzOIT17tPfm2Ur79PxBbmFmETirvN
	 6/z2xXhyZKz1WEYyTa9ySylU39jBcxrcd/LaesSsiSgm4WZeP5HMBWX76VJ2mMVnlV
	 3HVMlBc9re1Z4MtzUQv3z5aLXfQ6beeJ7DdK6fPjtwRoTDJaSFg4Tv1P0K365g6Xnz
	 lL5wkoVXSMH235A+WDbEaMuUz7+vSIAbl8IqCGrTyxL+ATr3C2IxBwOLW2pnNP+C31
	 TyvqXGWFVQiKzXHNB8RLx5qPpjPiSbEfZvQ7k5koLM845Ed7SdKJFdjXQ9df1LX8I1
	 j0YEIpr35ql2w==
Date: Fri, 14 Nov 2025 18:17:27 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, jasonmiu@google.com,
	arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca,
	ebiggers@google.com, graf@amazon.com, kees@kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v1 00/13] kho: simplify state machine and enable dynamic
 updates
Message-ID: <aRdWF8ck4iq1hc0B@kernel.org>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
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

On Fri, Nov 14, 2025 at 10:53:45AM -0500, Pasha Tatashin wrote:
> 
> This patch series refactors the Kexec Handover subsystem to transition
> from a rigid, state-locked model to a dynamic, re-entrant architecture.
> It also introduces usability improvements.
> 
> Pasha Tatashin (13):
>   kho: Fix misleading log message in kho_populate()
>   kho: Convert __kho_abort() to return void
>   kho: Preserve FDT folio only once during initialization
>   kho: Verify deserialization status and fix FDT alignment access
>   kho: Always expose output FDT in debugfs
>   kho: Simplify serialization and remove __kho_abort
>   kho: Remove global preserved_mem_map and store state in FDT
>   kho: Remove abort functionality and support state refresh
>   kho: Update FDT dynamically for subtree addition/removal
>   kho: Allow kexec load before KHO finalization
>   kho: Allow memory preservation state updates after finalization
>   kho: Add Kconfig option to enable KHO by default
>   kho: Introduce high-level memory allocation API

For the series:

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

with small nits in patches 9 and 13 in replies to them.

> 
>  include/linux/kexec_handover.h              |  22 +-
>  kernel/liveupdate/Kconfig                   |  14 +
>  kernel/liveupdate/kexec_handover.c          | 338 ++++++++++++--------
>  kernel/liveupdate/kexec_handover_debugfs.c  |   2 +-
>  kernel/liveupdate/kexec_handover_internal.h |   1 -
>  5 files changed, 232 insertions(+), 145 deletions(-)
> 
> -- 
> 2.52.0.rc1.455.g30608eb744-goog
> 

-- 
Sincerely yours,
Mike.

