Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9ub4-0003wC-5A
 for kexec@lists.infradead.org; Fri, 07 Sep 2012 09:11:38 +0000
From: Matthew Leach <matthew.leach@arm.com>
Subject: [PATCH 2/7] kexec-elf.h: Include headers for types used
Date: Fri,  7 Sep 2012 10:11:21 +0100
Message-Id: <1347009086-16506-3-git-send-email-matthew.leach@arm.com>
In-Reply-To: <1347009086-16506-1-git-send-email-matthew.leach@arm.com>
References: <1347009086-16506-1-git-send-email-matthew.leach@arm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, will.deacon@arm.com

From: Simon Horman <horms@verge.net.au>

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/kexec-elf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kexec/kexec-elf.h b/kexec/kexec-elf.h
index 99cb80b..d0e9dc0 100644
--- a/kexec/kexec-elf.h
+++ b/kexec/kexec-elf.h
@@ -1,6 +1,9 @@
 #ifndef KEXEC_ELF_H
 #define KEXEC_ELF_H
 
+#include <stdint.h>
+#include <sys/types.h>
+
 struct kexec_info;
 
 struct mem_ehdr {
-- 
1.7.12


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
