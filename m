Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdLzd-0006aC-N3
 for kexec@lists.infradead.org; Mon, 04 Nov 2013 15:23:06 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 23A313EE0AE
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:22:39 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1349045DE55
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:22:39 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id F0E0245DE54
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:22:38 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id E4E3BE08001
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:22:38 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9C90E1DB8045
 for <kexec@lists.infradead.org>; Tue,  5 Nov 2013 00:22:38 +0900 (JST)
Subject: [PATCH v2 0/2] makedumpfile: write out a whole part of the 1st
 bitmap before entering cyclic process
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Tue, 05 Nov 2013 00:22:37 +0900
Message-ID: <20131104152202.2556.83382.stgit@localhost6.localdomain6>
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
1st bitmap is written out before entering cyclic process. By this:

- we no longer need to keep buffer for the 1st bitmap during cyclic
  process, and

- it's possible for incomplete crash dump, for example, generated in
  case of ENOSPC, to avoid the case that we don't know where memory is
  present.

Note that this patch only deal with a conversion from ELF to
kdump-compressed format only, not from ELF to ELF.

ChangeLog

v1 => v2)

- Fix a bug of assigning wrong cyclic buffer size from free memory
  size.

---

HATAYAMA Daisuke (2):
      Use memset() to improve the 1st bitmap initialization performance
      Write out a whole part of the 1st bitmap before entering cyclic process


 makedumpfile.c |  268 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 241 insertions(+), 27 deletions(-)

-- 

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
