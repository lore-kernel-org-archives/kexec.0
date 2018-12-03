Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTppq-0005Bn-I1
 for kexec@lists.infradead.org; Mon, 03 Dec 2018 15:08:36 +0000
Date: Mon, 3 Dec 2018 16:08:09 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
Message-ID: <20181203150809.GA4794@zn.tnic>
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181202030839.29945-2-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: linux-doc@vger.kernel.org, bhe@redhat.com, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

Add some more Ccs.

On Sun, Dec 02, 2018 at 11:08:38AM +0800, Lianbo Jiang wrote:
> This document lists some variables that export to vmcoreinfo, and briefly
> describles what these variables indicate. It should be instructive for
> many people who do not know the vmcoreinfo, and it also normalizes the
> exported variable as a standard ABI between kernel and use-space.

Yeah, I'm not sure about it being an ABI. Apparently, it is considered
too tightly coupled to the kernel for it to be an ABI.

Regardless, thanks for doing that.

> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  Documentation/kdump/vmcoreinfo.txt | 400 +++++++++++++++++++++++++++++
>  1 file changed, 400 insertions(+)
>  create mode 100644 Documentation/kdump/vmcoreinfo.txt
> 
> diff --git a/Documentation/kdump/vmcoreinfo.txt b/Documentation/kdump/vmcoreinfo.txt

Aren't we adding new docs in rst format only or what is the logic there?

Jon?

> new file mode 100644
> index 000000000000..c6759be14af7
> --- /dev/null
> +++ b/Documentation/kdump/vmcoreinfo.txt
> @@ -0,0 +1,400 @@
> +================================================================
> +		Documentation for Vmcoreinfo
> +================================================================
> +
> +=======================
> +What is the vmcoreinfo?
> +=======================
> +The vmcoreinfo contains the first kernel's various information, for

The first sentence here should be explaining what VMCOREINFO is: it is
an ELF PT_NOTE section. So that people can go, oh ok, it is a special
ELF section, when reading.

Then, MAKEDUMPFILE(8) spells VMCOREINFO in all caps and I think we
should do that too here, for ease of recognition.

Btw, do we have a makedumpfile switch or a tool/script which dumps
VMCOREINFO contents in human-readable form?

Maybe something nicer than:

$ hexdump -C /proc/kcore

> +example, structure size, page size, symbol values and field offset,
> +etc. These data are encapsulated into an elf format, and these data
> +will also help user-space tools(e.g. makedumpfile, crash) analyze the
> +first kernel's memory usage.
> +
> +================
> +Common variables
> +================
> +
> +init_uts_ns.name.release
> +========================
> +The number of OS release.
> +
> +PAGE_SIZE
> +=========
> +The size of a page. It is usually 4k bytes.
> +
> +init_uts_ns
> +===========
> +This is the UTS namespace, which is used to isolate two specific elements
> +of the system that relate to the uname system call. The UTS namespace is
> +named after the data structure used to store information returned by the
> +uname system call.

Those non-obvious exports should also have a short explanation why
they're part of VMCOREINFO.

> +
> +node_online_map
> +===============
> +It is a macro definition, actually it is an arrary node_states[N_ONLINE],
> +and it represents the set of online node in a system, one bit position
> +per node number.

Ditto.

So yeah, people can find out what those things are but I think it is
more important to state here *why* they're part of VMCOREINFO and how
they're used and why they're exported.

Who knows, some might turn out to be not needed anymore. :)

> +
> +swapper_pg_dir
> +=============
> +It is always an array, it gerenally stands for the pgd for the kernel.
> +When mmu is enabled in config file, the 'swapper_pg_dir' is valid.
> +
> +_stext
> +======
> +It is an assemble directive that defines the beginning of the text section.

That's an assembly symbol.

> +In gerenal, the '_stext' indicates the kernel start address.
> +
> +vmap_area_list
> +==============
> +It stores the virtual area list, makedumpfile can get the vmalloc start
> +value according to this variable.

"... from this variable."

> +
> +mem_map
> +=======
> +Physical addresses are translated to struct pages by treating them as an
> +index into the mem_map array. Shifting a physical address PAGE_SHIFT bits
> +to the right will treat it as a PFN from physical address 0, which is also
> +an index within the mem_map array.
> +
> +In a word, it can map the address to struct page.

"In short, ... "

> +
> +contig_page_data
> +================
> +Makedumpfile can get the pglist_data structure according to this symbol

Please look up in the dictionary what "according" means. Using it in
this context is at least weird.

> +'contig_page_data'. The pglist_data structure is used to describe the
> +memory layout.
> +
> +mem_section|(mem_section, NR_SECTION_ROOTS)|(mem_section, section_mem_map)
> +==========================================================================
> +Export the address of 'mem_section' array, and it's length, structure size,
> +and the 'section_mem_map' offset.
> +
> +It exists in the sparse memory mapping model, and it is also somewhat
> +similar to the mem_map variable, both of them will help to translate
> +the address.
> +
> +page
> +====
> +The size of a 'page' structure.
> +
> +pglist_data
> +===========
> +The size of a 'pglist_data' structure.
> +
> +zone
> +====
> +The size of a 'zone' structure.
> +
> +free_area
> +=========
> +The size of a 'free_area' structure.
> +
> +list_head
> +=========
> +The size of a 'list_head' structure.
> +
> +nodemask_t
> +==========
> +The size of a 'nodemask_t' type.
> +
> +(page, flags|_refcount|mapping|lru|_mapcount|private|compound_dtor|
> +       compound_order|compound_head)
> +===================================================================
> +The page structure is a familiar concept for most of linuxer, there is no
> +need to explain too much.

Just delete that sentence.

> To know more information, please refer to the
> +definition of the page struct(include/linux/mm_types.h).
> +
> +(pglist_data, node_zones|nr_zones|node_mem_map|node_start_pfn|node_
> +              spanned_pages|node_id)
> +===================================================================
> +On NUMA machines, each NUMA node would have a pg_data_t to describe

s/would have/has/

> +it's memory layout. On UMA machines there is a single pglist_data which
> +describes the whole memory.
> +
> +The pglist_data structure contains these varibales, here export their
					    ^^^^^^^^^

Before you send next time, run the *whole* text through a spellchecker.

> +offset in the pglist_data structure, which is defined in this file
> +"include/linux/mmzone.h".

You don't have to state where stuff is defined - I hope everyone
should be able to grep.

...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
