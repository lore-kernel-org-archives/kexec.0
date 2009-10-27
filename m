Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from flmx07.ccur.com ([12.192.68.12])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1N2rbu-0007S3-N7
	for kexec@lists.infradead.org; Tue, 27 Oct 2009 19:21:43 +0000
Message-ID: <4AE74705.2000707@ccur.com>
Date: Tue, 27 Oct 2009 14:16:21 -0500
From: John Blackwood <john.blackwood@ccur.com>
MIME-Version: 1.0
Subject: Re: Kdump issue with percpu_alloc=lpage
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>


 > Vivek Goyal wrote:
 > > > In kdump, we allocate per cpu area using alloc_percpu() and later
 > > > export the physical address of the area allocated to user space 
through
 > > > sysfs. (/sys/devices/system/cpu/cpuN/crash_notes). kexec-tools 
user space
 > > > utility makes use of this physical address to store in some ELF 
headers
 > > > which in turn are used by the second kernel booted after crash.
 > > >
 > > > We assume that address returned by per_cpu_ptr() is unity mapped and
 > > > use __pa() to convert that address to physical address.
 > > >
 > > > addr = __pa(per_cpu_ptr(crash_notes, cpunum));
 > > >
 > > > Is that not a valid assumption with percpu_alloc=lpage or 
percpu_alloc=4k
 > > > options? If not, what's the right way to get the physical address in
 > > > such situations?
 >
 > The lpage allocator is gone in the latest tree and only "embed" and
 > "page" allocators are there.  The only difference between the two is
 > that the embed one will put the first chunk inside the linearly mapped
 > area which in turn means that __pa() would work on static percpu
 > variables and some of dynamic ones but from the second chunk on and
 > for the page allocator, the percpu addresses will be remapped into
 > vmalloc area and behaves just like any other vmalloc address meaning
 > that the physical page can be determined using vmalloc_to_page().  So,
 > something like the following should work,
 >
 >         v = per_cpu_ptr(crash_notes, cpunum);
 >         if (v < VMALLOC_START || v >= VMALLOC_END)
 >                 p = __pa(v);
 >         else
 >                 p = page_to_phys(vmalloc_to_page(v));
 >
 > For the now removed lpage, it would be a bit difficult and we'll
 > probably need to add a dedicated function to percpu to determine the
 > physical address.  Hmmm... probably the right thing to do is to add
 > such function so that the user can simply call percpu_to_phys()
 > regardless of address?

Hi Tejun,

Just my 2 cent's worth...

I like the idea of having a percpu_to_phys() function that others can
call so that such detail are localized... and this also would tend to
be maintained better over time, since it would be more visible being
located near where the percpu support is implmented.

Thank you for the information.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
