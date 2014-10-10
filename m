Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XcZEP-0005sA-Pq
 for kexec@lists.infradead.org; Fri, 10 Oct 2014 12:23:38 +0000
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 10 Oct 2014 13:23:14 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3C01C2190046
 for <kexec@lists.infradead.org>; Fri, 10 Oct 2014 13:22:49 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9ACNBmJ61603884
 for <kexec@lists.infradead.org>; Fri, 10 Oct 2014 12:23:11 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9ACNBiB013700
 for <kexec@lists.infradead.org>; Fri, 10 Oct 2014 06:23:11 -0600
Date: Fri, 10 Oct 2014 14:23:10 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] makedumpfile: Enable --mem-usage for s390x
Message-ID: <20141010142310.4c488f6a@holzheu>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701D4D5E4@BPXM01GP.gisp.nec.co.jp>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <20140922170247.36774052@holzheu>
 <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
 <20140924171904.1db5ac90@holzheu>
 <20140925094412.GI8697@dhcp-16-116.nay.redhat.com>
 <20140926101057.14549a12@holzheu>
 <20140926085546.GA30346@dhcp-16-116.nay.redhat.com>
 <20140926133441.5e58303c@holzheu>
 <20140929090432.GA9989@dhcp-16-116.nay.redhat.com>
 <20140929151413.4e9bd1ab@holzheu>
 <20140930090201.GB9989@dhcp-16-116.nay.redhat.com>
 <20141001185953.66c6ae9d@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4D5E4@BPXM01GP.gisp.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

On Thu, 9 Oct 2014 06:41:10 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> Hello,
> 
> >On Tue, 30 Sep 2014 17:02:01 +0800
> >Baoquan He <bhe@redhat.com> wrote:
> >
> >> On 09/29/14 at 03:14pm, Michael Holzheu wrote:
> >> > Implement is_vmalloc_addr() using /proc/iommem parsing to enable the new
> >> > makedumpfile option "--mem-usage".
> >> >
> >> > Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> >>
> >>
> >> Hi Michael,
> >>
> >> This idea looks good to me. One question, should it be put in
> >> arch/s390.c since this is only for s390? Then iomem_for_each_line() need
> >> be declared in makedumpfile.h .
> >>
> >> If later it's needed by other arch, can be taken out to makedumpfile.c,
> >> that should be better. Surely this is only my personal concern, if
> >> Atsushi like to accept it, I am fine too.
> >
> >Hello Atsushi,
> >
> >What is your preference regarding this question?
> >
> >Michael
> 
> In the first place, this is_vmalloc_addr() for s390 isn't a good
> implementation because it works only on 1st kernel due to the
> dependence on /proc/iomem. is_vmalloc_addr_XXX() are general functions,
> they can be called from any path besides --mem-usage.
> 
> I think the Michael's first idea below is better since it implements
> is_real_addr() only for --mem-usage as a common function for all
> architectures, it's explicit design.
> 
> >@@ -854,7 +854,7 @@ int get_kcore_dump_loads(void)
> >
> > 	for (i = 0; i < num_pt_loads; ++i) {
> > 		struct pt_load_segment *p = &pt_loads[i];
> >-		if (is_vmalloc_addr(p->virt_start))
> >+		if (!is_real_addr(p->virt_start))
> > 			continue;
> > 		loads++;
> > 	}
> 
> However, this code will not work since the argument of is_real_addr()
> must be physical address. Even unluckily, /proc/kcore's PT_LOAD looks
> useless for VtoP converting because PhysAddr is always 0:
> 
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   NOTE           0x00000000000002a8 0x0000000000000000 0x0000000000000000
>                  0x0000000000000a84 0x0000000000000000         0
>   LOAD           0x00007fffff601000 0xffffffffff600000 0x0000000000000000
>                  0x0000000000001000 0x0000000000001000  RWE    1000
>   LOAD           0x00007fff81001000 0xffffffff81000000 0x0000000000000000
>                  0x0000000000a1b000 0x0000000000a1b000  RWE    1000
>   LOAD           0x0000490000001000 0xffffc90000000000 0x0000000000000000
>                  0x00001fffffffffff 0x00001fffffffffff  RWE    1000
>   LOAD           0x00007fffa0001000 0xffffffffa0000000 0x0000000000000000
>                  0x000000005f000000 0x000000005f000000  RWE    1000
>   ...
> 
> 
> So the way using /proc/iomem seems inappropriate, we have to consider other
> approaches (but I still don't have any good ideas...)

Hello Atsushi,

Hmmm ok, sure. For x86 using /proc/iomem does not work because there is no 1:1
mapping for the kernel address space. The kernel/real memory is mapped somewhere
at the end, right?

For s390 we have a 1:1 mapping for the kernel physical memory that starts with
zero. Therefore IMHO we could use /proc/iomem. For example, on my s390x system
with 1GB memory and 256MB crashkernel:

$ cat /proc/iomem
00000000-2fffffff : System RAM
  00000000-007ddd4b : Kernel code
  007ddd4c-00bfcc5f : Kernel data
  00e18000-01c28b1f : Kernel bss
30000000-3fffffff : Crash kernel

$ objdump -h /proc/kcore
...
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  NOTE           0x0000000000000158 0x0000000000000000 0x0000000000000000
                 0x00000000000027fc 0x0000000000000000         0
  LOAD           0x000003e080003000 0x000003e080000000 0x0000000000000000
                 0x0000001f00000000 0x0000001f00000000  RWE    1000
  LOAD           0x000003ff80003000 0x000003ff80000000 0x0000000000000000
                 0x0000000080000000 0x0000000080000000  RWE    1000
  LOAD           0x0000000000003000 0x0000000000000000 0x0000000000000000
                 0x0000000030000000 0x0000000030000000  RWE    1000
  LOAD           0x000003d100003000 0x000003d100000000 0x0000000000000000
                 0x0000000000c00000 0x0000000000c00000  RWE    1000

So in that case every /proc/kcore load that is below 0x30000000 must
be real memory.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
