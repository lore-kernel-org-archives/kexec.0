Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjB1y-0002H0-DK
 for kexec@lists.infradead.org; Thu, 13 Dec 2012 15:49:03 +0000
From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH 4/5] fix comment typo in do_bzImage_load on x86
Date: Thu, 13 Dec 2012 16:48:49 +0100
Message-Id: <1355413730-18190-4-git-send-email-olaf@aepfle.de>
In-Reply-To: <1355413730-18190-1-git-send-email-olaf@aepfle.de>
References: <1355413730-18190-1-git-send-email-olaf@aepfle.de>
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
Cc: Olaf Hering <olaf@aepfle.de>

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 kexec/arch/i386/kexec-bzImage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 6998587..fd214a3 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -194,7 +194,7 @@ int do_bzImage_load(struct kexec_info *info,
 	}
 
 	/* Load the trampoline.  This must load at a higher address
-	 * the the argument/parameter segment or the kernel will stomp
+	 * than the argument/parameter segment or the kernel will stomp
 	 * it's gdt.
 	 *
 	 * x86_64 purgatory code has got relocations type R_X86_64_32S
-- 
1.8.0.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
