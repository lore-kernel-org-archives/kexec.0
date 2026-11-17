Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D6E606A8A7
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Q6FphMV4;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=znQ1nDnI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Z5C4RujqYa7rNsHZWdwamxL4wXW4pZCK+kg2c9d4mPM=; b=Q6FphMV4t4JEdhh5cgw4sGXlal
	bvirRqlnnmzRDhZw0dPPnDgeLddPtuEfdFRcWyjmLvJ5n7WyzgfbtFWrLbzfhEjeW5lMKLo4zKK8+
	vOJ9UblxeE9u14vBu31+FfhWEMOKHsYZ37Zsi53bTQiZYfR33tWH6yKz7WMPJjjN/qEmosMnJ0mLL
	QNR8oQUTqLHFLQksGk7A4ni7Qi5Y4u23DHZhko4iUyPktsGTfFlYX33HiD7f8fIOwzL7Yd4ke+WCV
	pV19xB2tNr02Gv/r+nIoioYFgaBSY1V/Qte6iuraaqC0poqot5MQ/WpIWnPRYro3eJOM39QJAL9MZ
	A5K+ptSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTFYQ-000000055yq-1rxG;
	Tue, 17 Nov 2026 09:32:42 +0000
Received: from canpmsgout10.his.huawei.com ([113.46.200.225])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTFYN-000000055rL-0hOM
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 09:32:41 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Z5C4RujqYa7rNsHZWdwamxL4wXW4pZCK+kg2c9d4mPM=;
	b=znQ1nDnIdWf9SGMir8UIlbfd1jTstZak29Z+HUh5ZxqFySQz6O3w3Y7VekesEJPsZMNdlghDe
	m1KpNMMAyhtae1KajqunOWgzPIUE0wWxVYiqiLrWJsGOR6MIv3edgRAo4y282N0y/YW9cIDyZ67
	yfhV+AfzdiC5S+12IgP7kAg=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jTKJM1X4Nz1K9Xr;
	Tue, 17 Nov 2026 17:32:19 +0800 (CST)
Received: from kwepemo200009.china.huawei.com (unknown [7.202.195.26])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D4A24055B;
	Tue, 17 Nov 2026 17:32:32 +0800 (CST)
Received: from localhost.localdomain (10.50.159.234) by
 kwepemo200009.china.huawei.com (7.202.195.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 17 Nov 2026 17:32:31 +0800
From: Long Wei <longwei27@huawei.com>
To: <rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<akpm@linux-foundation.org>
CC: <graf@amazon.com>, <leitao@debian.org>, <corbet@lwn.net>,
	<rdunlap@infradead.org>, <linux-mm@kvack.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hewenliang4@huawei.com>, Long Wei <longwei27@huawei.com>
Subject: [PATCH 2/2] docs: kho: describe the in/blobs debugfs file
Date: Tue, 17 Nov 2026 17:29:51 +0800
Message-ID: <20261117092951.4017931-3-longwei27@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117092951.4017931-1-longwei27@huawei.com>
References: <20261117092951.4017931-1-longwei27@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo200009.china.huawei.com (7.202.195.26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_013239_385822_55D1675B 
X-CRM114-Status: GOOD (  10.56  )
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The incoming sub-blob raw nodes under kho/in/sub_fdts no longer exist:
the sub-blob pages are owned by their consumers and may already be freed
by the time the debugfs view is created, so exposing them was unsafe.
Document the in/blobs metadata file that replaces them.

Signed-off-by: Long Wei <longwei27@huawei.com>
---
 Documentation/admin-guide/mm/kho.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/kho.rst b/Documentation/admin-guide/mm/kho.rst
index 902d171a780a..602c8ce90e9a 100644
--- a/Documentation/admin-guide/mm/kho.rst
+++ b/Documentation/admin-guide/mm/kho.rst
@@ -118,6 +118,6 @@ stabilized.
     device tree. This file may disappear when all consumers of
     it finished to interpret their metadata.

-``/sys/kernel/debug/kho/in/sub_fdts/``
-    Similar to ``kho/out/sub_fdts/``, but contains sub blobs
-    of KHO producers passed from the old kernel.
+``/sys/kernel/debug/kho/in/blobs``
+    Metadata for the sub-blobs referenced by the incoming FDT. Each line
+    contains the name, physical address and size of a sub-blob.
--
2.43.0

