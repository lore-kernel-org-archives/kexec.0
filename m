Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYB3S-0007jz-W5
 for kexec@lists.infradead.org; Thu, 10 Apr 2014 09:13:55 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v5 04/10] x86,
 cleanup: add_memmap() only do alignment check on RANGE_RAM
Date: Thu, 10 Apr 2014 17:12:57 +0800
Message-Id: <1397121186-9353-5-git-send-email-chaowang@redhat.com>
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
 kexec/arch/i386/crashdump-x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 43eb8f7..4072c10 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -482,8 +482,8 @@ static int add_memmap(struct memory_range *memmap_p, int *nr_memmap_p,
 	int i, j, nr_entries = 0, tidx = 0, align = 1024;
 	unsigned long long mstart, mend;
 
-	/* Do alignment check. */
-	if ((addr%align) || (size%align))
+	/* Do alignment check if it's RANGE_RAM */
+	if ((type == RANGE_RAM) && ((addr%align) || (size%align)))
 		return -1;
 
 	/* Make sure at least one entry in list is free. */
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
