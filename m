Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U2Fl0-0000Ls-Fb
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 06:42:22 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id E13503EE0C0
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:42:20 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C83BD45DE58
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:42:20 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id AFE6545DE54
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:42:20 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id A33AF1DB804A
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:42:20 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5B34DE08002
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:42:20 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RESEND PATCH 2/4] kdump, ppc: make saved_max_pfn exclusive
Date: Mon, 04 Feb 2013 15:42:19 +0900
Message-ID: <20130204064219.13324.25714.stgit@localhost6.localdomain6>
In-Reply-To: <20130204064112.13324.89478.stgit@localhost6.localdomain6>
References: <20130204064112.13324.89478.stgit@localhost6.localdomain6>
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
To: ralf@linux-mips.org, michael@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, holzheu@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, vgoyal@redhat.com
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
