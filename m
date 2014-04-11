Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYR8I-0007e4-HE
 for kexec@lists.infradead.org; Fri, 11 Apr 2014 02:23:58 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH RESEND v5 01/10] x86, cleanup: fix indent
Date: Fri, 11 Apr 2014 10:23:22 +0800
Message-Id: <1397183011-1526-2-git-send-email-chaowang@redhat.com>
In-Reply-To: <1397183011-1526-1-git-send-email-chaowang@redhat.com>
References: <1397183011-1526-1-git-send-email-chaowang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au, vgoyal@redhat.com, ebiederm@xmission.com, hpa@zytor.com, trenn@suse.de, dyoung@redhat.com, linn@hp.com
Cc: kexec@lists.infradead.org

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 91872ab..72bce0b 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -509,11 +509,11 @@ static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
 		else if (addr > mend)
 			tidx = i+1;
 	}
-		/* Insert the memory region. */
-		for (j = nr_entries-1; j >= tidx; j--)
-			memmap_p[j+1] = memmap_p[j];
-		memmap_p[tidx].start = addr;
-		memmap_p[tidx].end = addr + size - 1;
+	/* Insert the memory region. */
+	for (j = nr_entries-1; j >= tidx; j--)
+		memmap_p[j+1] = memmap_p[j];
+	memmap_p[tidx].start = addr;
+	memmap_p[tidx].end = addr + size - 1;
 
 	dbgprintf("Memmap after adding segment\n");
 	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
