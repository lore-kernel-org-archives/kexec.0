Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UjXwZ-0005QM-Rq
 for kexec@lists.infradead.org; Mon, 03 Jun 2013 16:49:16 +0000
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 3 Jun 2013 17:44:04 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1934E1B0805F
 for <kexec@lists.infradead.org>; Mon,  3 Jun 2013 17:48:50 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r53Gmdxb51970274
 for <kexec@lists.infradead.org>; Mon, 3 Jun 2013 16:48:39 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r53GmnvY030056
 for <kexec@lists.infradead.org>; Mon, 3 Jun 2013 10:48:49 -0600
Date: Mon, 3 Jun 2013 18:48:47 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] kdump/mmap: Fix mmap of /proc/vmcore for s390
Message-ID: <20130603184847.4434c7ea@holzheu>
In-Reply-To: <20130603155940.GA6714@redhat.com>
References: <51A006CF.90105@gmail.com> <87k3mnahkf.fsf@xmission.com>
 <51A076FE.3060604@gmail.com> <20130525145217.0549138a@holzheu>
 <20130528135500.GC7088@redhat.com>
 <20130529135144.7f95c4c0@holzheu>
 <20130530203847.GB5968@redhat.com>
 <20130531162127.6d512233@holzheu>
 <20130531160158.GC13057@redhat.com>
 <20130603152718.5ba4d05f@holzheu>
 <20130603155940.GA6714@redhat.com>
Mime-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On Mon, 3 Jun 2013 11:59:40 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Mon, Jun 03, 2013 at 03:27:18PM +0200, Michael Holzheu wrote:
> 
> [..]
> > > If not, how would remap_pfn_range() work with HSA region when
> > > /proc/vmcore is mmaped()?
> > 
> > I am no memory management expert, so I discussed that with Martin
> > Schwidefsky (s390 architecture maintainer). Perhaps something like
> > the following could work:
> > 
> > After vmcore_mmap() is called the HSA pages are not initially
> > mapped in the page tables. So when user space accesses those parts
> > of /proc/vmcore, a fault will be generated. We implement a mechanism
> > that in this case the HSA is copied to a new page in the page cache
> > and a mapping is created for it. Since the page is allocated in the
> > page cache, it can be released afterwards by the kernel when we get
> > memory pressure.
> > 
> > Our current idea for such an implementation:
> > 
> > * Create new address space (struct address_space) for /proc/vmcore.
> > * Implement new vm_operations_struct "vmcore_mmap_ops" with
> >   new vmcore_fault() ".fault" callback for /proc/vmcore.
> > * Set vma->vm_ops to vmcore_mmap_ops in mmap_vmcore().
> > * The vmcore_fault() function will get a new page cache page,
> >   copy HSA page to page cache page add it to vmcore address space.
> >   To see how this could work, we looked into the functions
> >   filemap_fault() in "mm/filemap.c" and relay_buf_fault() in
> >   "kernel/relay.c".
> > 
> > What do you think?
> 
> I am not mm expert either but above proposal sounds reasonable to me.
> 
> So remap_pfn_range() call will go in arch dependent code so that arch
> can decide which range can be mapped right away and which ranges will
> be filed in when fault happens? I am assuming that s390 will map
> everything except for pfn between 0 and HSA_SIZE.

Yes, for [0 - HSA_SIZE] the fault handler will be called and for
the rest we establish a mapping with remap_pfn_range() as it is
currently done. Therefore no fault handler will be called for that part
of /proc/vmcore.

I will try to find out if it is doable that way.

> And regular s390 kdump will map everyting right away and will not
> have to rely on fault mechanism?

Yes, as kdump on the other archs.

Thanks
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
