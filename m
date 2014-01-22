Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W5yKN-0006yd-T6
 for kexec@lists.infradead.org; Wed, 22 Jan 2014 13:58:48 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/3] makedumpfile: introduce struct cycle to store the cyclic
 region
Date: Wed, 22 Jan 2014 21:57:29 +0800
Message-Id: <1390399051-8732-1-git-send-email-bhe@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, Baoquan He <bhe@redhat.com>

The cyclic mode use two member variables in struct DumpInfo to store
the cyclic region each time. Since there's a global instance of struct
DumpInfo, then those two member variables, cyclic_start_pfn and
cyclic_end_pfn would be the same as global variable on behavior. So
with this attribute, the implementation of updating cyclic region
have to couple with several other actions. Especially in function
update_cyclic_region().

struct DumpInfo {
	...
	unsigned long long cyclic_start_pfn;
	unsigned long long cyclic_end_pfn;
	...
}

Now introduce struct cycle and several helper functions and MACRO
as Hatayama suggested. With these, the pfn region which is contained
in struct cycle can be passed down to inner functions. Then several
actions embedded in update_cyclic_region() can be decoupled.

struct cycle {
	unsigned long long start_pfn;
	unsigned long long end_pfn;
};

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.c | 27 +++++++++++++++++++++++++++
 makedumpfile.h |  5 +++++
 2 files changed, 32 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 73467ab..325cd66 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -37,6 +37,33 @@ struct DumpInfo		*info = NULL;
 
 char filename_stdout[] = FILENAME_STDOUT;
 
+static void first_cycle(unsigned long long start, unsigned long long max, struct cycle *cycle)
+{
+	cycle->start_pfn = start;
+	cycle->end_pfn = cycle->start_pfn + info->pfn_cyclic;
+
+	if (cycle->end_pfn > max)
+		cycle->end_pfn = max;
+}
+
+static void update_cycle(unsigned long long max, struct cycle *cycle)
+{
+	cycle->start_pfn= cycle->end_pfn;
+	cycle->end_pfn=  cycle->start_pfn + info->pfn_cyclic;
+
+	if (cycle->end_pfn > max)
+		cycle->end_pfn = max;
+}
+
+static int end_cycle(unsigned long long max, struct cycle *cycle)
+{
+	return (cycle->start_pfn >=  max)?TRUE:FALSE;
+}
+
+#define for_each_cycle(start, max, C) \
+	for (first_cycle(start, max, C); !end_cycle(max, C); \
+	     update_cycle(max, C))
+
 /*
  * The numbers of the excluded pages
  */
diff --git a/makedumpfile.h b/makedumpfile.h
index 3d270c6..4cf8102 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1590,6 +1590,11 @@ int get_xen_info_ia64(void);
 #define get_xen_info_arch(X) FALSE
 #endif	/* s390x */
 
+struct cycle {
+	unsigned long long start_pfn;
+	unsigned long long end_pfn;
+};
+
 static inline int
 is_on(char *bitmap, int i)
 {
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
