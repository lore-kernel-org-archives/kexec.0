Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uz5sE-0005dq-Rc
 for kexec@lists.infradead.org; Tue, 16 Jul 2013 14:05:05 +0000
Date: Tue, 16 Jul 2013 10:04:18 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
Message-ID: <20130716140418.GB4005@redhat.com>
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130702154214.GC22603@redhat.com>
 <20130715154451.02a3a767@holzheu>
 <20130715142708.GB23772@redhat.com>
 <20130716112527.35decf17@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130716112527.35decf17@holzheu>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On Tue, Jul 16, 2013 at 11:25:27AM +0200, Michael Holzheu wrote:

[..]
> > > Hello Vivek and Andrew,
> > > 
> > > We just realized that Hatayama's mmap patches went into v3.11-rc1. This currently
> > > breaks s390 kdump because of the following two issues:
> > > 
> > > 1) The copy_oldmem_page() is now used for copying to vmalloc memory
> > > 2) The mmap() implementation is not compatible with the current
> > >    s390 crashkernel swap:
> > >    See: http://marc.info/?l=kexec&m=136940802511603&w=2
> > > 
> > > The "kdump: Introduce ELF header in new memory feature" patch series will
> > > fix both issues for s390.
> > > 
> > > There is the one small open discussion left:
> > > 
> > > http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg464856.html
> > > 
> > > But once we have finished that, would it be possible to get the
> > > patches in 3.11?
> > 
> > How about taking mmap() fault handler patches in 3.12. And in 3.11, deny
> > mmap() on s390 forcing makedumpfile to fall back on read() interface. That
> > way there will be no regression and mmap() related speedup will show up
> > in next release on s390.
> 
> Hello Vivek and Hatayama,
> 
> But then we still would have to somehow fix the copy_oldmem_page() issue (1).
> 
> We would prefer to add the current patch series with "#ifndef CONFIG_S390" in
> the fault handler.
> 
> @Vivek:
> 
> Since you are the kdump maintainer, could you tell us which of the both
> variants you would like to have?
> 
> static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
> {
> ...
> 
> #ifndef CONFIG_S390
> 	return VM_FAULT_SIGBUS;
> #endif

I think let us use this one. Kill the process on non-s390 arch if it goes
into mmap() fault handler.

copy_oldmem_page() using real mode in s390 is an issue for vmalloc region.
I think post the series again and let us see if Andrew is comfortable
with it. I suspect it is late.

IIUC, we do copying in real mode only to cope with HSA region in zfcpdump
case. Also I think in case of zfcpdump, /proc/vmcore is not usable yet
and your patches achieves that. So as an stop gap measure can we stop
dropping to real mode so that regular kdump in s390 work. (I am not sure
in case of zfcpdump, currently how do you retrieve vmcore as /dev/oldmem
is gone now).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
