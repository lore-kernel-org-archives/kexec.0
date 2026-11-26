Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4946606A323
	for <kexec@archiver.kernel.org>; Thu, 26 Nov 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i9OCfipq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGPLwRl5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hZduP2sQE9gkeUneqSWpAXjGsaRT+wkgF+eZBdvryg4=; b=i9OCfipqdVbzky
	PGYBjITkCYFTLkJr1r4nfHGDYtkMBCWnvOe1/vkDd7XCuT00BtA0pRnyGVgz4/6AnXQGJQiA8z5Ol
	ZwW6hmkFWhCydGPhWCFtWkY14SLTVOJCwjGLxKdZCSWguRFbW9Ji5MCsYdSExSqJvNfcSIdnZVVEx
	DK/GMUkrs4FYfl+jFymzoi0PBWvIEnQlqP+25T7HKWAc1t0oh+1fyE6w3ThimigStrBUOIVpQgPhJ
	umH6gT5oEPDSNhRwcu09+MZc7mvHy9px0aI19ya9+vnXlLsWGuGGpFN3NpLVRHNyQzIGcg1exsKH9
	FN+4hk67AA6PsCtu4SbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWXue-0000000D34n-277S;
	Thu, 26 Nov 2026 11:45:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWXuc-0000000D33R-1iEO
	for kexec@lists.infradead.org;
	Thu, 26 Nov 2026 11:45:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1C5E14096F;
	Thu, 26 Nov 2026 11:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408FF1F00AD3;
	Thu, 26 Nov 2026 11:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693513;
	bh=hZduP2sQE9gkeUneqSWpAXjGsaRT+wkgF+eZBdvryg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LGPLwRl5itV+aeR1X/ZTZEjZE9n7QTLS5WeN9wxiW5eJ+G3sNzUwTPUhdM6f95cI3
	 aEYQD/hdunuQJwqmxqetz9p3RsnaENUjUysATniX8cgDzy6/Apr/7YiWo4XXltcpFY
	 texh2cyxoIfGpf/OSY8vfmoW5wBEwBkctQeKz8cubK2CTWZ7kXJGQp5heASixPFUN5
	 P5jO2b6AAEhzGMVLOPSi1bcr8jZgsPz8XSIZy14ZvCw0ANQuUD9R0ZJysBe43/BKOH
	 pbVGrivRY2h/2vaKGSZoHxfAHfYq+R3LlaLNYMqvmXoYp/E+39CgDHSYmNdvHy4lMV
	 tQQCFWro6PQvQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	"Srivatsa S. Bhat (Microsoft)" <srivatsa@csail.mit.edu>
Cc: Mike Rapoport <rppt@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] MAINTAINERS: Add missing files to KEXEC, KHO and KDUMP subsystems
Date: Thu, 26 Nov 2026 13:44:54 +0200
Message-ID: <179569348035.4110350.13594456540362973475.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124-fix-kexec-kdump-maintainers-v1-0-79c6a6144de4@csail.mit.edu>
References: <20261124-fix-kexec-kdump-maintainers-v1-0-79c6a6144de4@csail.mit.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Tue, 24 Nov 2026 01:37:52 +0530, Srivatsa S. Bhat (Microsoft) wrote:
> Several files relevant to the KEXEC, KHO and KDUMP subsystems are
> currently not listed against them in the MAINTAINERS file, which would
> cause scripts/get_maintainers.pl to miss recommending these subsystem
> maintainers or mailing lists for changes to those files. This series
> addresses those gaps.
> 
> These patches apply on on top of Mike Rapoport's series:
> "arch, kexec: declare kexec and crash capabilities in Kconfig.kexec"
> 
> [...]

Applied to kexec-7.5 branch of liveupdate/linux.git tree, thanks!

[1/2] MAINTAINERS: Add missing files to KEXEC and KHO subsystems
      commit: 77059f4e9b56d78e22b8fa55f294bb2b9ecef85b
[2/2] MAINTAINERS: Add missing files to KDUMP subsystem
      commit: fedac4c07bef7d3ad84110f51a8051e3655818f8

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: kexec-7.5

--
Sincerely yours,
Mike.


