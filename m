Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UfO1m-0001IC-TA
 for kexec@lists.infradead.org; Thu, 23 May 2013 05:25:28 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 4FE0D3EE0C0
 for <kexec@lists.infradead.org>; Thu, 23 May 2013 14:24:57 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3AD3745DE5A
 for <kexec@lists.infradead.org>; Thu, 23 May 2013 14:24:57 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 24BB745DE58
 for <kexec@lists.infradead.org>; Thu, 23 May 2013 14:24:57 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 179FF1DB804B
 for <kexec@lists.infradead.org>; Thu, 23 May 2013 14:24:57 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9C88CE08001
 for <kexec@lists.infradead.org>; Thu, 23 May 2013 14:24:56 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v8 0/9] kdump, vmcore: support mmap() on /proc/vmcore
Date: Thu, 23 May 2013 14:24:55 +0900
Message-ID: <20130523052421.13864.83978.stgit@localhost6.localdomain6>
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
To: vgoyal@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org
Cc: riel@redhat.com, hughd@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, zhangyanfei@cn.fujitsu.com, kosaki.motohiro@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp, walken@google.com, cpw@sgi.com, jingbai.ma@hp.com

Currently, read to /proc/vmcore is done by read_oldmem() that uses
ioremap/iounmap per a single page. For example, if memory is 1GB,
ioremap/iounmap is called (1GB / 4KB)-times, that is, 262144
times. This causes big performance degradation due to repeated page
table changes, TLB flush and build-up of VM related objects.

To address the issue, this patch implements mmap() on /proc/vmcore to
improve read performance under sufficiently large mapping size.

In particular, the current main user of this mmap() is makedumpfile,
which not only reads memory from /proc/vmcore but also does other
processing like filtering, compression and I/O work.

Benchmark
=========

You can see two benchmarks on terabyte memory system. Both show about
40 seconds on 2TB system. This is almost equal to performance by
experimental kernel-side memory filtering.

- makedumpfile mmap() benchmark, by Jingbai Ma
  https://lkml.org/lkml/2013/3/27/19

- makedumpfile: benchmark on mmap() with /proc/vmcore on 2TB memory system
  https://lkml.org/lkml/2013/3/26/914

ChangeLog
=========

v7 => v8)

- Unify set_vmcore_list_offsets_elf{64,32} as set_vmcore_list_offsets.
  [Patch 2/9]
- Introduce update_note_header_size_elf{64,32} and cleanup
  get_note_number_and_size_elf{64,32} and copy_notes_elf{64,32}.
  [Patch 6/9]
- Create new patch that sets VM_USERMAP flag in VM object for ELF note
  segment buffer.
  [Patch 7/9]
- Unify get_vmcore_size_elf{64,32} as get_vmcore_size.
  [Patch 8/9]

v6 => v7)

- Rebase 3.10-rc2.
- Move roundup operation to note segment from patch 2/8 to patch 6/8.
- Rewrite get_note_number_and_size_elf{64,32} and
  copy_notes_elf{64,32} in patch 6/8.

v5 => v6)

- Change patch order: clenaup patch => PT_LOAD change patch =>
  vmalloc-related patch => mmap patch.
- Some cleanups: improve symbol names simply, add helper functoins for
  processing ELF note segment and add comments for the helper
  functions.
- Fix patch description of patch 7/8.

v4 => v5)

- Rebase 3.10-rc1.
- Introduce remap_vmalloc_range_partial() in order to remap vmalloc
  memory in a part of vma area.
- Allocate buffer for ELF note segment at 2nd kernel by vmalloc(). Use
  remap_vmalloc_range_partial() to remap the memory to userspace.

v3 => v4)

- Rebase 3.9-rc7.
- Drop clean-up patches orthogonal to the main topic of this patch set.
- Copy ELF note segments in the 2nd kernel just as in v1. Allocate
  vmcore objects per pages. => See [PATCH 5/8]
- Map memory referenced by PT_LOAD entry directly even if the start or
  end of the region doesn't fit inside page boundary, no longer copy
  them as the previous v3. Then, holes, outside OS memory, are visible
  from /proc/vmcore. => See [PATCH 7/8]

v2 => v3)

- Rebase 3.9-rc3.
- Copy program headers separately from e_phoff in ELF note segment
  buffer. Now there's no risk to allocate huge memory if program
  header table positions after memory segment.
- Add cleanup patch that removes unnecessary variable.
- Fix wrongly using the variable that is buffer size configurable at
  runtime. Instead, use the variable that has original buffer size.

v1 => v2)

- Clean up the existing codes: use e_phoff, and remove the assumption
  on PT_NOTE entries.
- Fix potential bug that ELF header size is not included in exported
  vmcoreinfo size.
- Divide patch modifying read_vmcore() into two: clean-up and primary
  code change.
- Put ELF note segments in page-size boundary on the 1st kernel
  instead of copying them into the buffer on the 2nd kernel.

Test
====

This patch set is composed based on v3.10-rc2, tested on x86_64,
x86_32 both with 1GB and with 5GB (over 4GB) memory configurations.

---

HATAYAMA Daisuke (9):
      vmcore: support mmap() on /proc/vmcore
      vmcore: calculate vmcore file size from buffer size and total size of vmcore objects
      vmcore: Allow user process to remap ELF note segment buffer
      vmcore: allocate ELF note segment in the 2nd kernel vmalloc memory
      vmalloc: introduce remap_vmalloc_range_partial
      vmalloc: make find_vm_area check in range
      vmcore: treat memory chunks referenced by PT_LOAD program header entries in page-size boundary in vmcore_list
      vmcore: allocate buffer for ELF headers on page-size alignment
      vmcore: clean up read_vmcore()


 fs/proc/vmcore.c        |  657 +++++++++++++++++++++++++++++++++--------------
 include/linux/vmalloc.h |    4 
 mm/vmalloc.c            |   65 +++--
 3 files changed, 515 insertions(+), 211 deletions(-)

-- 

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
