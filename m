Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKWof-0007sP-7t
 for kexec@lists.infradead.org; Thu, 21 Aug 2014 18:10:30 +0000
Date: Thu, 21 Aug 2014 14:10:00 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
Message-ID: <20140821181000.GB21891@redhat.com>
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
 <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
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
To: Kees Cook <keescook@chromium.org>
Cc: "Thomas D." <whissi@whissi.de>, Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>

On Thu, Aug 21, 2014 at 10:57:09AM -0500, Kees Cook wrote:
> On Wed, Aug 20, 2014 at 9:33 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> > On Tue, Aug 19, 2014 at 05:07:24PM +0800, WANG Chao wrote:
> >> On 08/18/14 at 10:57am, Vivek Goyal wrote:
> >> > Hi Thomas,
> >> >
> >> > I think kexec is broken with CONFIG_RANDOMIZE_BASE=y. Chao had raised
> >> > this issue some time back when this option was introduced. I don't
> >> > remember the details though that why it is broken.
> 
> The "normal" problems with kaslr have to do with areas of memory that
> shouldn't be stomped on, or if 1-to-1 page tables are not in place.
> What state are the page tables in when doing the kexec, and how are
> kernel parameters (including e820) passed?

Hi Kees,

I suspect that it has something to do with overwriting page tables or some
other data by the new kernel.

IIUC, we are preparing identity mapped page tables for "nr_pfn_mapped".

arch/x86/kernel/machine_kexec_64.c
init_pgtable() {
        for (i = 0; i < nr_pfn_mapped; i++) {
                mstart = pfn_mapped[i].start << PAGE_SHIFT;
                mend   = pfn_mapped[i].end << PAGE_SHIFT; 

                result = kernel_ident_mapping_init(&info,
                                                 level4p, mstart, mend);
                if (result)
                        return result;
        }
}

So most likely page tables have been setup right. In fact, if one is
trying to load bzimage32, then we drop to 32bit mode and disable paging.
This new 64bit must be using the page tables setup by old kernel.

Mememory map (e820) and kernel parameters are passed in bootparams. This
is that 4K page setup by old kernel.

So I have question. How does kASLR work. Previously x86_64 relocatable
kernel will move itself to proper alignment boundary and then page
tables will be updated properly. IIRC, virtual addresses reamined fixed
and PAGE_OFFSET was not fixed.

Now with kASLR, are you moving kernel physically significantly or kernel
is not moved physically just that its placement in virtual address is not
fixed and it is chosen randomly?

If kernel is being moved physically, then we potentially have the issue of
it stomping other things. So how do we make sure that it does not overwrite
initramfs, or previous kernel's page tables or something else?

If kernel is not moving physically and only its location in virtual
address space changes, then it is very puzzling that why it should be
a problem.

If kernel always moves itself to higher addresses then one solution could
be that load everything else below kernel and load kernel at higher
addresses. But old kexec system call will not be able to cope with it as
user space determines the load location of kernel and other segments while
running kernel decides location of pages for page table and kernel has
no idea where user space has loaded new kernel. New system call still
might be able to handle it.

Also, I vaguely recall that there was a kernel parameter to disable kASLR.
And kexec/kdump initially can use that paramter as a work around. What was
that parameter.

> 
> >>
> >> The following fix the problem for kdump case:
> >>
> >> commit 0d52644
> >> Author: WANG Chao <chaowang@redhat.com>
> >> Date:   Fri Mar 28 15:05:00 2014 +0800
> >>
> >>     x86, kaslr: add alternative way to locate kernel text mapping area
> 
> I don't see this in Linus's tree? Where can I find this commit?

This is a kexec-tools patch and not kernel patch, that's why you don't
see it in linus tree. kexec-tools has to prepare ELF headers for kernel
text area. As with kASLR kernel text virtual addresses moved, kexec-tools
had to be modified to look at /proc/kallsyms and look for symbol _stext to
figure out where kernel text is and prepare ELF header accordingly.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
