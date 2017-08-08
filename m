Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1deuFK-0003fC-Fm
 for kexec@lists.infradead.org; Tue, 08 Aug 2017 02:27:52 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [makedumpfile PATCH] Fix formatting problems in header file
Date: Tue, 8 Aug 2017 02:25:28 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EF7324@BPXM01GP.gisp.nec.co.jp>
References: <1501849748-11647-1-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1501849748-11647-1-git-send-email-eric.devolder@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "daniel.kiper@oracle.com" <daniel.kiper@oracle.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>

Hello,

>The list of #defines uses spaces to separate the value from the
>name. A few used tabs, so those tabs have been converted to
>spaces so that the values align again.
>
>Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

Thanks, I'll merge this into v1.6.3.

Regards,
Atsushi Kumagai

>---
> makedumpfile.h | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/makedumpfile.h b/makedumpfile.h
>index 8a05794..34dd8d7 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -2244,7 +2244,7 @@ struct elf_prstatus {
> #define OPT_DEBUG               'D'
> #define OPT_DUMP_LEVEL          'd'
> #define OPT_ELF_DUMPFILE        'E'
>-#define OPT_EXCLUDE_UNUSED_VM	'e'
>+#define OPT_EXCLUDE_UNUSED_VM   'e'
> #define OPT_FLATTEN             'F'
> #define OPT_FORCE               'f'
> #define OPT_GENERATE_VMCOREINFO 'g'
>@@ -2271,10 +2271,10 @@ struct elf_prstatus {
> #define OPT_EPPIC               OPT_START+11
> #define OPT_NON_MMAP            OPT_START+12
> #define OPT_MEM_USAGE           OPT_START+13
>-#define OPT_SPLITBLOCK_SIZE	OPT_START+14
>+#define OPT_SPLITBLOCK_SIZE     OPT_START+14
> #define OPT_WORKING_DIR         OPT_START+15
>-#define OPT_NUM_THREADS	OPT_START+16
>-#define OPT_PARTIAL_DMESG	OPT_START+17
>+#define OPT_NUM_THREADS         OPT_START+16
>+#define OPT_PARTIAL_DMESG       OPT_START+17
>
> /*
>  * Function Prototype.
>--
>2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
