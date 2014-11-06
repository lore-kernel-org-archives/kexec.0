Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XmHq1-00045L-UP
 for kexec@lists.infradead.org; Thu, 06 Nov 2014 07:50:39 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH V4 4/5] Add module of calculating start_pfn and end_pfn
 in each dumpfile
Date: Thu, 6 Nov 2014 07:47:46 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D64E7B@BPXM01GP.gisp.nec.co.jp>
References: <1415251402-12698-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1415251402-12698-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1415251402-12698-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: "zhouwj-fnst@cn.fujitsu.com" <zhouwj-fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>When --split is specified in cyclic mode, start_pfn and end_pfn of each dumpfile
>will be calculated to make each dumpfile have the same size.
>
>Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
>Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
>---
> makedumpfile.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
> 1 files changed, 66 insertions(+), 5 deletions(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index a01c616..831e7de 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -8217,6 +8217,63 @@ out:
> 		return ret;
> }
>
>+/*
>+ * calculate end_pfn of one dumpfile.
>+ * try to make every output file have the same size.
>+ * splitblock_table is used to reduce calculate time.
>+ */
>+
>+#define CURRENT_SPLITBLOCK_PFN_NUM (*cur_splitblock_num * splitblock->page_per_splitblock)
>+mdf_pfn_t
>+calculate_end_pfn_by_splitblock(mdf_pfn_t start_pfn,
>+				 int *cur_splitblock_num)
>+{
>+	if (start_pfn >= info->max_mapnr)
>+		return info->max_mapnr;
>+
>+	mdf_pfn_t end_pfn;
>+	long long pfn_needed, offset;
>+	char *splitblock_value_offset;
>+
>+	pfn_needed = info->num_dumpable / info->num_dumpfile;

pfn_needed is calculated by rounding-down, so...

>+	offset = *cur_splitblock_num * splitblock->entry_size;
>+	splitblock_value_offset = splitblock->table + offset;
>+	end_pfn = start_pfn;
>+
>+	while (*cur_splitblock_num < splitblock->num && pfn_needed > 0) {
>+		pfn_needed -= read_from_splitblock_table(splitblock_value_offset);
>+		splitblock_value_offset += splitblock->entry_size;
>+		++*cur_splitblock_num;
>+	}
>+
>+	end_pfn = CURRENT_SPLITBLOCK_PFN_NUM;
>+	if (end_pfn > info->max_mapnr)
>+		end_pfn = info->max_mapnr;
>+
>+	return end_pfn;
>+}
>+
>+/*
>+ * calculate start_pfn and end_pfn in each output file.
>+ */
>+static int setup_splitting_cyclic(void)
>+{
>+	int i;
>+	mdf_pfn_t start_pfn, end_pfn;
>+	int cur_splitblock_num = 0;
>+	start_pfn = end_pfn = 0;
>+
>+	for (i = 0; i < info->num_dumpfile; i++) {
>+		start_pfn = end_pfn;
>+		end_pfn = calculate_end_pfn_by_splitblock(start_pfn,
>+							  &cur_splitblock_num);
>+		SPLITTING_START_PFN(i) = start_pfn;
>+		SPLITTING_END_PFN(i) = end_pfn;
>+	}

the last SPLITTING_END_PFN can be shorter than the max_mapnr like:

    kdump sub header
      phys_base        : 0x0
      dump_level       : 30
      split            : 1
      start_pfn        : 0x11b609
      end_pfn          : 0x11fffe
      start_pfn_64     : 0x11b609
      end_pfn_64       : 0x11fffe           /* shorter than max_mapnr */
      max_mapnr_64     : 0x120000
      offset_vmcoreinfo: 0x1610
      size_vmcoreinfo  : 0x1726
      ...

then reassembling will fail like below:

  $ ./makedumpfile --reassemble split1 split2 split3 dumpfile
  check_splitting_info: There is not dumpfile corresponding to pfn 0x11fffe - 0x120000.

  makedumpfile Failed.
  $

We should adjust the last SPLITTING_END_PFN to max_mapnr.


Thanks,
Atsushi Kumagai

>+
>+	return TRUE;
>+}
>+
> int
> setup_splitting(void)
> {
>@@ -8230,12 +8287,16 @@ setup_splitting(void)
> 		return FALSE;
>
> 	if (info->flag_cyclic) {
>-		for (i = 0; i < info->num_dumpfile; i++) {
>-			SPLITTING_START_PFN(i) = divideup(info->max_mapnr, info->num_dumpfile) * i;
>-			SPLITTING_END_PFN(i)   = divideup(info->max_mapnr, info->num_dumpfile) * (i + 1);
>+		int ret = FALSE;
>+
>+		if(!prepare_bitmap2_buffer_cyclic()){
>+			free_bitmap_buffer();
>+			return ret;
> 		}
>-		if (SPLITTING_END_PFN(i-1) > info->max_mapnr)
>-			SPLITTING_END_PFN(i-1) = info->max_mapnr;
>+		ret = setup_splitting_cyclic();
>+		free_bitmap2_buffer_cyclic();
>+
>+		return ret;
>         } else {
> 		initialize_2nd_bitmap(&bitmap2);
>
>--
>1.7.1
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
