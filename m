Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from acsinet15.oracle.com ([141.146.126.227])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SoeKu-00074V-7T
 for kexec@lists.infradead.org; Tue, 10 Jul 2012 17:34:57 +0000
Date: Tue, 10 Jul 2012 13:26:26 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] incorrect layout of globals from head_64.S during
 kexec boot
Message-ID: <20120710172626.GA6868@phenom.dumpdata.com>
References: <20120706084120.GA31219@router-fw-old.local.net-space.pl>
 <20120706120750.GA8970@aepfle.de>
 <4FF6FCA9020000780008E0BB@nat28.tlf.novell.com>
 <20120706133105.GA20600@aepfle.de>
 <20120706141419.GA21951@aepfle.de>
 <4FF7174C020000780008E1FF@nat28.tlf.novell.com>
 <20120706172918.GA15222@aepfle.de>
 <20120710093327.GA13864@aepfle.de>
 <20120710141411.GB1791@phenom.dumpdata.com>
 <20120710152308.GA31819@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120710152308.GA31819@aepfle.de>
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
To: Olaf Hering <olaf@aepfle.de>
Cc: Jan Beulich <JBeulich@suse.com>, xen-devel@lists.xensource.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Kiper <dkiper@net-space.pl>

On Tue, Jul 10, 2012 at 05:23:08PM +0200, Olaf Hering wrote:
> On Tue, Jul 10, Konrad Rzeszutek Wilk wrote:
> 
> > On Tue, Jul 10, 2012 at 11:33:27AM +0200, Olaf Hering wrote:
> > > On Fri, Jul 06, Olaf Hering wrote:
> > > 
> > > > On Fri, Jul 06, Jan Beulich wrote:
> > > > 
> > > > > > Could it be that some code tweaks the stack content used by decompress()
> > > > > > in some odd way? But that would most likely lead to a crash, not to
> > > > > > unexpected uncompressing results.
> > > > > 
> > > > > Especially if the old and new kernel are using the exact same
> > > > > image, how about the decompression writing over the shared
> > > > > info page causing all this? As the decompressor wouldn't
> > > > > expect Xen to possibly write stuff there itself, it could easily be
> > > > > that some repeat count gets altered, thus breaking the
> > > > > decompressed data without the decompression code necessarily
> > > > > noticing.
> > > > 
> > > > In my case the gfn of the shared info page is 1f54.
> > > > Is it possible to move the page at runtime? It looks like it can be done
> > > > because the hvm loader configures fffff initially.
> > > > 
> > > > Perhaps the PVonHVM code has to give up the shared pages or move them to
> > > > some dedicated unused page during the process of booting into the new
> > > > kernel.
> > > 
> > > The pfn 1f54 of the shared info page is in the middle of the new bzImage:
> > > pfn    32080 KiB   <= ok, so the old .bss
> > 
> > > _head  29360 KiB
> > > _text  33826 KiB
> > > _end   33924 KiB
> > 
> > So _head is at 1CAC and _text starts at  2108h?
> > Ugh, and 1F54 gets overriden. And with your patch, the data gets
> > stuck in between _text and _end? No wait, where would the shared_info
> > be located in the old kernel? Somewhere below the 1CACh?
> 
> The 3 symbols above are from bzImage, which contains the gzipped vmlinux
> and some code to decompress and actually start the uncompressed vmlinux.
> 
> > I presume 1F54 is the _brk_end for the old kernel as well?
> 
> Its in the .brk section of the old kernel.
> 
> > Could you tell me how the decompress code works? Is the new kernel
> > put at PFN 1000h and the decompressor code is put below it?
> 
> I'm not too familiar with the details of the events that happen during
> kexec -e. This is what happens from my understanding:
> kexec -l loads the new kernel and some helper code into some allocated
> memory. kexec -e starts the helper code which relocates the new bzImage
> to its new location (_head) and starts it. The new bzImage uncompresses
> the vmlinux to its final location and finally starts the new vmlinux.
> 
> 
> Now that I think about it, during the relocation of the new bzImage the
> part which contains the compressed vmlinux will already be corrupted
> because the shared info page will be modified by Xen (I dont know in
> what intervals the page gets modified).
> 
> > And the decompressor code uses the .bss section of the "new" kernel
> > to do its deed - since it assumes that the carcass of the old kernel
> > is truly dead and it is not raising a hand saying: "I am not dead yet!".
> 
> The decompressor uses its own .bss.
> 
> > Which brings me to another question - say we do use this patch, what
> > if the decompressor overwrites the old kernels .data section. Won't
> > we run into this problem again?
> 
> The old kernel is dead at this point. If both kernels have the same
> memory layout then the decompressor will clear the page. If they have a
> different layout the .data section (or whatever happens to be there) of
> the new kernel will be corrupted.
> 
> > And what about the new kernel? It will try to register at a new
> > MFN location the VCPU structure. Is that something that the hypervisor
> > is OK with? Does that work with more than VCPU? Or is is stuck with
> > just one VCPU (b/c it couldn't actually do the hypercall?).
> 
> So far I havent seen an issue because my guest uses a single cpu.
> 
> > Or is the registration OK, since the new kernel has the same layout
> > so it registers at the same MFN as the "dead" kernel and it works
> > peachy? What if the kernel version used in the kexec is different
> > from the old one (say it has less built in things)? That would mean
> > the .text and .data section are different than the "dead" kernel?
> 
> Yes, the layout would differ. During decompression corruption may
> occour.
> 
> > > In the patch below the pfn is moved from the bss to the data section. As
> > > a result the new location is now at 28680 KiB, which is outside of the
> > > bzImage.
> > > 
> > > Maybe there is a way to use another dedicated page as shared info page.
> > 
> > That would do it, but it has the negative consequence that we end up
> > consuming an extra PAGE_SIZE that on baremetal kernels won't be used.
> 
> I was not thinking of statically allocated pages but some new concept of
> allocating such shared pages. Shouldnt there be some dedicated area in
> the E820 table which has to be used during the whole life time of the
> guest?

Not that I can see. But I don't see why that could not be added? Perhaps
the HVM loader can make it happen? But then how would it tell the kernel
that this E820_RESERVED is the shared_info one. Not the other ones..


> Are there more shared areas or is it just the shared info page?
> 
> > And I am kind of worried that moving it to the .data section won't
> > be completly safe - as the decompressor might blow away that part too.
> 
> The decompressor may just clear the area, but since there is no way to
> tell where the shared pages are its always a risk to allocate them at
> compile time.

Yeah, and with the hypervisor potentially still updating the "old"
MFN before the new kernel has registered the new MFN, we can end up
corrupting the new kernel. Ouch.

Would all of these issues disappear if the hypervisor had a hypercall
that would stop updating the shared info? or just deregister the MFN?
What if you ripped the GMFN out using 'decrease_reservation' hypercall?
Would that eliminate the pesky GMFN?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
