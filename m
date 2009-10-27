Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1N2rfA-0007iI-9Z
	for kexec@lists.infradead.org; Tue, 27 Oct 2009 19:25:05 +0000
Date: Tue, 27 Oct 2009 15:24:14 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kdump issue with percpu_alloc=lpage
Message-ID: <20091027192414.GC2744@redhat.com>
References: <4AE74705.2000707@ccur.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4AE74705.2000707@ccur.com>
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
To: John Blackwood <john.blackwood@ccur.com>
Cc: Tejun Heo <tj@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, Oct 27, 2009 at 02:16:21PM -0500, John Blackwood wrote:
>
> > Vivek Goyal wrote:
> > > > In kdump, we allocate per cpu area using alloc_percpu() and later
> > > > export the physical address of the area allocated to user space  
> through
> > > > sysfs. (/sys/devices/system/cpu/cpuN/crash_notes). kexec-tools  
> user space
> > > > utility makes use of this physical address to store in some ELF  
> headers
> > > > which in turn are used by the second kernel booted after crash.
> > > >
> > > > We assume that address returned by per_cpu_ptr() is unity mapped and
> > > > use __pa() to convert that address to physical address.
> > > >
> > > > addr = __pa(per_cpu_ptr(crash_notes, cpunum));
> > > >
> > > > Is that not a valid assumption with percpu_alloc=lpage or  
> percpu_alloc=4k
> > > > options? If not, what's the right way to get the physical address in
> > > > such situations?
> >
> > The lpage allocator is gone in the latest tree and only "embed" and
> > "page" allocators are there.  The only difference between the two is
> > that the embed one will put the first chunk inside the linearly mapped
> > area which in turn means that __pa() would work on static percpu
> > variables and some of dynamic ones but from the second chunk on and
> > for the page allocator, the percpu addresses will be remapped into
> > vmalloc area and behaves just like any other vmalloc address meaning
> > that the physical page can be determined using vmalloc_to_page().  So,
> > something like the following should work,
> >
> >         v = per_cpu_ptr(crash_notes, cpunum);
> >         if (v < VMALLOC_START || v >= VMALLOC_END)
> >                 p = __pa(v);
> >         else
> >                 p = page_to_phys(vmalloc_to_page(v));
> >
> > For the now removed lpage, it would be a bit difficult and we'll
> > probably need to add a dedicated function to percpu to determine the
> > physical address.  Hmmm... probably the right thing to do is to add
> > such function so that the user can simply call percpu_to_phys()
> > regardless of address?
>
> Hi Tejun,
>
> Just my 2 cent's worth...
>
> I like the idea of having a percpu_to_phys() function that others can
> call so that such detail are localized... and this also would tend to
> be maintained better over time, since it would be more visible being
> located near where the percpu support is implmented.
>
> Thank you for the information.

Thanks Tejun. percpu_to_phys() makes sense to me also. John, would you like to
post a patch for this.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
