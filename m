Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gibson.whatever-company.com ([87.98.251.113])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bdGXZ-0006Ur-8y
 for kexec@lists.infradead.org; Fri, 26 Aug 2016 12:47:22 +0000
From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: [PATCH 3/3] multiboot: Use the "reserved" type for non-ram zones
Date: Fri, 26 Aug 2016 12:46:16 +0000
Message-Id: <1472215576-7466-3-git-send-email-s.munaut@whatever-company.com>
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

Seems that Xen actually checks for some zones to be 'reserved' and
complains if they are not.

This also matches what the bios uses at boot.

Signed-off-by: Sylvain Munaut <s.munaut@whatever-company.com>
---
 kexec/arch/i386/kexec-multiboot-x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 4de237c..69027e2 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -278,7 +278,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 			    && (range[i].end > mem_upper + 0x100000))
 				mem_upper = range[i].end - 0x100000;
 		} else {
-			mmap[i].Type = 0xbad;  /* Not RAM */
+			mmap[i].Type = 2;  /* Not RAM (reserved) */
 		}
 	}
 
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
