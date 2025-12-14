Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABF2D59D99
	for <kexec@archiver.kernel.org>; Sun, 14 Dec 2025 17:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xnZQYaE3f+lyVpaIqfD5G12ltock2Ul/7/4qFYFks1Y=; b=PwJy9r7gepg/mntybkWsidwl7I
	9aHFLT9IzJTkwUTnnSKiSzTh2xzq1h/hvxL3In9UW9bs2bJj0frPvLgqkgf+llVG4K50/crm9Pb+a
	CTXtX7FcHtvNrR0DCkSNYFNlZjciv66sZuKjG6WcLJhwU+P1rYjmp/xU9s2yRGo/Q0UVxmUIEH9Zr
	M+17dGTWROXovrBSHJu0TsJ4HcEnzAB6MDgAFwo/K+FgM+kL6IRRAyYA278MXakh2FSxCgFHIBOeQ
	ePFOwObSexy0aZNNg6ahEKe/3o1xDSxdl5pBSza3yppcSG0xwSbdp+xxCSi7dFHambBZ49QFifQaM
	fKPu3v8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUqLm-00000002deA-4ATr;
	Sun, 14 Dec 2025 17:57:42 +0000
Received: from smtp-72.smtpout.orange.fr ([80.12.242.72] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUqLh-00000002ddk-2pyB
	for kexec@lists.infradead.org;
	Sun, 14 Dec 2025 17:57:39 +0000
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id UqLdv2norud1nUqLdv9T2w; Sun, 14 Dec 2025 18:57:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1765735055;
	bh=xnZQYaE3f+lyVpaIqfD5G12ltock2Ul/7/4qFYFks1Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SCnnrhTOBZkYuALZm0U1vRmpA4qyiEggQ4ovliUyS5QQbl3RkO4BmvnC7unDVPM+6
	 I9SMO/gsE+PSC0d1+UvzAFkgf37F7kbXFHH7bg6osAntKcXoh5dlw6OZV7Q/qBLNYJ
	 FGFczam2O/TQIGDkDfhZQ7J287mQS4NcwePgjCpSfMXMRJL25HyyJa+dQS8tDfzcsV
	 H8SjxYjfbAkZSQcb2vrmZeCDKzHczKRcV7o2bdSk1C2D07GdAhd8MqrHn5q72aXDSL
	 yoSR2zNCvtIaQUwrMI9xPcyftN1xr8ykmi+rnS3RJPxdJeLtg3cJv+38BwseBAdzm8
	 96EGoiArOhNVg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Dec 2025 18:57:35 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	kexec@lists.infradead.org
Subject: [PATCH] crash_dump: Constify struct configfs_item_operations and configfs_group_operations
Date: Sun, 14 Dec 2025 18:57:30 +0100
Message-ID: <d046ee5666d2f6b1a48ca1a222dfbd2f7c44462f.1765735035.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251214_095738_131197_2E0E0C2E 
X-CRM114-Status: GOOD (  10.90  )
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

'struct configfs_item_operations' and 'configfs_group_operations' are not
modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  16339	  11001	    384	  27724	   6c4c	kernel/crash_dump_dm_crypt.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  16499	  10841	    384	  27724	   6c4c	kernel/crash_dump_dm_crypt.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

This change is possible since commits f2f36500a63b and f7f78098690d.
---
 kernel/crash_dump_dm_crypt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 401423ba477d..0d23dc1de67c 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -223,7 +223,7 @@ static void config_key_release(struct config_item *item)
 	key_count--;
 }
 
-static struct configfs_item_operations config_key_item_ops = {
+static const struct configfs_item_operations config_key_item_ops = {
 	.release = config_key_release,
 };
 
@@ -298,7 +298,7 @@ static struct configfs_attribute *config_keys_attrs[] = {
  * Note that, since no extra work is required on ->drop_item(),
  * no ->drop_item() is provided.
  */
-static struct configfs_group_operations config_keys_group_ops = {
+static const struct configfs_group_operations config_keys_group_ops = {
 	.make_item = config_keys_make_item,
 };
 
-- 
2.52.0


