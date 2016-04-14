Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from antelope.tulip.relay.mailchannels.net ([23.83.218.4])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aqf9A-0006f5-Ir
 for kexec@lists.infradead.org; Thu, 14 Apr 2016 11:09:23 +0000
MIME-Version: 1.0
Date: Thu, 14 Apr 2016 07:07:43 -0400
From: Emrah Demir <ed@abdsec.com>
Subject: Re: Removal of the kernel code/data/bss resources does break
 kexec/kdump
In-Reply-To: <570F6D99.6090400@gmail.com>
References: <570F6D99.6090400@gmail.com>
Message-ID: <2f4d7dee6bb0e4afdc05f2b7457fcf79@abdsec.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Freeman Zhang <freeman.zhang1992@gmail.com>
Cc: kexec@lists.infradead.org, torvalds@linux-foundation.org

On 2016-04-14 06:14, Freeman Zhang wrote:
> Mr. Torvalds,
> 
> I do notice your recent commit:
> 
>> commit c4004b02f8e5b9ce357a0bb1641756cc86962664
>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>> Date:   Wed Apr 6 13:45:07 2016 -0700
>> 
>>     x86: remove the kernel code/data/bss resources from /proc/iomem
>> 
>> Let's see if anybody even notices.  I doubt anybody uses this, and it
>> does expose addresses that should be randomized, so let's just remove
>> the code.  It's old and traditional, and it used to be cute, but we
>> should have removed this long ago.
>> 
>> If it turns out anybody notices and this breaks something, we'll have 
>> to
>> revert this, and maybe we'll end up using other approaches instead
>> (using %pK or similar).  But removing unnecessary code is always the
>> preferred option.
> 
> Removal of these information causes 'kexec/kdump' to fail in the newer
> kernel, as 'kexec/arch/i386/crashdump-x86.c' is coded this way:
> 
> 
> /* Read kernel physical load addr from the file returned by 
> proc_iomem()
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

Ubuntu also has some issues with this patch. I think there are several 
issue that hasn't been noticed.
It would be better you to revert this patch. Updating kexec/kdump might 
not solve this problem.

Kees Cook proposed to write a %pK formatted patch. This would solve most 
of the problems.

https://lkml.org/lkml/2016/4/14/18

Best regards!
Emrah Demir

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
