Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74570606A8B7
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=M3RsSRQs;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=akHKDD3X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=kXfjSX8A0sMCwSrc1NZ9DdCD8p1mIiqPqqCInt2hce0=; b=M3RsSRQsfZbo8V5cCbe73DsvVt
	B8PACDTzTp+51VKaNdyhF82am2A9FHDxhsfCWftUnryoty1iQA5AYYr9D9QBWvC5quyJowL4/vvu+
	uPlRU4hu23Z1R8lSTpJArIGqqvJ+ForbMrFjl0bl9zc0NJ22rcXi4qDjzwcjt+YKAJh9Bw2Bg+OLj
	2iv42CO7BkDSqlry+TOHpSnu6Uv6njOkvWRNq8sorxsJVcIpdMHIxhD8NTm19CmM4xKywCTqmoh+b
	IjTSVvx078qVWU3Z7fPMJBp7olpukxmywBT4lNDqw/n6TBBZfB+o/dw+pKUwA1XCnLRMdtcuo9nOH
	LyVa9yFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTFYN-000000055uq-0OsB;
	Tue, 17 Nov 2026 09:32:39 +0000
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTFYJ-000000055pO-2PJG
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 09:32:37 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kXfjSX8A0sMCwSrc1NZ9DdCD8p1mIiqPqqCInt2hce0=;
	b=akHKDD3XFur+jgEm7qdeoTDQvtUIj3wMYu3N0UKMq91NlUGx2dBznwEFvtCsCCn9/iyCcX/A7
	pH8DowUtdDJ20EZLRab6ImOXhhKPaRGe0ZNw6+SGzwl3qr2It3xOXSGjJwU5d5Qg8V+C4WxjbM4
	EtkRZJz/82xI+rt0JH3IkVY=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jTKJF1tByzRhT6;
	Tue, 17 Nov 2026 17:32:13 +0800 (CST)
Received: from kwepemo200009.china.huawei.com (unknown [7.202.195.26])
	by mail.maildlp.com (Postfix) with ESMTPS id 398054057D;
	Tue, 17 Nov 2026 17:32:27 +0800 (CST)
Received: from localhost.localdomain (10.50.159.234) by
 kwepemo200009.china.huawei.com (7.202.195.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 17 Nov 2026 17:32:26 +0800
From: Long Wei <longwei27@huawei.com>
To: <rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<akpm@linux-foundation.org>
CC: <graf@amazon.com>, <leitao@debian.org>, <corbet@lwn.net>,
	<rdunlap@infradead.org>, <linux-mm@kvack.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hewenliang4@huawei.com>, Long Wei <longwei27@huawei.com>
Subject: [PATCH 0/2] kho: expose incoming sub-blob metadata instead of contents
Date: Tue, 17 Nov 2026 17:29:49 +0800
Message-ID: <20261117092951.4017931-1-longwei27@huawei.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo200009.china.huawei.com (7.202.195.26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_013236_122753_B4EA9603 
X-CRM114-Status: UNSURE (   8.87  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Incoming sub-blob pages under kho/in/sub_fdts are owned by their consumers
and have independent lifetimes.  Consumers restore and free them at their own
initcall level, which is always earlier than kho_init() (fs_initcall) where
the debugfs view is built.  LUO, for example, frees its state in
early_initcall, so in/sub_fdts/LUO ends up pointing at a page that has
already been returned to the page allocator.  Reading the file then triggers
a KASAN use-after-free in _copy_to_user(), with the backing page already
marked page_type: f0(buddy).

KHO does not own these pages, so it cannot safely expose their contents at
any point.  Instead of trying to track which blobs are still alive, replace
the raw blob nodes with a read-only in/blobs file that reports the name,
physical address and size of every sub-blob referenced by the incoming FDT.
The FDT itself is reserved by KHO and remains available as in/fdt.

The first patch does the change, the second updates the documentation.

Long Wei (2):
  kho: expose incoming sub-blob metadata instead of contents
  docs: kho: describe the in/blobs debugfs file

 Documentation/admin-guide/mm/kho.rst       |  6 +--
 kernel/liveupdate/kexec_handover_debugfs.c | 83 +++++++++++++++---------------
 2 files changed, 45 insertions(+), 44 deletions(-)

-- 
2.43.0


