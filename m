Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYB39-0007jH-Tl
 for kexec@lists.infradead.org; Thu, 10 Apr 2014 09:13:38 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v5 00/10] kexec-tools, x86: E820 memmap pass for kdump
Date: Thu, 10 Apr 2014 17:12:53 +0800
Message-Id: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au, vgoyal@redhat.com, ebiederm@xmission.com, hpa@zytor.com, trenn@suse.de, dyoung@redhat.com, linn@hp.com
Cc: kexec@lists.infradead.org

Hi, all

(Sorry for this late update. I was occupied with something else)

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

v5->v4:
Dave:
 - separate add_setup_data() to another patch
Vivek:
 - adding comments for setup_data
 - store crash memory range info golobally in kexec_info

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

WANG Chao (10):
  x86, cleanup: fix indent
  x86, cleanup: add extra arguments to add_memmap() and delete_memmap()
  x86, cleanup: add other types of memory range for 2nd kernel boot to
    memmap_p
  x86, cleanup: add_memmap() only do alignment check on RANGE_RAM
  x86, cleanup: use dbgprint_mem_range for memory range debugging
  x86, cleanup: increase CRASH_MAX_MEMMAP_NR up to
    CRASH_MAX_MEMORY_RANGES
  x86, cleanup: Store crash memory ranges kexec_info
  x86, cleanup: Add a funtion add_setup_data()
  x86: add --pass-memmap-cmdline option
  x86: Pass memory range via E820 for kdump

 kexec/arch/i386/crashdump-x86.c        |  79 +++++++--------
 kexec/arch/i386/crashdump-x86.h        |   2 +-
 kexec/arch/i386/include/arch/options.h |   2 +
 kexec/arch/i386/kexec-x86.c            |   4 +
 kexec/arch/i386/kexec-x86.h            |   1 +
 kexec/arch/i386/x86-linux-setup.c      | 175 ++++++++++++++++++++++-----------
 kexec/arch/i386/x86-linux-setup.h      |   1 +
 kexec/arch/x86_64/kexec-x86_64.c       |   5 +
 kexec/kexec.h                          |   2 +
 9 files changed, 171 insertions(+), 100 deletions(-)

-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
