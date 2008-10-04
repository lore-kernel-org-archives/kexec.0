Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-outbound-2.vmware.com ([65.115.85.73])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Klzx4-0000Uy-Va
	for kexec@lists.infradead.org; Sat, 04 Oct 2008 05:45:15 +0000
Subject: Re: kexec with vmware esx 3.0.2
From: Zachary Amsden <zach@vmware.com>
In-Reply-To: <86802c440810031645m5a09c243se072cbcc6f2a151d@mail.gmail.com>
References: <86802c440810031408i60e2036ax805bfd997092cd86@mail.gmail.com>
	<1223068893.7330.117.camel@bodhitayantram.eng.vmware.com>
	<86802c440810031440o59359f30ka72230b4b0ff73e@mail.gmail.com>
	<1223070521.7330.122.camel@bodhitayantram.eng.vmware.com>
	<86802c440810031458s1ce79589s2448aa0869a74e21@mail.gmail.com>
	<1223071731.7330.127.camel@bodhitayantram.eng.vmware.com>
	<86802c440810031551g246232c9n520ef43c6881b8af@mail.gmail.com>
	<1223074735.7330.138.camel@bodhitayantram.eng.vmware.com>
	<86802c440810031645m5a09c243se072cbcc6f2a151d@mail.gmail.com>
Date: Fri, 03 Oct 2008 22:41:25 -0700
Message-Id: <1223098885.7330.157.camel@bodhitayantram.eng.vmware.com>
Mime-Version: 1.0
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: Alok Kataria <akataria@vmware.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 2008-10-03 at 16:45 -0700, Yinghai Lu wrote:
> On Fri, Oct 3, 2008 at 3:58 PM, Zachary Amsden <zach@vmware.com> wrote:
> > On Fri, 2008-10-03 at 15:51 -0700, Yinghai Lu wrote:
> >
> >> ok, my question is: anyone tried to use kexec with vmware?
> >
> > Do you mean has anyone tried to use kexec in Linux running under VMware,
> 
> that should work

It does.

> > or do you mean has anyone tried to use kexec to start ESX?
> 
> yeah, that is strange request. hope it work..

Well you're a braver soul than me.  If your hardware is really so horked
you can't boot Linux without noacpi, I seriously doubt the vmkernel will
run properly.  You might be able to kexec the Linux pre-bootstrapping
bit, the the vmkernel is not even close to the same code lineage and has
a limited and very fixed set of hardware requirements.  And you are
talking about fixing up the MP table and interfering with the custom
boot process?  I would not for any amount of money want to find out what
kind of squirrels are hiding in that nest.

I mean can you run Oracle on an overclocked budget brand laptop?  Well,
maybe.

But you're talking about running an enterprise class application on
dodgy hardware, and that is seriously stretching the realms of sanity.

I kinda don't think this is really interesting to the folks on LKML, you
could try asking over on the VMware forums.

Good luck,

Zach


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
