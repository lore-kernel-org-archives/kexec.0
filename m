Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UUCmT-0001tZ-Rw
 for kexec@lists.infradead.org; Mon, 22 Apr 2013 09:11:27 +0000
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 10:06:15 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id BD5201B0806B
 for <kexec@lists.infradead.org>; Mon, 22 Apr 2013 10:11:20 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3M9BAgN45744202
 for <kexec@lists.infradead.org>; Mon, 22 Apr 2013 09:11:10 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3M9BKT4023380
 for <kexec@lists.infradead.org>; Mon, 22 Apr 2013 03:11:20 -0600
Date: Mon, 22 Apr 2013 11:11:17 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] makedumpfile: Check dump file early
Message-ID: <20130422111117.00c1ecef@holzheu>
In-Reply-To: <51747DD3.8000104@jp.fujitsu.com>
References: <20130419173644.4c24dead@holzheu> <51747DD3.8000104@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org

On Mon, 22 Apr 2013 09:01:23 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> > +	if (info->flag_force) {
> > +		if (access(path, W_OK) == 0)
> > +			return TRUE; /* We have write permission */
> > +		err_str = strerror(errno);
> > +	} else {
> > +		err_str = "File exists";
> 
> How about strerror(EEXIST)? It's better to avoid hard code to use the 
> same string as what libc returns.

Yes, this solution is better.

Here the updated patch:
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
+		err_str = strerror(EEXIST);
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
