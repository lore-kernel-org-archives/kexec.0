Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xbjzn-00088Q-H0
 for kexec@lists.infradead.org; Wed, 08 Oct 2014 05:41:09 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH resend v2 3/3] makedumpfile: implementation of dealing
 with kdump-compressed dumpfile with ENOSPC error
Date: Wed, 8 Oct 2014 05:39:31 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D4CED4@BPXM01GP.gisp.nec.co.jp>
References: <1411551304-5776-1-git-send-email-wangx.fnst@cn.fujitsu.com>
 <1411551304-5776-3-git-send-email-wangx.fnst@cn.fujitsu.com>
In-Reply-To: <1411551304-5776-3-git-send-email-wangx.fnst@cn.fujitsu.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "wangx.fnst@cn.fujitsu.com" <wangx.fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>kdump-compressed:
>Dump the bitmap before any page header and page data. This format use
>"status" of "disk_dump_header" to indicate that it has been modified.
>
>Signed-of-by: Wang Xiao <wangx.fnst@cn.fujitsu.com>
>---
> diskdump_mod.h |  2 ++
> makedumpfile.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
> 2 files changed, 82 insertions(+), 5 deletions(-)
>

[snip]

>+int
>+check_and_modify_multiple_kdump_headers() {
>+	int i, status, ret = TRUE;
>+	pid_t pid;
>+	pid_t array_pid[info->num_dumpfile];
>+
>+	for (i = 0; i < info->num_dumpfile; i++) {
>+		if ((pid = fork()) < 0) {
>+			return FALSE;
>+
>+		} else if (pid == 0) { /* Child */
>+			if (!check_and_modify_kdump_headers(SPLITTING_DUMPFILE(i)))
>+				exit(1);

reassemble_kdump_header() adopts only the dh.status of SPLITTING_DUMPFILE(0),
we should fix it to take over incomplete flags of the other dump files.


Thanks
Atsushi Kumagai

>+			exit(0);
>+		}
>+		array_pid[i] = pid;
>+	}
>+
>+	for (i = 0; i < info->num_dumpfile; i++) {
>+		waitpid(array_pid[i], &status, WUNTRACED);
>+		if (!WIFEXITED(status) || WEXITSTATUS(status) == 1) {
>+			ERRMSG("Check and modify the incomplete dumpfile(%s) failed.\n",
>+			       SPLITTING_DUMPFILE(i));
>+			ret = FALSE;
>+		}
>+	}
>+
>+	return ret;
>+}
>+
>+int
> rearrange_dumpdata(void)
> {
> 	int read_size, tmp_read_size;
>@@ -7185,11 +7250,11 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
> 		if (!exclude_unnecessary_pages_cyclic(&cycle))
> 			return FALSE;
>
>-		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero,
>-					&offset_data, &cycle))
>+		if (!write_kdump_bitmap2_cyclic(&cycle))
> 			return FALSE;
>
>-		if (!write_kdump_bitmap2_cyclic(&cycle))
>+		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero,
>+					&offset_data, &cycle))
> 			return FALSE;
> 	}
>
>@@ -8189,12 +8254,12 @@ writeout_dumpfile(void)
> 	} else {
> 		if (!write_kdump_header())
> 			goto out;
>+		if (!write_kdump_bitmap())
>+			goto out;
> 		if (!write_kdump_pages(&cd_header, &cd_page))
> 			goto out;
> 		if (!write_kdump_eraseinfo(&cd_page))
> 			goto out;
>-		if (!write_kdump_bitmap())
>-			goto out;
> 	}
> 	if (info->flag_flatten) {
> 		if (!write_end_flat_header())
>@@ -8405,6 +8470,16 @@ retry:
> 					if (check_and_modify_elf_headers(info->name_dumpfile))
> 						MSG("This is an incomplete dumpfile,"
> 						    " but might analyzable.\n");
>+				} else {
>+					if (info->flag_split) {
>+						if (check_and_modify_multiple_kdump_headers())
>+							MSG("The splited dumpfiles are incomplete,"
>+							    " but might analyzable.\n");
>+					} else {
>+						if (check_and_modify_kdump_headers(info->name_dumpfile))
>+							MSG("This is an incomplete dumpfile,"
>+							    " but might analyzable.\n");
>+					}
> 				}
> 			}
>
>--
>1.8.3.1
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
