Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOlJW-00FTX9-UP
 for kexec@lists.infradead.org; Tue, 23 Mar 2021 17:59:36 +0000
Received: by mail-wr1-x432.google.com with SMTP id e9so21725010wrw.10
 for <kexec@lists.infradead.org>; Tue, 23 Mar 2021 10:59:33 -0700 (PDT)
From: Raphael Ning <raphning@gmail.com>
Subject: [PATCH] kexec-xen: Use correct image type for Live Update
Date: Tue, 23 Mar 2021 17:59:23 +0000
Message-Id: <20210323175923.7342-1-raphning@gmail.com>
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
Cc: kexec@lists.infradead.org, Raphael Ning <raphning@gmail.com>, Julien Grall <julien@xen.org>, Hongyan Xia <hx242@xen.org>, xen-devel@lists.xenproject.org, Raphael Ning <raphning@amazon.com>

From: Raphael Ning <raphning@amazon.com>

Unlike xen_kexec_load(), xen_kexec_unload() and xen_kexec_status()
fail to distinguish between normal kexec and Xen Live Update image
types.

Fix that by introducing a new helper function that maps internal
flags to KEXEC_TYPE_*, and using it throughout kexec-xen.c.

Signed-off-by: Raphael Ning <raphning@amazon.com>
---
 kexec/kexec-xen.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index da514d052e3d..47da3da466f0 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -91,6 +91,17 @@ out:
 	return rc;
 }
 
+static uint8_t xen_get_kexec_type(unsigned long kexec_flags)
+{
+	if (kexec_flags & KEXEC_ON_CRASH)
+		return KEXEC_TYPE_CRASH;
+
+	if (kexec_flags & KEXEC_LIVE_UPDATE)
+		return KEXEC_TYPE_LIVE_UPDATE;
+
+	return KEXEC_TYPE_DEFAULT;
+}
+
 #define IDENTMAP_1MiB (1024 * 1024)
 
 int xen_kexec_load(struct kexec_info *info)
@@ -177,12 +188,7 @@ int xen_kexec_load(struct kexec_info *info)
 		seg++;
 	}
 
-	if (info->kexec_flags & KEXEC_ON_CRASH)
-		type = KEXEC_TYPE_CRASH;
-	else if (info->kexec_flags & KEXEC_LIVE_UPDATE )
-		type = KEXEC_TYPE_LIVE_UPDATE;
-	else
-		type = KEXEC_TYPE_DEFAULT;
+	type = xen_get_kexec_type(info->kexec_flags);
 
 	arch = (info->kexec_flags & KEXEC_ARCH_MASK) >> 16;
 #if defined(__i386__) || defined(__x86_64__)
@@ -211,8 +217,7 @@ int xen_kexec_unload(uint64_t kexec_flags)
 	if (!xch)
 		return -1;
 
-	type = (kexec_flags & KEXEC_ON_CRASH) ? KEXEC_TYPE_CRASH
-		: KEXEC_TYPE_DEFAULT;
+	type = xen_get_kexec_type(kexec_flags);
 
 	ret = xc_kexec_unload(xch, type);
 
@@ -232,7 +237,7 @@ int xen_kexec_status(uint64_t kexec_flags)
 	if (!xch)
 		return -1;
 
-	type = (kexec_flags & KEXEC_ON_CRASH) ? KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
+	type = xen_get_kexec_type(kexec_flags);
 
 	ret = xc_kexec_status(xch, type);
 
-- 
2.23.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
