Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZzpXp-0004jk-Rd
 for kexec@lists.infradead.org; Fri, 20 Nov 2015 17:32:22 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id CCE8514CAA5
 for <kexec@lists.infradead.org>; Fri, 20 Nov 2015 17:32:02 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
Subject: [PATCH 1/4] uImage: cleanup some warnings
Date: Fri, 20 Nov 2015 12:31:51 -0500
Message-Id: <1448040714-19841-2-git-send-email-drjones@redhat.com>
In-Reply-To: <1448040714-19841-1-git-send-email-drjones@redhat.com>
References: <1448040714-19841-1-git-send-email-drjones@redhat.com>
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
To: kexec@lists.infradead.org

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 kexec/arch/arm/kexec-uImage-arm.c | 3 ++-
 kexec/arch/ppc/kexec-uImage-ppc.c | 5 +++--
 kexec/arch/sh/kexec-uImage-sh.c   | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/arm/kexec-uImage-arm.c b/kexec/arch/arm/kexec-uImage-arm.c
index 03c2f4ddca7b0..285883eb9779d 100644
--- a/kexec/arch/arm/kexec-uImage-arm.c
+++ b/kexec/arch/arm/kexec-uImage-arm.c
@@ -11,7 +11,8 @@
 
 int uImage_arm_probe(const char *buf, off_t len)
 {
-	return uImage_probe_kernel(buf, len, IH_ARCH_ARM);
+	return uImage_probe_kernel((const unsigned char *)buf,
+				   len, IH_ARCH_ARM);
 }
 
 int uImage_arm_load(int argc, char **argv, const char *buf, off_t len,
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index c89a1a77926d2..30be9d9cb5817 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -78,7 +78,8 @@ char *slurp_ramdisk_ppc(const char *filename, off_t *r_size)
 	
 int uImage_ppc_probe(const char *buf, off_t len)
 {
-	return uImage_probe_kernel(buf, len, IH_ARCH_PPC);
+	return uImage_probe_kernel((const unsigned char *)buf,
+				   len, IH_ARCH_PPC);
 }
 
 static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
@@ -316,7 +317,7 @@ int uImage_ppc_load(int argc, char **argv, const char *buf, off_t len,
 	struct Image_info img;
 	int ret;
 
-	ret = uImage_load(buf, len, &img);
+	ret = uImage_load((const unsigned char *)buf, len, &img);
 	if (ret)
 		return ret;
 
diff --git a/kexec/arch/sh/kexec-uImage-sh.c b/kexec/arch/sh/kexec-uImage-sh.c
index 130f12ca94317..28c8f2fde3a35 100644
--- a/kexec/arch/sh/kexec-uImage-sh.c
+++ b/kexec/arch/sh/kexec-uImage-sh.c
@@ -13,7 +13,8 @@
 
 int uImage_sh_probe(const char *buf, off_t len)
 {
-	return uImage_probe_kernel(buf, len, IH_ARCH_SH);
+	return uImage_probe_kernel((const unsigned char *)buf,
+				   len, IH_ARCH_SH);
 }
 
 int uImage_sh_load(int argc, char **argv, const char *buf, off_t len,
-- 
2.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
