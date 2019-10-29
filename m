Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPKx4-00056c-Hl
 for kexec@lists.infradead.org; Tue, 29 Oct 2019 06:25:59 +0000
Date: Tue, 29 Oct 2019 14:25:43 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/2 v7] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
Message-ID: <20191029062543.GC7616@MiWiFi-R3L-srv>
References: <20191029021059.22070-1-lijiang@redhat.com>
 <20191029021059.22070-2-lijiang@redhat.com>
 <20191029052842.GA7616@MiWiFi-R3L-srv>
 <ffb0d2d3-31c3-fba0-e0f4-bd48999a033e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ffb0d2d3-31c3-fba0-e0f4-bd48999a033e@redhat.com>
Content-Disposition: inline
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
To: lijiang <lijiang@redhat.com>
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, horms@verge.net.au, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, d.hatayama@fujitsu.com, vgoyal@redhat.com

On 10/29/19 at 02:06pm, lijiang wrote:
> >>  struct crash_memmap_data {
> >> @@ -68,6 +70,19 @@ static inline void cpu_crash_vmclear_loaded_vmcss(void)
> >>  	rcu_read_unlock();
> >>  }
> >>  
> >> +/*
> >> + * When the crashkernel option is specified, only use the low
> >> + * 1MiB for the real mode trampoline.
> >> + */
> >> +void __init kexec_reserve_low_1MiB(void)
> > 
> > Thanks for the effort, Lianbo. I believe everyone is confident with this
> > solution and fix.
> > 
> > I have a tiny concern, why the function name is
> > kexec_reserve_low_1MiB(), but not kexec_reserve_low_1M()?
> 
> Thanks for your comment, Baoquan.
> 
> It means that kernel will reserve 1M 'Byte' memory, the function name does not
> have special meaning.
> 
> Would you mind if i change it to the crash_reserve_low_1M()?

Yes, crash_xx looks better since it's only related to crash dumping. As
for 1M, not very sure, see if other people have comment about it. Anyway,
crash_reserve_low_1M() looks good to me. Thanks.

> 
> void __init crash_reserve_low_1M(void)
> 
> Thanks.
> Lianbo
> 
> > I searched in kernel code with below filter, didn't see MiB appearing in
> > a function name. I am not sure about it either, just ask.
> > 
> > git grep "_[1-9]*M " arch/ kernel/ mm include/ drivers/ net/ init fs crypto/ certs/ ipc lib
> > 
> > Thanks
> > Baoquan
> > 
> >> +{
> >> +	if (cmdline_find_option(boot_command_line, "crashkernel",
> >> +				NULL, 0) > 0) {
> >> +		memblock_reserve(0, 1<<20);
> >> +		pr_info("Reserving the low 1MiB of memory for crashkernel\n");
> >> +	}
> >> +}
> >> +
> >>  #if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
> >>  
> >>  static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
> >> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> >> index 7dce39c8c034..b8bbd0017ca8 100644
> >> --- a/arch/x86/realmode/init.c
> >> +++ b/arch/x86/realmode/init.c
> >> @@ -8,6 +8,7 @@
> >>  #include <asm/pgtable.h>
> >>  #include <asm/realmode.h>
> >>  #include <asm/tlbflush.h>
> >> +#include <asm/crash.h>
> >>  
> >>  struct real_mode_header *real_mode_header;
> >>  u32 *trampoline_cr4_features;
> >> @@ -34,6 +35,7 @@ void __init reserve_real_mode(void)
> >>  
> >>  	memblock_reserve(mem, size);
> >>  	set_real_mode_mem(mem);
> >> +	kexec_reserve_low_1MiB();
> >>  }
> >>  
> >>  static void __init setup_real_mode(void)
> >> -- 
> >> 2.17.1
> >>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
