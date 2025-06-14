Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906DCC71136
	for <kexec@archiver.kernel.org>; Sat, 14 Jun 2025 02:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OUz9I+i5wHyxyyAJTk0830GJubFnv9VDf+gVBkAFDtY=; b=iVLTfqTLrqGukDmBnzlpQaBTZ+
	v7bcwGBz9/TJQFLp6I55wmpp7k2/hJh3v5I2lD7OidCxpr4muY+dUD+oGkjEQK8R5jKDyWK+NzyzK
	ceP8BAjSKL0xETrlTr2tzosLbDlZLishe7eVAi1oK1TPKZVDzUjthInPwtacsSgSemuPItXfzTDVd
	3ifgpjr2TPEVcPlc4gpzEYe1csEcZJBdl5sDiE+L6gZMhFJ64GkSILNR/egqk1XL7zdiJnj+YTnzI
	UL84PGVz0q5gxO1Wi7K+dWISdPY6DWEMxA5HthEd7TOf9uYjraMQkg5Y5Up+EQH+fIFVytWDINOLx
	hn6XV7pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQGYt-00000000XD8-2rbl;
	Sat, 14 Jun 2025 02:24:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQGYo-00000000XCH-1SBi
	for kexec@lists.infradead.org;
	Sat, 14 Jun 2025 02:23:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749867835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OUz9I+i5wHyxyyAJTk0830GJubFnv9VDf+gVBkAFDtY=;
	b=YG48rx4vBdnKFNYGh1LoN4J4fEjziKa88BJusfk/CXpO3reDe+KI47EwQTa1nZLMHgXraw
	82WOKbbb1GsJfOoyFZNicJcki67Zew3e83VSrSmQv/VTf+7zChhq31wJPAvFFrTWXUf9ru
	Moka7YjZtmNcU3nkxO2cKqOZlthiN5E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-DI_vibO8PzKwdhke3B1xbA-1; Fri,
 13 Jun 2025 22:23:54 -0400
X-MC-Unique: DI_vibO8PzKwdhke3B1xbA-1
X-Mimecast-MFC-AGG-ID: DI_vibO8PzKwdhke3B1xbA_1749867833
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58A311956080;
	Sat, 14 Jun 2025 02:23:52 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.42])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B34A418003FC;
	Sat, 14 Jun 2025 02:23:46 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zohar@linux.ibm.com,
	coxu@redhat.com,
	piliu@redhat.com,
	pmenzel@molgen.mpg.de,
	chenste@linux.microsoft.com,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3] ima: add a knob ima= to allow disabling IMA in kdump kernel
Date: Sat, 14 Jun 2025 10:23:42 +0800
Message-ID: <20250614022342.5988-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_192358_461020_2EDFE68F 
X-CRM114-Status: GOOD (  15.07  )
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

Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
extra memory. It would be very helpful to allow IMA to be disabled for
kdump kernel.

Hence add a knob ima=on|off here to allow turning IMA off in kdump
kernel if needed.

Note that this IMA disabling is limited to kdump kernel, please don't
abuse it in other kernel and thus serious consequences are caused.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v2->v3:
- Remove rdundant word 'only' and rephrase sentences in patch log code
  comment, and rephrase patch subject, thanks to Mimi's comments.

 .../admin-guide/kernel-parameters.txt         |  5 ++++
 security/integrity/ima/ima_main.c             | 26 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b3d62f4c370a..93357fb5c03e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2214,6 +2214,11 @@
 			different crypto accelerators. This option can be used
 			to achieve best performance for particular HW.
 
+	ima=		[IMA] Enable or disable IMA
+			Format: { "off" | "on" }
+			Default: "on"
+			Note that disabling IMA is limited to kdump kernel.
+
 	indirect_target_selection= [X86,Intel] Mitigation control for Indirect
 			Target Selection(ITS) bug in Intel CPUs. Updated
 			microcode is also required for a fix in IBPB.
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f99ab1a3b0f0..cdd225f65a62 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 #include <linux/iversion.h>
 #include <linux/evm.h>
+#include <linux/crash_dump.h>
 
 #include "ima.h"
 
@@ -38,11 +39,30 @@ int ima_appraise;
 
 int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
+static int ima_disabled __ro_after_init;
 
 static struct notifier_block ima_lsm_policy_notifier = {
 	.notifier_call = ima_lsm_policy_change,
 };
 
+static int __init ima_setup(char *str)
+{
+	if (!is_kdump_kernel()) {
+		pr_info("Warning: ima setup option only permitted in kdump");
+		return 1;
+	}
+
+	if (strncmp(str, "off", 3) == 0)
+		ima_disabled = 1;
+	else if (strncmp(str, "on", 2) == 0)
+		ima_disabled = 0;
+	else
+		pr_err("Invalid ima setup option: \"%s\" , please specify ima=on|off.", str);
+
+	return 1;
+}
+__setup("ima=", ima_setup);
+
 static int __init hash_setup(char *str)
 {
 	struct ima_template_desc *template_desc = ima_template_desc_current();
@@ -1186,6 +1206,12 @@ static int __init init_ima(void)
 {
 	int error;
 
+	/*Note that turning IMA off is intentionally limited to kdump kernel.*/
+	if (ima_disabled && is_kdump_kernel()) {
+		pr_info("IMA functionality is disabled");
+		return 0;
+	}
+
 	ima_appraise_parse_cmdline();
 	ima_init_template_list();
 	hash_setup(CONFIG_IMA_DEFAULT_HASH);
-- 
2.41.0


