Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVeZm-0000WX-LA
 for kexec@lists.infradead.org; Mon, 14 Oct 2013 09:36:35 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id CA11B3EE1A4
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:07 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id B99E645DE50
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:07 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9D18045DE4D
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:07 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8F10A1DB802C
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:07 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 46A181DB8038
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 18:36:07 +0900 (JST)
Subject: [PATCH 0/3] procfs,
 vmcore: fix regression of mmap on /proc/vmcore since v3.12-rc1
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Mon, 14 Oct 2013 18:36:06 +0900
Message-ID: <20131014093606.9801.11175.stgit@localhost6.localdomain6>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, davem@davemloft.net, ebiederm@xmission.com, holzheu@linux.vnet.ibm.com, adobriyan@gmail.com, vgoyal@redhat.com

This patch set fixes regression of mmap on /proc/vmcore since
v3.12-rc1. The primary one is the 2nd patch. The 1st patch is another
bug I found during investiation and it affects mmap on /proc/vmcore
even if only 2nd patch is applied, so fix it together in this patch
set. The last patch is just for cleaning up of target function in both
1st and 2nd patches.

---

HATAYAMA Daisuke (3):
      procfs: fix unintended truncation of returned mapped address
      procfs: Call default get_unmapped_area on MMU-present architectures
      procfs: clean up proc_reg_get_unmapped_area for 80-column limit


 fs/proc/inode.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

-- 
Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
