Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13180C54E58
	for <kexec@archiver.kernel.org>; Sun, 24 Mar 2024 03:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pkJ1FgFY0j3OKYzNobyXq1oupHFbXvDwBSO1WuhtGV0=; b=o2t/SrYvSydQhG
	jCxP9ulKnM6qDtDZNW0niqIOzSFGOmQXiGWkubtZK8TBYNsSYjRl5YF8fACfcMllEIHfuk8JFB646
	D2/dFzqCznMliP+bErktpNYDNaIU371ANVDXL9QlB5w8EQ9TGbtgUkalJjDkIAs3mNde4q5CQbBvU
	8xTMD79XqTcHrxftvZUr8PBDBTtLW4wi7iekMyF38urJ8uRzZkd/7I0E61fR5YvOcd9IvaxqKuxcw
	haMosIIZK36MQerogAv3y+y6OgzAbrLWs0D738Z9tGmIGDlez4J6cV7hPDjBC2fMIIOvKTMfLhe1x
	DVYRsx41pRz1xyioNfqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roEe3-0000000BlAR-3M4M;
	Sun, 24 Mar 2024 03:35:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roEe0-0000000Bl9e-1XzI
	for kexec@lists.infradead.org;
	Sun, 24 Mar 2024 03:35:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711251332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uzc9OQ25tN5N05LxUi1HJqZiK0gR2H6bi1qq3O3hEtk=;
	b=S/FN1+imNZmDHBlVxWKvBY2r/0iqakB1Vmi5AkOOO1cmjNBnS+DQSqapt3230Yqmsol6Op
	HUiQTFuXxWIWz9msKg8T/Wcnwpg39ks/+8HJS25LXSsWyEVYEPeK+Lo3sLLz/3/nO0cfSb
	zgn/loZQbL2JgoPLhp5TkQOwE5OlTqo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-4wjq6wNqPhiuSHz20KU_ww-1; Sat, 23 Mar 2024 23:35:28 -0400
X-MC-Unique: 4wjq6wNqPhiuSHz20KU_ww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB404101A523;
	Sun, 24 Mar 2024 03:35:27 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB4C38173;
	Sun, 24 Mar 2024 03:35:21 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	akpm@linux-foundation.org,
	chenhuacai@loongson.cn,
	dyoung@redhat.com,
	jbohac@suse.cz,
	lihuafei1@huawei.com,
	chenhaixiang3@huawei.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH] crash: use macro to add crashk_res into iomem early for specific arch
Date: Sun, 24 Mar 2024 11:35:13 +0800
Message-ID: <20240324033513.1027427-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240323_203536_514041_6113E573 
X-CRM114-Status: GOOD (  11.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

There are regression reports[1][2] that crashkernel region on x86_64 can't
be added into iomem tree sometime. This causes the later failure of kdump
loading.

This happened after commit 4a693ce65b18 ("kdump: defer the insertion of
crashkernel resources") was merged.

Even though, these reported issues are proved to be related to other
component, they are just exposed after above commmit applied, I still
would like to keep crashk_res and crashk_low_res being added into iomem
early as before because the early adding has been always there on x86_64
and working very well. For safety of kdump, Let's change it back.

Here, add a macro HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY to limit that
only ARCH defining the macro can have the early adding
crashk_res/_low_res into iomem. Then define
HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY on x86 to enable it.

Note: In reserve_crashkernel_low(), there's a remnant of crashk_low_res
hanlding which was mistakenly added back in commit 85fcde402db1 ("kexec:
split crashkernel reservation code out from crash_core.c").

[1]
[PATCH V2] x86/kexec: do not update E820 kexec table for setup_data
https://lore.kernel.org/all/Zfv8iCL6CT2JqLIC@darkstar.users.ipa.redhat.com/T/#u

[2]
Question about Address Range Validation in Crash Kernel Allocation
https://lore.kernel.org/all/4eeac1f733584855965a2ea62fa4da58@huawei.com/T/#u

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/crash_reserve.h | 2 ++
 kernel/crash_reserve.c               | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
index 152239f95541..4681a543eba3 100644
--- a/arch/x86/include/asm/crash_reserve.h
+++ b/arch/x86/include/asm/crash_reserve.h
@@ -39,4 +39,6 @@ static inline unsigned long crash_low_size_default(void)
 #endif
 }
 
+# define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+
 #endif /* _X86_CRASH_RESERVE_H */
diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index bbb6c3cb00e4..066668799f75 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -366,7 +366,9 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 
 	crashk_low_res.start = low_base;
 	crashk_low_res.end   = low_base + low_size - 1;
+#ifdef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
 	insert_resource(&iomem_resource, &crashk_low_res);
+#endif
 #endif
 	return 0;
 }
@@ -448,8 +450,12 @@ void __init reserve_crashkernel_generic(char *cmdline,
 
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
+#ifdef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+	insert_resource(&iomem_resource, &crashk_res);
+#endif
 }
 
+#ifndef HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
 static __init int insert_crashkernel_resources(void)
 {
 	if (crashk_res.start < crashk_res.end)
@@ -462,3 +468,4 @@ static __init int insert_crashkernel_resources(void)
 }
 early_initcall(insert_crashkernel_resources);
 #endif
+#endif
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
