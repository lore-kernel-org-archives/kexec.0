Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fXtwe-0004vG-3b
 for kexec@lists.infradead.org; Tue, 26 Jun 2018 19:48:09 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (8.14.7/8.14.7) with
 ESMTP id w5QJlkw9062831
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
 for <kexec@lists.infradead.org>; Tue, 26 Jun 2018 19:47:53 GMT
From: Munehisa Kamata <kamatam@amazon.com>
Subject: [PATCH 1/2] arm64: increase command line size to 2048
Date: Tue, 26 Jun 2018 12:47:28 -0700
Message-ID: <1530042449-19329-1-git-send-email-kamatam@amazon.com>
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
Cc: Munehisa Kamata <kamatam@amazon.com>

Otherwise, we can hit the current 512 chars limit before hitting the
Linux kernel's one, where allows 2048 chars in arm64.

Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
---
 kexec/arch/arm64/kexec-arm64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
index bf724ef..22e4b69 100644
--- a/kexec/arch/arm64/kexec-arm64.h
+++ b/kexec/arch/arm64/kexec-arm64.h
@@ -15,7 +15,7 @@
 
 #define BOOT_BLOCK_VERSION 17
 #define BOOT_BLOCK_LAST_COMP_VERSION 16
-#define COMMAND_LINE_SIZE 512
+#define COMMAND_LINE_SIZE 2048 /* from kernel */
 
 #define KiB(x) ((x) * 1024UL)
 #define MiB(x) (KiB(x) * 1024UL)
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
