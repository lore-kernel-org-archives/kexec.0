Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UD1tu-0001VS-DC
 for kexec@lists.infradead.org; Wed, 06 Mar 2013 00:08:07 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 6BF373EE0BC
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 09:07:59 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4C8E645DE55
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 09:07:59 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 2CDEB45DE50
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 09:07:59 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1DBC81DB8041
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 09:07:59 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id C5E681DB8037
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 09:07:58 +0900 (JST)
Date: Wed, 06 Mar 2013 09:07:53 +0900 (JST)
Message-Id: <20130306.090753.332720289.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2 03/20] vmcore, sysfs: export ELF note segment size
 instead of vmcoreinfo data size
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130302083605.31252.26646.stgit@localhost6.localdomain6>
References: <20130302083447.31252.93914.stgit@localhost6.localdomain6>
 <20130302083605.31252.26646.stgit@localhost6.localdomain6>
Mime-Version: 1.0
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
To: vgoyal@redhat.com, ebiederm@xmission.com, cpw@sgi.com, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com, heiko.carstens@de.ibm.com, akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v2 03/20] vmcore, sysfs: export ELF note segment size instead of vmcoreinfo data size
Date: Sat, 2 Mar 2013 17:36:05 +0900

> p_memsz member of program header entry with PT_NOTE type needs to have
> size of the corresponding ELF note segment. Currently, vmcoreinfo
> exports data part only. If vmcoreinfo reachs vmcoreinfo_max_size, then
> in merge_note_headers_elf{32,64}, empty ELF note header cannot be
> found or buffer overrun can happen.

Sorry, I noticed this "buffer overrun can happen" was completely
wrong. In merge_note_headers_elf{32,64}, the size is being checked to
avoid buffer overrun.

                int j;
                void *notes_section;
                struct vmcore *new;
                u64 offset, max_sz, sz, real_sz = 0;
...
                for (j = 0; j < max_sz; j += sz) {
                        if (nhdr_ptr->n_namesz == 0)
                                break;
                        sz = sizeof(Elf32_Nhdr) +
                                ((nhdr_ptr->n_namesz + 3) & ~3) +
                                ((nhdr_ptr->n_descsz + 3) & ~3);
                        real_sz += sz;
                        nhdr_ptr = (Elf32_Nhdr*)((char*)nhdr_ptr + sz);
                }

But later patch changes teminator of ELF note segments from the null
not header to NT_VMCORE_PAD note type. It's important to export a
whole buffer for ELF note segments, not data part only. This patch
description doesn't explain this, and I'll add this explanation in the
next version.

Also, here j has int type but the other variables compared with the j
have u64 type. This is strange, and in fact verbose because for the
purpose of the j, real_sz seems exact. I'll replace the for statement
by while statement in additional clean-up patch as:

  while (real_sz < max_sz) {
    ..
  }

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
