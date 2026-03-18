Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1024010854D7
	for <kexec@archiver.kernel.org>; Wed, 18 Mar 2026 09:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CEeNeGSuoJbwavsVGKqIrrGpZX/tRWL23KECmmLaw5o=; b=bDg2F2bWPxpaP1UlMOzW82MSQh
	fp95JUtRx9vF0zk7P1LLYXmocJle7RtOmf2mehAQtGPy/+Ua3QSHKraWrBNpkJVk5jF0A69yk4tvK
	djkiP7Z1PzPY+k/S6dbRyibg7Qou9LzW3E4qXgPXrcPY5W0rMDEUdtJ+kFJi2bGZSnOcGEzQb3H6W
	ILdS2JQQ24t+zf+UhSUpUAyqC44SLl/FmZ5oB1Ee9kdbs8bB3l0mlmzQqQbZkYoJxG3JWV5+vVKdk
	IEUmEnNGIHITlHvi/lB8kV53GUdQ7qXue5/rmhNOtAussYvP/FciOmrxNEYOYN2jcTA4167WgvCz+
	NaeBzUxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2nI9-000000089SR-0fIc;
	Wed, 18 Mar 2026 09:34:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2nI7-000000089S7-2kyF
	for kexec@lists.infradead.org;
	Wed, 18 Mar 2026 09:34:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BF58160131;
	Wed, 18 Mar 2026 09:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834DCC19421;
	Wed, 18 Mar 2026 09:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773826454;
	bh=RNmLphyfgBoFzN7pwRjKveGHVFoZvoAzSTPSlQqJSbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qamBkgFmmvA2Gb1XpCOtLpa/pLT/8rI3SHSEPpp2OkOt5UqDx2qZT/QqYKxDgrx2N
	 auNVEDZQD45erneLBRq49YfmhkuK5IdkzUk2TUbiYSIN2Zgjj9jau8jp/2obyC1mlt
	 oiDCcn9ALby+qpo0uT2L18eWQqJy3pzpNQPrydq7ZbLA+B3GHaJ5KWHfS89obCvnvq
	 ZrNeEA9QqK6WY/l3FE9ahaKbNWHy99ZlxS0hcpwUnQMDVYBgBM3bsPBLYL2b1SekYN
	 sXCLHta8bd6bDdmYU9TPJnuA114W3jzhAU+OFP3XBQTOMiDMgACy9H3dKiD5v54H4X
	 zdUI6ziOS0f+g==
Date: Wed, 18 Mar 2026 11:34:07 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Clapinski <mclapinski@google.com>,
	Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] kho: add support for deferred struct page init
Message-ID: <abpxj3hOmNJlodvF@kernel.org>
References: <20260317141534.815634-1-mclapinski@google.com>
 <20260317104625.fd6a006871dcceaceafe990b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317104625.fd6a006871dcceaceafe990b@linux-foundation.org>
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

On Tue, Mar 17, 2026 at 10:46:25AM -0700, Andrew Morton wrote:
> On Tue, 17 Mar 2026 15:15:31 +0100 Michal Clapinski <mclapinski@google.com> wrote:
> 
> > When CONFIG_DEFERRED_STRUCT_PAGE_INIT (hereinafter DEFERRED) is
> > enabled, struct page initialization is deferred to parallel kthreads
> > that run later in the boot process.
> > 
> > Currently, KHO is incompatible with DEFERRED.
> > This series fixes that incompatibility.
> 
> Thanks, I've added this series to mm.git's mm-new branch for testing. 
> All being well I'll move it into the mm-unstable branch (and hence
> linux-next) in a few days.  All being well I'll move it into the
> non-rebasing mm-stable branch a few weeks hence.  Then into mainline
> during the merge window!
> 
> [1/3] and [2/3] aren't showing any review at this time, but the

They keep changing because of review comments, that's why there still no
tags for them,

> well-reviewed [3/3] is the meat of this series.

-- 
Sincerely yours,
Mike.

