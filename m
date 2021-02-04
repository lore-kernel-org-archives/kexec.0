Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7kJY-0007so-BG
 for kexec@lists.infradead.org; Thu, 04 Feb 2021 19:29:17 +0000
Received: by mail-wm1-x333.google.com with SMTP id f16so4105766wmq.5
 for <kexec@lists.infradead.org>; Thu, 04 Feb 2021 11:29:14 -0800 (PST)
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] makedumpfile.h: fix build on sparc64
Date: Thu,  4 Feb 2021 20:27:53 +0100
Message-Id: <20210204192753.1316622-1-fontaine.fabrice@gmail.com>
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
To: kexec@lists.infradead.org
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>

Fix the following build failure on sparc64:

/home/giuliobenetti/autobuild/run/instance-0/output-1/host/opt/ext-toolchain/bin/../lib/gcc/sparc64-buildroot-linux-gnu/9.3.0/../../../../sparc64-buildroot-linux-gnu/bin/ld: /tmp/ccylTux8.o: in function `find_kaslr_offsets':
/home/giuliobenetti/autobuild/run/instance-0/output-1/build/makedumpfile-1.6.8/makedumpfile.c:4017: undefined reference to `get_kaslr_offset'

Fixes:
 - http://autobuild.buildroot.org/results/1421f54f7599bba62c0a4bd5c65ce21c8cc7ee1a

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 makedumpfile.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/makedumpfile.h b/makedumpfile.h
index 97a5554..dfc1a77 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1139,6 +1139,7 @@ unsigned long long vaddr_to_paddr_sparc64(unsigned long vaddr);
 #define get_machdep_info()      TRUE
 #define get_phys_base()         get_phys_base_sparc64()
 #define get_versiondep_info()   get_versiondep_info_sparc64()
+#define get_kaslr_offset(X)     stub_false()
 #define vaddr_to_paddr(X)       vaddr_to_paddr_sparc64(X)
 #define paddr_to_vaddr(X)	paddr_to_vaddr_general(X)
 #define is_phys_addr(X)		stub_true_ul(X)
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
