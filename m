Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U2FUG-0005tn-Vf
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 06:25:05 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 42A453EE0C3
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:25:03 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2479045DEB7
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:25:03 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0B76345DEBE
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:25:03 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id F2B8B1DB803F
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:25:02 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id A67CB1DB8041
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:25:02 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 3/4] kdump, s390: make saved_max_pfn exclusive
Date: Mon, 04 Feb 2013 15:25:01 +0900
Message-ID: <20130204062501.13161.57145.stgit@localhost6.localdomain6>
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

 arch/s390/kernel/setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index a5360de..3357566 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -729,9 +729,9 @@ static void reserve_oldmem(void)
 	reserve_kdump_bootmem(OLDMEM_SIZE, memory_end - OLDMEM_SIZE,
 			      CHUNK_OLDMEM);
 	if (OLDMEM_BASE + OLDMEM_SIZE == real_memory_size)
-		saved_max_pfn = PFN_DOWN(OLDMEM_BASE) - 1;
+		saved_max_pfn = PFN_DOWN(OLDMEM_BASE);
 	else
-		saved_max_pfn = PFN_DOWN(real_memory_size) - 1;
+		saved_max_pfn = PFN_DOWN(real_memory_size);
 #endif
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
