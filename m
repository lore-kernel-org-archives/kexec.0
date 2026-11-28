Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF81606A31F
	for <kexec@archiver.kernel.org>; Sat, 28 Nov 2026 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=weupYLdn;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SQJC7cRS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=uXPgXvBJT57DR1S+V3IBkpL9Dt6mi6Z/uuu7CuFzrb8=; b=weupYLdnWoaLWlSpVXLBrySAVW
	wJe9kq0bTkdiemk7mz4YbX5RHvSHXNyNvxk1PtisgF1jX3M7Jbf9VRTxGEef6PZ7dBd/Q9lUBZElY
	2GfFCPenxuQc/GfQ1WMY++9aHqwtAInlI+xJknGsxdI7hXFG5EgQNcPIXrN+Po6BS8JW0FiDQM4rU
	84QFVmH7VgDZbKL+T3N7vvSKKYDIR3WTTGS4dAzLzaorRvYBULOTz6T0uQyyZUlb2dd17DGqaFOpf
	eNfC2dJSTh5c0dE4s8LyxyjwCxOywxl/xPkqs9kqIC6v213QK93IdoF8Xml+hOGAILZR/6AU06kq+
	4uw/fFLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXCqR-00000000TAM-0wkU;
	Sat, 28 Nov 2026 07:27:39 +0000
Received: from canpmsgout08.his.huawei.com ([113.46.200.223])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXCqH-00000000T6k-3Apk
	for kexec@lists.infradead.org;
	Sat, 28 Nov 2026 07:27:37 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uXPgXvBJT57DR1S+V3IBkpL9Dt6mi6Z/uuu7CuFzrb8=;
	b=SQJC7cRSWEjLbpHqVRB+BqMMel7rrly3hil4T6/9JLroEsRPJ7J9axzhBt/AYqMCverJa6To+
	QQ51V35MLf4A36Vab01XTQM1VnVkLvh4PzsAyivPZ0/YlnEt0SJ2jsw8YAngiu3b+uGKW7Ew8JY
	jZJzF/KYZUPKeMGBczEfZCo=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jc20Y6V9FzmV6J;
	Sat, 28 Nov 2026 15:26:53 +0800 (CST)
Received: from kwepemo200009.china.huawei.com (unknown [7.202.195.26])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C12D40586;
	Sat, 28 Nov 2026 15:27:19 +0800 (CST)
Received: from localhost.localdomain (10.50.159.234) by
 kwepemo200009.china.huawei.com (7.202.195.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 28 Nov 2026 15:27:18 +0800
From: Long Wei <longwei27@huawei.com>
To: <rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>
CC: <shuah@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <hewenliang4@huawei.com>, Long Wei
	<longwei27@huawei.com>
Subject: [PATCH 0/2] mm: memfd_luo: pick up seals added after preserve at freeze
Date: Sat, 28 Nov 2026 15:24:42 +0800
Message-ID: <20261128072444.1114964-1-longwei27@huawei.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo200009.china.huawei.com (7.202.195.26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_232732_315297_A0C8A0DC 
X-CRM114-Status: GOOD (  12.85  )
X-Spam-Score: -2.8 (--)
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

A seal added to a memfd after the memfd was preserved with a liveupdate
session is accepted without any error, but the seal is silently gone once
the kexec handover is over: the retrieved memfd no longer has it.

memfd_luo_preserve() snapshots the file seals, but userspace may keep
operating on the memfd until the handover, so the preserve-time snapshot
is naturally incomplete.  memfd_luo_freeze() never re-read the seals and
memfd_luo_retrieve() replays the stale snapshot, so seals added in the
window between preserve() and kexec were dropped without any notice.

Patch 1 re-reads the seals at freeze time, mirroring the file position
handling: freeze is the last snapshot point before kexec and the only
place where the final value can still be sampled and, when it diverged
from the preserve-time snapshot, validated while the live update can
still be aborted.

Patch 2 adds a kexec round-trip selftest that adds F_SEAL_GROW after
preserve and asserts that the seal survives the handover.

Tested on arm64 and x86_64 with two consecutive kexec handovers each:
with the fix the seal survives and dmesg stays free of new warnings.

This series applies on the current next branch of liveupdate.git,
where the file is still named memfd_luo.c. I am aware of the
pending "mm: Rename memfd_luo to shmem_luo" series. If that series
lands first, a trivial s/memfd_luo/shmem_luo/ rebase will be needed,
which I am happy to provide.


Long Wei (2):
  mm: memfd_luo: pick up seals added after preserve at freeze
  selftests/liveupdate: add seal-after-preserve kexec test

 mm/memfd_luo.c                                |  27 ++-
 tools/testing/selftests/liveupdate/Makefile   |   1 +
 .../liveupdate/luo_seal_after_preserve.c      | 170 ++++++++++++++++++
 .../selftests/liveupdate/run-vmtests.sh       |   1 +
 4 files changed, 197 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/liveupdate/luo_seal_after_preserve.c

-- 
2.43.0


