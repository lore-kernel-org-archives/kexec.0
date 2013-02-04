Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U2FUM-0005vW-9b
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 06:25:10 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B39BD3EE0CD
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:25:08 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6CC0F45DE4D
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:25:08 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 50DF945DE53
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:25:08 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3BAD41DB8041
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:25:08 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id E75381DB803E
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:25:07 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 4/4] kdump, oldmem: compare with saved_max_pfn exclusively
Date: Mon, 04 Feb 2013 15:25:07 +0900
Message-ID: <20130204062507.13161.37270.stgit@localhost6.localdomain6>
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

 drivers/char/mem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index c6fa3bc..5da737c 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -369,7 +369,7 @@ static ssize_t read_oldmem(struct file *file, char __user *buf,
 
 	while (count) {
 		pfn = *ppos / PAGE_SIZE;
-		if (pfn > saved_max_pfn)
+		if (!(pfn < saved_max_pfn))
 			return read;
 
 		offset = (unsigned long)(*ppos % PAGE_SIZE);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
