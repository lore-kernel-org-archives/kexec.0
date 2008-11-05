Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kxjyv-00075f-76
	for kexec@lists.infradead.org; Wed, 05 Nov 2008 15:07:41 +0000
Date: Wed, 5 Nov 2008 13:07:25 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 09/16] kdump: Hook emergency_virt_disable() on crash
	shutdown code
Message-ID: <20081105150725.GH5247@blackpad>
References: <1225810364-8990-1-git-send-email-ehabkost@redhat.com>
	<1225810364-8990-10-git-send-email-ehabkost@redhat.com>
	<20081105144144.GC8993@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081105144144.GC8993@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>

On Wed, Nov 05, 2008 at 09:41:44AM -0500, Vivek Goyal wrote:
> On Tue, Nov 04, 2008 at 12:52:37PM -0200, Eduardo Habkost wrote:
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  arch/x86/kernel/crash.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index d84a852..87780ba 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/kdebug.h>
> >  #include <asm/smp.h>
> >  #include <asm/reboot.h>
> > +#include <asm/virtext.h>
> >  
> >  #include <mach_ipi.h>
> >  
> > @@ -49,6 +50,7 @@ static void kdump_nmi_callback(int cpu, struct die_args *args)
> >  #endif
> >  	crash_save_cpu(regs, cpu);
> >  
> > +	emergency_virt_disable();
> >  	disable_local_APIC();
> >  }
> >  
> > @@ -80,6 +82,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> >  	local_irq_disable();
> >  
> >  	kdump_nmi_shootdown_cpus();
> > +	emergency_virt_disable();
> 
> Hi Eduardo,
> 
> It might be a good idea to put a 2-3 line comment saying why it is
> imporatant to disable virtualization here before we continue.

True. Sometimes I forget that detailed commit messages don't replace
good documentation on source code. I will do that.

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
