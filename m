Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxRN2-0009Zs-5V
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 10:18:49 +0000
From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2 2/5] s390: use KEXEC_ALL_OPTIONS
Date: Wed, 15 Dec 2021 11:18:33 +0100
Message-Id: <20211215101836.1181165-3-svens@linux.ibm.com>
In-Reply-To: <20211215101836.1181165-1-svens@linux.ibm.com>
References: <20211215101836.1181165-1-svens@linux.ibm.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, prudo@redhat.com, Sven Schnelle <svens@linux.ibm.com>, Alexander Egorenkov <egorenar@linux.ibm.com>

KEXEC_ALL_OPTIONS could be used instead defining the same
array several times. This makes code easier to maintain when
new options are added.

Suggested-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 kexec/arch/s390/kexec-image.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
index a52399eafd2a..209ab77ddccb 100644
--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -57,10 +57,7 @@ int image_s390_load_file(int argc, char **argv, struct kexec_info *info)
 
 	static const struct option options[] =
 		{
-			KEXEC_OPTIONS
-			{"command-line",     1, 0, OPT_APPEND},
-			{"append",           1, 0, OPT_APPEND},
-			{"initrd",           1, 0, OPT_RAMDISK},
+			KEXEC_ALL_OPTIONS
 			{0,                  0, 0, 0},
 		};
 	static const char short_options[] = KEXEC_OPT_STR "";
@@ -111,10 +108,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 
 	static const struct option options[] =
 		{
-			KEXEC_OPTIONS
-			{"command-line",     1, 0, OPT_APPEND},
-			{"append",           1, 0, OPT_APPEND},
-			{"initrd",           1, 0, OPT_RAMDISK},
+			KEXEC_ALL_OPTIONS
 			{0,                  0, 0, 0},
 		};
 	static const char short_options[] = KEXEC_OPT_STR "";
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
