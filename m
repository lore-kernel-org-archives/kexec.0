Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UjXBB-0004Ez-4l
 for kexec@lists.infradead.org; Mon, 03 Jun 2013 16:00:18 +0000
Date: Mon, 3 Jun 2013 11:59:40 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/2] kdump/mmap: Fix mmap of /proc/vmcore for s390
Message-ID: <20130603155940.GA6714@redhat.com>
References: <51A006CF.90105@gmail.com> <87k3mnahkf.fsf@xmission.com>
 <51A076FE.3060604@gmail.com> <20130525145217.0549138a@holzheu>
 <20130528135500.GC7088@redhat.com>
 <20130529135144.7f95c4c0@holzheu>
 <20130530203847.GB5968@redhat.com>
 <20130531162127.6d512233@holzheu>
 <20130531160158.GC13057@redhat.com>
 <20130603152718.5ba4d05f@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130603152718.5ba4d05f@holzheu>
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
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On Mon, Jun 03, 2013 at 03:27:18PM +0200, Michael Holzheu wrote:

[..]
> > If not, how would remap_pfn_range() work with HSA region when
> > /proc/vmcore is mmaped()?
> 
> I am no memory management expert, so I discussed that with Martin
> Schwidefsky (s390 architecture maintainer). Perhaps something like
> the following could work:
> 
> After vmcore_mmap() is called the HSA pages are not initially mapped in
> the page tables. So when user space accesses those parts
> of /proc/vmcore, a fault will be generated. We implement a mechanism
> that in this case the HSA is copied to a new page in the page cache and
> a mapping is created for it. Since the page is allocated in the page
> cache, it can be released afterwards by the kernel when we get memory
> pressure.
> 
> Our current idea for such an implementation:
> 
> * Create new address space (struct address_space) for /proc/vmcore.
> * Implement new vm_operations_struct "vmcore_mmap_ops" with
>   new vmcore_fault() ".fault" callback for /proc/vmcore.
> * Set vma->vm_ops to vmcore_mmap_ops in mmap_vmcore().
> * The vmcore_fault() function will get a new page cache page,
>   copy HSA page to page cache page add it to vmcore address space.
>   To see how this could work, we looked into the functions
>   filemap_fault() in "mm/filemap.c" and relay_buf_fault() in
>   "kernel/relay.c".
> 
> What do you think?

I am not mm expert either but above proposal sounds reasonable to me.

So remap_pfn_range() call will go in arch dependent code so that arch
can decide which range can be mapped right away and which ranges will
be filed in when fault happens? I am assuming that s390 will map
everything except for pfn between 0 and HSA_SIZE.

And regular s390 kdump will map everyting right away and will not
have to rely on fault mechanism?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
