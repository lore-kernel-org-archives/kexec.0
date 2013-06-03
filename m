Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UjUnd-0007sC-BG
 for kexec@lists.infradead.org; Mon, 03 Jun 2013 13:27:50 +0000
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 3 Jun 2013 14:20:46 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 73C2A1B08070
 for <kexec@lists.infradead.org>; Mon,  3 Jun 2013 14:27:23 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r53DRCH810158146
 for <kexec@lists.infradead.org>; Mon, 3 Jun 2013 13:27:12 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r53DRK3p021617
 for <kexec@lists.infradead.org>; Mon, 3 Jun 2013 07:27:22 -0600
Date: Mon, 3 Jun 2013 15:27:18 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] kdump/mmap: Fix mmap of /proc/vmcore for s390
Message-ID: <20130603152718.5ba4d05f@holzheu>
In-Reply-To: <20130531160158.GC13057@redhat.com>
References: <20130524152849.GF18218@redhat.com> <87mwrkatgu.fsf@xmission.com>
 <51A006CF.90105@gmail.com> <87k3mnahkf.fsf@xmission.com>
 <51A076FE.3060604@gmail.com> <20130525145217.0549138a@holzheu>
 <20130528135500.GC7088@redhat.com>
 <20130529135144.7f95c4c0@holzheu>
 <20130530203847.GB5968@redhat.com>
 <20130531162127.6d512233@holzheu>
 <20130531160158.GC13057@redhat.com>
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

On Fri, 31 May 2013 12:01:58 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Fri, May 31, 2013 at 04:21:27PM +0200, Michael Holzheu wrote:
> > On Thu, 30 May 2013 16:38:47 -0400
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> > 
> > > On Wed, May 29, 2013 at 01:51:44PM +0200, Michael Holzheu wrote:
> > > 

[...]

> > For zfcpdump currently we add a load from [0, HSA_SIZE] where
> > p_offset equals p_paddr. Therefore we can't distinguish in
> > copy_oldmem_page() if we read from oldmem (HSA) or newmem. The
> > range [0, HSA_SIZE] is used twice. As a workaroun we could use an
> > artificial p_offset for the HSA memory chunk that is not used by
> > the 1st kernel physical memory. This is not really beautiful, but
> > probably doable.
> 
> Ok, zfcpdump is a problem because HSA memory region is in addition to
> regular memory address space. 

Right and the HSA memory is accessed with a read() interface and can't
be directly mapped.

[...]

> If you decide not to do that, agreed that copy_oldmem_page() need to
> differentiate between reference to HSA memory and reference to new
> memory. I guess in that case we will have to go with original proposal
> of using arch functions to access and read headers.

Let me think about that a bit more ...

[...]

> > If copy_oldmem_page() now also must be able to copy to vmalloc
> > memory, we would have to add new code for that:
> > 
> > * oldmem -> newmem (real): Use direct memcpy_real()
> > * oldmem -> newmem (vmalloc): Use intermediate buffer with
> > memcpy_real()
> > * newmem -> newmem: Use memcpy()
> > 
> > What do you think?
> 
> Yep, looks like you will have to do something like that.
> 
> Can't we map HSA frames temporarily, copy data and tear down the
> mapping?

Yes, we would have to create a *temporarily* mapping (see suggestion
below). We do not have enough memory to copy the complete HSA.
 
> If not, how would remap_pfn_range() work with HSA region when
> /proc/vmcore is mmaped()?

I am no memory management expert, so I discussed that with Martin
Schwidefsky (s390 architecture maintainer). Perhaps something like
the following could work:

After vmcore_mmap() is called the HSA pages are not initially mapped in
the page tables. So when user space accesses those parts
of /proc/vmcore, a fault will be generated. We implement a mechanism
that in this case the HSA is copied to a new page in the page cache and
a mapping is created for it. Since the page is allocated in the page
cache, it can be released afterwards by the kernel when we get memory
pressure.

Our current idea for such an implementation:

* Create new address space (struct address_space) for /proc/vmcore.
* Implement new vm_operations_struct "vmcore_mmap_ops" with
  new vmcore_fault() ".fault" callback for /proc/vmcore.
* Set vma->vm_ops to vmcore_mmap_ops in mmap_vmcore().
* The vmcore_fault() function will get a new page cache page,
  copy HSA page to page cache page add it to vmcore address space.
  To see how this could work, we looked into the functions
  filemap_fault() in "mm/filemap.c" and relay_buf_fault() in
  "kernel/relay.c".

What do you think?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
