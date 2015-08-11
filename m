Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZOyZn-0003Ng-Fj
 for kexec@lists.infradead.org; Tue, 11 Aug 2015 01:42:05 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t7B1cVMs001075
 for <kexec@lists.infradead.org>; Tue, 11 Aug 2015 09:38:31 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v5 09/10] Make makedumpfile available to read and compress
 pages parallelly
Date: Tue, 11 Aug 2015 09:35:21 +0800
Message-ID: <1439256922-8781-10-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1439256922-8781-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1439256922-8781-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: kexec@lists.infradead.org
Cc: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>

From: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>

Using this patch, it is available to use multiple threads to read
and compress pages. This parallel process will save time.

Currently, sadump and xen kdump is not supported.

Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
Signed-off-by: Zhou wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 makedumpfile.h |  1 +
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index cd423e6..385bb67 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3857,6 +3857,27 @@ out:
 		DEBUG_MSG("Buffer size for the cyclic mode: %ld\n", info->bufsize_cyclic);
 	}
 
+	if (info->num_threads) {
+		if (is_xen_memory()) {
+			MSG("'--num-threads' option is disable,\n");
+			MSG("because %s is Xen's memory core image.\n",
+							info->name_memory);
+			return FALSE;
+		}
+
+		if (info->flag_sadump) {
+			MSG("'--num-threads' option is disable,\n");
+			MSG("because %s is sadump %s format.\n",
+			    info->name_memory, sadump_format_type_name());
+			return FALSE;
+		}
+
+		if (!initial_for_parallel()) {
+			MSG("Fail to initial for parallel process.\n");
+			return FALSE;
+		}
+	}
+
 	if (!is_xen_memory() && !cache_init())
 		return FALSE;
 
@@ -7896,9 +7917,16 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		if (!write_kdump_bitmap2(&cycle))
 			return FALSE;
 
-		if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero,
+		if (info->num_threads) {
+			if (!write_kdump_pages_parallel_cyclic(cd_header,
+							cd_page, &pd_zero,
+							&offset_data, &cycle))
+				return FALSE;
+		} else {
+			if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero,
 					&offset_data, &cycle))
-			return FALSE;
+				return FALSE;
+		}
 	}
 	free_bitmap2_buffer();
 
@@ -9865,6 +9893,18 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
 	if (info->flag_sadump_diskset && !sadump_is_supported_arch())
 		return FALSE;
 
+	if (info->num_threads) {
+		if (info->flag_split) {
+			MSG("--num-threads cannot used with --split.\n");
+			return FALSE;
+		}
+
+		if (info->flag_elf_dumpfile) {
+			MSG("--num-threads cannot used with ELF format.\n");
+			return FALSE;
+		}
+	}
+
 	if ((argc == optind + 2) && !info->flag_flatten
 				 && !info->flag_split
 				 && !info->flag_sadump_diskset) {
@@ -9929,6 +9969,18 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
 	} else
 		return FALSE;
 
+	if (info->num_threads) {
+		if ((info->parallel_info =
+		     malloc(sizeof(parallel_info_t) * info->num_threads))
+		    == NULL) {
+			MSG("Can't allocate memory for parallel_info.\n");
+			return FALSE;
+		}
+
+		memset(info->parallel_info, 0, sizeof(parallel_info_t)
+							* info->num_threads);
+	}
+
 	return TRUE;
 }
 
@@ -10245,6 +10297,7 @@ static struct option longopts[] = {
 	{"mem-usage", no_argument, NULL, OPT_MEM_USAGE},
 	{"splitblock-size", required_argument, NULL, OPT_SPLITBLOCK_SIZE},
 	{"work-dir", required_argument, NULL, OPT_WORKING_DIR},
+	{"num-threads", required_argument, NULL, OPT_NUM_THREADS},
 	{0, 0, 0, 0}
 };
 
@@ -10389,6 +10442,9 @@ main(int argc, char *argv[])
 		case OPT_WORKING_DIR:
 			info->working_dir = optarg;
 			break;
+		case OPT_NUM_THREADS:
+			info->num_threads = MAX(atoi(optarg), 0);
+			break;
 		case '?':
 			MSG("Commandline parameter is invalid.\n");
 			MSG("Try `makedumpfile --help' for more information.\n");
@@ -10532,6 +10588,8 @@ out:
 	else if (!info->flag_mem_usage)
 		MSG("makedumpfile Completed.\n");
 
+	free_for_parallel();
+
 	if (info) {
 		if (info->dh_memory)
 			free(info->dh_memory);
@@ -10559,6 +10617,8 @@ out:
 			free(info->p2m_mfn_frame_list);
 		if (info->page_buf != NULL)
 			free(info->page_buf);
+		if (info->parallel_info != NULL)
+			free(info->parallel_info);
 		free(info);
 
 		if (splitblock) {
diff --git a/makedumpfile.h b/makedumpfile.h
index 1f5bd7f..3cd24c5 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -2033,6 +2033,7 @@ struct elf_prstatus {
 #define OPT_MEM_USAGE           OPT_START+13
 #define OPT_SPLITBLOCK_SIZE	OPT_START+14
 #define OPT_WORKING_DIR         OPT_START+15
+#define OPT_NUM_THREADS	OPT_START+16
 
 /*
  * Function Prototype.
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
