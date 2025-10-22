Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96271CCD1BB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 12:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=luI49aJWaaO/LQ54EBxZk4WAfdvW9kwQCGC0aaaZi3A=; b=DaAwmjvU8TTctkOYie3T/k02dw
	g8Cv3YtPg5LtA51y+c4eXN0CCjAhnEcT0yHRoYCmT9Vhq/M7SDx6O4ACaJvrhqX3QiilUUdf5AdSa
	vNbEiuS7YvLZW/Ao6ujV0hdL/rC+Abk7YQMo/eQMSsb/DC/gQX9Cqe8IfxihTmFfPAiaLB7KJ+6Yc
	Uk1v7ntgFmSXQFEM1LwzU2ndFEqEVxe0XagFyy0Qk4Bg72by1lMvbXjDNbMy/o5CJnSZFcRBvSH4j
	RCDlihV84sWcQEMbbVtLVg9kkJcE7c5qn4UmT5+Czp0L3ThvO3bSHdxMI7anc+7AoIL8lTIF54R7i
	7mpyX6Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBXjn-00000002ljv-0h64;
	Wed, 22 Oct 2025 12:14:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBXjh-00000002lgx-1S3a
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 12:14:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761135276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luI49aJWaaO/LQ54EBxZk4WAfdvW9kwQCGC0aaaZi3A=;
	b=H0Q+rsP5jwrPQdl8IET2+qSD/j1rDxIEoUAv1Ap7z8zWWmHXVc7CKkvYoaNpdq8BBPrf2q
	gOpLfyOPiiqyRhs9nfCXe2qXdoxeexHJOAP4VGOeOmi9QUDuGUFVPfm15OdovkhZmnI4p7
	iFNtWjBas8ZcXrdpbEL/uKxBXIx3748=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-FQa_G7grMAKwqXKMAP421Q-1; Wed,
 22 Oct 2025 08:14:34 -0400
X-MC-Unique: FQa_G7grMAKwqXKMAP421Q-1
X-Mimecast-MFC-AGG-ID: FQa_G7grMAKwqXKMAP421Q_1761135272
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C01019539AB;
	Wed, 22 Oct 2025 12:14:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C2FEA180035A;
	Wed, 22 Oct 2025 12:14:20 +0000 (UTC)
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
Subject: [RFC 2/3] kernel/cpu: Mark nonboot cpus as inactive when shutting down nonboot cpus
Date: Wed, 22 Oct 2025 20:13:44 +0800
Message-ID: <20251022121345.23496-3-piliu@redhat.com>
In-Reply-To: <20251022121345.23496-1-piliu@redhat.com>
References: <20251022121345.23496-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_051437_542894_7639F0B9 
X-CRM114-Status: GOOD (  13.54  )
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
process, which raises a potential issue: as the number of online CPUs
decreases, DL tasks may be crowded onto a few CPUs, which may starve the
CPU hotplug kthread. As a result, the hot-removal cannot proceed in
practice.  On the other hand, as CPUs are offlined one by one, all tasks
will eventually be migrated to the kexec CPU.

Therefore, this patch marks all other CPUs as inactive to signal the
scheduler to migrate tasks to the kexec CPU during hot-removal.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 kernel/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index db9f6c539b28c..76aa0f784602b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1546,6 +1546,16 @@ void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
 	if (!cpu_online(primary_cpu))
 		primary_cpu = cpumask_first(cpu_online_mask);
 
+	/*
+	 * Mark all other CPUs as inactive so the scheduler won't select them as
+	 * migration targets.
+	 */
+	for_each_online_cpu(cpu) {
+		if (cpu == primary_cpu)
+			continue;
+		set_cpu_active(cpu, false);
+	}
+
 	for_each_online_cpu(cpu) {
 		if (cpu == primary_cpu)
 			continue;
-- 
2.49.0


