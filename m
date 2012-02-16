Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RxsAc-0001Jz-Qg
 for kexec@lists.infradead.org; Thu, 16 Feb 2012 03:38:11 +0000
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Thu, 16 Feb 2012 09:08:04 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1G3bLje3707026
 for <kexec@lists.infradead.org>; Thu, 16 Feb 2012 09:07:21 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1G3bL4J009137
 for <kexec@lists.infradead.org>; Thu, 16 Feb 2012 09:07:21 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v1 4/4] [makedumpfile][ppc] PPC44x page translation definitions
Date: Thu, 16 Feb 2012 09:07:07 +0530
Message-ID: <20120216033656.7972.19596.stgit@suzukikp>
In-Reply-To: <20120216033411.7972.77705.stgit@suzukikp>
References: <20120216033411.7972.77705.stgit@suzukikp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

This patch defines the translation bits for PPC44x.


Signed-off-by : Suzuki K. Poulose <suzuki@in.ibm.com>
---

 arch/ppc.c     |   15 +++++++++++++++
 makedumpfile.h |    4 ++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/ppc.c b/arch/ppc.c
index 0ad2cf4..b63a617 100644
--- a/arch/ppc.c
+++ b/arch/ppc.c
@@ -37,12 +37,27 @@ struct platform {
 typedef int (*probe_func_t)(char *, struct platform *);
 
 static int probe_default_platform(char *, struct platform*);
+static int probe_ppc44x_platform(char *, struct platform*);
 
 probe_func_t probe_platforms[] = {
+	probe_ppc44x_platform,
 	probe_default_platform,		/* This should be at the end of the list */
 	NULL
 };
 
+static int probe_ppc44x_platform(char *s, struct platform *p)
+{
+	if (!strncmp(s, "ppc440", 6) || strcmp(s, "ppc470")) {
+		p->name = strdup(s);
+		p->pgdir_shift = PPC44x_PGDIR_SHIFT;
+		p->ptrs_per_pte = PPC44x_PTRS_PER_PTE;
+		p->pte_size = PPC44x_PTE_SIZE;
+
+		return TRUE;
+	}
+	return FALSE;
+}
+	
 static int probe_default_platform(char *s, struct platform *p)
 {
 	/* Accept as the default platform */
diff --git a/makedumpfile.h b/makedumpfile.h
index 3a5152c..430202b 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -543,6 +543,10 @@ do { \
 #define DEFAULT_PTRS_PER_PTE	(1024)
 #define DEFAULT_PTE_SIZE	(sizeof(unsigned long))
 
+#define PPC44x_PGDIR_SHIFT	(21)
+#define PPC44x_PTRS_PER_PTE	(512)
+#define PPC44x_PTE_SIZE 	(sizeof(unsigned long long))
+
 #define PGDIR_SHIFT		(base_platform.pgdir_shift)
 #define PTRS_PER_PTE		(base_platform.ptrs_per_pte)
 #define PTE_SIZE		(base_platform.pte_size)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
