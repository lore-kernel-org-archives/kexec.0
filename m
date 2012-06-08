Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Sd37L-0000pJ-J3
 for kexec@lists.infradead.org; Fri, 08 Jun 2012 17:37:00 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <20120608151936.GE29471@redhat.com> (Vivek Goyal's message of
 "Fri, 8 Jun 2012 11:19:36 -0400")
References: <20120608134315.GA29791@redhat.com>
 <20120608134801.GZ24904@tucnak.redhat.com>
 <20120608143949.GC29471@redhat.com>
 <20120608145113.GB24904@tucnak.redhat.com>
 <20120608151936.GE29471@redhat.com>
Date: Fri, 08 Jun 2012 10:36:04 -0700
Message-ID: <873965aepn.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] ppc/ppc64: Compile purgatory code with gcc option
 -msoft-float
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Jakub Jelinek <jakub@redhat.com>, Lingzhu Xiang <lxiang@redhat.com>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, "Suzuki K. Poulose" <suzuki@in.ibm.com>, Jeremy Kerr <jk@ozlabs.org>

Vivek Goyal <vgoyal@redhat.com> writes:

> On Fri, Jun 08, 2012 at 04:51:13PM +0200, Jakub Jelinek wrote:
>> On Fri, Jun 08, 2012 at 10:39:49AM -0400, Vivek Goyal wrote:
>> > BTW, What does -mcmodel do and why should we use -mcmodel? purgatory, is a
>> > separate binary which we reloate at turn time based on physical memory
>> > location. IOW, why should we make any assumptions about running location
>> > of purgatory and pass -mcmodel flag.
>> 
>> The default x86_64 -mcmodel=small requires that the binary (and all
>> corresponding data (rodata etc.) sections must be within the low 2GB of
>> address space.  Kernel code is usually in the topmost 2GB of address space,
>> and -mcmodel=kernel is the memory model for that (all code and all other
>> sections must be in topmost 2GB of address space).  Of course pointers
>> are 64-bit in both cases, so any memory you access solely through pointers,
>> not through symbols, can be anywhere.  Haven't looked at where purgatory
>> relocates itself into the address space.
>
> IIRC, by the time purgatory runs we turn the paging off and we are
> operating in protected mode. And by that time purgatory is running from
> low 2GB of address space.
>
> It is relocated by kexec-tools itself before it calls kernel. So in
> user space we decide a physical address where purgatory can be run
> from. Relocate this binary so that it can run from that address and
> then call kernel to load this binary at this address. (Kernel might
> store the binary at some other location but it is moved to it final
> destination just before kexec and just before we jump to it).
>
> Relocation happens here.
>
> kexec-tools/kexec/arch/i386/kexec-bzImage.c
>
> ***********************************************************************
>
>         /* Load the trampoline.  This must load at a higher address
>          * the the argument/parameter segment or the kernel will stomp
>          * it's gdt.
>          *
>          * x86_64 purgatory code has got relocations type R_X86_64_32S
>          * that means purgatory got to be loaded within first 2G otherwise
>          * overflow takes place while applying relocations.
>          */
>         if (!real_mode_entry && relocatable_kernel)
>                 elf_rel_build_load(info, &info->rhdr, purgatory,
> purgatory_size,
>                                         0x3000, 0x7fffffff, -1, 0);
>         else
>                 elf_rel_build_load(info, &info->rhdr, purgatory,
> purgatory_size,
>                                         0x3000, 640*1024, -1, 0);
>         dbgprintf("Loaded purgatory at addr 0x%lx\n",
> info->rhdr.rel_addr);
>
> *************************************************************************
>
> So at this point of time, it does not look like that we should be passing
> -mcmodel for purgatory code.

I agree.  The current purgatory code very much makes sense with
-mcmodel=small.  However ideally purgatory would be compiled like a
shared library and able to live anywhere in the lower half of the
64bit address space.  

>> -mno-sse -mno-mmx will tell gcc not to use any %mmX or %xmmX registers.
>> i?86 also passes -msoft-float in addition to -mno-sse -mno-mmx I think.
>> 
>
> Yes, i386 is also passing -msoft-float in kernel. Personally I have no
> issues in adding -mno-sse and -mno-mmx and -msoft-float for i386. It is
> that kind of thing that one gets the motivation to change these flags
> once something breaks down.

I didn't think there was enough code in purgatory for there to be these
kinds of issues but we should definitely do something like this.  If
there was actually an advantage to using sse or mmx we might actually be
able to use them on x86_64 as we don't have the kernels task switching
reasons not to use them.  But still it is probably easier to tell gcc
not to bother.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
