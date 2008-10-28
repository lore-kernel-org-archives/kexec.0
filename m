Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kuuxo-0008Sf-JS
	for kexec@lists.infradead.org; Tue, 28 Oct 2008 20:14:53 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org> <490487C1.1010707@redhat.com>
	<20081026213927.GF23893@blackpad>
	<m1bpx6bxhm.fsf@frodo.ebiederm.org>
	<49058645.9010005@redhat.com> <20081027122808.GH23893@blackpad>
	<4905C9ED.807@redhat.com> <m18wsa7xl0.fsf@frodo.ebiederm.org>
	<20081028194530.GK23893@blackpad>
Date: Tue, 28 Oct 2008 13:13:03 -0700
In-Reply-To: <20081028194530.GK23893@blackpad> (Eduardo Habkost's message of
	"Tue, 28 Oct 2008 17:45:30 -0200")
Message-ID: <m18ws84gxc.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> I am still wondering if a simple function pointer (instead of a full
> notifier interface) would be good enough. It looks like a reasonable
> tradeoff.

Oh sorry.   As long as we do the whole rcu protected thing so it is safe
to call the function without taking locks it should work.  I'm not
thrilled about a function pointer but it should work.

> I think I will get flamed if I try to pull to the core a bunch of code
> that always lived in the KVM module.  8)

Why is KVM modular anyway?  That seems like some pretty core cpu functionality...

> And even if we pull those functions to the core, we will still have
> a function pointer on the new code anyway, because we would need to
> support vmx and svm.

Depending.  It doesn't sound like svm has the problem where init doesn't
work so svm really doesn't need to do this.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
