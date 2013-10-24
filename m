Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VZEmP-0006aG-IL
 for kexec@lists.infradead.org; Thu, 24 Oct 2013 06:52:27 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 0E6243EE0AE
 for <kexec@lists.infradead.org>; Thu, 24 Oct 2013 15:51:56 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0255C45DE4F
 for <kexec@lists.infradead.org>; Thu, 24 Oct 2013 15:51:56 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id E06FD45DE4E
 for <kexec@lists.infradead.org>; Thu, 24 Oct 2013 15:51:55 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id AFC411DB8037
 for <kexec@lists.infradead.org>; Thu, 24 Oct 2013 15:51:55 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 554CD1DB803E
 for <kexec@lists.infradead.org>; Thu, 24 Oct 2013 15:51:55 +0900 (JST)
Subject: [PATCH 0/2] makedumpfile: write out a whole part of the 1st bitmap
 before entering cyclic process
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Thu, 24 Oct 2013 15:51:54 +0900
Message-ID: <20131024065015.5291.51864.stgit@localhost6.localdomain6>
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
Cc: kexec@lists.infradead.org, vgoyal@redhat.com

This patch set changes the implementation so that a whole part of the
1st bitmap is written out before entering cyclic process. By this, we
no longer need to keep buffer for the 1st bitmap during cyclic
process.

Note that this patch only deal with a conversion from ELF to
kdump-compressed format only, not from ELF to ELF.

---

HATAYAMA Daisuke (2):
      Use memset() to improve the 1st bitmap initialization performance
      Write out a whole part of the 1st bitmap before entering cyclic process


 makedumpfile.c |  252 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 227 insertions(+), 25 deletions(-)

-- 

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
