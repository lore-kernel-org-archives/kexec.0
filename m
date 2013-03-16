Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UHmJS-00051W-Sx
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 02:30:09 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id CF36F3EE0C0
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:29:59 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id A8B0745DEC4
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:29:59 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8D4C445DEBE
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:29:59 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 19E9E1DB804A
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:29:59 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 9BC961DB803F
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2013 11:29:58 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v3 00/21] kdump, vmcore: support mmap() on /proc/vmcore
Date: Sat, 16 Mar 2013 13:00:47 +0900
Message-ID: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
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
To: vgoyal@redhat.com, ebiederm@xmission.com, cpw@sgi.com, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com, heiko.carstens@de.ibm.com, akpm@linux-foundation.org
Cc: zhangyanfei@cn.fujitsu.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Currently, read to /proc/vmcore is done by read_oldmem() that uses
ioremap/iounmap per a single page. For example, if memory is 1GB,
ioremap/iounmap is called (1GB / 4KB)-times, that is, 262144
times. This causes big performance degradation.

In particular, the current main user of this mmap() is makedumpfile,
which not only reads memory from /proc/vmcore but also does other
processing like filtering, compression and IO work. Update of page
table and the following TLB flush makes such processing much slow;
though I have yet to make patch for makedumpfile and yet to confirm
how it's improved.

To address the issue, this patch implements mmap() on /proc/vmcore to
improve read performance. My simple benchmark shows the improvement
from 200 [MiB/sec] to over 50.0 [GiB/sec].

ChangeLog
=========

v2 => v3)

- Rebase 3.9-rc3.

- Copy program headers seprately from e_phoff in ELF note segment
  buffer. Now there's no risk to allocate huge memory if program
  header table positions after memory segment.
  => See PATCH 01.

- Add cleanup patch that removes unnecessary variable.
  => See PATCH 02.

- Fix wrongly using the variable that is buffer size configurable at
  runtime. Instead, use the varibale that has original buffer size.
  => See PATCH 05.

v1 => v2)

- Clean up the existing codes: use e_phoff, and remove the assumption
  on PT_NOTE entries.
  => See PATCH 01, 02.

- Fix potencial bug that ELF haeader size is not included in exported
  vmcoreinfo size.
  => See Patch 03.

- Divide patch modifying read_vmcore() into two: clean-up and primary
  code change.
  => See Patch 9, 10.

- Put ELF note segments in page-size boundary on the 1st kernel
  instead of copying them into the buffer on the 2nd kernel.
  => See Patch 11, 12, 13, 14, 16.

Benchmark
=========

No change is seen from the previous patch series. See the previous
one from here:

  https://lkml.org/lkml/2013/2/14/89

The benchmark using fixed makedumpfile on 32GB memory system is found
at:

  http://lists.infradead.org/pipermail/kexec/2013-March/008300.html

TODO
====

- Benchmark on system with tera-byte memory using fixed makedumpfile.

- fix crash utility to support NT_VMCORE_PAD note type, which donesn't
  distinguish the same note types from different note names, which is
  not conform to ELF specification; now NT_VMCORE_PAD note is wrongly
  interpreted as NT_VMCORE_DEBUGINFO.

Test
====

This patch set is composed based on v3.9-rc3.

Done on x86-64, x86-32 both with 1GB and over 4GB memory environments.

---

HATAYAMA Daisuke (21):
      vmcore: introduce mmap_vmcore()
      vmcore: count holes generated by round-up operation for vmcore size
      vmcore: round-up offset of vmcore object in page-size boundary
      vmcore: check if vmcore objects satify mmap()'s page-size boundary requirement
      vmcore: check NT_VMCORE_PAD as a mark indicating the end of ELF note buffer
      kexec: fill note buffers by NT_VMCORE_PAD notes in page-size boundary
      elf: introduce NT_VMCORE_PAD type
      kexec, elf: introduce NT_VMCORE_DEBUGINFO note type
      kexec: allocate vmcoreinfo note buffer on page-size boundary
      vmcore: allocate per-cpu crash_notes objects on page-size boundary
      vmcore: read buffers for vmcore objects copied from old memory
      vmcore: clean up read_vmcore()
      vmcore: modify vmcore clean-up function to free buffer on 2nd kernel
      vmcore: copy non page-size aligned head and tail pages in 2nd kernel
      vmcore, procfs: introduce a flag to distinguish objects copied in 2nd kernel
      vmcore: round up buffer size of ELF headers by PAGE_SIZE
      vmcore: allocate buffer for ELF headers on page-size alignment
      vmcore, sysfs: export ELF note segment size instead of vmcoreinfo data size
      vmcore: rearrange program headers without assuming consequtive PT_NOTE entries
      vmcore: clean up by removing unnecessary variable
      vmcore: reference e_phoff member explicitly to get position of program header table


 arch/s390/include/asm/kexec.h |    8 -
 fs/proc/vmcore.c              |  595 ++++++++++++++++++++++++++++++++---------
 include/linux/kexec.h         |   16 +
 include/linux/proc_fs.h       |    8 -
 include/uapi/linux/elf.h      |    5 
 kernel/kexec.c                |   47 ++-
 kernel/ksysfs.c               |    2 
 7 files changed, 522 insertions(+), 159 deletions(-)

-- 

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
