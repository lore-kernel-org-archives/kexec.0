Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwOrl-0007tQ-4J
	for kexec@lists.infradead.org; Wed, 14 May 2008 21:50:29 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1210574441.30365.8.camel@caritas-dev.intel.com>
	<20080513053408.GA5870@redhat.com>
	<1210730266.23707.50.camel@caritas-dev.intel.com>
	<20080514025607.GA19944@redhat.com>
	<1210736275.23707.62.camel@caritas-dev.intel.com>
Date: Wed, 14 May 2008 14:43:41 -0700
In-Reply-To: <1210736275.23707.62.camel@caritas-dev.intel.com> (Ying Huang's
	message of "Wed, 14 May 2008 11:37:55 +0800")
Message-ID: <m1lk2c4l4i.fsf@frodo.ebiederm.org>
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

>> So, IMHO, for first simple implementation, we don't have to pass around
>> any data between kernels except entry point. (Please correct me if I am 
>> wrong). Lets get that implementation in first and then we can get rest
>> of the pieces in place.
>
> Yes. Kernel entry/re-entry point is the only information need to be
> communicated between kernels for just switching between them. So we can
> focus on kexec jump patch firstly.

Then as a preliminary design let's plan on this.

- Pass the rentry point as the return address (using the C ABI).
  We may want to load the stack pointer etc so we can act as
  a direct entry point for new code.

- Look at passing a pointer to the mapping of pages that the kexec
  trampoline uses in arg1 of the C ABI.  Largely the format is defacto
  fixed anyway because we need to pass the structure from C to
  assembly.

Using the standard C ABI makes things much it much easier to pick
a calling convention, and to document it.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
