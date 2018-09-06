Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fxnHU-0007Iz-RG
 for kexec@lists.infradead.org; Thu, 06 Sep 2018 05:56:42 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH v2] kdump: fix an error that can not parse the e820 reserved
 region
Date: Thu,  6 Sep 2018 13:56:18 +0800
Message-Id: <20180906055618.3210-1-lijiang@redhat.com>
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
the /proc/iomem, so we have to fix these cases.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 437e8a8..140f45b 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -289,6 +289,8 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 			type = RANGE_PMEM;
 		} else if(memcmp(str,"reserved\n",9) == 0 ) {
 			type = RANGE_RESERVED;
+		} else if (memcmp(str, "Reserved\n", 9) == 0) {
+			type = RANGE_RESERVED;
 		} else if (memcmp(str, "GART\n", 5) == 0) {
 			gart_start = start;
 			gart_end = end;
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
