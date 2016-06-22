Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x236.google.com ([2607:f8b0:400e:c03::236])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFb7y-0005xm-VR
 for kexec@lists.infradead.org; Wed, 22 Jun 2016 05:55:08 +0000
Received: by mail-pa0-x236.google.com with SMTP id wo6so13548959pac.3
 for <kexec@lists.infradead.org>; Tue, 21 Jun 2016 22:54:46 -0700 (PDT)
Date: Wed, 22 Jun 2016 14:59:41 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v19 10/13] arm64: kdump: add VMCOREINFO's for user-space
 coredump tools
Message-ID: <20160622055940.GY20774@linaro.org>
References: <cover.1466120418.git.geoff@infradead.org>
 <6e96110e85e7b1167043d789e85f9c916fdf281a.1466120418.git.geoff@infradead.org>
 <20160620053222.GB14309@dhcppc9>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160620053222.GB14309@dhcppc9>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, James Morse <james.morse@arm.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 20, 2016 at 11:02:22AM +0530, Pratyush Anand wrote:
> +Atsushi
> 
> Hi Takahiro,
> 
> On 16/06/2016:11:48:28 PM, Geoff Levand wrote:
> > From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > 
> > For the current crash utility, we need to know, at least,
> >   - kimage_voffset
> >   - PHYS_OFFSET
> > to handle the contents of core dump file (/proc/vmcore) correctly due to
> > the introduction of KASLR (CONFIG_RANDOMIZE_BASE) in v4.6.
> > This patch puts them as VMCOREINFO's into the file.
> > 
> >   - VA_BITS
> > is also added for makedumpfile command.
> 
> Thanks for adding them. They are quite helpful for makedumpfile as well.
> 
> > More VMCOREINFO's may be added later.
> 
> Yes, we will need to pass VMCOREINFO_SYMBOL(_text) and VMCOREINFO_SYMBOL(_end)
> in order to work with makedumpfile.

I know that adding those symbols is the easiest way, but
theoretically, if we know the physical address of "swapper_pg_dir",
instead of its virtual address, we can access all the memory pointed to
by any kernel virtual address.
How do you rationalize that we need to know "_text" and "_end"?

Thanks,
-Takahiro AKASHI

> I already have makedumpfile patches [1]  which uses _text and _end, but not
> sending them to makedumpfile upstream, until you will be agreeing to take [2] in
> future. Please let me know your opinion about it. If it would be acceptable then
> I may send aarch64 makedumpfile improvements to upstream.
> 
> [1] https://github.com/pratyushanand/makedumpfile/commit/d9590fec049976b8fee0d6b4e66e6f3e99ff1113
> [2] https://github.com/pratyushanand/linux/commit/1d94df20c575c725910c9c29a129b9f14e7e900b
> 
> ~Pratyush
> 
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  arch/arm64/kernel/machine_kexec.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index f270967..57a30fb 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -18,6 +18,7 @@
> >  
> >  #include <asm/cacheflush.h>
> >  #include <asm/cpu_ops.h>
> > +#include <asm/memory.h>
> >  #include <asm/mmu_context.h>
> >  
> >  #include "cpu-reset.h"
> > @@ -278,3 +279,13 @@ void machine_crash_shutdown(struct pt_regs *regs)
> >  
> >  	pr_info("Starting crashdump kernel...\n");
> >  }
> > +
> > +void arch_crash_save_vmcoreinfo(void)
> > +{
> > +	VMCOREINFO_NUMBER(VA_BITS);
> > +	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
> > +	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
> > +						kimage_voffset);
> > +	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
> > +						PHYS_OFFSET);
> > +}
> > -- 
> > 2.5.0
> > 
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
