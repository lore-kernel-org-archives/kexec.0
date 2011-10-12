Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RE812-0007Ol-Q8
	for kexec@lists.infradead.org; Wed, 12 Oct 2011 23:15:14 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 2/2] sh: On 32bit segments may not be in P2
Date: Thu, 13 Oct 2011 07:44:41 +0900
Message-Id: <1318459481-23527-2-git-send-email-horms@verge.net.au>
In-Reply-To: <1318459481-23527-1-git-send-email-horms@verge.net.au>
References: <1318459481-23527-1-git-send-email-horms@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/sh/kexec-sh.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index a397d08..7710fdf 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -219,13 +219,15 @@ unsigned long virt_to_phys(unsigned long addr)
 {
 	unsigned long seg = addr & 0xe0000000;
 	unsigned long long start = 0;
+	int have_32bit = is_32bit();
 
-	if (seg != 0x80000000 && seg != 0xc0000000)
-		die("Virtual address %p is not in P1 or P2\n", (void *)addr);
+	if (seg != 0x80000000 && (have_32bit || seg != 0xc0000000))
+		die("Virtual address %p is not in P1%s\n", (void *)addr,
+		    have_32bit ? "" : " or P2");
 
 	/* If 32bit addressing is used then the base of system RAM
 	 * is an offset into physical memory. */
-	if (is_32bit()) {
+	if (have_32bit) {
 		unsigned long long end;
 		int ret;
 
-- 
1.7.6.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
