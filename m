Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKR0a-0001LQ-B1
 for kexec@lists.infradead.org; Fri, 13 Sep 2013 10:53:53 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 7B7753EE102
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:23 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6D2F145DE50
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:23 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5700545DE4F
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:23 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 47B431DB8037
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:23 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id F3D691DB8032
 for <kexec@lists.infradead.org>; Fri, 13 Sep 2013 19:53:22 +0900 (JST)
Subject: [PATCH 0/2] makedumpfile, sadump: fix two GUID print bugs
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Fri, 13 Sep 2013 19:53:22 +0900
Message-ID: <20130913105216.2332.8060.stgit@localhost6.localdomain6>
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
Cc: kexec@lists.infradead.org

Hello Kumagai-san,

These are fixing the two bugs in printing GUID on sadump format.
Could you apply these?

These patchs are built on top of v1.5.4.

---

HATAYAMA Daisuke (2):
      sadump: correct buffer size for GUID EFI text representation
      sadump: convert the first three fields of EFI GUID from little-endian into big-endian


 sadump_info.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
