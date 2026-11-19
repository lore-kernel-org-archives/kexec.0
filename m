Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE0606A331
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Omk/zUHO;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=W4uSz27O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qmyNQOgDSlHi7bLgEAYFmsoW4l6Q4fZQE6fLWxCxItw=; b=Omk/zUHOZp6dPMFGhKoqj7GzZF
	ugbbVdbKsff6kqkF1mCV0wLpoFfAsUy8L4TBuLkDHSAUkoHv1Vk/lAqT22ZrmaiHbE6zB0xgTY4CJ
	CYATKwlWOQnErmxIo15NBlzI4+wD6BwGpSE44tVB82B2Uhc6eNGnv4cZq+LfvZ17JdRPP9tqgillg
	wKS56lToolM/IPX1GtXIFks+ca/cXPURq0F4dDiJb89C/d/7vPR7csjzQUizmvNeEWCc/Kqtn3xe6
	+mG7kIS8HLFxRoG5M9NTiR9TNKNPRJbKelaNOiG9QROmMRXK0yNFLmmm7hd1JiNDtDpT1SDrzcDA7
	uqLwiTyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTvpL-0000000B0nz-1X6j;
	Thu, 19 Nov 2026 06:40:59 +0000
Received: from canpmsgout03.his.huawei.com ([113.46.200.218])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTvpI-0000000B0la-0Vn2
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 06:40:57 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qmyNQOgDSlHi7bLgEAYFmsoW4l6Q4fZQE6fLWxCxItw=;
	b=W4uSz27OCn1hv14o2GwFcqRRNsK4bkfn/keWtNk8SFs3aS5cQC/aXA8NrNCJBiXIS7NWYn3rB
	am2gUnQr+JiglTJSQs/cy4O9g0qu8V6w1mUYELJ9F3e5Cv95XWWdjExwCPEvZ/SLq7sPq+wHIT4
	7gVJPorGh8kEDTF1Bk3DywE=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jVTNW2yFKzpSvH;
	Thu, 19 Nov 2026 14:39:55 +0800 (CST)
Received: from kwepemo200009.china.huawei.com (unknown [7.202.195.26])
	by mail.maildlp.com (Postfix) with ESMTPS id DFA844056E;
	Thu, 19 Nov 2026 14:40:46 +0800 (CST)
Received: from localhost.localdomain (10.50.159.234) by
 kwepemo200009.china.huawei.com (7.202.195.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 19 Nov 2026 14:40:46 +0800
From: Long Wei <longwei27@huawei.com>
To: <rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<akpm@linux-foundation.org>
CC: <graf@amazon.com>, <leitao@debian.org>, <corbet@lwn.net>,
	<rdunlap@infradead.org>, <linux-mm@kvack.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hewenliang4@huawei.com>, Long Wei <longwei27@huawei.com>
Subject: [PATCH v2 0/2] kho: drop the incoming sub-blob debugfs view
Date: Thu, 19 Nov 2026 14:37:58 +0800
Message-ID: <20261119063800.698863-1-longwei27@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117092951.4017931-1-longwei27@huawei.com>
References: <20261117092951.4017931-1-longwei27@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo200009.china.huawei.com (7.202.195.26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_224056_334865_714E9864 
X-CRM114-Status: GOOD (  10.63  )
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kho/in/sub_fdts exposes the raw contents of the sub-blobs described by
the incoming KHO FDT.  KHO does not own those pages: they belong to the
producers' consumers and have independent lifetimes.  LUO, for example,
restores and frees its state in early_initcall, before kho_init()
(fs_initcall) creates the debugfs view, so the blobs point at pages that
are already back in the buddy allocator.  Reading them triggers a KASAN
use-after-free in _copy_to_user().

The same information is already available to user space from in/fdt,
which KHO does own and which stays reserved.  Drop the directory rather
than adding another interface to describe it, keeping the -rc fix small.

Patch 1 removes the interface, patch 2 drops its documentation.

Changes in v2:
- Drop the in/blobs metadata file entirely
- Just remove in/sub_fdts to fix the UAF, no replacement interface
- Update Fixes tag to c609c144b0e8 (the commit that first added sub_fdts)
- Remove the now-unused #include <linux/io.h>

Long Wei (2):
  kho: do not expose incoming sub-blob contents in debugfs
  docs: kho: drop kho/in/sub_fdts description

 Documentation/admin-guide/mm/kho.rst       |  4 --
 kernel/liveupdate/kexec_handover_debugfs.c | 47 +---------------------
 2 files changed, 2 insertions(+), 49 deletions(-)

-- 
2.43.0


