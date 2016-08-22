Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yb0-f177.google.com ([209.85.213.177])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bbmxM-0005Dq-Iu
 for kexec@lists.infradead.org; Mon, 22 Aug 2016 10:59:53 +0000
Received: by mail-yb0-f177.google.com with SMTP id b96so927152ybi.0
 for <kexec@lists.infradead.org>; Mon, 22 Aug 2016 03:59:31 -0700 (PDT)
Date: Mon, 22 Aug 2016 16:29:25 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [RFC 0/4] Kexec: Enable run time memory resrvation of crash kernel
Message-ID: <20160822105925.GA17255@localhost.localdomain>
References: <20160812141838.5973-1-ronit.crj@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160812141838.5973-1-ronit.crj@gmail.com>
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
To: Ronit Halder <ronit.crj@gmail.com>
Cc: vdavydov@parallels.com, jack@suse.cz, linux-mm@kvack.org, krzysiek@podlesie.net, mnfhuang@gmail.com, hpa@zytor.com, tglx@linutronix.de, aarcange@redhat.com, bhe@redhat.com, mingo@redhat.com, msalter@redhat.com, bp@suse.de, dyoung@redhat.com, vgoyal@redhat.com, jroedel@suse.de, mchehab@osg.samsung.com, dan.j.williams@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com

On 12/08/2016:07:48:38 PM, Ronit Halder wrote:
> Currenty linux kernel reserves memory at the boot time for crash kernel.
> It will be very useful if we can reserve memory in run time. The user can 
> reserve the memory whenerver needed instead of reserving at the boot time.
> 
> It is possible to reserve memory for crash kernel at the run time using
> CMA (Contiguous Memory Allocator). CMA is capable of allocating big chunk 
> of memory. At the boot time we will create one (if only low memory is used)
> or two (if we use both high memory in case of x86_64) CMA areas of size 
> given in "crashkernel" boot time command line parameter. This memory in CMA
> areas can be used as movable pages (used for disk caches, process pages
> etc) if not allocated. Then the user can reserve or free memory from those
> CMA areas using "/sys/kernel/kexec_crash_size" sysfs entry. If the user

But the cma_alloc() is not a guaranteed allocation function, whereas memblock
api will guarantee that crashkerenel memory is available. 
More over, most of the system starts kdump service at boot time, so not sure if
it could be useful enough. Lets see what other says....

> usee high memory it will automatically at least 256MB low memory
> (needed for swiotlb and DMA buffers) when the user allocates memory using
> mentioned sysfs enrty. In case of high memory reservation the user controls
> the size of reserved region in high memory with
> "/sys/kernel/kexec_crash_size" entry. If the size set is zero then the 
> memory allocated in low memory will automatically be freed.
> 
> As the pages under CMA area (when not allocated by CMA) can only be used by
> movable pages. The pages won't be used for DMA. So, after allocating pages
> from CMA area for loading the crash kernel, there won't be any chance of
> DMA on the memory.
> 
> Thus is a prototype patch. Please share your opinions on my approach. This
> patch is only for x86 and x86_64. Please note, this patch is only a
> prototype just to explain my approach and get the review. This patch is on
> kernel version v4.4.11.
> 
> CMA depends on page migration and only uses movable pages. But, the movable
> pages become unmovable momentarily for pinning. The CMA fails for this
> reason. I don't have any solution for that right now. This approach will
> work when the this problems with CMA will be fixed. The patch is enabled
> by a kernel configuration option CONFIG_KEXEC_CMA.
> 
> Ronit Halder (4):
>   Creating one or two CMA area at Boot time
>   Functions for memory reservation and release
>   Adding a new kernel configuration to enable the feature
>   Enable memory allocation through sysfs interface
> 
>  arch/x86/kernel/setup.c | 44 ++++++++++++++++++++++++--
>  include/linux/kexec.h   | 11 ++++++-
>  kernel/kexec_core.c     | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/ksysfs.c         | 23 +++++++++++++-
>  mm/Kconfig              |  6 ++++
>  5 files changed, 162 insertions(+), 5 deletions(-)

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
