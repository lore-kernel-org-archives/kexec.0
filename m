Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NmPWC-00009j-VP
	for kexec@lists.infradead.org; Tue, 02 Mar 2010 10:40:05 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id o22AdrOF017323
	for <kexec@lists.infradead.org>; Tue, 2 Mar 2010 21:39:53 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o22AYKNb1233038
	for <kexec@lists.infradead.org>; Tue, 2 Mar 2010 21:34:21 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o22Adq5l018329
	for <kexec@lists.infradead.org>; Tue, 2 Mar 2010 21:39:53 +1100
From: Chandru <chandru@in.ibm.com>
Subject: [PATCH] kexec/kdump: RMO region does not exist in drconf memory
Date: Tue, 2 Mar 2010 16:09:49 +0530
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <201003021609.50188.chandru@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

The RMO region can only exist in '/memory@0' node in the device tree.
While adding support for '/ibm,dynamic-reconfiguration-memory' in
kexec-tools, I incorrectly extended the code of '/memory@' nodes to
drconf memory with the assumption that what applies to '/memory@'
nodes would also apply to drconf memory. This is incorrect and
hence removing the code from kexec-tools now.

With this code in place, kexec on kexec fails. The first kexec
works because '/memory@0' node is read after drconf memory and
that correctly sets rmo_base and rmo_top from '/memory@0' node.
While in the kexec'ed kernel, '/ibm,dynamic-reconfiguration-memory'
is read after '/memory@xxx' nodes and this incorrectly sets both
rmo_base and rmo_top from drconf memory.

Sorry for introducing this bug.

Signed-off-by: Chandru Siddalingappa <chandru@linux.vnet.ibm.com>
---

--- kexec-tools/kexec/arch/ppc64/kexec-ppc64.c.orig	2010-03-02 08:11:16.000000000 +0000
+++ kexec-tools/kexec/arch/ppc64/kexec-ppc64.c	2010-03-02 08:13:37.000000000 +0000
@@ -342,9 +342,7 @@ static int get_devtree_details(unsigned
 			strncmp(dentry->d_name, "memory@", 7) &&
 			strcmp(dentry->d_name, "memory") &&
 			strncmp(dentry->d_name, "pci@", 4) &&
-			strncmp(dentry->d_name, "rtas", 4) &&
-			strncmp(dentry->d_name,
-				"ibm,dynamic-reconfiguration-memory", 35))
+			strncmp(dentry->d_name, "rtas", 4)) 
 			continue;
 		strcpy(fname, device_tree);
 		strcat(fname, dentry->d_name);
@@ -550,29 +548,6 @@ static int get_devtree_details(unsigned
 			closedir(cdir);
 		} /* memory */
 
-		if (!strncmp(dentry->d_name,
-				"ibm,dynamic-reconfiguration-memory", 35)) {
-			unsigned int k;
-			strcat(fname, "/ibm,dynamic-memory");
-			if ((file = fopen(fname, "r")) == NULL) {
-				perror(fname);
-				goto error_opencdir;
-			}
-			fseek(file, 4, SEEK_SET);
-			for (k = 0; k < num_of_lmbs; k++) {
-				if ((n = fread(buf, 1, 24, file)) < 0) {
-					perror(fname);
-					goto error_openfile;
-				}
-				rmo_base = ((uint64_t *)buf)[0];
-				rmo_top = rmo_base + lmb_size;
-				if (rmo_top > 0x30000000UL)
-					rmo_top = 0x30000000UL;
-			}
-			fclose(file);
-			closedir(cdir);
-		} /* ibm,dynamic-reconfiguration-memory */
-
 		if (strncmp(dentry->d_name, "pci@", 4) == 0) {
 			strcat(fname, "/linux,tce-base");
 			if ((file = fopen(fname, "r")) == NULL) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
