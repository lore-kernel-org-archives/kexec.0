Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KM0fp-0004VU-0M
	for kexec@lists.infradead.org; Thu, 24 Jul 2008 13:16:01 +0000
Date: Thu, 24 Jul 2008 09:15:52 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec/kdump of a kvm guest?
Message-ID: <20080724131552.GA22243@redhat.com>
References: <170fa0d20806261158me6f81d0p2ea4fa6b7e694a5a@mail.gmail.com>
	<486F58EC.6020408@qumranet.com>
	<170fa0d20807231713t19b5bd5bt5f418f509040b7aa@mail.gmail.com>
	<D8D3E355-6D19-403B-8F61-FC15EA78851F@suse.de>
	<170fa0d20807240449n3e52c002qdb9c2626a192b0f1@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <170fa0d20807240449n3e52c002qdb9c2626a192b0f1@mail.gmail.com>
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
To: Mike Snitzer <snitzer@gmail.com>
Cc: Avi Kivity <avi@qumranet.com>, kexec@lists.infradead.org, Alexander Graf <agraf@suse.de>, kvm@vger.kernel.org

On Thu, Jul 24, 2008 at 07:49:59AM -0400, Mike Snitzer wrote:
> On Thu, Jul 24, 2008 at 4:39 AM, Alexander Graf <agraf@suse.de> wrote:
> >
> > On Jul 24, 2008, at 2:13 AM, Mike Snitzer wrote:
> >
> >> On Sat, Jul 5, 2008 at 7:20 AM, Avi Kivity <avi@qumranet.com> wrote:
> >>>
> >>> Mike Snitzer wrote:
> >>>>
> >>>> My host is x86_64 RHEL5U1 running 2.6.25.4 with kvm-70 (kvm-intel).
> >>>>
> >>>> When I configure kdump in the guest (running 2.6.22.19) and force a
> >>>> crash (with 'echo c > /proc/sysrq-trigger) kexec boots the kdump
> >>>> kernel but then the kernel hangs (before it gets to /sbin/init et al).
> >>>> On the host, the associated qemu is consuming 100% cpu.
> >>>>
> >>>> I really need to be able to collect vmcores from my kvm guests.  So
> >>>> far I can't (on raw hardware all works fine).
> >>>>
> >>>>
> >>>
> >>> I've tested this a while ago and it worked (though I tested regular
> >>> kexecs,
> >>> not crashes); this may be a regression.
> >>>
> >>> Please run kvm_stat to see what's happening at the time of the crash.
> >>
> >> OK, I can look into kvm_stat but I just discovered that just having
> >> kvm-intel and kvm loaded into my 2.6.22.19 kernel actually prevents
> >
> > Is 2.6.22.19 your host or your guest kernel? It's very unlikely that you
> > loaded kvm modules in the guest.
> 
> Correct, 2.6.22.19 is my host kernel.
> 
> >> the host from being able to kexec/kdump too!?  I didn't have any
> >> guests running (only the kvm modules were loaded).  As soon as I
> >> unloaded the kvm modules kdump worked as expected.
> >>
> >> Something about kvm is completely breaking kexec/kdump on both the
> >> host and guest kernels.
> >
> > I guess the kexec people would be pretty interested in this as well, so I'll
> > just CC them for now.
> > As you're stating that the host kernel breaks with kvm modules loaded, maybe
> > someone there could give a hint.
> 
> OK, I can try using a newer kernel on the host too (e.g. 2.6.25.x) to
> see how kexec/kdump of the host fairs when kvm modules are loaded.
> 
> On the guest side of things, as I mentioned in my original post,
> kexec/kdump wouldn't work within a 2.6.22.19 guest with the host
> running 2.6.25.4 (with kvm-70).
> 

Hi Mike,

I have never tried kexec/kdump inside a kvm guest. So I don't know if
historically they have been working or not.

Having said that, Why do we need kdump to work inside the guest? In this
case qemu should be knowing about the memory of guest kernel and should
be able to capture a kernel crash dump? I am not sure if qemu already does
that. If not, then probably we should think about it?

To me, kdump is a good solution for baremetal but not for virtualized
environment where we already have another piece of software running which
can do the job for us. We will end up wasting memory in every instance
of guest (memory reserved for kdump kernel in every guest).

It will be interesting to look at your results with 2.6.25.x kernels with
kvm module inserted. Currently I can't think what can possibly be wrong.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
