Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo02F-00FP1Y-8I
 for kexec@lists.infradead.org; Tue, 01 Jun 2021 08:46:04 +0000
Received: by mail-ot1-x331.google.com with SMTP id
 h19-20020a9d6f930000b02903c0c4560e99so227658otq.1
 for <kexec@lists.infradead.org>; Tue, 01 Jun 2021 01:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-5-aisheng.dong@nxp.com>
 <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
 <CAA+hA=Ss4j8qeoe7RtDJ14nuqy+TpOk2qi-A9+YN6=2y8c_CGg@mail.gmail.com>
 <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
In-Reply-To: <f7f77368-72cf-e15d-cc3c-b0ddf86e14fd@redhat.com>
From: Dong Aisheng <dongas86@gmail.com>
Date: Tue, 1 Jun 2021 16:44:50 +0800
Message-ID: <CAA+hA=SEKczg-tkyEQSHR=HxE8vB5Acvf-HPGy3E-0apdkZ8FA@mail.gmail.com>
Subject: Re: [PATCH V2 4/6] mm: rename the global section array to mem_sections
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
To: David Hildenbrand <david@redhat.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org, open list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

On Tue, Jun 1, 2021 at 4:40 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 01.06.21 10:37, Dong Aisheng wrote:
> > On Tue, Jun 1, 2021 at 4:22 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 31.05.21 11:19, Dong Aisheng wrote:
> >>> In order to distinguish the struct mem_section for a better code
> >>> readability and align with kernel doc [1] name below, change the
> >>> global mem section name to 'mem_sections' from 'mem_section'.
> >>>
> >>> [1] Documentation/vm/memory-model.rst
> >>> "The `mem_section` objects are arranged in a two-dimensional array
> >>> called `mem_sections`."
> >>>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> Cc: Dave Young <dyoung@redhat.com>
> >>> Cc: Baoquan He <bhe@redhat.com>
> >>> Cc: Vivek Goyal <vgoyal@redhat.com>
> >>> Cc: kexec@lists.infradead.org
> >>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >>> ---
> >>> v1->v2:
> >>>    * no changes
> >>> ---
> >>>    include/linux/mmzone.h | 10 +++++-----
> >>>    kernel/crash_core.c    |  4 ++--
> >>>    mm/sparse.c            | 16 ++++++++--------
> >>>    3 files changed, 15 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >>> index a6bfde85ddb0..0ed61f32d898 100644
> >>> --- a/include/linux/mmzone.h
> >>> +++ b/include/linux/mmzone.h
> >>> @@ -1302,9 +1302,9 @@ struct mem_section {
> >>>    #define SECTION_ROOT_MASK   (SECTIONS_PER_ROOT - 1)
> >>>
> >>>    #ifdef CONFIG_SPARSEMEM_EXTREME
> >>> -extern struct mem_section **mem_section;
> >>> +extern struct mem_section **mem_sections;
> >>>    #else
> >>> -extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
> >>> +extern struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
> >>>    #endif
> >>>
> >>>    static inline unsigned long *section_to_usemap(struct mem_section *ms)
> >>> @@ -1315,12 +1315,12 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
> >>>    static inline struct mem_section *__nr_to_section(unsigned long nr)
> >>>    {
> >>>    #ifdef CONFIG_SPARSEMEM_EXTREME
> >>> -     if (!mem_section)
> >>> +     if (!mem_sections)
> >>>                return NULL;
> >>>    #endif
> >>> -     if (!mem_section[SECTION_NR_TO_ROOT(nr)])
> >>> +     if (!mem_sections[SECTION_NR_TO_ROOT(nr)])
> >>>                return NULL;
> >>> -     return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
> >>> +     return &mem_sections[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
> >>>    }
> >>>    extern unsigned long __section_nr(struct mem_section *ms);
> >>>    extern size_t mem_section_usage_size(void);
> >>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> >>> index 29cc15398ee4..fb1180d81b5a 100644
> >>> --- a/kernel/crash_core.c
> >>> +++ b/kernel/crash_core.c
> >>> @@ -414,8 +414,8 @@ static int __init crash_save_vmcoreinfo_init(void)
> >>>        VMCOREINFO_SYMBOL(contig_page_data);
> >>>    #endif
> >>>    #ifdef CONFIG_SPARSEMEM
> >>> -     VMCOREINFO_SYMBOL_ARRAY(mem_section);
> >>> -     VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> >>> +     VMCOREINFO_SYMBOL_ARRAY(mem_sections);
> >>> +     VMCOREINFO_LENGTH(mem_sections, NR_SECTION_ROOTS);
> >>>        VMCOREINFO_STRUCT_SIZE(mem_section);
> >>>        VMCOREINFO_OFFSET(mem_section, section_mem_map);
> >>>        VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
> >>> diff --git a/mm/sparse.c b/mm/sparse.c
> >>> index d02ee6bb7cbc..6412010478f7 100644
> >>> --- a/mm/sparse.c
> >>> +++ b/mm/sparse.c
> >>> @@ -24,12 +24,12 @@
> >>>     * 1) mem_section   - memory sections, mem_map's for valid memory
> >>>     */
> >>>    #ifdef CONFIG_SPARSEMEM_EXTREME
> >>> -struct mem_section **mem_section;
> >>> +struct mem_section **mem_sections;
> >>>    #else
> >>> -struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
> >>> +struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
> >>>        ____cacheline_internodealigned_in_smp;
> >>>    #endif
> >>> -EXPORT_SYMBOL(mem_section);
> >>> +EXPORT_SYMBOL(mem_sections);
> >>>
> >>>    #ifdef NODE_NOT_IN_PAGE_FLAGS
> >>>    /*
> >>> @@ -66,8 +66,8 @@ static void __init sparse_alloc_section_roots(void)
> >>>
> >>>        size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> >>>        align = 1 << (INTERNODE_CACHE_SHIFT);
> >>> -     mem_section = memblock_alloc(size, align);
> >>> -     if (!mem_section)
> >>> +     mem_sections = memblock_alloc(size, align);
> >>> +     if (!mem_sections)
> >>>                panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> >>>                      __func__, size, align);
> >>>    }
> >>> @@ -103,14 +103,14 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
> >>>         *
> >>>         * The mem_hotplug_lock resolves the apparent race below.
> >>>         */
> >>> -     if (mem_section[root])
> >>> +     if (mem_sections[root])
> >>>                return 0;
> >>>
> >>>        section = sparse_index_alloc(nid);
> >>>        if (!section)
> >>>                return -ENOMEM;
> >>>
> >>> -     mem_section[root] = section;
> >>> +     mem_sections[root] = section;
> >>>
> >>>        return 0;
> >>>    }
> >>> @@ -145,7 +145,7 @@ unsigned long __section_nr(struct mem_section *ms)
> >>>    #else
> >>>    unsigned long __section_nr(struct mem_section *ms)
> >>>    {
> >>> -     return (unsigned long)(ms - mem_section[0]);
> >>> +     return (unsigned long)(ms - mem_sections[0]);
> >>>    }
> >>>    #endif
> >>>
> >>>
> >>
> >> I repeat: unnecessary code churn IMHO.
> >
> > Hi David,
> >
> > Thanks, i explained the reason during my last reply.
> > Andrew has already picked this patch to -mm tree.
>
> Just because it's in Andrews tree doesn't mean it will end up upstream. ;)
>
> Anyhow, no really strong opinion, it's simply unnecessary code churn
> that makes bisecting harder without real value IMHO.

In my practice, it helps improve the code reading efficiency with
scope and vim hotkey.
Before the change, I really feel mixed definition causes troubles in
reading code efficiently.
Anyway, that's my personal experience while others may have different options.
Thanks for the feedback.

Regards
Aisheng

>
> --
> Thanks,
>
> David / dhildenb
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
