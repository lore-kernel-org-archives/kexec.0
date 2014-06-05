Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsVr0-0008O5-8f
 for kexec@lists.infradead.org; Thu, 05 Jun 2014 11:29:07 +0000
From: Liu Hua <sdu.liu@huawei.com>
Subject: [PATCH 1/2] kexec: iomem: accept u64 parameters for callbacks
Date: Thu, 5 Jun 2014 19:20:07 +0800
Message-ID: <1401967208-30948-2-git-send-email-sdu.liu@huawei.com>
In-Reply-To: <1401967208-30948-1-git-send-email-sdu.liu@huawei.com>
References: <1401967208-30948-1-git-send-email-sdu.liu@huawei.com>
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
To: horms@verge.net.au
Cc: wangnan0@huawei.com, Liu Hua <sdu.liu@huawei.com>, liusdu@126.com, kexec@lists.infradead.org, genghui@huawei.com, Wei Jitao <weijitao@huawei.com>

Since "start" and "end" in kexec_iomem_for_each_line
are unsigned long long, this patch makes "callback"s
accept unsigned-long-long-type parameters.

Signed-off-by: Wei Jitao <weijitao@huawei.com>
Signed-off-by: Liu Hua <sdu.liu@huawei.com>
---
 kexec/arch/arm/crashdump-arm.c | 4 ++--
 kexec/kexec-iomem.c            | 8 ++++----
 kexec/kexec.h                  | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index d124974..726c1e9 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -134,8 +134,8 @@ static int get_kernel_page_offset(struct kexec_info *info,
  * regions is placed in @crash_memory_nr_ranges.
  */
 static int crash_range_callback(void *UNUSED(data), int UNUSED(nr),
-				char *str, unsigned long base,
-				unsigned long length)
+				char *str, unsigned long long base,
+				unsigned long long length)
 {
 	struct memory_range *range;
 
diff --git a/kexec/kexec-iomem.c b/kexec/kexec-iomem.c
index 0396713..485a2e8 100644
--- a/kexec/kexec-iomem.c
+++ b/kexec/kexec-iomem.c
@@ -26,8 +26,8 @@ int kexec_iomem_for_each_line(char *match,
 			      int (*callback)(void *data,
 					      int nr,
 					      char *str,
-					      unsigned long base,
-					      unsigned long length),
+					      unsigned long long base,
+					      unsigned long long length),
 			      void *data)
 {
 	const char *iomem = proc_iomem();
@@ -65,8 +65,8 @@ int kexec_iomem_for_each_line(char *match,
 
 static int kexec_iomem_single_callback(void *data, int nr,
 				       char *UNUSED(str),
-				       unsigned long base,
-				       unsigned long length)
+				       unsigned long long base,
+				       unsigned long long length)
 {
 	struct memory_range *range = data;
 
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 22d4a42..2fad7dc 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -282,8 +282,8 @@ int kexec_iomem_for_each_line(char *match,
 			      int (*callback)(void *data,
 					      int nr,
 					      char *str,
-					      unsigned long base,
-					      unsigned long length),
+					      unsigned long long base,
+					      unsigned long long length),
 			      void *data);
 int parse_iomem_single(char *str, uint64_t *start, uint64_t *end);
 const char * proc_iomem(void);
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
