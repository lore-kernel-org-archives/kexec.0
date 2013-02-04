Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U2Fkx-0000JU-Et
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 06:42:20 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 0ED063EE0BC
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:42:10 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id EAC0645DEBC
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:42:09 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D1AB245DEB2
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:42:09 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id BE2F71DB803B
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:42:09 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5FD801DB803F
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 15:42:09 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [RESEND PATCH 0/4] kdump: make saved_max_pfn exlusive
Date: Mon, 04 Feb 2013 15:42:08 +0900
Message-ID: <20130204064112.13324.89478.stgit@localhost6.localdomain6>
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

# I emailed to Vivek at old email address so resend. Please reply to
# this RESEND patch series. Sorry for this noise...
    
First, there are two kinds of notation to represent a map: inclusive
and exclusive. Here are the examples:
    
  1)  [mem 0x0000000100000000-0x000000013fffffff]
  2)  [mem 0x0000000100000000-0x0000000140000000]
    
1) is inclusive and 2) is exclusive. In case of 1), the pfn calculated
from the end address belongs to the map, while in case of 2), it
doesn't.

Currently, saved_max_pfn is used in read_oldmem() as inclusive for a
check to see if a given request is to within kernel's memory mapping
regions.
    
	while (count) {
		pfn = *ppos / PAGE_SIZE;
		if (pfn > saved_max_pfn)
		   	return read;
    
Unfortunately, on x86 and ia64, there are bugs below:
    
- On the 1st kernel, saved_max_pfn is not initialized so 0. Then, read
  to pfn 0 is not guarded by the condition and the execution goes into
  ioremap path.
    
- On the 2nd kernel, x86 and ia64 wrongly initializes saved_max_pfn by
  exclusive value, on x86 as:
    
	saved_max_pfn = e820_end_of_ram_pfn();
    
  by which via /dev/oldmem we can read max_pfn that is not kernel's
  memory.
    
To fix this, fixing x86 and ia64 part needs smaller change, but
max_pfn is originally treated as exclusive so saved_max_pfn should
normally be exclusive. Also, the memory map information passed from
kexec is all exclusive on every architectures; it's possible to make
saved_max_pfn exclusive now.

However, ppc and ppc64 on kexec doesn't increment end address now and
this should be done as an insurance when map passed from firmware is
inclusive, for which I'll post a patch later.

---

HATAYAMA Daisuke (4):
      kdump, oldmem: compare with saved_max_pfn exclusively
      kdump, s390: make saved_max_pfn exclusive
      kdump, ppc: make saved_max_pfn exclusive
      kdump, mips: make saved_max_pfn exclusive


 arch/mips/kernel/crash_dump.c    |    2 +-
 arch/powerpc/kernel/crash_dump.c |    2 +-
 arch/s390/kernel/setup.c         |    4 ++--
 drivers/char/mem.c               |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
