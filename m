Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KuuVs-0003GE-59
	for kexec@lists.infradead.org; Tue, 28 Oct 2008 19:46:00 +0000
Date: Tue, 28 Oct 2008 17:45:30 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 0/2] kvm: disable virtualization on kdump
Message-ID: <20081028194530.GK23893@blackpad>
References: <m1tzb2hkny.fsf@frodo.ebiederm.org> <4904676F.3020706@redhat.com>
	<m1mygre7nk.fsf@frodo.ebiederm.org>
	<490487C1.1010707@redhat.com> <20081026213927.GF23893@blackpad>
	<m1bpx6bxhm.fsf@frodo.ebiederm.org>
	<49058645.9010005@redhat.com> <20081027122808.GH23893@blackpad>
	<4905C9ED.807@redhat.com> <m18wsa7xl0.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m18wsa7xl0.fsf@frodo.ebiederm.org>
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

On Mon, Oct 27, 2008 at 10:32:43AM -0700, Eric W. Biederman wrote:
> Avi Kivity <avi@redhat.com> writes:
<snip>
> >
> > I wouldn't mind notifiers (with a nice comment explaining that you must know
> > what you're doing, though that's the case with most kernel APIs).  I'm fine with
> > either approach.
> 
> This is the 3rd request I have seen for a notifier.  This is the first
> request I have seen for code that must be executed in the kexec on
> panic path.  So history suggest to me that notifiers make it
> unreasonably easy to get code onto the kexec on panic code path.
> 
> Occasionally the kexec on panic code path is tested to see how
> well it works in strange situations like being called from
> a stack overflow etc.
> 
> The rest of the history is that previous attempts like lkcd
> had very programmer friendly interfaces, that worked fine
> in test environments giving beautiful core dumps, but when things
> broke in the field they were essentially useless.  The kdump
> approach is still not completely reliable but it does work
> well enough that people get useful crash dumps sometimes.
> 
> I feel anything that makes the kexec on panic code path harder
> to verify it will work when things are crazy broken, like
> a notifier is something we should avoid.

I am still wondering if a simple function pointer (instead of a full
notifier interface) would be good enough. It looks like a reasonable
tradeoff.

I think I will get flamed if I try to pull to the core a bunch of code
that always lived in the KVM module.  8)

And even if we pull those functions to the core, we will still have
a function pointer on the new code anyway, because we would need to
support vmx and svm.

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
