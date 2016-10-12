Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bu7NW-0002VB-Jb
 for kexec@lists.infradead.org; Wed, 12 Oct 2016 00:26:39 +0000
Date: Wed, 12 Oct 2016 08:26:13 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: Export memory sections virtual addresses to
 vmcoreinfo
Message-ID: <20161012002613.GB21477@x1>
References: <1475743561-23912-1-git-send-email-bhe@redhat.com>
 <877f9lckbq.fsf@x220.int.ebiederm.org> <20161011074111.GD11185@x1>
 <20161011081921.GA21765@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20161011081921.GA21765@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: keescook@chromium.org, ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, thgarnie@google.com, takahiro.akashi@linaro.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org, tonli@redhat.com

On 10/11/16 at 04:19pm, Dave Young wrote:
> On 10/11/16 at 03:41pm, Baoquan He wrote:
> > Hi Eric,
> > 
> > Thanks a lot for your reviewing! Sorry for late reply.
> > 
> > On 10/06/16 at 03:07pm, Eric W. Biederman wrote:
> > > Baoquan He <bhe@redhat.com> writes:
> > > 
> > > > KASLR memory randomization can randomize the base of the physical memory
> > > > mapping (PAGE_OFFSET), vmalloc (VMALLOC_START) and vmemmap
> > > > (VMEMMAP_START). These need be exported to VMCOREINFO so that user space
> > > > utility, mainly makedumpfile can use them to identify the base of each
> > > > memory section. Here using VMCOREINFO_NUMBER we can reuse the existing
> > > > struct number_table in makedumpfile to import data easily.
> > > >
> > > > Since they are related to x86_64 only, put them into
> > > > arch_crash_save_vmcoreinfo. And move the exportion of KERNEL_IMAGE_SIZE
> > > > together since it's also for x86_64 only.
> > > 
> > > *Scratches my head*  I would have thought this information would have
> > > better fit in the ELF header.  Where it actually has a field for virtual
> > > address.  It also has a field for physical address, and a third field
> > > for offset in the file (which is where the kdump finds these things in
> > > memory aftewards).
> > > 
> > > Why do we need need more magic vmcoreinfo to handle this?
> > 
> > Previously in x86_64, values of PAGE_OFFSET, VMALLOC and VMEMMAP are
> > fixed, makedumpfile also hard codes them.
> > 
> > In kexec-tools, we try to get page_offset_base from /proc/kallsyms or
> > search it from /proc/kcore elf header with the help of virtual address
> > of symbol _stext. Then we save it into p_vaddr of kernel text program
> > segment. In kdump kernel, we may assume kernel text has the biggest
> > starting virtual address and search it from vmcore elf header. But I
> > can't think of a way to get the starting virtual address of vmalloc and
> > vmemmap which are necessary for makedumpfile analysis.
> > 
> > So it's necessary to add them into VMCOREINFO to let makedumpfile know.
> 
> PAGE_OFFSET can be get via vaddr - paddr from elf pt_loads so only
> VMALLOC_BASE and VMEMMAP_BASE is necessary..

Well, yes, I was wrong. I wrongly thought of kernel text virtual address
when I wrote the reply.

So for PAGE_OFFSET we can exclude PT_NOTE and kernel text and calculate
PAGE_OFFSET via vaddr - paddr from crash memory program headers. Surely 
exporting is easier.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
