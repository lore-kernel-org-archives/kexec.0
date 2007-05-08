Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-blu.bigfish.com ([65.55.251.10]
	helo=mail149-blu-R.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HlDc8-0005mf-3C
	for kexec@lists.infradead.org; Mon, 07 May 2007 20:31:37 -0400
Received: from mail149-blu (localhost.localdomain [127.0.0.1])
	by mail149-blu-R.bigfish.com (Postfix) with ESMTP id EBD3E900174
	for <kexec@lists.infradead.org>; Tue,  8 May 2007 00:03:06 +0000 (UTC)
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail149-blu.bigfish.com (Postfix) with ESMTP id 4582914B0077
	for <kexec@lists.infradead.org>; Tue,  8 May 2007 00:03:06 +0000 (UTC)
Received: from mail1.sgo.in.sel.sony.com (mail1.sgo.in.sel.sony.com
	[43.130.1.111])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id l48035Qw017730
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 00:03:05 GMT
Received: from USSDIXIM02.am.sony.com (ussdixim02.am.sony.com [43.130.140.34])
	by mail1.sgo.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id
	l48035nm019352
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 00:03:05 GMT
Message-ID: <463FBE38.5090901@am.sony.com>
Date: Mon, 07 May 2007 17:03:04 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [patch 5/5] kexec fix ppc64 device-tree mem node
References: <20070507235727.631477448@am.sony.com>>
In-Reply-To: <20070507235727.631477448@am.sony.com>>
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
To: kexec@lists.infradead.org
Cc: Geoff Levand <geoffrey.levand@am.sony.com>

Change the ppc64 device-tree memory node name spec to match the allowable names
specified in the booting-without-of document.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 kexec/arch/ppc64/crashdump-ppc64.c |    2 +-
 kexec/arch/ppc64/kexec-ppc64.c     |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

--- kexec-tools-hacked.orig/kexec/arch/ppc64/crashdump-ppc64.c
+++ kexec-tools-hacked/kexec/arch/ppc64/crashdump-ppc64.c
@@ -129,7 +129,7 @@ static int get_crash_memory_ranges(struc
 		goto err;
 	}
 	while ((dentry = readdir(dir)) != NULL) {
-		if (strncmp(dentry->d_name, "memory@", 7))
+		if (strncmp(dentry->d_name, "memory", 6))
 			continue;
 		strcpy(fname, device_tree);
 		strcat(fname, dentry->d_name);
--- kexec-tools-hacked.orig/kexec/arch/ppc64/kexec-ppc64.c
+++ kexec-tools-hacked/kexec/arch/ppc64/kexec-ppc64.c
@@ -98,7 +98,7 @@ err1:
 }
 
 /*
- * Count the memory@ nodes under /proc/device-tree and populate the
+ * Count the memory nodes under /proc/device-tree and populate the
  * max_memory_ranges variable. This variable replaces MAX_MEMORY_RANGES
  * macro used earlier.
  */
@@ -114,7 +114,7 @@ static int count_memory_ranges(void)
 	}
 
 	while ((dentry = readdir(dir)) != NULL) {
-		if (strncmp(dentry->d_name, "memory@", 7) &&
+		if (strncmp(dentry->d_name, "memory", 6) &&
 		    strncmp(dentry->d_name, "pci@", 4))
 			continue;
 		max_memory_ranges++;
@@ -170,7 +170,7 @@ static int get_base_ranges(void)
 		return -1;
 	}
 	while ((dentry = readdir(dir)) != NULL) {
-		if (strncmp(dentry->d_name, "memory@", 7))
+		if (strncmp(dentry->d_name, "memory", 6))
 			continue;
 		strcpy(fname, device_tree);
 		strcat(fname, dentry->d_name);
@@ -272,7 +272,7 @@ static int get_devtree_details(unsigned 
 
 	while ((dentry = readdir(dir)) != NULL) {
 		if (strncmp(dentry->d_name, "chosen", 6) &&
-			strncmp(dentry->d_name, "memory@0", 8) &&
+			strncmp(dentry->d_name, "memory", 6) &&
 			strncmp(dentry->d_name, "pci@", 4) &&
 			strncmp(dentry->d_name, "rtas", 4))
 			continue;
@@ -452,7 +452,7 @@ static int get_devtree_details(unsigned 
 				add_usable_mem_rgns(rtas_base, rtas_size);
 		} /* rtas */
 
-		if (strncmp(dentry->d_name, "memory@0", 8) == 0) {
+		if (strncmp(dentry->d_name, "memory", 6) == 0) {
 			strcat(fname, "/reg");
 			if ((file = fopen(fname, "r")) == NULL) {
 				perror(fname);

-- 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
