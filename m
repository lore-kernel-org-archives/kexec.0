Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fvNgU-0001vy-Sq
 for kexec@lists.infradead.org; Thu, 30 Aug 2018 14:12:32 +0000
Date: Thu, 30 Aug 2018 22:12:02 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 0/3] Add restrictions for kexec/kdump jumping between
 5-level and 4-level kernel
Message-ID: <20180830141202.GA14702@192.168.1.2>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180830135855.rylamc7mx2ur3tab@kshutemo-mobl1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180830135855.rylamc7mx2ur3tab@kshutemo-mobl1>
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
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org, kirill.shutemov@linux.intel.com

On 08/30/18 at 04:58pm, Kirill A. Shutemov wrote:
> On Wed, Aug 29, 2018 at 10:16:21PM +0800, Baoquan He wrote:
> > This was suggested by Kirill several months ago, I worked out several
> > patches to fix, then interrupted by other issues. So sort them out
> > now and post for reviewing.
> 
> Thanks for doing this.
> 
> > The current upstream kernel supports 5-level paging mode and supports
> > dynamically choosing paging mode during bootup according to kernel
> > image, hardware and kernel parameter setting. This flexibility brings
> > several issues for kexec/kdump:
> > 1)
> > Switching between paging modes, requires changes into target kernel.
> > It means you cannot kexec() 4-level paging kernel from 5-level paging
> > kernel if 4-level paging kernel doesn't include changes. 
> > 
> > 2)
> > Switching from 5-level paging to 4-level paging kernel would fail, if
> > kexec() put kernel image above 64TiB of memory.
> 
> I'm not entirely sure that 64TiB is the limit here. Technically, 4-level
> paging allows to address 256TiB in 1-to-1 mapping. We just don't have
> machines with that wide physical address space (which don't support
> 5-level paging too).

Hmm, afaik, the MAX_PHYSMEM_BITS limits the maximum address space
which physical RAM can mapped to. We have 256TB for the whole address
space for 4-level paging, that includes user space and kernel space,
it might not allow 256TB entirely for the direct mapping.
And the direct mapping is only for physical RAM mapping, and
kexec/kdump only cares about the physical RAM space and load them
inside.

# define MAX_PHYSMEM_BITS       (pgtable_l5_enabled() ? 52 : 46)

Not sure if my understanding is right, please correct me if I am wrong.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
