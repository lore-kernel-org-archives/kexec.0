Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-da0-x22e.google.com ([2607:f8b0:400e:c00::22e])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFpZi-0006gT-SX
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 17:34:51 +0000
Received: by mail-da0-f46.google.com with SMTP id z8so512766dad.33
 for <kexec@lists.infradead.org>; Wed, 13 Mar 2013 10:34:48 -0700 (PDT)
Message-ID: <5140B8B1.8090402@gmail.com>
Date: Thu, 14 Mar 2013 01:34:41 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 12/13] kexec: sh: use _ALIGN* to make the logic clear
References: <5140B511.7020109@gmail.com>
In-Reply-To: <5140B511.7020109@gmail.com>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

By replacing all the explicit align opertion with marco _ALIGN*,
the code logic could be more clear.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/sh/kexec-netbsd-sh.c |    4 ++--
 kexec/arch/sh/kexec-zImage-sh.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/sh/kexec-netbsd-sh.c b/kexec/arch/sh/kexec-netbsd-sh.c
index 8e80486..8a7e75e 100644
--- a/kexec/arch/sh/kexec-netbsd-sh.c
+++ b/kexec/arch/sh/kexec-netbsd-sh.c
@@ -121,7 +121,7 @@ int netbsd_sh_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
 		        size = bbs;
 		}
 
-		size = (size + psz - 1) & ~(psz - 1);
+		size = _ALIGN(size, psz);
 		memset(&img[bbs], 0, size-bbs);
 		add_segment(info, img, size, start, size);
 		start += size;
@@ -132,7 +132,7 @@ int netbsd_sh_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
 	if (miniroot) {
 		miniroot_buf = slurp_file(miniroot, &miniroot_length);
 		howto_value |= 0x200;
-		size = (miniroot_length + psz - 1) & ~(psz - 1);
+		size = _ALIGN(miniroot_length, psz);
 		add_segment(info, miniroot_buf, size, start, size);
 		start += size;
 	}
diff --git a/kexec/arch/sh/kexec-zImage-sh.c b/kexec/arch/sh/kexec-zImage-sh.c
index 1ce185a..7399052 100644
--- a/kexec/arch/sh/kexec-zImage-sh.c
+++ b/kexec/arch/sh/kexec-zImage-sh.c
@@ -138,7 +138,7 @@ int zImage_sh_load(int argc, char **argv, const char *buf, off_t len,
 	 * the zImage will relocate itself, but only up seems supported.
 	 */
 
-	image_base = (empty_zero + (0x10000 - 1)) & ~(0x10000 - 1);
+	image_base = _ALIGN(empty_zero, 0x10000);
 	add_segment(info, buf, len, image_base, len);
 	info->entry = (void *)virt_to_phys(image_base);
 	return 0;
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
