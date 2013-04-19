Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UTEUJ-0002UK-2z
 for kexec@lists.infradead.org; Fri, 19 Apr 2013 16:48:40 +0000
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 19 Apr 2013 16:34:07 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0851E219002D
 for <kexec@lists.infradead.org>; Fri, 19 Apr 2013 16:39:07 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3JFab7553608674
 for <kexec@lists.infradead.org>; Fri, 19 Apr 2013 15:36:37 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r3JFakiW027114
 for <kexec@lists.infradead.org>; Fri, 19 Apr 2013 09:36:46 -0600
Date: Fri, 19 Apr 2013 17:36:44 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH] makedumpfile: Check dump file early
Message-ID: <20130419173644.4c24dead@holzheu>
Mime-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On s390 the makedumpfile tool sometimes is used directly by
users on the command line. Currently the check if the dump
file already exists is done after the filtering function has
been called. Therefore, for large dumps the user has to wait
for filtering and after some time he gets the error message
"open_dump_file: Can't open the dump file(out). File exists".

This patch improves this by adding an early check for the
existence of the dump file. In case the -f (force) option has
been specified it is checked that an existing file is writable.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 makedumpfile.c |   37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -730,6 +730,24 @@ open_dump_file(void)
 }
 
 int
+check_dump_file(const char *path)
+{
+	char *err_str;
+
+	if (access(path, F_OK) != 0)
+		return TRUE; /* File does not exist */
+	if (info->flag_force) {
+		if (access(path, W_OK) == 0)
+			return TRUE; /* We have write permission */
+		err_str = strerror(errno);
+	} else {
+		err_str = "File exists";
+	}
+	ERRMSG("Can't open the dump file (%s). %s\n", path, err_str);
+	return FALSE;
+}
+
+int
 open_dump_bitmap(void)
 {
 	int i, fd;
@@ -8609,6 +8627,9 @@ main(int argc, char *argv[])
 			MSG("Try `makedumpfile --help' for more information.\n");
 			goto out;
 		}
+		if (!check_dump_file(info->name_dumpfile))
+			goto out;
+
 		if (!open_files_for_rearranging_dumpdata())
 			goto out;
 
@@ -8626,9 +8647,11 @@ main(int argc, char *argv[])
 			MSG("Try `makedumpfile --help' for more information.\n");
 			goto out;
 		}
-		if (!reassemble_dumpfile())
+		if (!check_dump_file(info->name_dumpfile))
 			goto out;
 
+		if (!reassemble_dumpfile())
+			goto out;
 		MSG("\n");
 		MSG("The dumpfile is saved to %s.\n", info->name_dumpfile);
 	} else if (info->flag_dmesg) {
@@ -8637,6 +8660,8 @@ main(int argc, char *argv[])
 			MSG("Try `makedumpfile --help' for more information.\n");
 			goto out;
 		}
+		if (!check_dump_file(info->name_dumpfile))
+			goto out;
 		if (!dump_dmesg())
 			goto out;
 
@@ -8648,6 +8673,16 @@ main(int argc, char *argv[])
 			MSG("Try `makedumpfile --help' for more information.\n");
 			goto out;
 		}
+		if (info->flag_split) {
+			for (i = 0; i < info->num_dumpfile; i++) {
+				if (!check_dump_file(SPLITTING_DUMPFILE(i)))
+					goto out;
+			}
+		} else {
+			if (!check_dump_file(info->name_dumpfile))
+				goto out;
+		}
+
 		if (!create_dumpfile())
 			goto out;
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
