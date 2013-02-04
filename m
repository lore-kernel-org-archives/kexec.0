Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U2FUB-0005sO-K7
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 06:25:00 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8521F3EE0BB
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:24:57 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6A5D245DE53
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:24:57 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 50E7545DE4E
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:24:57 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 433CD1DB803E
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:24:57 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id ED0FF1DB803A
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:24:56 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 2/4] kdump, ppc: make saved_max_pfn exclusive
Date: Mon, 04 Feb 2013 15:24:56 +0900
Message-ID: <20130204062456.13161.96151.stgit@localhost6.localdomain6>
In-Reply-To: <20130204062349.13161.29478.stgit@localhost6.localdomain6>
References: <20130204062349.13161.29478.stgit@localhost6.localdomain6>
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
To: ralf@linux-mips.org, michael@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, holzheu@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, vgoyal@in.ibm.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 arch/powerpc/kernel/crash_dump.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index b3ba516..fa64170 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -72,7 +72,7 @@ void __init setup_kdump_trampoline(void)
 static int __init parse_savemaxmem(char *p)
 {
 	if (p)
-		saved_max_pfn = (memparse(p, &p) >> PAGE_SHIFT) - 1;
+		saved_max_pfn = (memparse(p, &p) >> PAGE_SHIFT);
 
 	return 1;
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
