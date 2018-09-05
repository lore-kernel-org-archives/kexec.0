Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fxY4h-0003qu-Nu
 for kexec@lists.infradead.org; Wed, 05 Sep 2018 13:42:39 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH] kdump: fix an error that can not parse the e820 reserved
 region
Date: Wed,  5 Sep 2018 21:41:04 +0800
Message-Id: <20180905134104.18237-1-lijiang@redhat.com>
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
Cc: horms@verge.net.au, dyoung@redhat.com

When kexec-tools load the kernel and initramfs for kdump, kexec-tools will
read /proc/iomem and recreate the e820 ranges for kdump kernel. But it fails
to parse the e820 reserved region, because the memcmp() is case sensitive
when comparing the string. In fact, it may be "Reserved" or "reserved" in
the /proc/iomem, so we use the strncasecmp() instead of the memcmp() to fix
it.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 437e8a8..6669c1a 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -287,7 +287,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 			type = RANGE_PRAM;
 		} else if(memcmp(str,"Persistent Memory\n",18) == 0 ) {
 			type = RANGE_PMEM;
-		} else if(memcmp(str,"reserved\n",9) == 0 ) {
+		} else if(strncasecmp(str,"reserved\n",9) == 0 ) {
 			type = RANGE_RESERVED;
 		} else if (memcmp(str, "GART\n", 5) == 0) {
 			gart_start = start;
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
