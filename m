Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JKVfj-00027Q-Tr
	for kexec@lists.infradead.org; Thu, 31 Jan 2008 09:25:35 +0000
Received: from Relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id AFE7627808
	for <kexec@lists.infradead.org>; Thu, 31 Jan 2008 10:25:25 +0100 (CET)
Message-ID: <47A19405.7080109@suse.de>
Date: Thu, 31 Jan 2008 10:25:25 +0100
From: Stefan Assmann <sassmann@suse.de>
MIME-Version: 1.0
Subject: kexec buffer overflow on ppc platform
Content-Type: multipart/mixed; boundary="------------060606010200090906050305"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This is a multi-part message in MIME format.
--------------060606010200090906050305
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

this patch fixes a buffer overflow on ppc.

    Stefan

-- 
Stefan Assmann          | SUSE LINUX Products GmbH
Software Engineer       | Maxfeldstr. 5, D-90409 Nuernberg
Mail : sassmann@suse.de | GF: Markus Rex, HRB 16746 (AG Nuernberg)




--------------060606010200090906050305
Content-Type: text/x-patch;
 name="kexec-tools.fread-buffer-overflow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="kexec-tools.fread-buffer-overflow.patch"

This patch fixes buffer overflows when buf is allocated MAXBYTES-1 and fread(buf, 1, MAXBYTES, file) is invoked.

Signed-off-by: Stefan Assmann <sassmann@suse.de>
---
 kexec/arch/ppc64/crashdump-ppc64.c |    2 +-
 kexec/arch/ppc64/kexec-ppc64.c     |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: b/kexec/arch/ppc64/kexec-ppc64.c
===================================================================
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -160,7 +160,7 @@ static int get_base_ranges(void)
 	int local_memory_ranges = 0;
 	char device_tree[256] = "/proc/device-tree/";
 	char fname[256];
-	char buf[MAXBYTES-1];
+	char buf[MAXBYTES];
 	DIR *dir, *dmem;
 	FILE *file;
 	struct dirent *dentry, *mentry;
@@ -258,7 +258,7 @@ static int get_devtree_details(unsigned
 	unsigned long long htab_base, htab_size;
 	unsigned long long kernel_end;
 	unsigned long long initrd_start, initrd_end;
-	char buf[MAXBYTES-1];
+	char buf[MAXBYTES];
 	char device_tree[256] = "/proc/device-tree/";
 	char fname[256];
 	DIR *dir, *cdir;
Index: b/kexec/arch/ppc64/crashdump-ppc64.c
===================================================================
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -101,7 +101,7 @@ static int get_crash_memory_ranges(struc
 	int memory_ranges = 0;
 	char device_tree[256] = "/proc/device-tree/";
 	char fname[256];
-	char buf[MAXBYTES-1];
+	char buf[MAXBYTES];
 	DIR *dir, *dmem;
 	FILE *file;
 	struct dirent *dentry, *mentry;



--------------060606010200090906050305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------060606010200090906050305--

