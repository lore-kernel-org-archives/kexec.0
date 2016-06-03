Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b8kqd-0006y2-NA
 for kexec@lists.infradead.org; Fri, 03 Jun 2016 08:52:56 +0000
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 4/8] kexec: ensure user memory sizes do not wrap
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b8koF-0004HM-5x@rmk-PC.armlinux.org.uk>
Date: Fri, 03 Jun 2016 09:50:27 +0100
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ia64@vger.kernel.org, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-arm-kernel@lists.infradead.org

Ensure that user memory sizes do not wrap around when validating the
user input, which can lead to the following input validation working
incorrectly.

Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 kernel/kexec_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 8d34308ea449..d719a4d0ef55 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -169,6 +169,8 @@ int sanity_check_segment_list(struct kimage *image)
 
 		mstart = image->segment[i].mem;
 		mend   = mstart + image->segment[i].memsz;
+		if (mstart > mend)
+			return result;
 		if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
 			return result;
 		if (mend >= KEXEC_DESTINATION_MEMORY_LIMIT)
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
