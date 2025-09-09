Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA541CAC58C
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UrfLjqoesH2Mdwkd1Uq8kj4vRyvm4Z28yUkSYQofXQg=; b=4GdI5Nvgl6xN7ng7+99HTFGfjK
	xkjT0EVO/hsmJt/uli7K2ylsMXT/vopq9B8+9JrRbOW9Uh02eMC2YPLWtINOQQAn5MJmn5VMtjKmU
	CG514l487Y2szk/c0e9XviN1uHHItbsN29lJroWQpE54p9mAnP6orz/2f+dV91HzVeXRPjkSsMWNQ
	Ks1J+x81R+xKgXtZfZHxRD4OquMBFpr2ISAatXE3RTAwGkh0CwCQ2NwN7Gm19RWAeGvmS8qjB6EOr
	bE3KDM2ilLbYYXPbrKbleBZt1Hgh/pqhG5I3Lnb+34ZigTjgCmhElg6z1a0MxDXGlmbum2aGoKqnW
	0Xp4b38A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw21s-00000008xdM-3KVa;
	Tue, 09 Sep 2025 17:21:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvzaH-00000007p2L-46Jj
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 14:44:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 650E660224;
	Tue,  9 Sep 2025 14:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0B7C4CEF4;
	Tue,  9 Sep 2025 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757429077;
	bh=gr1qOquHmGnAq/jY71lVBf8+IAgpqOxYBEJiNJgw11k=;
	h=From:To:Cc:Subject:Date:From;
	b=XOdIY1Bvtm5/HQ3Iyd6I4zi6z1teXURtfIj2qsCbBwJ/B1fq91940d14ku6nZXAvy
	 FGHtQINugOPSfPhRObkdKVa9fSZ6opE3H8hSg786egjE+xrPstMsKjm23QyM28TiAu
	 7WW5PZEasI6WKDsH7p2byHV6ODIq2pMKA2+HSAINeyH+Gg7K61cbc8Cltw9+HxvspL
	 PKOhjeQB3g63ev+XnJvDNQnHq3RAVyh5EySucVBhOU5M55Yo0XArUFsuWYZFZktJ9n
	 kIShKdzJCeqyf5m/Nxt02v/gGZkoEs9q7wJC03XHc6IT3Ss5CMrghedNAemAk1gy5O
	 QEZy1m3N9IiVg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/4] kho: introduce the KHO array
Date: Tue,  9 Sep 2025 16:44:20 +0200
Message-ID: <20250909144426.33274-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi,

This series introduces the KHO array concept, and to demonstrate it in action it
converts the perservation bitmaps to use it. It also takes Mike's vmalloc
preservation patches v2 [0] and ports them to use the KHO array as well. The
memfd preservation proposed in [1] can also be a user of this.

The main idea behind the KHO array is to build fundamental and flexible
serialization data structures that other layers can use to make their logic
easier. There was extensive discussion on this topic in [1]. This series
provides actual code in action to give more substance to that discussion.

Patch 1 adds the KHO array. Read it for more details on the data structure.
Patch 2 converts the memory preservation bitmaps to use KHO array. Patches 3 and
4 are from Mike's vmalloc series [0] and are modified to use KHO array instead
of open-coding the linked lists. The full git tree can be found at [2].

When converting the two users to the KHO array, I think it did make the
serialization logic simpler for both. The actual judgement of whether this is
"worth it" is of course subjective, but I think this should at least give
everyone a clear idea of how it looks like.

[0] https://lore.kernel.org/linux-mm/20250905131302.3595582-1-rppt@kernel.org/T/#u
[1] https://lore.kernel.org/linux-mm/20250807014442.3829950-30-pasha.tatashin@soleen.com/T/#u
[2] https://git.kernel.org/pub/scm/linux/kernel/git/pratyush/linux.git/tag/?h=kho-array-rfc-v1

Mike Rapoport (Microsoft) (2):
  kho: add support for preserving vmalloc allocations
  lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in
    fdt

Pratyush Yadav (2):
  kho: introduce the KHO array
  kho: use KHO array for preserved memory bitmap serialization

 MAINTAINERS                    |   2 +
 include/linux/kexec_handover.h |  21 +++
 include/linux/kho_array.h      | 300 +++++++++++++++++++++++++++++++++
 kernel/Makefile                |   1 +
 kernel/kexec_handover.c        | 291 +++++++++++++++++++++++---------
 kernel/kho_array.c             | 209 +++++++++++++++++++++++
 lib/test_kho.c                 |  30 +++-
 7 files changed, 768 insertions(+), 86 deletions(-)
 create mode 100644 include/linux/kho_array.h
 create mode 100644 kernel/kho_array.c


base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.47.3


