Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E32C44532
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VNv2SZK5IuT20jKf63eyex2nA1u4B3QwivjV7yjy8NI=; b=ekc9N3GDpe1KZV
	MwA91HUYZsmdJWy0N7qdnvAT1m13sliUeIiKuLAP8CgMsSx4Pmm/h01JkgCkxsWtJPPSTdRN9Owb3
	OadpvJMYgWnOzh3u8FWX7N1tAAngSs2OmjfjKjhfr/TyAHiqtlHfeeCrvVWbl/ivr9PVe82f10ch4
	wPTQtcMBJ4KJZe/M5gf47KL7eAhK0XNtPQ3pUPV1u70sNGC2S+PvapJpd56QbnioMrpZiG+stVD7Z
	ioB3EXEO00LErdiWmJ82hEqLQSzkHDFUVmOI36yJntYpt1pIiDaMwTh5VsZE6SRUmzIrb2NuKpHkw
	L5vsbVK7esIg9Lz+16tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmCAk-00000009lmo-0qTz;
	Tue, 21 Jul 2026 15:14:18 +0000
Received: from devianza.investici.org ([2c0f:f930:0:4::108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmCAe-00000009li5-1rhu
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 15:14:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784646850;
	bh=VNv2SZK5IuT20jKf63eyex2nA1u4B3QwivjV7yjy8NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAGopWReZa5yseDbcQ6xaoOpr2kMsGb0yk+jAEqeqe79kRaCkJTozEWK6tQriLaBd
	 IEwhIS9Cs7cVVlBwlBGqQNQGsFwUzKmroAL54ec19pFxl6GSjXNuBwQDr6sG+LQPzK
	 bBSUmDy8TOq6JDKg7edd5udo2qT7arwnzF26ChVc=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4h4LWk2JWGz6vN3;
	Tue, 21 Jul 2026 15:14:10 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4h4LWj3r69z4vyJ;
	Tue, 21 Jul 2026 15:14:09 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Subject: [PATCH v2 2/3] kexec: log the task that initiated the kexec reboot
Date: Tue, 21 Jul 2026 16:13:57 +0100
Message-ID: <20260721151358.4185467-3-include@grrlz.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260721151358.4185467-1-include@grrlz.net>
References: <20260721151358.4185467-1-include@grrlz.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_081412_697096_20F42F5E 
X-CRM114-Status: GOOD (  11.85  )
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
Cc: pavel@kernel.org, tony.luck@intel.com, baoquan.he@linux.dev, rafael@kernel.org, kees@kernel.org, linux-pm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rppt@kernel.org, Bradley Morgan <include@grrlz.net>, pasha.tatashin@soleen.com, pratyush@kernel.org, lenb@kernel.org
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The reboot syscall now logs the initiating task for the restart, halt
and power off commands at the point where they can no longer fail.
The kexec command could not be handled there: kernel_kexec() has
several failure points and returns to a running system when any of
them fires, which would leave a stale "initiated by" line in the log
with no transition behind it.

Call reboot_log_initiator() from kernel_kexec() once the shutdown
of the current kernel is committed, right before the existing
"Starting new kernel" line:

  reboot: initiated by kexec[713]
  kexec_core: Starting new kernel

The preserve_context path is left alone since it returns to the
running kernel instead of tearing it down.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/kexec_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d05..23b7fe36e64e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1200,6 +1200,7 @@ int kernel_kexec(void)
 		 * CPU hotplug again; so re-enable it here.
 		 */
 		cpu_hotplug_enable();
+		reboot_log_initiator();
 		pr_notice("Starting new kernel\n");
 		machine_shutdown();
 	}
-- 
2.50.1


