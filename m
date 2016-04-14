Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1aqfQO-00081z-5P
 for kexec@lists.infradead.org; Thu, 14 Apr 2016 11:27:04 +0000
Date: Thu, 14 Apr 2016 19:26:38 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: Removal of the kernel code/data/bss resources does break
 kexec/kdump
Message-ID: <20160414112638.GA2802@x1.redhat.com>
References: <570F6D99.6090400@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <570F6D99.6090400@gmail.com>
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
To: Freeman Zhang <freeman.zhang1992@gmail.com>
Cc: kexec@lists.infradead.org, ed@abdsec.com, torvalds@linux-foundation.org

On 04/14/16 at 06:14pm, Freeman Zhang wrote:
> Mr. Torvalds,
> 
> I do notice your recent commit:
> 
> > commit c4004b02f8e5b9ce357a0bb1641756cc86962664
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Wed Apr 6 13:45:07 2016 -0700
> >
> >     x86: remove the kernel code/data/bss resources from /proc/iomem
> >
> > Let's see if anybody even notices.  I doubt anybody uses this, and it
> > does expose addresses that should be randomized, so let's just remove
> > the code.  It's old and traditional, and it used to be cute, but we
> > should have removed this long ago.
> >
> > If it turns out anybody notices and this breaks something, we'll have to
> > revert this, and maybe we'll end up using other approaches instead
> > (using %pK or similar).  But removing unnecessary code is always the
> > preferred option.
> 
> Removal of these information causes 'kexec/kdump' to fail in the newer
> kernel, as 'kexec/arch/i386/crashdump-x86.c' is coded this way:

Yes, kdump need this to construct the program header of elf file for
kernel text because users want kernel text included in /proc/vmcore. Now
kexec utility relies on /proc/iomem to get the phisical addr of  _text.
Without /proc/iomem we may need to pass it out or take other ways.

> 
> 
> /* Read kernel physical load addr from the file returned by proc_iomem()
>  * (Kernel Code) and store in kexec_info */
> static int get_kernel_paddr(struct kexec_info *UNUSED(info),
>                             struct crash_elf_info *elf_info)
> {
>                ...
> 
>       if (parse_iomem_single("Kernel code\n", &start, NULL) == 0) {
>               elf_info->kern_paddr_start = start;
>               dbgprintf("kernel load physical addr start = 0x%016Lx\n",
>                         (unsigned long long)start);
>               return 0;
>       }
> 
>      fprintf(stderr, "Cannot determine kernel physical load addr\n");
>      return -1;
> }
> 
> 
> Should we revert this commit, or update kexec/kdump code?
> 
> 
> Great respect!
> Freeman
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
