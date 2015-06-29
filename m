Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z9UZX-0006A4-Ay
 for kexec@lists.infradead.org; Mon, 29 Jun 2015 08:37:48 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 1/2] makedumpfile: Delete useless codes
Date: Mon, 29 Jun 2015 08:34:08 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DCA532@BPXM01GP.gisp.nec.co.jp>
References: <1435215062-31333-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1435215062-31333-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

>free_bitmap_buffer() in create_dump_bitmap() includes free_bitmap2_buffer().
>So delete free_bitmap2_buffer().

I thought that calling free_bitmap_buffer() at the end of create_dump_bitmap()
is wrong, actually I fixed that in the devel branch like below:

  int
  create_dump_bitmap(void)
  {
  ...
          /* Should keep the buffer in the 1-cycle case. */
          if (info->flag_cyclic)
                  free_bitmap_buffer();

          return ret;
  }

The reason why we free the 2nd bitmap buffer once here is to reduce the
memory consumption for the multi-cycle case in the kdump-compressed path,
otherwise the bitmap buffers should be kept during execution.

If the buffers are kept as expected, there is no need to re-prepare the
2nd bitmap buffer as [PATCH 2/2].

However, thanks to you, I notice that the current devel code still
free the 2nd bitmap buffer in the ELF path even though it's necessary.
So I'll fix it.


Thanks
Atsushi Kumagai

>Signed-off-by: Zhou wenjian <zhouwj-fnst@cn.fujitsu.com>
>---
> makedumpfile.c |    3 ---
> 1 files changed, 0 insertions(+), 3 deletions(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index cc71f20..7f2949c 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -5933,9 +5933,6 @@ create_dump_bitmap(void)
>
> 		info->num_dumpable = get_num_dumpable_cyclic();
>
>-		if (!info->flag_elf_dumpfile)
>-			free_bitmap2_buffer();
>-
> 	} else {
> 		struct cycle cycle = {0};
> 		first_cycle(0, info->max_mapnr, &cycle);
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
