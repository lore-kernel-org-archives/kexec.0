Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uf4ry-0002ox-HA
 for kexec@lists.infradead.org; Wed, 22 May 2013 08:58:03 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/4] kexec-tools: Cleanup: Fix indentation
Date: Wed, 22 May 2013 10:57:33 +0200
Message-Id: <1369213056-77661-2-git-send-email-trenn@suse.de>
In-Reply-To: <1369213056-77661-1-git-send-email-trenn@suse.de>
References: <1369213056-77661-1-git-send-email-trenn@suse.de>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, yinghai@kernel.org, ebiederm@xmission.com, vgoyal@redhat.com, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>
---
 kexec/arch/i386/crashdump-x86.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index e44fceb..17c8744 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -559,11 +559,11 @@ static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
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
1.7.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
