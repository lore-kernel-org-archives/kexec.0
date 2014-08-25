Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XLl3i-0000M6-7p
 for kexec@lists.infradead.org; Mon, 25 Aug 2014 03:35:06 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 0/8] add a new interface to show the memory usage of 1st
 kernel
Date: Mon, 25 Aug 2014 11:33:04 +0800
Message-Id: <1408937592-2609-1-git-send-email-bhe@redhat.com>
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

[patch 2/8] functions to get crashkernel memory range
v3->v4:
    In old iomem_for_each_line(), it will call exit(1) if opening iomem
    failed. Atsushi suggested changing this to be consistent with other
    return value. So here change all the return value to be nr, then
    check it outside of iomem_for_each_line, and then decide how to act.

[patch 3/8] preparation functions for parsing vmcoreinfo
v1->v3:
    Since get_kernel_version need be called to get page_offset
    before initial() in mem_usage code flow, and surely it will be called
    inside initial() again. Add a static variable to avoid this duplicate
    calling.
v3->v4:
    Check the value of info->kernel_version, just return if it has been
    assigned to a value. This is suggested by Atsushi, far better than the
    static variable idea.
    And replace replace get_versiondep_info_x86_64() with get_versiondep_info
    in get_page_offset().

[patch 4/8] set vmcoreinfo for kcore
v3->v4:
    Change several places error messages which are the same in nearby handling.

[patch 5/8] prepare the dump loads for kcore analysis
v1->v3:
    Fix the compiler warnings.
v3->v4:
    Rename is_vmalloc_addr() to is_vmalloc_addr_x86_64() in arch/x86_64.c. And
    then define is_vmalloc_addr() for all other ARCHs, just set their value to
    be TRUE except of x86_64.

[patch 6/8] introduce-a-function-exclude_zero_pages_cyclic
v3->v4:
    Newly introduce a function exclude_zero_pages_cyclic(), and call it in
    get_num_dumpable_cyclic().

    Besides, a strange thing happened when the new interface was tested on
    my local AMD machine. It always terminated and printed message:
    "Program terminated with signal SIGKILL"
    With gdb, it should be going in readmem() of exclude_zero_pages_cyclic, I
    still don't know why it happened.

[patch 7/8] implement a function to print the memory usage
v1->v3:
    Adjust the printing content and format of dumpable page numbers per Vivek's
    comments.

[patch 8/8]
v1->v2:
    Set info->dump_level=MAX_DUMP_LEVEL, with MAX_DUMP_LEVEL all kinds of
    memory can be calculated.
v2->v3:
    Add the description of this feature into help message and man page.
v3->v4:
    Continue adjusting the output message of show_mem_usage calling per
    Vivek's comments.

Baoquan He (8):
  initialize pfn_memhole in get_num_dumpable_cyclic
  functions to get crashkernel memory range
  preparation functions for parsing vmcoreinfo
  set vmcoreinfo for kcore
  prepare the dump loads for kcore analysis
  introduce a function exclude_zero_pages_cyclic()
  implement a function to print the memory usage
  add a new interface to show the memory usage of 1st kernel

 arch/x86_64.c  |   6 +-
 elf_info.c     | 237 +++++++++++++++++++++++++++++++++++++++++++++++
 elf_info.h     |   3 +
 makedumpfile.8 |  17 ++++
 makedumpfile.c | 288 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.h |  17 ++++
 print_info.c   |   8 ++
 7 files changed, 573 insertions(+), 3 deletions(-)

-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
