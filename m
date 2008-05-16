Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwqB8-0007MM-9l
	for kexec@lists.infradead.org; Fri, 16 May 2008 03:00:18 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1210574441.30365.8.camel@caritas-dev.intel.com>
	<20080513053408.GA5870@redhat.com>
	<1210730266.23707.50.camel@caritas-dev.intel.com>
	<20080514025607.GA19944@redhat.com>
	<1210736275.23707.62.camel@caritas-dev.intel.com>
	<m1lk2c4l4i.fsf@frodo.ebiederm.org>
	<1210827473.23707.133.camel@caritas-dev.intel.com>
	<20080516020043.GC6926@redhat.com>
	<1210904374.23707.178.camel@caritas-dev.intel.com>
Date: Thu, 15 May 2008 19:55:44 -0700
In-Reply-To: <1210904374.23707.178.camel@caritas-dev.intel.com> (Ying Huang's
	message of "Fri, 16 May 2008 10:19:34 +0800")
Message-ID: <m1tzgzez4f.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec based hibernation: a prototype of kexec multi-stage
	load
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

"Huang, Ying" <ying.huang@intel.com> writes:

> The disadvantage of this solution is that kernel B must know it is
> original kernel (A) or kexeced kernel (B). Different code should be used
> by kernel A and kernel B. And after jump from A to B, jump from B to A,
> when jump from A to B again, kernel A must use different code from the
> first time.

I don't know what the case is for keeping two kernels in memory and switching
between them.

I suspect a small piece of trampoline code between the two kernels could
handle the case. (i.e. purgatory pays attention).

That is a fundamental aspect of the design.  A general purpose infrastructure
with trampoline code to adapt it to whatever situation comes up.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
