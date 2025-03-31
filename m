Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17433C36017
	for <kexec@archiver.kernel.org>; Mon, 31 Mar 2025 06:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zT6uGNEasqGnc6bFrOg7/6G3oblOCVQuVcAM35oaSBU=; b=lWEMyM/MLy2SitAFXVH942S5Qr
	oEh0YaEwWfNjxcyi6M8ssyY0MOkSoLlWBZx7wRSycC6pN+TTKXmxoxFPd4QBu0hfELX7vRPZ9wkYn
	ZnbjKX8Iv2DHxlJlHoGYmgSpRuFJvai62IHZWTtEYGwP2/L0DdoG+uMkRFgzdC94/HOfQA2OcoIex
	4NJkIjCFhuBunr3aknfPAWvV2SEqjOGx1lqmfhiHEgUOMwsDOyJMYkFMTWJscZtcxMSYc/ndTi87q
	8GdST96ZzKgVtu7tivM9+dhjiyxpKSKKnssITzKYlqK81l12oivBftfttPyucXCv5tx2+cUvpHIkI
	w7RBGcEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tz8Rh-0000000H5nt-3bhh;
	Mon, 31 Mar 2025 06:16:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tz8Re-0000000H5n7-1W3h
	for kexec@lists.infradead.org;
	Mon, 31 Mar 2025 06:16:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743401783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zT6uGNEasqGnc6bFrOg7/6G3oblOCVQuVcAM35oaSBU=;
	b=EY2NLnQyomJNjD6Ax8gmURyTVfMlwwgYcubGjGHCXwdCpqo7+tFFg64Pae8s2RDvtBmJ+j
	OJkFNioU/IiWk70PqzanZOWPSGcmNjdbWPhJWLX/OQJuhn8Jt38uWgbyp4GuUKxtVJ6EA6
	nM5v+Zqxu8OjGf3mVElNre8ViyHw24k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-JExHtgYcP2--jqcDmDAWbQ-1; Mon,
 31 Mar 2025 02:16:19 -0400
X-MC-Unique: JExHtgYcP2--jqcDmDAWbQ-1
X-Mimecast-MFC-AGG-ID: JExHtgYcP2--jqcDmDAWbQ_1743401778
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48510195609F;
	Mon, 31 Mar 2025 06:16:18 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58DB61808867;
	Mon, 31 Mar 2025 06:16:14 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: zohar@linux.ibm.com
Cc: linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Date: Mon, 31 Mar 2025 14:16:11 +0800
Message-ID: <20250331061611.253919-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250330_231626_538094_A84BBCF6 
X-CRM114-Status: GOOD (  13.65  )
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

It doesn't make sense to run IMA functionality in kdump kernel, and that
will cost extra memory. It would be great to allow IMA to be disabled on
purpose, e.g for kdump kernel.

Hence add a knob here to allow people to disable IMA if needed.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 security/integrity/ima/ima_main.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 28b8b0db6f9b..5d677d1389fe 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -38,11 +38,27 @@ int ima_appraise;
 
 int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
+static int ima_disabled = 0;
 
 static struct notifier_block ima_lsm_policy_notifier = {
 	.notifier_call = ima_lsm_policy_change,
 };
 
+static int __init ima_setup(char *str)
+{
+	if (strncmp(str, "off", 3) == 0)
+                ima_disabled = 1;
+        else if (strncmp(str, "on", 2) == 0)
+                ima_disabled = 0;
+        else
+                pr_err("invalid ima setup option: \"%s\" ", str);
+
+	return 1;
+}
+__setup("ima=", ima_setup);
+
+
+
 static int __init hash_setup(char *str)
 {
 	struct ima_template_desc *template_desc = ima_template_desc_current();
@@ -1176,6 +1192,11 @@ static int __init init_ima(void)
 {
 	int error;
 
+	if (ima_disabled) {
+		pr_info("IMA functionality is disabled on purpose!");
+		return 0;
+	}
+
 	ima_appraise_parse_cmdline();
 	ima_init_template_list();
 	hash_setup(CONFIG_IMA_DEFAULT_HASH);
-- 
2.41.0


