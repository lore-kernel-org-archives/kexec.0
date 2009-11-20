Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mxo43.mail.genotec.ch ([2001:1b50::82:195:224:43])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NBXaZ-0004jZ-Dp
	for kexec@lists.infradead.org; Fri, 20 Nov 2009 17:48:08 +0000
From: Marc Andre Tanner <mat@brain-dump.org>
Subject: [PATCH] Accept architectures which partially match
Date: Fri, 20 Nov 2009 18:38:12 +0100
Message-Id: <1258738692-4990-2-git-send-email-mat@brain-dump.org>
In-Reply-To: <1258738692-4990-1-git-send-email-mat@brain-dump.org>
References: <1258738692-4990-1-git-send-email-mat@brain-dump.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: damm@opensource.se, horms@verge.net.au, Marc Andre Tanner <mat@brain-dump.org>

It doesn't make sense to add every possible architecture
family / endianness combination.

Signed-off-by: Marc Andre Tanner <mat@brain-dump.org>
---
 kexec/phys_arch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/phys_arch.c b/kexec/phys_arch.c
index ff8c28b..2b3cbf9 100644
--- a/kexec/phys_arch.c
+++ b/kexec/phys_arch.c
@@ -14,7 +14,7 @@ long physical_arch(void)
 	}
 
 	for (i = 0; arches[i].machine; ++i)
-		if (strcmp(utsname.machine, arches[i].machine) == 0)
+		if (strncmp(utsname.machine, arches[i].machine, strlen(arches[i].machine)) == 0)
 			return arches[i].arch;
 
 	fprintf(stderr, "Unsupported machine type: %s\n",
-- 
1.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
