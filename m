Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDQrq-0007WW-HD
 for kexec@lists.infradead.org; Thu, 07 Mar 2013 02:47:42 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 443923EE0C0
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:31 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 277B345DE4D
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:31 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0FC4F45DD78
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:31 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 014321DB803E
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:31 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A9E0B1DB8038
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:30 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 0/3] makedumpfile,
 elf: distinguish ELF note types by ELF note names
Date: Mon, 04 Mar 2013 13:18:24 +0900
Message-ID: <20130304041724.16856.19272.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

In ELF, the same integers for two note type represent different
meanings if the names they belong to are different. However,
get_pt_note_info() doesn't distinguish note types by name space, due
to which, for example, any new note type in "VMCOREINFO" name space is
wrongly interpretted as NT_PRSTATUS or the unique note type in
"VMCOREINFO" name space.

This patch series makes get_pt_note_info() distinguish ELF note types
by ELF note names along with cleanups related to this change.

For reference:

  Note Section
  http://www.sco.com/developers/gabi/latest/ch5.pheader.html#note_section

type

    This word gives the interpretation of the descriptor. Each
    originator controls its own types; multiple interpretations of a
    single type value may exist. Thus, a program must recognize both
    the name and the type to recognize a descriptor. Types currently
    must be non-negative. The ABI does not define what descriptors
    mean.

---

HATAYAMA Daisuke (3):
      elf: distinguish ELF note types by ELF note name space
      elf: swap checking order of VMCOREINFO and VMCOREINFO_XEN
      elf, sadump: move KEXEC macros from sadump_info.c to elf_info.h


 elf_info.c    |   83 ++++++++++++++++++++++++++++++++++++++-------------------
 elf_info.h    |    3 ++
 sadump_info.c |    4 +--
 3 files changed, 59 insertions(+), 31 deletions(-)

-- 

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
