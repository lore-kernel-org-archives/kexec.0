Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XcVT6-0005hn-Vp
 for kexec@lists.infradead.org; Fri, 10 Oct 2014 08:22:33 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v1 5/5] makedumpfile: Add support for --block-size
Date: Fri, 10 Oct 2014 08:11:48 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D4DD73@BPXM01GP.gisp.nec.co.jp>
References: <1411974387-10839-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1411974387-10839-6-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1411974387-10839-6-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

>Use --block-size to specify block size (KB)
>When --split is specified in cyclic mode,block table will be
>generated in get_num_dumpable_cyclic.
>
>Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
>Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
>---
> makedumpfile.8 |   16 ++++++++++++++++
> makedumpfile.c |    4 ++++
> makedumpfile.h |    1 +
> 3 files changed, 21 insertions(+), 0 deletions(-)
>
>diff --git a/makedumpfile.8 b/makedumpfile.8
>index 9cb12c0..a384213 100644
>--- a/makedumpfile.8
>+++ b/makedumpfile.8
>@@ -386,6 +386,22 @@ size, so ordinary users don't need to specify this option.
> # makedumpfile \-\-cyclic\-buffer 1024 \-d 31 \-x vmlinux /proc/vmcore dumpfile
>
> .TP
>+\fB\-\-block\-size\fR \fIblock_size\fR
>+Specify the block size in kilo bytes for analysis in the cyclic mode with --split.
>+In the cyclic split mode, the number of blocks is represented as:
>+
>+    num_of_blocks = system_memory / (\fIblock_size\fR * 1KB )
>+
>+The larger number of block, the faster working speed is expected, but the more memory will
>+be taken. By default, \fIblock_size\fR will be set as 1GB, so ordinary users don't need to
>+specify this option.
>+
>+.br
>+.B Example:
>+.br
>+# makedumpfile \-\-block\-size 10240 \-d 31 \-x vmlinux \-\-split /proc/vmcore dumpfile1 dumpfile2
>+
>+.TP

Also print_usage() in print_info.c should be modified.


Thanks,
Atsushi Kumagai

> \fB\-\-non\-cyclic\fR
> Running in the non-cyclic mode, this mode uses the old filtering logic same as v1.4.4 or before.
> If you feel the cyclic mode is too slow, please try this mode.
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 3e66346..405d935 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -9571,6 +9571,7 @@ static struct option longopts[] = {
> 	{"eppic", required_argument, NULL, OPT_EPPIC},
> 	{"non-mmap", no_argument, NULL, OPT_NON_MMAP},
> 	{"mem-usage", no_argument, NULL, OPT_MEM_USAGE},
>+	{"block-size", required_argument, NULL, OPT_BLOCK_SIZE},
> 	{0, 0, 0, 0}
> };
>
>@@ -9711,6 +9712,9 @@ main(int argc, char *argv[])
> 		case OPT_CYCLIC_BUFFER:
> 			info->bufsize_cyclic = atoi(optarg);
> 			break;
>+		case OPT_BLOCK_SIZE:
>+			info->block_size = atoi(optarg);
>+			break;
> 		case '?':
> 			MSG("Commandline parameter is invalid.\n");
> 			MSG("Try `makedumpfile --help' for more information.\n");
>diff --git a/makedumpfile.h b/makedumpfile.h
>index ed4f799..56d2c79 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -1883,6 +1883,7 @@ struct elf_prstatus {
> #define OPT_EPPIC               OPT_START+12
> #define OPT_NON_MMAP            OPT_START+13
> #define OPT_MEM_USAGE            OPT_START+14
>+#define OPT_BLOCK_SIZE		OPT_START+15
>
> /*
>  * Function Prototype.
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
