Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KTMiq-0003E4-QK
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 20:13:33 +0000
Date: Wed, 13 Aug 2008 13:13:13 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] kexec jump: fix compiling warning on xchg(&kexec_lock,
	0) in kernel_kexec()
In-Reply-To: <20080813130749.c406ab6c.akpm@linux-foundation.org>
Message-ID: <alpine.LFD.1.10.0808131310450.3462@nehalem.linux-foundation.org>
References: <1218618760.24951.137.camel@caritas-dev.intel.com>
	<alpine.LFD.1.10.0808130956360.3462@nehalem.linux-foundation.org>
	<m1r68shjhb.fsf@frodo.ebiederm.org>
	<20080813124406.21091eae.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808131247320.3462@nehalem.linux-foundation.org>
	<20080813130749.c406ab6c.akpm@linux-foundation.org>
MIME-Version: 1.0
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: nigel@nigel.suspend2.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, ebiederm@xmission.com, pavel@ucw.cz, ying.huang@intel.com, mingo@elte.hu, vgoyal@redhat.com



On Wed, 13 Aug 2008, Andrew Morton wrote:
> > 
> > Nope. That needs to be an "unsigned long".
> 
> It is.

Gaah. I just misread the patch, sorry.

> Used a bitop to preserve the runtime checking in there.  spin_unlock()
> doesn't return the previous lockedness.

Umm. spin_unlock does a lot more when you have lock debugging on, and 
doesn't do useless crap when it isn't.

> A bitop seems a better fit to me.  We never spin on that lock (it
> always uses test_and_set), so why use a "spin"lock?

..because an atomic bitop is not the same as a lock.

The memory ordering guarantees are different. Yes, they are sufficient, 
but that's because we've had to make them so to account for CRAP CODE that 
uses bit operations as if they were locks.

Don't continue that. It's WRONG.

		Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
