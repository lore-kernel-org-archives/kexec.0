Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-blu.frontbridge.com ([65.55.251.16]
	helo=outbound8-blu-R.bigfish.com)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hlc5r-00059A-Gc
	for kexec@lists.infradead.org; Wed, 09 May 2007 03:39:57 +0100
Received: from outbound8-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound8-blu-R.bigfish.com (Postfix) with ESMTP id AD48C9DCE4B
	for <kexec@lists.infradead.org>; Wed,  9 May 2007 02:39:48 +0000 (UTC)
Received: from mail260-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound8-blu.bigfish.com (Postfix) with ESMTP id 8DCAE60004F
	for <kexec@lists.infradead.org>; Wed,  9 May 2007 02:39:48 +0000 (UTC)
Received: from mail260-blu (localhost.localdomain [127.0.0.1])
	by mail260-blu-R.bigfish.com (Postfix) with ESMTP id 55EB312601E2
	for <kexec@lists.infradead.org>; Wed,  9 May 2007 02:39:48 +0000 (UTC)
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail260-blu.bigfish.com (Postfix) with ESMTP id 2ABE91648056
	for <kexec@lists.infradead.org>; Wed,  9 May 2007 02:39:48 +0000 (UTC)
Received: from mail1.sgo.in.sel.sony.com (mail1.sgo.in.sel.sony.com
	[43.130.1.111])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id l492dlS8000131
	for <kexec@lists.infradead.org>; Wed, 9 May 2007 02:39:47 GMT
Received: from USSDIXIM01.am.sony.com (ussdixim01.am.sony.com [43.130.140.33])
	by mail1.sgo.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id
	l492dkHA024345
	for <kexec@lists.infradead.org>; Wed, 9 May 2007 02:39:46 GMT
Message-ID: <46413472.8000304@am.sony.com>
Date: Tue, 08 May 2007 19:39:46 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [patch v2] kexec fix ppc64 device-tree mem node
References: <20070507235727.631477448@am.sony.com>>
	<463FBE38.5090901@am.sony.com>
In-Reply-To: <463FBE38.5090901@am.sony.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org

Change the ppc64 device-tree memory node name spec to match 'memory'
or 'memory@', as specified in the booting-without-of document.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
Version 2, changed to look for 'memory' or 'memory@' nodes.

 kexec/arch/ppc64/crashdump-ppc64.c |    3 ++-
 kexec/arch/ppc64/kexec-ppc64.c     |   16 ++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

--- ps3-kexec-tools.orig/kexec/arch/ppc64/crashdump-ppc64.c
+++ ps3-kexec-tools/kexec/arch/ppc64/crashdump-ppc64.c
@@ -129,7 +129,8 @@ static int get_crash_memory_ranges(struc
 		goto err;
 	}
 	while ((dentry = readdir(dir)) != NULL) {
-		if (strncmp(dentry->d_name, "memory@", 7))
+		if (strncmp(dentry->d_name, "memory@", 7) &&
+			strcmp(dentry->d_name, "memory"))
 			continue;
 		strcpy(fname, device_tree);
 		strcat(fname, dentry->d_name);
--- ps3-kexec-tools.orig/kexec/arch/ppc64/kexec-ppc64.c
+++ ps3-kexec-tools/kexec/arch/ppc64/kexec-ppc64.c
@@ -98,7 +98,7 @@ err1:
 }
 
 /*
- * Count the memory@ nodes under /proc/device-tree and populate the
+ * Count the memory nodes under /proc/device-tree and populate the
  * max_memory_ranges variable. This variable replaces MAX_MEMORY_RANGES
  * macro used earlier.
  */
@@ -114,8 +114,9 @@ static int count_memory_ranges(void)
 	}
 
 	while ((dentry = readdir(dir)) != NULL) {
-		if (strncmp(dentry->d_name, "memory@", 7) &&
-		    strncmp(dentry->d_name, "pci@", 4))
+			strncmp(dentry->d_name, "memory@", 7) &&
+			strcmp(dentry->d_name, "memory") &&
+			strncmp(dentry->d_name, "pci@", 4))
 			continue;
 		max_memory_ranges++;
 	}
@@ -170,7 +171,8 @@ static int get_base_ranges(void)
 		return -1;
 	}
 	while ((dentry = readdir(dir)) != NULL) {
-		if (strncmp(dentry->d_name, "memory@", 7))
+		if (strncmp(dentry->d_name, "memory@", 7) &&
+			strcmp(dentry->d_name, "memory"))
 			continue;
 		strcpy(fname, device_tree);
 		strcat(fname, dentry->d_name);
@@ -272,7 +274,8 @@ static int get_devtree_details(unsigned 
 
 	while ((dentry = readdir(dir)) != NULL) {
 		if (strncmp(dentry->d_name, "chosen", 6) &&
-			strncmp(dentry->d_name, "memory@0", 8) &&
+			strncmp(dentry->d_name, "memory@", 7) &&
+			strcmp(dentry->d_name, "memory") &&
 			strncmp(dentry->d_name, "pci@", 4) &&
 			strncmp(dentry->d_name, "rtas", 4))
 			continue;
@@ -452,7 +455,8 @@ static int get_devtree_details(unsigned 
 				add_usable_mem_rgns(rtas_base, rtas_size);
 		} /* rtas */
 
-		if (strncmp(dentry->d_name, "memory@0", 8) == 0) {
+		if (!strncmp(dentry->d_name, "memory@", 7) ||
+			!strcmp(dentry->d_name, "memory")) {
 			strcat(fname, "/reg");
 			if ((file = fopen(fname, "r")) == NULL) {
 				perror(fname);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
