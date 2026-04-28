Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6864FF886C
	for <kexec@archiver.kernel.org>; Tue, 28 Apr 2026 21:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YO8DkX4BQLo0qf2zzoV3t73Rm71Vx7qEdeREgZLXBlk=; b=iraTPsI6l65vzsea31MT1WCFQG
	DNJHWsSL0WR3kMFOg0H7n2E11A3UOKneAXI6BItin1v1wNBhjGI+id1SpKM7R9cPpb2uSO65YZJT9
	LFBhUuRWLs8WMdvlc6mnv8CD8RDFqE7mudXwVVnGeamAjeDikaFKtbA2mWK/BFT4De5UtX6+prWZz
	Fcx/HIWw8vNxlgoP1F2KQnMKJBnrHxA7eSk/AHzG+2uOBmdw8JBXmOkhL+5HupPyXntarQB0kY+mX
	d/pJi9ywH74lqfD6CD/Tqhl3nK/xl+Vk/jsjHVlYfGSULeZ7pT4bBKDey2s9U8kFX5iY6hp/4SiPe
	W34TK5Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHqJU-00000002XWE-2fLy;
	Tue, 28 Apr 2026 21:49:52 +0000
Received: from out-172.mta1.migadu.com ([95.215.58.172])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHqJR-00000002XVn-39R7
	for kexec@lists.infradead.org;
	Tue, 28 Apr 2026 21:49:51 +0000
Date: Wed, 29 Apr 2026 05:49:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777412984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YO8DkX4BQLo0qf2zzoV3t73Rm71Vx7qEdeREgZLXBlk=;
	b=nQEvw8nF5HSnRGiA9kb9Csd6Q0No4q1j3Di66Y6DatYTT3LLrEyG1q0Lp/bTO93G27TIqA
	ODKFseniSSDyO5dHAPbGQgbC2+j1AqCcs0g40YAgQ+wM7SFQRwHlShK3YGNehgC589WLFq
	YwGFwj6X6YVwy3/+GStxWdbvYyYb1Rg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] MAINTAINERS: update KEXEC, KDUMP and LIVE UPDATE
Message-ID: <afErcE5565Hdj2_a@MiWiFi-R3L-srv>
References: <20260428124833.1903302-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428124833.1903302-1-rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_144950_228376_4C9587A6 
X-CRM114-Status: GOOD (  10.61  )
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

On 04/28/26 at 03:48pm, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> KHO and LiveUpdate team is going to pick kdump and kexec patches to
> their tree at
>     
> https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
> 
> Update MAINTAINERS to reflect this change and add kexec@ list to LIVE
> UPDATE entry.
>    
> Mike Rapoport (Microsoft) (2):
>   MAINTAINERS: add tree for KDUMP and KEXEC
>   MAINTAINERS: add kexec@ list to LIVE UPDATE ENTRY
> 
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)

Ack the series:

Acked-by: Baoquan He <baoquan.he@linux.dev>


