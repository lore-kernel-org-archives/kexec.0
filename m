Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kv7OX-0004SG-UN
	for kexec@lists.infradead.org; Wed, 29 Oct 2008 09:31:18 +0000
Message-ID: <49082D60.9010904@redhat.com>
Date: Wed, 29 Oct 2008 11:31:12 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
References: <m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org>
	<490487C1.1010707@redhat.com> <20081026213927.GF23893@blackpad>
	<m1bpx6bxhm.fsf@frodo.ebiederm.org>
	<49058645.9010005@redhat.com> <20081027122808.GH23893@blackpad>
	<4905C9ED.807@redhat.com> <m18wsa7xl0.fsf@frodo.ebiederm.org>
	<20081028194530.GK23893@blackpad>
In-Reply-To: <20081028194530.GK23893@blackpad>
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
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

Eduardo Habkost wrote:
> I think I will get flamed if I try to pull to the core a bunch of code
> that always lived in the KVM module.  8)
>   

Having a simple api to enter vmx or svm mode in core code should not be 
too bad.  The kvm hardware_enable() stuff could simply call that.  The 
only downsides I see are a very minor bloat to the core, and spreading 
kvm code around.

> And even if we pull those functions to the core, we will still have
> a function pointer on the new code anyway, because we would need to
> support vmx and svm.
>   

Or have an if () statement there.

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
