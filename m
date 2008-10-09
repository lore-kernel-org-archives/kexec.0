Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KnytE-0004uv-RN
	for kexec@lists.infradead.org; Thu, 09 Oct 2008 17:01:29 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id A383F4191C
	for <kexec@lists.infradead.org>; Thu,  9 Oct 2008 19:01:25 +0200 (CEST)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Use return value of count_dyn_reconf_memory_ranges()
Date: Thu,  9 Oct 2008 19:01:25 +0200
Message-Id: <1223571685-14110-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Bernhard Walle <bwalle@suse.de>

This patch fixes the build error

    kexec/arch/ppc64/kexec-ppc64.c:140: \
        warning: control reaches end of non-void function

The patch returns 0 on success, and checks when the function is called
for a non-zero value.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/arch/ppc64/kexec-ppc64.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 40258b7..069a9fc 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -137,6 +137,8 @@ static int count_dyn_reconf_memory_ranges(void)
 	num_of_lmbs = ((unsigned int *)buf)[0];
 	max_memory_ranges += num_of_lmbs;
 	fclose(file);
+
+	return 0;
 }
 
 /*
@@ -158,7 +160,8 @@ static int count_memory_ranges(void)
 	while ((dentry = readdir(dir)) != NULL) {
 		if (!strncmp(dentry->d_name,
 				"ibm,dynamic-reconfiguration-memory", 35)){
-			count_dyn_reconf_memory_ranges();
+			if (count_dyn_reconf_memory_ranges() != 0)
+				return -1;
 			continue;
 		}
 
-- 
1.6.0.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
