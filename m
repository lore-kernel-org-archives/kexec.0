Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x241.google.com ([2607:f8b0:400e:c03::241])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aqeIr-0005rb-2H
 for kexec@lists.infradead.org; Thu, 14 Apr 2016 10:15:13 +0000
Received: by mail-pa0-x241.google.com with SMTP id k3so6455146pav.3
 for <kexec@lists.infradead.org>; Thu, 14 Apr 2016 03:14:52 -0700 (PDT)
From: Freeman Zhang <freeman.zhang1992@gmail.com>
Subject: Removal of the kernel code/data/bss resources does break kexec/kdump
Message-ID: <570F6D99.6090400@gmail.com>
Date: Thu, 14 Apr 2016 18:14:49 +0800
MIME-Version: 1.0
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
To: torvalds@linux-foundation.org
Cc: ed@abdsec.com, kexec@lists.infradead.org

Mr. Torvalds,

I do notice your recent commit:

> commit c4004b02f8e5b9ce357a0bb1641756cc86962664
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Apr 6 13:45:07 2016 -0700
>
>     x86: remove the kernel code/data/bss resources from /proc/iomem
>
> Let's see if anybody even notices.  I doubt anybody uses this, and it
> does expose addresses that should be randomized, so let's just remove
> the code.  It's old and traditional, and it used to be cute, but we
> should have removed this long ago.
>
> If it turns out anybody notices and this breaks something, we'll have to
> revert this, and maybe we'll end up using other approaches instead
> (using %pK or similar).  But removing unnecessary code is always the
> preferred option.

Removal of these information causes 'kexec/kdump' to fail in the newer
kernel, as 'kexec/arch/i386/crashdump-x86.c' is coded this way:


/* Read kernel physical load addr from the file returned by proc_iomem()
 * (Kernel Code) and store in kexec_info */
static int get_kernel_paddr(struct kexec_info *UNUSED(info),
                            struct crash_elf_info *elf_info)
{
               ...

      if (parse_iomem_single("Kernel code\n", &start, NULL) == 0) {
              elf_info->kern_paddr_start = start;
              dbgprintf("kernel load physical addr start = 0x%016Lx\n",
                        (unsigned long long)start);
              return 0;
      }

     fprintf(stderr, "Cannot determine kernel physical load addr\n");
     return -1;
}


Should we revert this commit, or update kexec/kdump code?


Great respect!
Freeman

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
