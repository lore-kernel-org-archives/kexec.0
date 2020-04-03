Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKKN8-00026L-4e
 for kexec@lists.infradead.org; Fri, 03 Apr 2020 11:20:28 +0000
From: Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH] kexec-tools: s390: Reset kernel command line on syscall
 fallback
Date: Fri,  3 Apr 2020 13:19:16 +0200
Message-Id: <20200403111916.14663-1-ptesarik@suse.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec mailing list <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.com>

The command line is duplicated on s390 if kexec_file_load(2) is not
implemented. That's because the corresponding variable is not reset
to an empty string before re-parsing the kexec command line.

Fixes: 9cf721279f6c ("Reset getopt before falling back to legacy syscall")
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 kexec/arch/s390/kexec-image.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
index 8b39566..3c24fdf 100644
--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -112,6 +112,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 		};
 	static const char short_options[] = KEXEC_OPT_STR "";
 
+	command_line[0] = 0;
 	ramdisk = NULL;
 	ramdisk_len = 0;
 	ramdisk_origin = 0;
-- 
2.16.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
