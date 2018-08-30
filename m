Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fvNvX-0001GV-BT
 for kexec@lists.infradead.org; Thu, 30 Aug 2018 14:28:04 +0000
Date: Thu, 30 Aug 2018 17:27:39 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 0/3] Add restrictions for kexec/kdump jumping between
 5-level and 4-level kernel
Message-ID: <20180830142739.gfpa23nvex7xbkkf@black.fi.intel.com>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180830135855.rylamc7mx2ur3tab@kshutemo-mobl1>
 <20180830141202.GA14702@192.168.1.2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180830141202.GA14702@192.168.1.2>
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
To: Baoquan He <bhe@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, "Kirill A. Shutemov" <kirill@shutemov.name>, tglx@linutronix.de, mingo@kernel.org

On Thu, Aug 30, 2018 at 02:12:02PM +0000, Baoquan He wrote:
> On 08/30/18 at 04:58pm, Kirill A. Shutemov wrote:
> > On Wed, Aug 29, 2018 at 10:16:21PM +0800, Baoquan He wrote:
> > > This was suggested by Kirill several months ago, I worked out several
> > > patches to fix, then interrupted by other issues. So sort them out
> > > now and post for reviewing.
> > 
> > Thanks for doing this.
> > 
> > > The current upstream kernel supports 5-level paging mode and supports
> > > dynamically choosing paging mode during bootup according to kernel
> > > image, hardware and kernel parameter setting. This flexibility brings
> > > several issues for kexec/kdump:
> > > 1)
> > > Switching between paging modes, requires changes into target kernel.
> > > It means you cannot kexec() 4-level paging kernel from 5-level paging
> > > kernel if 4-level paging kernel doesn't include changes. 
> > > 
> > > 2)
> > > Switching from 5-level paging to 4-level paging kernel would fail, if
> > > kexec() put kernel image above 64TiB of memory.
> > 
> > I'm not entirely sure that 64TiB is the limit here. Technically, 4-level
> > paging allows to address 256TiB in 1-to-1 mapping. We just don't have
> > machines with that wide physical address space (which don't support
> > 5-level paging too).
> 
> Hmm, afaik, the MAX_PHYSMEM_BITS limits the maximum address space
> which physical RAM can mapped to. We have 256TB for the whole address
> space for 4-level paging, that includes user space and kernel space,
> it might not allow 256TB entirely for the direct mapping.
> And the direct mapping is only for physical RAM mapping, and
> kexec/kdump only cares about the physical RAM space and load them
> inside.
> 
> # define MAX_PHYSMEM_BITS       (pgtable_l5_enabled() ? 52 : 46)
> 
> Not sure if my understanding is right, please correct me if I am wrong.

IIRC, we only care about the place kexec puts the kernel before it gets
decompressed. After the decompression kernel will be put into the right
spot.

Decompression is done in early boot where we use 1-to-1 mapping (not a
usual kernel virtual memory layout). All 256TiB should be reachable.

Said all that, I think it's safer to stick with 64TiB.

For the whole patcheset:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
