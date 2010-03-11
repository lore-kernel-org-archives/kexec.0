Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NpddV-0005Fj-Lq
	for kexec@lists.infradead.org; Thu, 11 Mar 2010 08:20:57 +0000
Subject: [PATCH 1/3] Refix concat_cmdline
References: <m1k4tjb7d1.fsf@fess.ebiederm.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 11 Mar 2010 00:20:48 -0800
In-Reply-To: <m1k4tjb7d1.fsf@fess.ebiederm.org> (Eric W. Biederman's message
	of "Thu\, 11 Mar 2010 00\:16\:58 -0800")
Message-ID: <m1fx47b76n.fsf@fess.ebiederm.org>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Kexec Mailing List <kexec@lists.infradead.org>


When removing the potential leak the logic was flipped which
mean we never reached the case for handling when both parameters
were set.

Signed-off-by: Eric W. Biederman <ebiederm@aristanetworks.com>
---
 kexec/kexec.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index d282ade..43d0189 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1007,9 +1007,9 @@ char *concat_cmdline(const char *base, const char *append)
 	char *cmdline;
 	if (!base && !append)
 		return NULL;
-	if (append)
+	if (append && !base)
 		return xstrdup(append);
-	if (base)
+	if (base && !append)
 		return xstrdup(base);
 	cmdline = xmalloc(strlen(base) + 1 + strlen(append) + 1);
 	strcpy(cmdline, base);
-- 
1.6.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
