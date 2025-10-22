Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A410BCCD1BB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ekimc72PCbpOA1x/tlS6SXdLF6ETf9qbbL3151vpaxg=; b=Csyi/Gll/HnZ7mFzYVj7QYAPXC
	pM8JTXKppL2xdm0IrT+uEmHorICL6VcoNH7ISVBxpXE9hlpMr5uCZycPF4Wk9EGhOsY0vmINfDrl6
	asEWc/bIXe7oZj5N+AZt2RmP/6IEi1clhvzv/4c0yNfKk9hRnrcfAXf6gI4MTBn4uCFut0rZLevUP
	vLs2X61UrjE11NqZxzmmyiM5Iv3+K1Lp1c+V5Q3TThO6ojHKrBDDNbDCgUZoIBbMykTT0fll+WdjL
	OgOCpPorIEtuMN0WHJrWi1y3UKZ3vUB+VVj45KvjVO/RlbuZPT6HHx5ioAhPbakW9gBFBf4Y3BnU+
	SFwGjE1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBXjv-00000002lnl-2aDA;
	Wed, 22 Oct 2025 12:14:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBXjt-00000002lmJ-2A7p
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 12:14:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761135288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ekimc72PCbpOA1x/tlS6SXdLF6ETf9qbbL3151vpaxg=;
	b=fNposwCIzTTER9hWeTo+CnghoOfEN8HzmEh5PiXzc/234FP/8beA38hNsbcL4kY6cyDSHU
	OjdoEfeispIOOtPC7bbVuLVg1T6ThiWWXbJRYwNvXxOsf4DKT4CaW/TG3mxT6N3JjMhWuU
	sBfE9TlrladL16z5XIg79VHHdQHv5/w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-d2iakW3GOnuSp_JrGPkW3A-1; Wed,
 22 Oct 2025 08:14:44 -0400
X-MC-Unique: d2iakW3GOnuSp_JrGPkW3A-1
X-Mimecast-MFC-AGG-ID: d2iakW3GOnuSp_JrGPkW3A_1761135282
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7125D1956089;
	Wed, 22 Oct 2025 12:14:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BF521800590;
	Wed, 22 Oct 2025 12:14:31 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Joel Granados <joel.granados@kernel.org>
Subject: [RFC 3/3] kexec_core: Promote the kexec to DL task
Date: Wed, 22 Oct 2025 20:13:45 +0800
Message-ID: <20251022121345.23496-4-piliu@redhat.com>
In-Reply-To: <20251022121345.23496-1-piliu@redhat.com>
References: <20251022121345.23496-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_051449_624142_A95E80C2 
X-CRM114-Status: GOOD (  15.12  )
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

The previous patch lifted the deadline bandwidth check during the kexec
process. As a result, DL tasks may be crowded onto the kexec CPU, which
may starve the kexec task. At this point, the kexec task is the only
task needed to make the reboot proceed, hence promoting it to a deadline
task prevents this starvation.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 kernel/kexec_core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 265de9d1ff5f5..0960bea1a8bab 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -41,6 +41,7 @@
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
 #include <linux/dma-map-ops.h>
+#include <uapi/linux/sched/types.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1183,6 +1184,20 @@ int kernel_kexec(void)
 	} else
 #endif
 	{
+		struct sched_attr attr = {
+			.size		= sizeof(struct sched_attr),
+			.sched_policy	= SCHED_DEADLINE,
+			.sched_nice	= 0,
+			.sched_priority	= 0,
+			/*
+			 * Fake (unused) bandwidth; workaround to "fix"
+			 * priority inheritance.
+			 */
+			.sched_runtime	= NSEC_PER_MSEC,
+			.sched_deadline = 10 * NSEC_PER_MSEC,
+			.sched_period	= 10 * NSEC_PER_MSEC,
+		};
+
 		/*
 		 * CPU hot-removal path refers to kexec_in_progress, it
 		 * requires a sync to ensure no in-flight hot-removing.
@@ -1202,6 +1217,13 @@ int kernel_kexec(void)
 		 */
 		cpu_hotplug_enable();
 		pr_notice("Starting new kernel\n");
+		/*
+		 * During hot-removing cpu, all DL tasks will be migrated to
+		 * this cpu.  To prevent this task from starving, promoting it
+		 * to DL task. And soon, local interrupt will be disabled in
+		 * machine_kexec().
+		 */
+		sched_setattr_nocheck(current, &attr);
 		machine_shutdown();
 	}
 
-- 
2.49.0


