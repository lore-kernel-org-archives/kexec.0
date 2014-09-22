Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XW594-0000e5-4o
 for kexec@lists.infradead.org; Mon, 22 Sep 2014 15:03:19 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 22 Sep 2014 16:02:54 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4D2FD2190046
 for <kexec@lists.infradead.org>; Mon, 22 Sep 2014 16:02:29 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8MF2ocD37159114
 for <kexec@lists.infradead.org>; Mon, 22 Sep 2014 15:02:50 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8MF2njs024011
 for <kexec@lists.infradead.org>; Mon, 22 Sep 2014 09:02:49 -0600
Date: Mon, 22 Sep 2014 17:02:47 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Add "--mem-usage" support for s390x
Message-ID: <20140922170247.36774052@holzheu>
In-Reply-To: <1409541340-2719-1-git-send-email-bhe@redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

Hello Baoquan,

I looked into your patches and tried to add s390x support.

My naive approach was to just enable the is_vmalloc_addr()
for s390x:

--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -814,13 +814,15 @@ unsigned long long vaddr_to_paddr_ppc(un
 #endif          /* powerpc32 */

 #ifdef __s390x__ /* s390x */
+int is_vmalloc_addr_s390x(ulong vaddr);
 int get_machdep_info_s390x(void);
 unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr);
 #define get_phys_base()        TRUE
 #define get_machdep_info()     get_machdep_info_s390x()
 #define get_versiondep_info()  TRUE
 #define vaddr_to_paddr(X)      vaddr_to_paddr_s390x(X)
-#define is_vmalloc_addr(X)     TRUE
+#define is_vmalloc_addr(X)     is_vmalloc_addr_s390x(X)
 #endif          /* s390x */

 #ifdef __ia64__ /* ia64 */

Unfortunately this does not work and makedumpfile loops.
I assume the reason is that get_kcore_dump_loads() is called
before get_machdep_info_s390x() which sets info->vmalloc_start.

I looked into the x86 code and for me it looks like it should
have the same problem.

Have I overlooked something here? Perhaps you can give me a hint?

For testing on my 1G system I hardcoded is_vmalloc_addr(X) to:

#define is_vmalloc_addr(X) ((X) > (1024 * 1024 * 1024))

Then --mem-usage seems to work:

# makedumpfile --mem-usage /proc/kcore
TYPE            PAGES                   EXCLUDABLE      DESCRIPTION
----------------------------------------------------------------------
ZERO            32014                   yes             Pages filled with zero
CACHE           23264                   yes             Cache pages
CACHE_PRIVATE   11462                   yes             Cache pages + private
USER            5154                    yes             User process pages
FREE            20227                   yes             Free pages
KERN_DATA       36903                   no              Dumpable kernel data 

page size:              4096            
Total pages on system:  129024          
Total size on system:   528482304        Byte

Best Regards
Michael


On Mon,  1 Sep 2014 11:15:32 +0800
Baoquan He <bhe@redhat.com> wrote:

> Recently people complained that they don't know how to decide how
> much disk size need be reserved for kdump. E.g there are lots of
> machines with different memory size, if the memory usage information
> of current system can be shown, that can help them to make an estimate
> how much storage space need be reserved.
> 
> In this patchset, a new interface is added into makedumpfile. By the
> help of this, people can know the page number of memory in different
> use. The implementation is analyzing the "System Ram" and "kernel text"
> program segment of /proc/kcore excluding the crashkernel range, then
> calculating the page number of different kind per vmcoreinfo.
> 
> Previouly, patchset v1 was posted. And patch 7/7 has a change in v2.
> So several changes are made in this v3 post per comments from Vivek
> and Atsushi.
> 
> [patch 2/8] functions to get crashkernel memory range
> v3->v4:
>     In old iomem_for_each_line(), it will call exit(1) if opening iomem
>     failed. Atsushi suggested changing this to be consistent with other
>     return value. So here change all the return value to be nr, then
>     check it outside of iomem_for_each_line, and then decide how to act.
> 
> [patch 3/8] preparation functions for parsing vmcoreinfo
> v1->v3:
>     Since get_kernel_version need be called to get page_offset
>     before initial() in mem_usage code flow, and surely it will be called
>     inside initial() again. Add a static variable to avoid this duplicate
>     calling.
> v3->v4:
>     Check the value of info->kernel_version, just return if it has been
>     assigned to a value. This is suggested by Atsushi, far better than the
>     static variable idea.
>     And replace replace get_versiondep_info_x86_64() with get_versiondep_info
>     in get_page_offset().
> v4->v5:
>     Update the git log.
> 
> [patch 4/8] set vmcoreinfo for kcore
> v3->v4:
>     Change several places error messages which are the same in nearby handling.
> 
> [patch 5/8] prepare the dump loads for kcore analysis
> v1->v3:
>     Fix the compiler warnings.
> v3->v4:
>     Rename is_vmalloc_addr() to is_vmalloc_addr_x86_64() in arch/x86_64.c. And
>     then define is_vmalloc_addr() for all other ARCHs, just set their value to
>     be TRUE except of x86_64.
> 
> [patch 6/8] introduce-a-function-exclude_zero_pages_cyclic
> v3->v4:
>     Newly introduce a function exclude_zero_pages_cyclic(), and call it in
>     get_num_dumpable_cyclic().
> 
>     Besides, a strange thing happened when the new interface was tested on
>     my local AMD machine. It always terminated and printed message:
>     "Program terminated with signal SIGKILL"
>     With gdb, it should be going in readmem() of exclude_zero_pages_cyclic, I
>     still don't know why it happened.
> 
> [patch 7/8] implement a function to print the memory usage
> v1->v3:
>     Adjust the printing content and format of dumpable page numbers per Vivek's
>     comments.
> v3->v6:
>     Slightly adjust the printing format and content.
> 
> [patch 8/8]
> v1->v2:
>     Set info->dump_level=MAX_DUMP_LEVEL, with MAX_DUMP_LEVEL all kinds of
>     memory can be calculated.
> v2->v3:
>     Add the description of this feature into help message and man page.
> v3->v4:
>     Continue adjusting the output message of show_mem_usage calling per
>     Vivek's comments.
> v4->v5:
>     Update the git log.
> v5->v6:
>     Adjust the printing format which is related to dump files previously.
> 
> Baoquan He (8):
>   initialize pfn_memhole in get_num_dumpable_cyclic
>   functions to get crashkernel memory range
>   preparation functions for parsing vmcoreinfo
>   set vmcoreinfo for kcore
>   prepare the dump loads for kcore analysis
>   introduce a function exclude_zero_pages_cyclic()
>   implement a function to print the memory usage
>   add a new interface to show the memory usage of 1st kernel
> 
>  arch/x86_64.c  |   6 +-
>  elf_info.c     | 237 +++++++++++++++++++++++++++++++++++++++++++++++
>  elf_info.h     |   3 +
>  makedumpfile.8 |  17 ++++
>  makedumpfile.c | 285 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  makedumpfile.h |  17 ++++
>  print_info.c   |   8 ++
>  7 files changed, 569 insertions(+), 4 deletions(-)
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
