Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLonO-0004fM-CM
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 06:29:59 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id D27853EE0B6
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:28 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id BFD7F45DEBB
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:28 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id A53A245DEB5
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:28 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8CA2AE08003
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:28 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3FB541DB8038
 for <kexec@lists.infradead.org>; Tue, 17 Sep 2013 15:29:28 +0900 (JST)
Subject: [PATCH 0/2] cache: fix cache logic not go into invalid state
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Tue, 17 Sep 2013 15:29:27 +0900
Message-ID: <20130917062606.4671.40617.stgit@localhost6.localdomain6>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, ptesarik@suse.cz

I faced failure of sadump phys_base calculation and found a bug in
cache.c causes it. Due to the bug, cache_alloc() returns NULL forever
throughout execution. The fix is the 2nd patch. During the
investigation I also found a lack of malloc() allocation failure
check. The fix is the 1st patch. Primary is the 2nd one.

I built this patch set on top of devel branch.

---

HATAYAMA Daisuke (2):
      cache: allocate buffers at initialization to detect malloc() failure
      cache: reuse entry in pending list


 cache.c        |   50 +++++++++++++++++++++++++++++++++-----------------
 cache.h        |    1 +
 makedumpfile.c |    3 +++
 3 files changed, 37 insertions(+), 17 deletions(-)

-- 

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
