Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYQrl-0003rH-Ab
 for kexec@lists.infradead.org; Fri, 11 Apr 2014 02:06:53 +0000
Date: Fri, 11 Apr 2014 10:06:22 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 00/10] kexec-tools, x86: E820 memmap pass for kdump
Message-ID: <20140411020622.GC5493@dhcp-16-198.nay.redhat.com>
References: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On 04/10/14 at 05:12pm, WANG Chao wrote:
> Hi, all
> 
> (Sorry for this late update. I was occupied with something else)
> 
> This patchset enables passing memory map via E820 map on x86 platform instead
> of memmap=exactmap. It's a better design and will solve the following problem
> so far:
> 
> - kernel cmdline is limited resource and large machines tend to have many
>   memory ranges that may excceed kernel cmdline limit size.
> - kASLR doesn't work with memmap=exactmap, because kASLR happens early than
>   user defined memmap=exactmap takes effect.
> 
> Unfortunately, saved_max_pfn still got its user out there (calgry pci, it looks
> like the only one). So for backward compatibility, I'm introducing a new option
> --pass-memmap-cmdline to force kexec-tools to pass memmap=exactmap, the old way.
> 
> This patchset contains massive updates from the previous one. I take some
> suggestions from reviewers. I try to split the changes into smaller pieces and
> keep the whole change as minimal as I can so it wouldn't be too harsh to review
> the patch.
> 
> Any comment is appreciate!
> 
> v5->v4:
> Dave:
>  - separate add_setup_data() to another patch
> Vivek:
>  - adding comments for setup_data
>  - store crash memory range info golobally in kexec_info
> 
> v3->v4:
> Linn: check return value of malloc (use xmalloc).
> me: fix dbgprintf_mem_range.
> 
> v2->v3:
> Linn:
>  - do not free sd (setup_data) buffer.
>  - reuse code in setup_e820 and setup_e820_ext.
> 
> v1->v2:
> Vivek:
>  - Use function instead of macro for dbgprint_mem_range
>  - Do not pass reserved memory range for kdump. It could addressed later
>    separately.
> 
> WANG Chao (10):
>   x86, cleanup: fix indent
>   x86, cleanup: add extra arguments to add_memmap() and delete_memmap()
>   x86, cleanup: add other types of memory range for 2nd kernel boot to
>     memmap_p
>   x86, cleanup: add_memmap() only do alignment check on RANGE_RAM
>   x86, cleanup: use dbgprint_mem_range for memory range debugging
>   x86, cleanup: increase CRASH_MAX_MEMMAP_NR up to
>     CRASH_MAX_MEMORY_RANGES
>   x86, cleanup: Store crash memory ranges kexec_info
>   x86, cleanup: Add a funtion add_setup_data()
>   x86: add --pass-memmap-cmdline option
>   x86: Pass memory range via E820 for kdump
> 
>  kexec/arch/i386/crashdump-x86.c        |  79 +++++++--------
>  kexec/arch/i386/crashdump-x86.h        |   2 +-
>  kexec/arch/i386/include/arch/options.h |   2 +
>  kexec/arch/i386/kexec-x86.c            |   4 +
>  kexec/arch/i386/kexec-x86.h            |   1 +
>  kexec/arch/i386/x86-linux-setup.c      | 175 ++++++++++++++++++++++-----------
>  kexec/arch/i386/x86-linux-setup.h      |   1 +
>  kexec/arch/x86_64/kexec-x86_64.c       |   5 +
>  kexec/kexec.h                          |   2 +
>  9 files changed, 171 insertions(+), 100 deletions(-)

Hi,

Here is what I received, seems there's some duplicate patches?

2535   T 04/10 WANG Chao         [PATCH v5 00/10] kexec-tools, x86: E820 memmap pass for kdump
2536   T 04/10 WANG Chao         [PATCH v5 01/10] x86, cleanup: fix indent
2537   T 04/10 WANG Chao         [PATCH v5 02/10] x86, cleanup: add extra arguments to add_memmap() and delete_memmap()
2538   T 04/10 WANG Chao         [PATCH v5 03/10] x86, cleanup: add other types of memory range for 2nd kernel boot to memmap_
2539   T 04/10 WANG Chao         [PATCH v5 04/10] x86, cleanup: add_memmap() only do alignment check on RANGE_RAM
2540   T 04/10 WANG Chao         [PATCH v5 05/10] x86, cleanup: use dbgprint_mem_range for memory range debugging
2541   T 04/10 WANG Chao         [PATCH v5 06/10] x86, cleanup: increase CRASH_MAX_MEMMAP_NR up to CRASH_MAX_MEMORY_RANGES
2542   T 04/10 WANG Chao         [PATCH v5 06/10] x86, cleanup: Store crash memory ranges kexec_info
2543   T 04/10 WANG Chao         [PATCH v5 07/10] x86, cleanup: Add a funtion add_setup_data()
2544   T 04/10 WANG Chao         [PATCH v5 07/10] x86, cleanup: Store crash memory ranges kexec_info

There's another [PATCH v5 06/10] x86, cleanup: Store crash memory ranges kexec_info

2545   T 04/10 WANG Chao         [PATCH v5 08/10] x86: add --pass-memmap-cmdline option
2546   T 04/10 WANG Chao         [PATCH v5 08/10] x86, cleanup: Add a funtion add_setup_data()

There's another [PATCH v5 07/10] x86, cleanup: Add a funtion add_setup_data()

2547   T 04/10 WANG Chao         [PATCH v5 09/10] x86: add --pass-memmap-cmdline option
2548   T 04/10 WANG Chao         [PATCH v5 09/10] x86: Pass memory range via E820 for kdump

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
