Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XBgBo-0005IJ-IG
 for kexec@lists.infradead.org; Mon, 28 Jul 2014 08:21:49 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [Patch v3 0/7] add a new interface to show the memory usage of 1st
 kernel
Date: Mon, 28 Jul 2014 16:19:59 +0800
Message-Id: <1406535606-16303-1-git-send-email-bhe@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, Baoquan He <bhe@redhat.com>, vgoyal@redhat.com

Recently people complained that they don't know how to decide how
much disk size need be reserved for kdump. E.g there are lots of
machines with different memory size, if the memory usage information
of current system can be shown, that can help them to make an estimate
how much storage space need be reserved.
    
In this patchset, a new interface is added into makedumpfile. By the
help of this, people can know the page number of memory in different
use. The implementation is analyzing the "System Ram" and "kernel text"
program segment of /proc/kcore excluding the crashkernel range, then
calculating the page number of different kind per vmcoreinfo.

Previouly, patchset v1 was posted. And patch 7/7 has a change in v2.
So several changes are made in this v3 post per comments from Vivek
and Atsushi.

[patch 3/7] preparation functions for parsing vmcoreinfo
v1->v3: 
    Since get_kernel_version need be called to get page_offset
    before initial() in mem_usage code flow, and surely it will be called
    inside initial() again. Add a static variable to avoid this duplicate
    calling.

[patch 5/7] prepare the dump loads for kcore analysis
v1->v3:
    Fix the compiler warnings.

[patch 6/7] implement a function to print the memory usage
v1->v3:
    Adjust the printing content and format of dumpable page numbers per Vivek's
    comments.

[patch 7/7]
v1->v2:
    Set info->dump_level=MAX_DUMP_LEVEL, with MAX_DUMP_LEVEL all kinds of
    memory can be calculated. 
v2->v3:
    Add the description of this feature into help message and man page.

Baoquan He (7):
  initialize pfn_memhole in get_num_dumpable_cyclic
  functions to get crashkernel memory range
  preparation functions for parsing vmcoreinfo
  set vmcoreinfo for kcore
  prepare the dump loads for kcore analysis
  implement a function to print the memory usage
  add a new interface to show the memory usage of 1st kernel

 elf_info.c     | 231 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 elf_info.h     |   3 +
 makedumpfile.8 |  17 ++++
 makedumpfile.c | 247 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |  10 +++
 print_info.c   |   8 ++
 6 files changed, 516 insertions(+)

-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
