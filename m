Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T6H0V-00072V-VC
 for kexec@lists.infradead.org; Tue, 28 Aug 2012 08:18:44 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 2/7] kexec-elf.h: Include headers for types used
Date: Tue, 28 Aug 2012 17:18:25 +0900
Message-Id: <1346141910-8214-3-git-send-email-horms@verge.net.au>
In-Reply-To: <1346141910-8214-1-git-send-email-horms@verge.net.au>
References: <1346141910-8214-1-git-send-email-horms@verge.net.au>
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
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>

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
1.7.10.2.484.gcd07cc5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
