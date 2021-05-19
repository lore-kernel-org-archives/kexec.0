Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1621383126.12301.4.camel@mtkswgap22>
Subject: Re: [PATCH v2 0/2] mm: unify the allocation of pglist_data instances
From: Miles Chen <miles.chen@mediatek.com>
Date: Wed, 19 May 2021 08:12:06 +0800
In-Reply-To: <YKPmxEu6YFDXRyTg@kernel.org>
References: <20210518092446.16382-1-miles.chen@mediatek.com>
 <YKPmxEu6YFDXRyTg@kernel.org>
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
To: Mike Rapoport <rppt@kernel.org>
Cc: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

On Tue, 2021-05-18 at 19:09 +0300, Mike Rapoport wrote:
> Hello Miles,
> 
> On Tue, May 18, 2021 at 05:24:44PM +0800, Miles Chen wrote:
> > This patches is created to fix the __pa() warning messages when
> > CONFIG_DEBUG_VIRTUAL=y by unifying the allocation of pglist_data
> > instances.
> > 
> > In current implementation of node_data, if CONFIG_NEED_MULTIPLE_NODES=y,
> > pglist_data is allocated by a memblock API. If CONFIG_NEED_MULTIPLE_NODES=n,
> > we use a global variable named "contig_page_data".
> > 
> > If CONFIG_DEBUG_VIRTUAL is not enabled. __pa() can handle both
> > allocation and symbol cases. But if CONFIG_DEBUG_VIRTUAL is set,
> > we will have the "virt_to_phys used for non-linear address" warning
> > when booting.
> > 
> > To fix the warning, always allocate pglist_data by memblock APIs and
> > remove the usage of contig_page_data.
> 
> Somehow I was sure that we can allocate pglist_data before it is accessed
> in sparse_init() somewhere outside mm/sparse.c. It's really not the case
> and having two places that may allocated this structure is surely worth
> than your previous suggestion.
> 
> Sorry about that.

Do you mean taht to call allocation function arch/*, somewhere after
paging_init() (so we can access pglist_data) and before sparse_init()
and free_area_init()?

Miles

>  
> > Warning message:
> > [    0.000000] ------------[ cut here ]------------
> > [    0.000000] virt_to_phys used for non-linear address: (____ptrval____) (contig_page_data+0x0/0x1c00)
> > [    0.000000] WARNING: CPU: 0 PID: 0 at arch/arm64/mm/physaddr.c:15 __virt_to_phys+0x58/0x68
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W         5.13.0-rc1-00074-g1140ab592e2e #3
> > [    0.000000] Hardware name: linux,dummy-virt (DT)
> > [    0.000000] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO BTYPE=--)
> > [    0.000000] pc : __virt_to_phys+0x58/0x68
> > [    0.000000] lr : __virt_to_phys+0x54/0x68
> > [    0.000000] sp : ffff800011833e70
> > [    0.000000] x29: ffff800011833e70 x28: 00000000418a0018 x27: 0000000000000000
> > [    0.000000] x26: 000000000000000a x25: ffff800011b70000 x24: ffff800011b70000
> > [    0.000000] x23: fffffc0001c00000 x22: ffff800011b70000 x21: 0000000047ffffb0
> > [    0.000000] x20: 0000000000000008 x19: ffff800011b082c0 x18: ffffffffffffffff
> > [    0.000000] x17: 0000000000000000 x16: ffff800011833bf9 x15: 0000000000000004
> > [    0.000000] x14: 0000000000000fff x13: ffff80001186a548 x12: 0000000000000000
> > [    0.000000] x11: 0000000000000000 x10: 00000000ffffffff x9 : 0000000000000000
> > [    0.000000] x8 : ffff8000115c9000 x7 : 737520737968705f x6 : ffff800011b62ef8
> > [    0.000000] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> > [    0.000000] x2 : 0000000000000000 x1 : ffff80001159585e x0 : 0000000000000058
> > [    0.000000] Call trace:
> > [    0.000000]  __virt_to_phys+0x58/0x68
> > [    0.000000]  check_usemap_section_nr+0x50/0xfc
> > [    0.000000]  sparse_init_nid+0x1ac/0x28c
> > [    0.000000]  sparse_init+0x1c4/0x1e0
> > [    0.000000]  bootmem_init+0x60/0x90
> > [    0.000000]  setup_arch+0x184/0x1f0
> > [    0.000000]  start_kernel+0x78/0x488
> > [    0.000000] ---[ end trace f68728a0d3053b60 ]---
> > 
> > [1] https://urldefense.com/v3/__https://lore.kernel.org/patchwork/patch/1425110/__;!!CTRNKA9wMg0ARbw!x-wGFEC1wLzXho2kI1CrC2fjXNaQm5f-n0ADQyJDckCOKZHAP_q055DCSWYcQ7Zdcw$ 
> > 
> > Change since v1:
> > - use memblock_alloc() to create pglist_data when CONFIG_NUMA=n
> > 
> > Miles Chen (2):
> >   mm: introduce prepare_node_data
> >   mm: replace contig_page_data with node_data
> > 
> >  Documentation/admin-guide/kdump/vmcoreinfo.rst | 13 -------------
> >  arch/powerpc/kexec/core.c                      |  5 -----
> >  include/linux/gfp.h                            |  3 ---
> >  include/linux/mm.h                             |  2 ++
> >  include/linux/mmzone.h                         |  4 ++--
> >  kernel/crash_core.c                            |  1 -
> >  mm/memblock.c                                  |  3 +--
> >  mm/page_alloc.c                                | 16 ++++++++++++++++
> >  mm/sparse.c                                    |  2 ++
> >  9 files changed, 23 insertions(+), 26 deletions(-)
> > 
> > 
> > base-commit: 8ac91e6c6033ebc12c5c1e4aa171b81a662bd70f
> > -- 
> > 2.18.0
> > 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
