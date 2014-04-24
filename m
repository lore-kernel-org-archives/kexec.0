Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from master.debian.org ([2001:41b8:202:deb:216:36ff:fe40:4001])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WdAvN-0007x3-4H
 for kexec@lists.infradead.org; Thu, 24 Apr 2014 04:06:13 +0000
From: Paul Wise <pabs3@bonedaddy.net>
Subject: [kexec-tools] [PATCH 2/2] Drop the pregenerated purgatory.c file
Date: Thu, 24 Apr 2014 12:04:32 +0800
Message-Id: <1398312272-15634-2-git-send-email-pabs3@bonedaddy.net>
In-Reply-To: <1398312272-15634-1-git-send-email-pabs3@bonedaddy.net>
References: <1398312272-15634-1-git-send-email-pabs3@bonedaddy.net>
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
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org
Cc: Paul Wise <pabs3@bonedaddy.net>

---
 purgatory/purgatory.c | 52 ---------------------------------------------------
 1 file changed, 52 deletions(-)
 delete mode 100644 purgatory/purgatory.c

diff --git a/purgatory/purgatory.c b/purgatory/purgatory.c
deleted file mode 100644
index 3bbcc09..0000000
--- a/purgatory/purgatory.c
+++ /dev/null
@@ -1,52 +0,0 @@
-
-#include <limits.h>
-#include <stdint.h>
-#include <purgatory.h>
-#include <sha256.h>
-#include <string.h>
-#include "../kexec/kexec-sha256.h"
-
-struct sha256_region sha256_regions[SHA256_REGIONS] = {};
-sha256_digest_t sha256_digest = { };
-
-int verify_sha256_digest(void)
-{
-	struct sha256_region *ptr, *end;
-	sha256_digest_t digest;
-	size_t i;
-	sha256_context ctx;
-	sha256_starts(&ctx);
-	end = &sha256_regions[sizeof(sha256_regions)/sizeof(sha256_regions[0])];
-	for(ptr = sha256_regions; ptr < end; ptr++) {
-		sha256_update(&ctx, (uint8_t *)((uintptr_t)ptr->start),
-			      ptr->len);
-	}
-	sha256_finish(&ctx, digest);
-	if (memcmp(digest, sha256_digest, sizeof(digest)) != 0) {
-		printf("sha256 digests do not match :(\n");
-		printf("       digest: ");
-		for(i = 0; i < sizeof(digest); i++) {
-			printf("%hhx ", digest[i]);
-		}
-		printf("\n");
-		printf("sha256_digest: ");
-		for(i = 0; i < sizeof(sha256_digest); i++) {
-			printf("%hhx ", sha256_digest[i]);
-		}
-		printf("\n");
-		return 1;
-	}
-	return 0;
-}
-
-void purgatory(void)
-{
-	printf("I'm in purgatory\n");
-	setup_arch();
-	if (verify_sha256_digest()) {
-		for(;;) {
-			/* loop forever */
-		}
-	}
-	post_verification_setup_arch();
-}
-- 
1.9.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
