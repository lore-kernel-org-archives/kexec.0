Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CEBFF8860
	for <kexec@archiver.kernel.org>; Mon, 27 Apr 2026 16:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jC5Ajr4a4rXVj9lOYr6ncLyoFPtYegjs3bNCdujjCOU=; b=Q5zuUjEk2q1SpjMCwGf+N4hqvY
	50lVw/XKioNl+mlT0sbMu3nNE7Dy+dgOFc46E7Kr/VdT028UzCOAM1Po2a0jhe3knRjxw/qksPzSP
	whdK+8cqXPUaMpncpRghoceMwSdOm/K3uBL7Cno3Ow4RDkW57QM2jID+Xz0zOH4wOB/2h/TTJ+/tu
	PZJITyKyLfmfgJmVE7BZVU7Qjm38GfwVo70xV/n3ELqb8FpEFX3UCMaHFl3yG6imnorAA/mvRGhB5
	R3Cwz7QYz3rhAgD4jjC/qBk3Vb8rLtOerRXQ+wfgh7HqBmhbMe9rO1I/hT/9C4AZdbzsBwcg3TwOk
	gHlmZD5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHOi7-0000000HLnO-3QLw;
	Mon, 27 Apr 2026 16:21:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHOi5-0000000HLmH-21f0
	for kexec@lists.infradead.org;
	Mon, 27 Apr 2026 16:21:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B8F3343919;
	Mon, 27 Apr 2026 16:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC569C19425;
	Mon, 27 Apr 2026 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777306884;
	bh=Qn6KG8K9yrtcG327jkMoStft/n8GyYVwtBTkac6FJZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mHpyoUJWSEbFh+Lkh0+aQpZHuWd2gyE0vKYYeDA/AVyUCe21NPRrGQ1fY+FlJn2A2
	 JJx/ZD0h7gFf6QPiOm84qB6YwSATbPZPYyvohxYNXSHBXoNMUWgejdpxu9SyQGvhNO
	 uSrn1EPskbnnZ5urRPGWjQ9neKN4tCOO4e5UnsfaW+W9ysb95OryKPMn/BUu20sksF
	 +5rzCgytas/KkeEhYV0wBESiuUi7YydhnlHljcZtXNWVwYrFvBZpG2wDYbejzQsbdA
	 siF7uJTsFfhS7ILMBAWRC0WSSfT3cUnkDFjrqrJ7Ksls3D+gEzrF/mIFkaeuoDSAxA
	 hXGpByAbc+GUg==
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	Michal Clapinski <mclapinski@google.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v9 0/3] kho: add support for deferred struct page init
Date: Mon, 27 Apr 2026 19:21:01 +0300
Message-ID: <177730685404.1888067.9769034341045819620.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423122538.140993-1-mclapinski@google.com>
References: <20260423122538.140993-1-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_092125_540370_C7B55A31 
X-CRM114-Status: UNSURE (   8.43  )
X-CRM114-Notice: Please train this message.
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

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Thu, 23 Apr 2026 14:25:35 +0200, Michal Clapinski wrote:
> When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, struct page
> initialization is deferred to parallel kthreads that run later in
> the boot process.
> 
> Currently, KHO is incompatible with DEFERRED.
> This series fixes that incompatibility.
> 
> [...]

Applied to next branch of liveupdate/linux.git tree, thanks!

[1/3] kho: fix deferred initialization of scratch areas
      commit: fe60961059eee7a3a303454c827bb347c45612c1
[2/3] kho: make preserved pages compatible with deferred struct page init
      commit: d4835433f4f6b5d618955a6a6eeb3e9f8b2b725e
[3/3] selftests: kho: test with deferred struct page init
      commit: eee13213401bafb7ffe3b447adffb1f570b9d813

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: next

--
Sincerely yours,
Mike.


