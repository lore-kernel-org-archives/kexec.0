Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlMfA-0002FW-Gn
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 17:43:05 +0000
From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH] kexec/xen: Fix typo in __i386__ preprocessor identifier
Date: Tue, 26 Nov 2013 17:42:37 +0000
Message-ID: <1385487757-18378-1-git-send-email-andrew.cooper3@citrix.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Xen-devel <xen-devel@lists.xen.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>

This typo was introduced in c/s c0b4a3f95dd80256cc6d7084436235e69b4933fb

It prevents a 32bit build of kexec from loading a 32bit crash image.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
CC: David Vrabel <david.vrabel@citrix.com>
CC: Daniel Kiper <daniel.kiper@oracle.com>
CC: Simon Horman <horms@verge.net.au>
CC: kexec@lists.infradead.org

---
 kexec/kexec-xen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
index e885246..d2bd7bf 100644
--- a/kexec/kexec-xen.c
+++ b/kexec/kexec-xen.c
@@ -70,7 +70,7 @@ int xen_kexec_load(struct kexec_info *info)
 		: KEXEC_TYPE_DEFAULT;
 
 	arch = (info->kexec_flags & KEXEC_ARCH_MASK) >> 16;
-#if defined(_i386__) || defined(__x86_64__)
+#if defined(__i386__) || defined(__x86_64__)
 	if (!arch)
 		arch = EM_386;
 #endif
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
