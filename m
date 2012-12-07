Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tgt5q-00072a-Tp
 for kexec@lists.infradead.org; Fri, 07 Dec 2012 08:15:35 +0000
Received: by mail-vc0-f177.google.com with SMTP id m8so180010vcd.36
 for <kexec@lists.infradead.org>; Fri, 07 Dec 2012 00:15:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOJsxLFy5TP_xJ0GcqYdpsZ_Lj+Sf2Bfn99CqCqOv8P21N8+UA@mail.gmail.com>
References: <1354810175-4338-1-git-send-email-js1304@gmail.com>
 <1354810175-4338-2-git-send-email-js1304@gmail.com>
 <CAOJsxLFy5TP_xJ0GcqYdpsZ_Lj+Sf2Bfn99CqCqOv8P21N8+UA@mail.gmail.com>
Date: Fri, 7 Dec 2012 16:15:30 +0800
Message-ID: <CAA_GA1e1ZoifSFnPG6bcyFUt4GRXP4DzukKKrJS0O6LCn4Qotg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] mm,
 vmalloc: change iterating a vmlist to find_vm_area()
From: Bob Liu <lliubbo@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Joonsoo Kim <js1304@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Dec 7, 2012 at 3:44 PM, Pekka Enberg <penberg@kernel.org> wrote:
> On Thu, Dec 6, 2012 at 6:09 PM, Joonsoo Kim <js1304@gmail.com> wrote:
>> The purpose of iterating a vmlist is finding vm area with specific
>> virtual address. find_vm_area() is provided for this purpose
>> and more efficient, because it uses a rbtree.
>> So change it.
>
> You no longer take the 'vmlist_lock'. This is safe, because...?
>

I think it's because find_vm_area() -> find_vmap_area() will use
vmap_area_lock instead.

>> Cc: Chris Metcalf <cmetcalf@tilera.com>
>> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Signed-off-by: Joonsoo Kim <js1304@gmail.com>
>>
>> diff --git a/arch/tile/mm/pgtable.c b/arch/tile/mm/pgtable.c
>> index de0de0c..862782d 100644
>> --- a/arch/tile/mm/pgtable.c
>> +++ b/arch/tile/mm/pgtable.c
>> @@ -592,12 +592,7 @@ void iounmap(volatile void __iomem *addr_in)
>>            in parallel. Reuse of the virtual address is prevented by
>>            leaving it in the global lists until we're done with it.
>>            cpa takes care of the direct mappings. */
>> -       read_lock(&vmlist_lock);
>> -       for (p = vmlist; p; p = p->next) {
>> -               if (p->addr == addr)
>> -                       break;
>> -       }
>> -       read_unlock(&vmlist_lock);
>> +       p = find_vm_area((void *)addr);
>>
>>         if (!p) {
>>                 pr_err("iounmap: bad address %p\n", addr);
>> diff --git a/arch/unicore32/mm/ioremap.c b/arch/unicore32/mm/ioremap.c
>> index b7a6055..13068ee 100644
>> --- a/arch/unicore32/mm/ioremap.c
>> +++ b/arch/unicore32/mm/ioremap.c
>> @@ -235,7 +235,7 @@ EXPORT_SYMBOL(__uc32_ioremap_cached);
>>  void __uc32_iounmap(volatile void __iomem *io_addr)
>>  {
>>         void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
>> -       struct vm_struct **p, *tmp;
>> +       struct vm_struct *vm;
>>
>>         /*
>>          * If this is a section based mapping we need to handle it
>> @@ -244,17 +244,10 @@ void __uc32_iounmap(volatile void __iomem *io_addr)
>>          * all the mappings before the area can be reclaimed
>>          * by someone else.
>>          */
>> -       write_lock(&vmlist_lock);
>> -       for (p = &vmlist ; (tmp = *p) ; p = &tmp->next) {
>> -               if ((tmp->flags & VM_IOREMAP) && (tmp->addr == addr)) {
>> -                       if (tmp->flags & VM_UNICORE_SECTION_MAPPING) {
>> -                               unmap_area_sections((unsigned long)tmp->addr,
>> -                                                   tmp->size);
>> -                       }
>> -                       break;
>> -               }
>> -       }
>> -       write_unlock(&vmlist_lock);
>> +       vm = find_vm_area(addr);
>> +       if (vm && (vm->flags & VM_IOREMAP) &&
>> +               (vm->flags & VM_UNICORE_SECTION_MAPPING))
>> +               unmap_area_sections((unsigned long)vm->addr, vm->size);
>>
>>         vunmap(addr);
>>  }
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index 78fe3f1..9a1e658 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -282,12 +282,7 @@ void iounmap(volatile void __iomem *addr)
>>            in parallel. Reuse of the virtual address is prevented by
>>            leaving it in the global lists until we're done with it.
>>            cpa takes care of the direct mappings. */
>> -       read_lock(&vmlist_lock);
>> -       for (p = vmlist; p; p = p->next) {
>> -               if (p->addr == (void __force *)addr)
>> -                       break;
>> -       }
>> -       read_unlock(&vmlist_lock);
>> +       p = find_vm_area((void __force *)addr);
>>
>>         if (!p) {
>>                 printk(KERN_ERR "iounmap: bad address %p\n", addr);
>> --
>> 1.7.9.5

-- 
Thanks,
--Bob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
