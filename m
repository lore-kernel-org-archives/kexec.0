Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KuUMO-000762-KA
	for kexec@lists.infradead.org; Mon, 27 Oct 2008 15:50:28 +0000
Date: Mon, 27 Oct 2008 13:50:03 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
Message-ID: <20081027155003.GM23893@blackpad>
References: <20081023194129.GD27959@blackpad>
	<20081023222906.GB10753@verge.net.au>
	<m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org>
	<490487C1.1010707@redhat.com> <20081026213927.GF23893@blackpad>
	<m1bpx6bxhm.fsf@frodo.ebiederm.org> <49058645.9010005@redhat.com>
	<m1skqi9iy9.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1skqi9iy9.fsf@frodo.ebiederm.org>
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
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Mon, Oct 27, 2008 at 08:05:50AM -0700, Eric W. Biederman wrote:
> Avi Kivity <avi@redhat.com> writes:
> 
> > There's no way to query whether vmx is enabled or disabled, AFAICT.  So we have
> > to execute vmxoff and ignore possible #UDs.
> >
> > If we trust the exception handlers, there's no problem.  Otherwise we need to
> > replace the current #UD handler with an iret (perhaps switching temporarily to
> > another IDT).
> 
> Ugh.  We already change the IDT on that code path so that
> may be a way to go.

I don't see the IDT being changed on native_machine_shutdown(). It even
uses notifier chain registration (register_die_notifier()) to sneak a
NMI handler in.

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
