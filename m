Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32125CCF9E0
	for <kexec@archiver.kernel.org>; Tue, 28 Oct 2025 03:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zb7uctCA+8DACYb+CzN2IamRFlY2/R42eag8ZUqBA0k=; b=KZ2iNZyTFldJz+eBKZEfosrVr+
	fbpvwLBw1t/YtebvL2DFqUm1gw1wwweB/buXYzuAPEimyxzswq44SPum3AKJAXbGrguyDyEMgcM+Y
	9t726dApvIYL+ufXYOoTRsaQhGB7E3be+E9yTH0MgIGVnKe7xwWHOKv7WTcA/I8fsOknUu0RzoUUY
	iyuieib0FuBGmQcB9AnrN+Pp2OMOdCFaU0mdEGHm8blTNfUyw34CaxWztrRIv2VMRaBmZZfCMRMPy
	j9aAF0hHooW7qkIBVu81YtceVD6A8vPwxxYmyT7xE6n1SqcP06sDMVn+mFNg27ztxEhLERP4iOh6f
	cEOXHDBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDa5t-0000000F9Gl-3ZEI;
	Tue, 28 Oct 2025 03:09:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDa5r-0000000F9Fy-2dYG
	for kexec@lists.infradead.org;
	Tue, 28 Oct 2025 03:09:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761620994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zb7uctCA+8DACYb+CzN2IamRFlY2/R42eag8ZUqBA0k=;
	b=aa2d5flj/PS84cpra7RzZY2aCB9yugoUSHEJcsSdRCyNmenNTNNZ1j61Zl3nCOAOC5FKsj
	qHXxVZ9QogA4I6UswA1IYXQTALMXFJDlMJUSZOfIJ5bIp5dKw7c4REJFNSnRBJLIJRj6Ol
	BBIjm6Ucfew1szEE0gZw4uC5DuJhOOc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-mhCbpsDbPXmrAnz5ukEPgQ-1; Mon,
 27 Oct 2025 23:09:49 -0400
X-MC-Unique: mhCbpsDbPXmrAnz5ukEPgQ-1
X-Mimecast-MFC-AGG-ID: mhCbpsDbPXmrAnz5ukEPgQ_1761620988
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E66B196F754;
	Tue, 28 Oct 2025 03:09:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.84])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 504931800298;
	Tue, 28 Oct 2025 03:09:37 +0000 (UTC)
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
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCHv2 1/2] sched/deadline: Skip the deadline bandwidth check if kexec_in_progress
Date: Tue, 28 Oct 2025 11:09:13 +0800
Message-ID: <20251028030914.9520-2-piliu@redhat.com>
In-Reply-To: <20251028030914.9520-1-piliu@redhat.com>
References: <20251028030914.9520-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_200955_739927_8508720F 
X-CRM114-Status: GOOD (  14.11  )
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

During discussion of the scheduler deadline bug [1], Pierre Gondois
pointed out a potential issue during kexec: as CPUs are unplugged, the
available DL bandwidth of the root domain gradually decreases. At some
point, insufficient bandwidth triggers an overflow detection, causing
CPU hot-removal to fail and kexec to hang [2].

This can be reproduced by:
  chrt -d -T 1000000 -P 1000000 0 yes > /dev/null &
  kexec -e

Meeting deadline bandwidth requirements is unnecessary during the kexec
process. Skip DL bandwidth validation to allow kexec to proceed smoothly.

[1]: https://lore.kernel.org/all/20250929133602.32462-1-piliu@redhat.com/
[2]: https://lore.kernel.org/all/3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com/

Reported-by: Pierre Gondois <pierre.gondois@arm.com>
Closes: https://lore.kernel.org/all/3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com/
Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Joel Granados <joel.granados@kernel.org>
To: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 kernel/kexec_core.c     | 6 ++++++
 kernel/sched/deadline.c | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 31203f0bacafa..265de9d1ff5f5 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1183,7 +1183,13 @@ int kernel_kexec(void)
 	} else
 #endif
 	{
+		/*
+		 * CPU hot-removal path refers to kexec_in_progress, it
+		 * requires a sync to ensure no in-flight hot-removing.
+		 */
+		cpu_hotplug_disable();
 		kexec_in_progress = true;
+		cpu_hotplug_enable();
 		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
 		syscore_shutdown();
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 72c1f72463c75..9db6f26b6cc81 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -18,6 +18,7 @@
 
 #include <linux/cpuset.h>
 #include <linux/sched/clock.h>
+#include <linux/kexec.h>
 #include <uapi/linux/sched/types.h>
 #include "sched.h"
 #include "pelt.h"
@@ -3484,6 +3485,12 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 
 int dl_bw_deactivate(int cpu)
 {
+	/*
+	 * The system is shutting down and cannot roll back.  There is no point
+	 * in keeping track of bandwidth, which may fail hotplug.
+	 */
+	if (unlikely(kexec_in_progress))
+		return 0;
 	return dl_bw_manage(dl_bw_req_deactivate, cpu, 0);
 }
 
-- 
2.49.0


