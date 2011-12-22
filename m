Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RdjQU-0001sn-DR
 for kexec@lists.infradead.org; Thu, 22 Dec 2011 14:15:22 +0000
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 22 Dec 2011 14:15:09 -0000
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBMEF58l2179186
 for <kexec@lists.infradead.org>; Thu, 22 Dec 2011 14:15:05 GMT
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBMEF5fM030529
 for <kexec@lists.infradead.org>; Thu, 22 Dec 2011 07:15:05 -0700
Message-ID: <1324563305.2720.41.camel@br98xy6r>
Subject: Re: [PATCH] crash: s390x: Auto-detect the correct	MAX_PHYSMEM_BITS
 used in vmcore being analyzed
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 22 Dec 2011 15:15:05 +0100
In-Reply-To: <0fcc2238-1a56-4ce1-a3bd-648ad7a47202@zmail15.collab.prod.int.phx2.redhat.com>
References: <0fcc2238-1a56-4ce1-a3bd-648ad7a47202@zmail15.collab.prod.int.phx2.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org, V Strivatsa <vatsa@linux.vnet.ibm.com>, Ananth Narayan <ananth@in.ibm.com>, Crash-utility <crash-utility@redhat.com>

Hi Dave,

On Thu, 2011-12-22 at 08:47 -0500, Dave Anderson wrote:
> 
> ----- Original Message -----
> > Hello Dave and Mahesh,
> > 
> > We also tried to solve the problem and came up with an alternative
> > solution.
> > 
> > The function s390x_max_physmem_bits() solves the following equation:
> > 
> > array_len == NR_MEM_SECTIONS / SECTIONS_PER_ROOT
> >           
> >                  2^(MAX_PYSMEM_BITS - SECTION_SIZE_BITS)
> >                  ---------------------------------------
> >           ==                    PAGE_SIZE
> >                         -------------------------
> >                         sizeof(struct mem_section)
> > 
> > This leads to the following:
> > 
> > MAX_PYSMEM_BITS  == SECTION_SIZE_BITS + log2(array_len) +
> > log2(PAGE_SIZE)
> >                          - log2(sizeof(struct mem_section));
> > 
> > I tested the patch with 42 and 46 bits and for both it seems to work.
> > I will leave now for vacation and will return January the 9th 2012.
> > 
> > I leave it to you which solution to take.
> 
> No -- I leave to you guys to decide.  I appreciate the simplicity of
> your solution, but Mahesh's patch is easier to understand.
> 
> So please decide before you go home -- I was hoping to get a release
> out today!

Unfortunately Mahesh is currently not online. We still have some time
because Martin's kernel patch that introduces the change will go into
Linux version 3.3.

So perhaps you make your crash release without this patch.

Michael




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
