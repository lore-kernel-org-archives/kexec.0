Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYB39-0007jV-UD
 for kexec@lists.infradead.org; Thu, 10 Apr 2014 09:13:38 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v5 01/10] x86, cleanup: fix indent
Date: Thu, 10 Apr 2014 17:12:54 +0800
Message-Id: <1397121186-9353-2-git-send-email-chaowang@redhat.com>
In-Reply-To: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
References: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
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
