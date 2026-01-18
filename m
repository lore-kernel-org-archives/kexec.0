Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D75D4A5F4
	for <kexec@archiver.kernel.org>; Sun, 18 Jan 2026 12:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+3FxoXkmPeID2GJwOJFR6A2aukHlecal+A0ncvlf2KU=; b=E5L986Nw3Qoua2HHJu9mwUUjt0
	OdKIzyIWcRqcbTxMA7CQLhQ6ifpciMYSoepLqfHDUlCCVuUE2EZ0uIA8Tbc1I92w5WypQuW8mz7kT
	0Z+7N6CTqlVz9UF5Yu0FfqXyDgTszbfpd/RI2VYB1+1TG+hp/KndWPXyMdKPlwFK9mbjyPQiHj9XT
	xywRRuAgz4Jb7b9fiAmaVud1TUfOHR+khTjoJ9Gg7JztyBt4IxYqHUZ5kYpfMo36r9sjyHjb8hXrA
	0+PbkwJfpbNGR59G7k5K+OXJtuu6QvykWojGF7zxw/KcK177Vd3PvZAlogn5sdxDEU2bPLVtoRj4b
	5QIcm7KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhRix-0000000HYIZ-3XyE;
	Sun, 18 Jan 2026 12:17:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhRiw-0000000HYIL-3dhx
	for kexec@lists.infradead.org;
	Sun, 18 Jan 2026 12:17:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B0B686000A;
	Sun, 18 Jan 2026 12:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31F1C116D0;
	Sun, 18 Jan 2026 12:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768738661;
	bh=qmv8ORmWnoMxTVCGZbpQws3WnDSwMW0jSLeuj6yOg98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4Jl3OVO8i4mu1TXuQhW1sD/XctkNy7uFszi75HK+aJXhJHpL2KQZr2ANDSkMlQUy
	 PCzDhkSfM1NGk3EsQko9irugSftavEIRviuFThXWk4I1M/Nlrte3sIQp1kDWLdf00K
	 RhRD7/mBnqOs6tV+Qm8UIe8XwSTDlNcESitXWx1Ox0Fl1YfpMR+SirMEveVQZ9PQqA
	 mzZNbQnlcuapCX79UiwV782t3rail8MeDGYsmZ3xY8DJGF3Y0Wd9VTMQJvWTAyy0eQ
	 NJIT/Bz20eAlmVH2Jct+OLTb8Yy2bidlSXNn7smWCVn7FBc3bUKf8+xzw8cLH+Ld/s
	 ZL7gaiciEr3Mw==
Date: Sun, 18 Jan 2026 14:17:33 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>,
	Jason Miu <jasonmiu@google.com>
Subject: Re: [PATCH] kho: print which scratch buffer failed to be reserved
Message-ID: <aWzPXXqc_jWjh4rD@kernel.org>
References: <20260116165416.1262531-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116165416.1262531-1-pratyush@kernel.org>
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

On Fri, Jan 16, 2026 at 04:54:11PM +0000, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> When scratch area fails to reserve, KHO prints a message indicating
> that. But it doesn't say which scratch failed to allocate. This can be
> useful information for debugging. Even more so when the failure is hard
> to reproduce.
> 
> Along with the current message, also print which exact scratch area
> failed to be reserved.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

