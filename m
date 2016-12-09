Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cFM7J-0001B4-4r
 for kexec@lists.infradead.org; Fri, 09 Dec 2016 14:25:50 +0000
Date: Fri, 9 Dec 2016 22:25:15 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [Makedumpfile PATCH V2 2/4] x86_64: translate all VA to PA using
 page table values
Message-ID: <20161209142515.GB6875@x1>
References: <cover.1477901442.git.panand@redhat.com>
 <c72c3722595f7b86754c6d9835ffdc3c68361bb4.1477901442.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E87E88@BPXM01GP.gisp.nec.co.jp>
 <3d3fcf63-eb95-9adb-b645-9f906d5f900f@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3d3fcf63-eb95-9adb-b645-9f906d5f900f@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, "louis.bouchard@canonical.com" <louis.bouchard@canonical.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 12/09/16 at 03:40pm, Pratyush Anand wrote:
> > > -	page_dir  = SYMBOL(init_level4_pgt);
> > > +	page_dir = SYMBOL(init_level4_pgt) - __START_KERNEL_map + phys_base;
> > 
> > I found that this change breaks the backward compatibility for
> > kernel 2.6.21 or older since phys_base was introduced in kernel 2.6.22
> > by the commit below:
> > 
> >   commit 1ab60e0f72f71ec54831e525a3e1154f1c092408
> >   Author: Vivek Goyal <vgoyal@in.ibm.com>
> >   Date:   Wed May 2 19:27:07 2007 +0200
> > 
> >       [PATCH] x86-64: Relocatable Kernel Support
> > 
> > There is no problem if phys_base is always 0 in older kernel, but
> > get_phys_base_x86_64() calculates "phys_base = 0x100000" from my vmcore:

This is really awkward. Checked code, found PAGE_OFFSET is
0xffff810000000000 before 2.6.26, then changed to 0xffff880000000000
after that. Can we check the page_offset calculated from pt_load
segments, meanwhile check if has VMCOREINFO and osrelease after 2.6.21.

With both of above condition, we could set phys_vase to 0. Not sure if
this can solve the existing problem.

> > 
> >   Type           Offset             VirtAddr           PhysAddr
> >                  FileSiz            MemSiz              Flags  Align
> >   NOTE           0x0000000000000190 0x0000000000000000 0x0000000000000000
> >                  0x0000000000000590 0x0000000000000590         0
> >   LOAD           0x0000000000000720 0xffffffff80000000 0x0000000000100000    // CONFIG_PHYSICAL_START = 0x100000
> >                  0x00000000008b2000 0x00000000008b2000  RWE    0
> >   LOAD           0x00000000008b2720 0xffff810000000000 0x0000000000000000
> >                  0x00000000000a0000 0x00000000000a0000  RWE    0
> >   LOAD           0x0000000000952720 0xffff810000100000 0x0000000000100000
> >                  0x0000000000f00000 0x0000000000f00000  RWE    0
> >   LOAD           0x0000000001852720 0xffff810005000000 0x0000000005000000
> >                  0x00000000caf70000 0x00000000caf70000  RWE    0
> >   LOAD           0x00000000cc7c2720 0xffff810100000000 0x0000000100000000
> >                  0x0000000070000000 0x0000000070000000  RWE    0
> > 
> > Of course we shouldn't use that invalid phys_base:
> > 
> >   crash> sym init_level4_pgt
> >   ffffffff80101000 (T) init_level4_pgt
> >   crash> vtop ffffffff80101000
> >   VIRTUAL           PHYSICAL
> >   ffffffff80101000  101000               // just "VIRTUAL - __START_KERNEL_map"
> > 
> >   PML4 DIRECTORY: ffffffff80101000
> >   PAGE DIRECTORY: 103027
> >      PUD: 103ff0 => 105027
> >      PMD: 105000 => 1e3
> >     PAGE: 0  (2MB)
> > 
> >   PTE  PHYSICAL  FLAGS
> >   1e3      0     (PRESENT|RW|ACCESSED|DIRTY|PSE|GLOBAL)
> > 
> >         PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
> >   ffff810005004838    101000                0        0  1 400
> >   crash>
> > 
> > At first I thought about setting 0 to phys_base if the kernel is
> > older than 2.6.22, but unfortunately we can't get the kernel version
> > before getting correct phys_base since VtoP is necessary to read
> > system_utsname.
> > (and 2.6.21 doesn't have VMCOREINFO, OSRELEASE can't be used too.)
> 
> We can use this fact may be. So, when has_vmcoreinfo() is false we can
> consider it as old kernel and can set phys_start as 0.
> 
> 
> Bao, any opnion?
> 
> ~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
