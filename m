Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JxYLy-0006uZ-Io
	for kexec@lists.infradead.org; Sun, 18 May 2008 02:10:26 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20080513053408.GA5870@redhat.com>
	<1210730266.23707.50.camel@caritas-dev.intel.com>
	<20080514025607.GA19944@redhat.com>
	<1210736275.23707.62.camel@caritas-dev.intel.com>
	<m1lk2c4l4i.fsf@frodo.ebiederm.org>
	<1210827473.23707.133.camel@caritas-dev.intel.com>
	<m1lk2bs970.fsf@frodo.ebiederm.org>
	<1210902114.23707.156.camel@caritas-dev.intel.com>
	<m14p8zgf43.fsf@frodo.ebiederm.org>
	<1210906575.23707.189.camel@caritas-dev.intel.com>
	<20080516032758.GD6926@redhat.com>
Date: Sat, 17 May 2008 18:59:58 -0700
In-Reply-To: <20080516032758.GD6926@redhat.com> (Vivek Goyal's message of
	"Thu, 15 May 2008 23:27:58 -0400")
Message-ID: <m1skwg8j8h.fsf@frodo.ebiederm.org>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>

Vivek Goyal <vgoyal@redhat.com> writes:
>
> To me this idea also looks good. So control flow will look something
> as follows?
>
> relocate_new kernel:
> 	
> 	if (!preserve_context)
> 		set registers to known state.
> 		jump to purgatory.
> 	else
> 		goto jump-back-setup:
>
> jump-back-setup:
> - Color the stack.
>   move $0xffffffff 0(%esp)
>
> - call %edx
>
> kexec_jump_back_entry:
>
> - If 0 (%esp) is not -1
> 	image->start = 0(%esp)  //Re entry point of kernel B. Store it.
>   else
> 	We returned from BIOS call. Re-entry point has not changed
>         Do nothing.
>
> - Continue to resume kernel A


That logic has more conditionals then I like but it may in
fact be reasonable.  I don't have any fundamental objections
into making this a co-routine interface.

That said.  I think immediately implementing a coroutine interface
is a premature optimization.  Please let's work on call/return.
Then prototype the coroutine method of suspend to swap and see
how much time it saves us.

Honestly I will be surprised if time will be saved, as historically
at least the bottleneck in kernel startup time is initializing
hardware, and we need to essentially redo all of that initialization.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
