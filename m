Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KxmYx-0003yl-Jx
	for kexec@lists.infradead.org; Wed, 05 Nov 2008 17:53:04 +0000
Date: Wed, 5 Nov 2008 15:52:35 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 08/16] x86: Emergency virtualization disable function
Message-ID: <20081105175235.GJ5247@blackpad>
References: <1225810364-8990-1-git-send-email-ehabkost@redhat.com>
	<1225810364-8990-9-git-send-email-ehabkost@redhat.com>
	<m1bpwu3wod.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1bpwu3wod.fsf@frodo.ebiederm.org>
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

On Wed, Nov 05, 2008 at 09:33:06AM -0800, Eric W. Biederman wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > +int set_virt_disable_func(void (*fn)(void))
> > +{
> > +	int r = 0;
> > +
> > +	spin_lock(&virt_disable_lock);
> > +	if (!virt_disable_fn)
> > +		rcu_assign_pointer(virt_disable_fn, fn);
> > +	else
> > +		r = -EEXIST;
> > +	spin_unlock(&virt_disable_lock);
> > +
> > +	return r;
> > +}
> > +EXPORT_SYMBOL(set_virt_disable_func);
> 
> EXPORT_SYMBOL_GPL?
> 
> > +EXPORT_SYMBOL(clear_virt_disable_func);
> EXPORT_SYMBOL_GPL?
> 
> We are talking a core internal api that should not even
> be exported if KVM is compiled into the kernel.
> 
> I have had to tell people NO too many times by that
> wanted to shove code on the kexec on panic path that
> had no business there.  I do not want to give
> the least little impression that this is an ok hook
> for the to use.  The very specific name helps in
> that regard thank you for that.  Having the symbol
> exported GPL would help even more.

Agreed. I will change that if nobody else objects.

> 
> Overall I think the code is just barely ok.
> 
> I don't like the fact that to run 2-3 instructions per cpu we are two
> function pointers deep.  It feels like we have an excess of
> abstraction here on the kvm side.
> 
> Is it possible to have the individual kvm modules call
> set_virt_disable_func and clear_virt_disable_func?  Instead
> of going through the x86_kvm_ops?
> 
> It really feels like we have an excess of abstraction here.

We could move the set_virt_disable_func() calls to vmx.c and svm.c (on
hardware_setup/hardware_unsetup). One could argue that it is sort of a
coincidence that we need the code for both vmx and svm.

Avi, what do you think?

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
