Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B3DCCF9E0
	for <kexec@archiver.kernel.org>; Tue, 28 Oct 2025 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I8WR19ZGz2+uRagsLyH/16PxuPlbDWfbpOkIs9ZyrcI=; b=3GbWs4TGVf1CAGF0XAmxaJkMNy
	CkyDR+c0WpKCecfyy87LN/HfpYzW5XBczVEiZE/U+w93GddBQ7LmAwrVfv77jtZk1/M3qamfQ4gn1
	BHMdt1/t8Z5abnoRRDkwclrjbHuFqepZd00/jrqyZ9XLAz+X/X92hBblU6vznwuuigLLBpRFmfHzA
	FhRU+hJWyNPsalx2QPolA8HBJMYZHyTkOM0zypu+DBSyyKMSFytUCTK+FOFCwTim8iy/S7w8xuoAi
	Tiz+ACZ9PkqJek3NYT2AnnaSs46pmtscMIMW+3s1d+XyDWbSPZNweGNuwyoNPL18Q2fWG2SpqnIVM
	iysL7/Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDa6A-0000000F9KB-0Zp4;
	Tue, 28 Oct 2025 03:10:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDa67-0000000F9JV-0TMm
	for kexec@lists.infradead.org;
	Tue, 28 Oct 2025 03:10:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761621010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8WR19ZGz2+uRagsLyH/16PxuPlbDWfbpOkIs9ZyrcI=;
	b=O3yabnsa7dhYWG7IDjpi9+c4nIt+Y96xMZT2sTd77RASvvybYJRqaXQEZRRP1kfTwi1Bxs
	rQCu1EZfU3e03LPlNzXaBSEMW+gQ4KwVbztyL5AEKwlDuf95u5qFTfzPfXjdKpvjyGx4Z6
	iK1/p+9bxUJqNtuPiN1fzWlXrstSCBg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-8ksgbZnRO-WlzUfowka3Ww-1; Mon,
 27 Oct 2025 23:10:07 -0400
X-MC-Unique: 8ksgbZnRO-WlzUfowka3Ww-1
X-Mimecast-MFC-AGG-ID: 8ksgbZnRO-WlzUfowka3Ww_1761621000
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E267919539BC;
	Tue, 28 Oct 2025 03:09:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.84])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC6F618002AD;
	Tue, 28 Oct 2025 03:09:47 +0000 (UTC)
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
Subject: [PATCHv2 2/2] kernel/kexec: Stop all userspace deadline tasks
Date: Tue, 28 Oct 2025 11:09:14 +0800
Message-ID: <20251028030914.9520-3-piliu@redhat.com>
In-Reply-To: <20251028030914.9520-1-piliu@redhat.com>
References: <20251028030914.9520-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_201011_221059_77E6159F 
X-CRM114-Status: GOOD (  12.11  )
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

Now that the deadline bandwidth check has been skipped, there is nothing
to prevent CPUs from being unplugged. But as deadline tasks are crowded
onto the remaining CPUs, they may starve normal tasks, especially the
hotplug kthreads. As a result, the kexec process will hang indefinitely.

Send SIGSTOP to all userspace deadline tasks at the beginning of kexec
to allow other tasks to run as CPUs are unplugged.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 kernel/kexec_core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 265de9d1ff5f5..090bb58797d12 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1132,6 +1132,18 @@ bool kexec_load_permitted(int kexec_image_type)
 	return true;
 }
 
+static void stop_user_deadline_tasks(void)
+{
+	struct task_struct *task;
+
+	rcu_read_lock();
+	for_each_process(task) {
+		if (task->policy == SCHED_DEADLINE && task->mm)
+			send_sig(SIGSTOP, task, 1);
+	}
+	rcu_read_unlock();
+}
+
 /*
  * Move into place and start executing a preloaded standalone
  * executable.  If nothing was preloaded return an error.
@@ -1190,6 +1202,11 @@ int kernel_kexec(void)
 		cpu_hotplug_disable();
 		kexec_in_progress = true;
 		cpu_hotplug_enable();
+		/*
+		 * As CPU hot-removal, the crowed deadline task may starve other
+		 * tasks. So stop them.
+		 */
+		stop_user_deadline_tasks();
 		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
 		syscore_shutdown();
-- 
2.49.0


