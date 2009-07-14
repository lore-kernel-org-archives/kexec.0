Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MQYY4-000875-Ul
	for kexec@lists.infradead.org; Tue, 14 Jul 2009 03:19:28 +0000
Received: from m4.gw.fujitsu.co.jp ([10.0.50.74])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n6E3JHBM019039 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Tue, 14 Jul 2009 12:19:17 +0900
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 27E8645DE4D
	for <kexec@lists.infradead.org>; Tue, 14 Jul 2009 12:19:17 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 036B245DE6E
	for <kexec@lists.infradead.org>; Tue, 14 Jul 2009 12:19:17 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id DEB711DB8042
	for <kexec@lists.infradead.org>; Tue, 14 Jul 2009 12:19:16 +0900 (JST)
Received: from m108.s.css.fujitsu.com (m108.s.css.fujitsu.com [10.249.87.108])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6E1EE1DB803A
	for <kexec@lists.infradead.org>; Tue, 14 Jul 2009 12:19:13 +0900 (JST)
Message-ID: <4A5BF922.2000503@jp.fujitsu.com>
Date: Tue, 14 Jul 2009 12:18:58 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH] kexec: Fix omitting offset in extended crashkernel syntax
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, kexec-ml <kexec@lists.infradead.org>

Setting
 "crashkernel=512M-2G:64M,2G-:128M"
does not work but it turns to work if it has a trailing-whitespace,
like
 "crashkernel=512M-2G:64M,2G-:128M ".

It was because of a bug in the parser, running over the cmdline.

This patch adds a check of the termination.

Reported-by: Jin Dongming <jin.dongming@np.css.fujitsu.com>
Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Tested-by: Jin Dongming <jin.dongming@np.css.fujitsu.com>
---
 kernel/kexec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index ae1c352..f336e21 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1228,7 +1228,7 @@ static int __init parse_crashkernel_mem(char 			*cmdline,
 	} while (*cur++ == ',');
 
 	if (*crash_size > 0) {
-		while (*cur != ' ' && *cur != '@')
+		while (*cur && *cur != ' ' && *cur != '@')
 			cur++;
 		if (*cur == '@') {
 			cur++;
-- 
1.6.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
