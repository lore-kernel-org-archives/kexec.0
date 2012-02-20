Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RzPG2-0007P1-Lz
 for kexec@lists.infradead.org; Mon, 20 Feb 2012 09:10:11 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 6E3FA3EE0B6
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 18:10:01 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 551B045DE5C
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 18:10:01 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3C27845DE55
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 18:10:01 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2F84A1DB8055
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 18:10:01 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D9E6B1DB8044
 for <kexec@lists.infradead.org>; Mon, 20 Feb 2012 18:10:00 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH makedumpfile 0/2] LZO Compression Support
Date: Mon, 20 Feb 2012 18:10:00 +0900
Message-ID: <20120220090528.30966.59163.stgit@localhost6.localdomain6>
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

The following series implements LZO compression support to
makedumpfile. LZO is as good as in size but by far better in speed
than ZLIB, readucing down time during generation of crash dump and
refiltering.

The RFC discussion:

  http://lists.infradead.org/pipermail/kexec/2011-November/005783.html
  http://lists.infradead.org/pipermail/kexec/2011-December/005868.html

How to build:

  1. Get lzo libraries: lzo, lzo-devel and lzo-minilzo from either of
  the following:

    1) Original author's website:
       http://www.oberhumer.com/opensource/lzo/

    2) yum framework on fedora. Older releases don't have the packages.

  2. Apply the patch set to makedumpfile v1.4.2.

  3. Do make.

How to use:

  Introduce new -l option. If a user specify this, makedumpfile
  generates dumpfile compressed by pages with lzo compression.

  Example)
  $ makedumpfile -l vmcore dumpfile

Performance evaluation:

  - Kumagai-san's evaluation simulating actually working servers:
    http://lists.infradead.org/pipermail/kexec/2011-December/005868.html

  - My evaluation focusing on the worst cases:
    http://lists.infradead.org/pipermail/kexec/2011-November/005783.html

LZO Support for crash:

  I'll post LZO support patch for crash after makedumpfile merges
  these patches.

---

HATAYAMA Daisuke (2):
      Add help and manual messages about LZO compression support
      Add LZO Support


 Makefile       |    2 +-
 diskdump_mod.h |    3 ++-
 makedumpfile.8 |    6 +++---
 makedumpfile.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++---------
 makedumpfile.h |    2 ++
 print_info.c   |   16 ++++++++--------
 6 files changed, 64 insertions(+), 22 deletions(-)

-- 
HATAYAMA Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
