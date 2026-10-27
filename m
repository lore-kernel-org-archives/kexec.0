Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA55606A322
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Wvcc8GZz;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvXXwyCu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=k9SppgYxlUdd5nAVm8BiImH/4wxn+yjRYEqQSQtPBHU=; b=Wvcc8GZzz6fqurxclANxKsESMN
	w/3aR+Bw/1tHJxbKXRaQHkzdo06WG1YtfEYCD/X3qdJFwgBnoYbXqlaTmQfNISiQhHdXJOo8ezkEB
	Jh3eeqqX0xkt9JSgHoKIe4bVMs1ieJ9zUFMZ9H6DJ9doMgUydjlqiPaa2LeqDqJGyZJOSAWkKbL/0
	kscCzckx00Gq9I/IjhlqVcG8kTUq/8sND2m8pA5PSrPaC3pGyD2nkhGcgK62geXqLP5jnmtizMPUz
	Es9sn3LFK/WaJKyKcCS7pI1xIksJ17eCEJsyM8Y47RwdD10SlGbtyr19kgRhnoXj5TpdzCrbwyara
	4x62oXBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLl0e-00000005Sr3-0tLH;
	Tue, 27 Oct 2026 17:30:52 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLl0d-00000005Sqh-0T4U
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 17:30:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A813860142;
	Tue, 27 Oct 2026 17:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9671F01825;
	Tue, 27 Oct 2026 17:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793122249;
	bh=k9SppgYxlUdd5nAVm8BiImH/4wxn+yjRYEqQSQtPBHU=;
	h=From:To:Cc:Subject:Date;
	b=TvXXwyCuQe+su5CB6Yk1L0Z5PYM0JO1lcGmzJpnwcdYC9fH8qSjHWcjgzspNCzA9d
	 sjPwgTN4D6lXRKPJvrp2VaeOd4k/mwuDnwsigLs0aZwaF1n0m5leaFQcaUfcWyZNxO
	 1MLfxUUBrPPJIqiPlPIZ/j6avZmhv9eobEHrUKu9BQNGofiP5mlBtGXvG+QitNd6pV
	 8W57j7e3/U0Fbp5gWTQSLaaeia2bkiMkAm/imNCpfaDn8aqKVMdrqk/TfD5MisQ6Kc
	 KtMcLTCERiXZ9tYzaQSVyNrQZ4bVBF5ZfgNS3SOs78yXqp8F9DUlEBwat2cB/HLSAv
	 84xUsHMOVUyRg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Subject: [PATCH 0/3] mm: allow freezing mappings
Date: Tue, 27 Oct 2026 18:30:25 +0100
Message-ID: <20261027173031.763213-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Hi,

This series allows freezing the mapping of an inode. The main user is
memfd_luo. It serializes the state of the mapping and needs to make sure
it does not go out of sync. Currently it does so via a combination of
pinning and internal flags. But this functionality will be used by
HugeTLB and guest_memfd preservation in the future, so this series makes
the feature generic.

The idea came from David Hildenbrand during my presentation on HugeTLB
preservation at LSF/MM/BPF this year. He originally suggested putting it
in the VFS layer, but I find the page cache to be the appropriate layer
for this, since it is the i_pages that memfd_luo serializes.

Patch 1 is a cleanup that also came as a suggestion from David. It is
useful for this series since the freezing change exposes a race with
shmem_writeout(), and this patch fixes this, along with other
improvements including preservation performance. It can be taken
independent of this series, but for now I am including it here.

Patch 2 is the main one. It adds AS_FROZEN, and adds helpers to set it,
and adds checks in filemap core.

Patch 3 updates shmem and memfd_luo to use AS_FROZEN.

My local sashiko has complained about some more minor things, but this
is my first foray into the page cache and I am not even sure this is the
right approach to begin with. So I'd much rather find out early if this
is the wrong approach.

The series is based on mm-unstable. It has a minor merge conflict with
liveupdate/next, but I can fix that up after the merge window. I see
this mainly as a MM change, so I think this should go through the MM
tree.

Regards,
Pratyush Yadav

Pratyush Yadav (Google) (3):
  mm/memfd_luo: don't use memfd_pin_folios()
  mm: allow freezing i_pages
  mm: shmem: use mapping_set_frozen() for memfd preservation

 fs/inode.c               |   9 ++
 include/linux/pagemap.h  |  35 +++++
 include/linux/shmem_fs.h |  17 ---
 mm/filemap.c             |   7 +
 mm/huge_memory.c         |  10 ++
 mm/khugepaged.c          |  12 ++
 mm/memfd_luo.c           | 291 +++++++++++++++++++++++----------------
 mm/migrate.c             |  14 +-
 mm/shmem.c               |  34 +++--
 mm/truncate.c            |  16 ++-
 mm/vmscan.c              |   3 +
 11 files changed, 302 insertions(+), 146 deletions(-)


base-commit: 39274b454e9993cea319f4ac342a8082a9ee1730
-- 
2.56.0.307.g5fe7bd680c-goog


