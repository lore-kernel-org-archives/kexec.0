Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WcQtW-00011b-Bc
 for kexec@lists.infradead.org; Tue, 22 Apr 2014 02:57:14 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v7 0/9] kexec-tools, x86: E820 memmap pass for kdump
Date: Tue, 22 Apr 2014 10:56:38 +0800
Message-Id: <1398135407-30142-1-git-send-email-chaowang@redhat.com>
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
To: horms@verge.net.au, dyoung@redhat.com, linn@hp.com, vgoyal@redhat.com, hpa@zytor.com, trenn@suse.de
Cc: kexec@lists.infradead.org

Hi, All

This patchset enables passing memory map via E820 map on x86 platform instead
of memmap=exactmap. It's a better design and will solve the following problem
so far:

- kernel cmdline is limited resource and large machines tend to have many
    memory ranges that may excceed kernel cmdline limit size.
- kASLR doesn't work with memmap=exactmap, because kASLR happens early than
    user defined memmap=exactmap takes effect.

Unfortunately, saved_max_pfn still got its user out there (calgry pci, it looks
like the only one). So for backward compatibility, I'm introducing a new option
--pass-memmap-cmdline to force kexec-tools to pass memmap=exactmap, the old way.

This patchset contains massive updates from the previous one. I take some
suggestions from reviewers. I try to split the changes into smaller pieces and
keep the whole change as minimal as I can so it wouldn't be too harsh to review
the patch.

Any comment is appreciate!

v7->v6:
dyoung/Simon:
 - more description for CRASH_MAX_MEMMAP_NR to be 1024

v6->v5:
dyoung:
 - use nr_memmap instead of nr_memmap_p
 - .end inclusive
Simon:
 - more description on some patches

v5->v4:
Dave:
 - separate add_setup_data() to another patch.
Vivek:
 - adding comments for setup_data.
 - store crash memory range info golobally in kexec_info.
me:
 -remove dbgprint_mem_range defination, Simon has merged the patch.

v3->v4:
Linn: check return value of malloc (use xmalloc).
me: fix dbgprintf_mem_range.

v2->v3:
Linn:
 - do not free sd (setup_data) buffer.
 - reuse code in setup_e820 and setup_e820_ext.

v1->v2:
Vivek:
 - Use function instead of macro for dbgprint_mem_range
 - Do not pass reserved memory range for kdump. It could addressed later
   separately.


WANG Chao (9):
  x86, cleanup: add extra arguments to add_memmap() and delete_memmap()
  x86, cleanup: add_memmap() only do alignment check on RANGE_RAM
  x86, cleanup: add other types of memory range for 2nd kernel boot to
    memmap_p
  x86, cleanup: use dbgprint_mem_range for memory range debugging
  x86, cleanup: increase CRASH_MAX_MEMMAP_NR up to 1024
  x86, cleanup: Store crash memory ranges kexec_info
  x86, cleanup: kexec memory range .end to be inclusive
  x86: add --pass-memmap-cmdline option
  x86: Pass memory range via E820 for kdump

 kexec/arch/i386/crashdump-x86.c        |  69 +++++++--------
 kexec/arch/i386/crashdump-x86.h        |   2 +-
 kexec/arch/i386/include/arch/options.h |   2 +
 kexec/arch/i386/kexec-x86-common.c     |   3 +-
 kexec/arch/i386/kexec-x86.c            |   4 +
 kexec/arch/i386/kexec-x86.h            |   1 +
 kexec/arch/i386/x86-linux-setup.c      | 149 ++++++++++++++++++++++-----------
 kexec/arch/i386/x86-linux-setup.h      |   1 +
 kexec/arch/x86_64/kexec-x86_64.c       |   5 ++
 kexec/firmware_memmap.c                |   1 -
 kexec/kexec.h                          |   2 +
 11 files changed, 147 insertions(+), 92 deletions(-)

-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
