Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KxmWt-0005TI-4O
	for kexec@lists.infradead.org; Wed, 05 Nov 2008 17:50:55 +0000
Date: Wed, 5 Nov 2008 15:50:05 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 15/16] kvm: x86: set kdump virt_disable function on
	initialization
Message-ID: <20081105175004.GI5247@blackpad>
References: <1225810364-8990-1-git-send-email-ehabkost@redhat.com>
	<1225810364-8990-16-git-send-email-ehabkost@redhat.com>
	<m1od0u3wyq.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1od0u3wyq.fsf@frodo.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

On Wed, Nov 05, 2008 at 09:26:53AM -0800, Eric W. Biederman wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > Finally implement the virt_disable function for kdump. It will call
> > kvm_x86_ops->crash_hardware_disable(), that will disable virtualization
> > extensions on the CPU if it is not disabled yet.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  arch/x86/kvm/x86.c |   19 ++++++++++++++++++-
> >  1 files changed, 18 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 049c6a0..9e61baf 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -40,6 +40,7 @@
> >  #include <asm/msr.h>
> >  #include <asm/desc.h>
> >  #include <asm/mtrr.h>
> > +#include <asm/virtext.h>
> >  
> >  #define MAX_IO_MSRS 256
> >  #define CR0_RESERVED_BITS						\
> > @@ -2581,6 +2582,13 @@ int kvm_emulate_pio_string(struct kvm_vcpu *vcpu, struct
> > kvm_run *run, int in,
> >  }
> >  EXPORT_SYMBOL_GPL(kvm_emulate_pio_string);
> >  
> > +/* Called at crash time, so we can disable virtualization if needed
> > + */
> > +static void crash_hardware_disable(void)
> > +{
> > +	kvm_x86_ops->crash_hardware_disable(NULL);
> > +}
> > +
> >  int kvm_arch_init(void *opaque)
> >  {
> >  	int r;
> > @@ -2605,9 +2613,15 @@ int kvm_arch_init(void *opaque)
> >  
> >  	kvm_x86_ops = ops;
> >  
> > +	r = set_virt_disable_func(crash_hardware_disable);
> 
> Can we make this say:
> set_virt_disable_func(kvm_x86_ops->crash_hardware_disable);
> 
> So we can avoid going through 2 levels of function pointers?
> I find that a little scary in code that might be running
> at the edge of stack overflow.

When I've checked this (on x86_64), gcc did tail recursion optimization
and the call was just a jump to the function, so stack usage shouldn't
be a problem.

But I am inclined to agree with you about the excess of abstraction.

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
