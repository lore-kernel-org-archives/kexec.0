Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gibson.whatever-company.com ([87.98.251.113])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bdGXZ-0006Um-90
 for kexec@lists.infradead.org; Fri, 26 Aug 2016 12:47:22 +0000
From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: [PATCH 2/3] multiboot: Fix length computation for the memory zones
Date: Fri, 26 Aug 2016 12:46:15 +0000
Message-Id: <1472215576-7466-2-git-send-email-s.munaut@whatever-company.com>
In-Reply-To: <1472215576-7466-1-git-send-email-s.munaut@whatever-company.com>
References: <1472215576-7466-1-git-send-email-s.munaut@whatever-company.com>
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
To: kexec@lists.infradead.org
Cc: Sylvain Munaut <s.munaut@whatever-company.com>

Signed-off-by: Sylvain Munaut <s.munaut@whatever-company.com>
---
 kexec/arch/i386/kexec-multiboot-x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 0dbac70..4de237c 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -252,7 +252,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	mmap = xmalloc(ranges * sizeof(*mmap));
 	for (i=0; i<ranges; i++) {
 		unsigned long long length;
-		length = range[i].end - range[i].start;
+		length = range[i].end - range[i].start + 1;
 		/* Translate bzImage mmap to multiboot-speak */
 		mmap[i].size = sizeof(mmap[i]) - 4;
 		mmap[i].base_addr_low  = range[i].start & 0xffffffff;
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
