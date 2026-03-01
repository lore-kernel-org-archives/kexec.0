Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4A9FD0057
	for <kexec@archiver.kernel.org>; Sun,  1 Mar 2026 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+5hSVLyMrqUzESvlc5APBImj2Nw/31Gm0PRLtn5Zcco=; b=Qpv983SvH29BTukftT6h56/yT/
	lfc1IYytbZEYINs5fgNcW+wL+BwclNzi2Ha9lO+RBJ3kZvB6yDr3E33Vx9beDDdeNKG8+EX4ZbntY
	BJDK9YHo9XDDik6K9S8jn0xNouiT8YQ/SEZQrgkiAmXRK3bo9tPI7dUgwY8hUq/6KKcGz+mjNW9kz
	0f/kLmbQgSCb40nrxqAPgYzEZtIUHMb9GcihKCe2dBSVfwFaQPRDkSMgdGPGOZIyie7fVlZcyt0Rc
	clA8QS/xKycBpMbAKrKQuZqQCxyYE9ucTt0iAnr7uzzuvkpM3Bd/Px8X5FrPBFEDwBsCN+he5+6yQ
	ELMBdDiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwgI2-0000000B7pB-2jzv;
	Sun, 01 Mar 2026 12:52:54 +0000
Received: from out-187.mta1.migadu.com ([2001:41d0:203:375::bb])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwgHz-0000000B7os-2ljZ
	for kexec@lists.infradead.org;
	Sun, 01 Mar 2026 12:52:53 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772369564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+5hSVLyMrqUzESvlc5APBImj2Nw/31Gm0PRLtn5Zcco=;
	b=LEJV/Y8a24oM1vY67p1/P5rm7FaW21JuUfIVDs/lHV7GS7tLhuFBKF5ybi+38neELJkwkG
	iZVMe/6ep2AsVuHMR78prPd8euR6hfHWjc6E8XnWfXy1rRVOQcnqXFnh7rvAreOo1N8/UT
	K7cvbSHNccR7SACF3Kgx/FD+YJkvF5w=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crash_dump: use sysfs_emit in sysfs show functions
Date: Sun,  1 Mar 2026 13:51:07 +0100
Message-ID: <20260301125106.911980-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_045251_988863_3F57BA6C 
X-CRM114-Status: UNSURE (   7.47  )
X-CRM114-Notice: Please train this message.
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

Replace sprintf() with sysfs_emit() in sysfs show functions.
sysfs_emit() is preferred for formatting sysfs output because it
provides safer bounds checking.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/crash_dump_dm_crypt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 1f4067fbdb94..827572aa800b 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -6,6 +6,7 @@
 #include <linux/cc_platform.h>
 #include <linux/configfs.h>
 #include <linux/module.h>
+#include <linux/sysfs.h>
 
 #define KEY_NUM_MAX 128	/* maximum dm crypt keys */
 #define KEY_SIZE_MAX 256	/* maximum dm crypt key size */
@@ -189,7 +190,7 @@ static inline struct config_key *to_config_key(struct config_item *item)
 
 static ssize_t config_key_description_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%s\n", to_config_key(item)->description);
+	return sysfs_emit(page, "%s\n", to_config_key(item)->description);
 }
 
 static ssize_t config_key_description_store(struct config_item *item,
@@ -265,7 +266,7 @@ static struct config_item *config_keys_make_item(struct config_group *group,
 
 static ssize_t config_keys_count_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%d\n", key_count);
+	return sysfs_emit(page, "%d\n", key_count);
 }
 
 CONFIGFS_ATTR_RO(config_keys_, count);
@@ -274,7 +275,7 @@ static bool is_dm_key_reused;
 
 static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%d\n", is_dm_key_reused);
+	return sysfs_emit(page, "%d\n", is_dm_key_reused);
 }
 
 static ssize_t config_keys_reuse_store(struct config_item *item,
@@ -321,7 +322,7 @@ static bool restore;
 
 static ssize_t config_keys_restore_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%d\n", restore);
+	return sysfs_emit(page, "%d\n", restore);
 }
 
 static ssize_t config_keys_restore_store(struct config_item *item,
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


