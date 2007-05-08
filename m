Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-blu.bigfish.com ([65.55.251.10]
	helo=mail63-blu-R.bigfish.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HlDb5-0005ld-0m
	for kexec@lists.infradead.org; Mon, 07 May 2007 20:30:32 -0400
Received: from mail63-blu (localhost.localdomain [127.0.0.1])
	by mail63-blu-R.bigfish.com (Postfix) with ESMTP id 7795D681EB
	for <kexec@lists.infradead.org>; Tue,  8 May 2007 00:02:50 +0000 (UTC)
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail63-blu.bigfish.com (Postfix) with ESMTP id 4F642720072
	for <kexec@lists.infradead.org>; Tue,  8 May 2007 00:02:50 +0000 (UTC)
Received: from mail1.sgo.in.sel.sony.com (mail1.sgo.in.sel.sony.com
	[43.130.1.111])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id l4802nib019457
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 00:02:49 GMT
Received: from USSDIXIM01.am.sony.com (ussdixim01.am.sony.com [43.130.140.33])
	by mail1.sgo.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id
	l4802n0m019327
	for <kexec@lists.infradead.org>; Tue, 8 May 2007 00:02:49 GMT
Message-ID: <463FBE27.4060402@am.sony.com>
Date: Mon, 07 May 2007 17:02:47 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [patch 1/5] kexec debug output improvments
References: <20070507235727.631477448@am.sony.com>>
In-Reply-To: <20070507235727.631477448@am.sony.com>>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Geoff Levand <geoffrey.levand@am.sony.com>

kexec debug output improvments.
 - Add better type checking for the debug output macro dfprintf().
 - Add a convenence macro dprintf().

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 kexec/kexec.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- kexec-tools-hacked.orig/kexec/kexec.h
+++ kexec-tools-hacked/kexec/kexec.h
@@ -217,10 +217,12 @@ int parse_iomem_single(char *str, uint64
 
 #define MAX_LINE	160
 
+#define dprintf(args...) dfprintf(stdout, args)
 #ifdef DEBUG
-#define dfprintf(args...)	do {fprintf(args);} while(0)
+#define dfprintf(_f, _args...) do {fprintf(_f, _args);} while(0)
 #else
-#define dfprintf(args...)	do { } while(0)
+static inline int __attribute__ ((format (printf, 1, 2)))
+	dfprintf(FILE *f, const char *fmt, ...) {return 0;}
 #endif
 
 #endif /* KEXEC_H */

-- 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
