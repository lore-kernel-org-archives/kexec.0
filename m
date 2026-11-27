Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B3606A332
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kLfkisP6;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqTI2cWq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=vIra0SPO6KCMA7V7+wMdA0YK65SWM0LHFYgUPK6Xstg=; b=kLfkisP6jDAtbcR6mpvfr3Q/hY
	FpTsR1xRm2b7+1zUZe7opknQbP1gi39f270oPLCxrdHqEGGQO125xs0Q1S9/k2D/hNyxuUdwrqoph
	l++l08fjm+i0wuzSHabpGKI6jnAmpxXJS2r1bmv8hn00eMMq20k1lskwNFcJ0KCN89CchEtuHJQMp
	nlfFRXZLRje/Ebyy2+d4BO3zSFscPahx7Q4qWFZwogqS1r8S//qjkORlwk8OUYjseIKSL5+RQk37y
	RIi/s7jMfcn6z7OCYBazuTnsVYB0oIFt9eWDYhrgbZaKhsbKrbfL7qFCwEvXFDkzq4HudeA5fqFuU
	rj5FWcUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWv1T-0000000G7Es-2kKc;
	Fri, 27 Nov 2026 12:25:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWv1P-0000000G7EI-3bgP
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 12:25:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5102761D96;
	Fri, 27 Nov 2026 12:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1CD1F000C1;
	Fri, 27 Nov 2026 12:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795782346;
	bh=vIra0SPO6KCMA7V7+wMdA0YK65SWM0LHFYgUPK6Xstg=;
	h=From:To:Cc:Subject:Date;
	b=NqTI2cWqT7sayH9ORaHeylVAF7fwQWncs7cD1N5+FvdBR+UTvK99Alc4u8fqJafnE
	 UZ86EaZGc/EuW4a0MJrKqXsyQ8vQXSr8yL+e1C6Nobnr8pCzSPZK21j6YlULugFMmy
	 R7e6RX27cnS5xW1ZtCxapH03I4ZLO7oRXvUXi+Wxe4L4XuR+X5bVnlXO7yBqxQnztI
	 pRFvRynI9ct60n6Jhz/RmUpKwi7PjWmNDUPEjm7keqf9tiZqIJcw2oDloU2wKC+vtr
	 EMvlxd73jP4ZtLE0d/kQftOpg9E8r+U8WMdPCT/CmUQ3TPBcl8t3ivNicv/1LtntRD
	 HWZWcPjbgMMyw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Matlack <dmatlack@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/6] kho: housekeeping
Date: Fri, 27 Nov 2026 12:25:26 +0000
Message-ID: <20261127122536.3708770-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Hi,

This series is a collection of miscellaneous cleanups for KHO. The
patches are all independent of each other for the most part. They are
kept in a series mainly to keep things easier to track and manage.

Patch 1 is lifted from [0]. All others are new.

[0] https://lore.kernel.org/kexec/20261116134013.1636689-3-pratyush@kernel.org/

Regards,
Pratyush Yadav

Pratyush Yadav (Google) (6):
  kho: build KHO objects into a single kho.o
  kho: use acronym for KHO .c files
  kho: move kho_{block,radix_tree}.h into include/linux/kho/
  kho: use unsigned long for kho_preserve_pages() and co when KHO=n
  kho: fix kernel-doc return for kho_alloc_preserve()
  kho: don't reference subtree blobs as FDTs

 Documentation/core-api/kho/index.rst          |  6 +--
 MAINTAINERS                                   |  3 +-
 drivers/pci/liveupdate.c                      |  2 +-
 include/linux/kexec_handover.h                |  6 +--
 include/linux/{kho_block.h => kho/block.h}    |  0
 .../{kho_radix_tree.h => kho/radix_tree.h}    |  0
 kernel/liveupdate/Makefile                    | 12 +++--
 kernel/liveupdate/kho_block.c                 |  2 +-
 .../{kexec_handover.c => kho_core.c}          |  8 +--
 ...kexec_handover_debugfs.c => kho_debugfs.c} | 54 +++++++++----------
 ...xec_handover_internal.h => kho_internal.h} | 10 ++--
 kernel/liveupdate/luo_core.c                  |  2 +-
 kernel/liveupdate/luo_internal.h              |  2 +-
 kernel/liveupdate/luo_session.c               |  2 +-
 14 files changed, 56 insertions(+), 53 deletions(-)
 rename include/linux/{kho_block.h => kho/block.h} (100%)
 rename include/linux/{kho_radix_tree.h => kho/radix_tree.h} (100%)
 rename kernel/liveupdate/{kexec_handover.c => kho_core.c} (99%)
 rename kernel/liveupdate/{kexec_handover_debugfs.c => kho_debugfs.c} (75%)
 rename kernel/liveupdate/{kexec_handover_internal.h => kho_internal.h} (87%)


base-commit: fcddbfa7a3693f1225a4d32b28401543b3bbedaf
-- 
2.56.1.839.g22a8290db9-goog


