Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate7.uk.ibm.com ([194.196.100.167])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R3lV2-0007X9-Az
	for kexec@lists.infradead.org; Wed, 14 Sep 2011 09:11:21 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8E9BAHK028920
	for <kexec@lists.infradead.org>; Wed, 14 Sep 2011 09:11:10 GMT
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
	[9.149.37.252])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p8E99Eej2601170
	for <kexec@lists.infradead.org>; Wed, 14 Sep 2011 10:11:10 +0100
Received: from d06av11.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av11.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p8E8wUce022908
	for <kexec@lists.infradead.org>; Wed, 14 Sep 2011 02:58:30 -0600
Subject: Re: [patch v2 2/2] s390: Add architecture code for unmapping
	crashkernel memory
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110913145218.659f9e21.akpm@google.com>
References: <20110913132635.063397500@linux.vnet.ibm.com>
	<20110913132654.157278466@linux.vnet.ibm.com>
	<20110913145218.659f9e21.akpm@google.com>
Date: Wed, 14 Sep 2011 10:58:28 +0200
Message-ID: <1315990708.3367.14.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andrew Morton <akpm@google.com>
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, vgoyal@redhat.com

Hello Andrew,

On Tue, 2011-09-13 at 14:52 -0700, Andrew Morton wrote:
> On Tue, 13 Sep 2011 15:26:37 +0200
> Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

[snip]

> > --- a/arch/s390/include/asm/kexec.h
> > +++ b/arch/s390/include/asm/kexec.h
> > @@ -36,6 +36,9 @@
> >  /* Allocate one page for the pdp and the second for the code */
> >  #define KEXEC_CONTROL_PAGE_SIZE 4096
> >  
> > +/* Alignment of crashkernel memory */
> > +#define KEXEC_CRASH_MEM_ALIGN HPAGE_SIZE
> 
> Why not make this unconditional, for all architectures which support
> hugepages?  ie:
> 
> #ifdef HPAGE_SIZE
> #define KEXEC_CRASH_MEM_ALIGN HPAGE_SIZE
> #else
> #define KEXEC_CRASH_MEM_ALIGN PAGE_SIZE
> #endif

> in include/linux/kexec.h?
> 
> IOW, what are the compromises here?

If we would do it that way, crashkernel memory on architectures that
support large pages but do not support unmapping of crashkernel memory
would always be aligned to HPAGE_SIZE. But only PAGE_SIZE alignment
would be necessary in that case.

If that is acceptable I have no problem to define that unconditional for
all architectures. Vivek what do you think?

> 
> Also, does s390 support CONFIG_HUGETLB_PAGE=n?  If so, does the use of
> HPAGE_SIZE still make sense?  Does it compile?

Yes, s390 supports CONFIG_HUGETLB_PAGE=n and it still compiles in that
case. For us it is ok to use HPAGE_SIZE crashkernel alignment also for
kernels with CONFIG_HUGETLB_PAGE=n.

> 
> 
> >  /* The native architecture */
> >  #define KEXEC_ARCH KEXEC_ARCH_S390
> >  
> > --- a/arch/s390/kernel/machine_kexec.c
> > +++ b/arch/s390/kernel/machine_kexec.c
> > @@ -243,6 +243,37 @@ static void __machine_kdump(void *image)
> >  #endif
> >  
> >  /*
> > + * Map or unmap crashkernel memory
> > + */
> > +static void crash_map_pages(int enable)
> > +{
> > +	unsigned long size = crashk_res.end - crashk_res.start + 1;
> 
> resource_size().

Ok I will use that. Thanks for the hint.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
