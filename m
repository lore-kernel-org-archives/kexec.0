Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SltTS-0006U4-7h
 for kexec@lists.infradead.org; Tue, 03 Jul 2012 03:08:26 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B25F93EE0BC
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:28 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9756845DE50
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:28 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7E23145DD78
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:28 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 70BC81DB8038
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:28 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 286F3E08002
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:07:28 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 0/8] makedumpfile: Add Snappy Compression Support
Date: Tue, 03 Jul 2012 12:07:27 +0900
Message-ID: <20120703030552.16633.42523.stgit@localhost6.localdomain6>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

This patch series add snappy compression support, applied on top of
v1.4.4. snappy is fast compressoin algorhythm like lzo, but it's more
optimized than lzo on x86 machines and some others.

A lot of benchmark is available on the web. Here I only point at my
benchmark I posted a few weeks ago,

- http://lists.infradead.org/pipermail/kexec/2012-June/006425.html

  where snappy shows mostly as good performance as simple copying on
  the worst case that input data increases its data size during
  compression; this means we can use snappy with mostly NO risk.

How to get snappy libraries:

  1) Use yum framework to get snappy and snappy-devel packages, or

  2) Visit official website: http://code.google.com/p/snappy/,
    download snappy-<version>.tar.gz and then build it.

How to build makedumpfile with snappy support:

  Do make as follows:

  $ make USESNAPPY=on

---

HATAYAMA Daisuke (8):
      Add manual description
      Add help message
      Add uncompression processing
      Add compression processing
      Notify snappy unsupporting when disabled
      Add snappy build support
      Add command-line processing for snappy
      Add dump header for snappy


 Makefile       |    5 +++++
 diskdump_mod.h |    2 ++
 makedumpfile.8 |    9 +++++---
 makedumpfile.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 makedumpfile.h |    3 +++
 print_info.c   |   16 ++++++++++-----
 6 files changed, 80 insertions(+), 15 deletions(-)

-- 

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
