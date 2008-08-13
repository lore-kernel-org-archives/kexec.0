Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KTN0R-00009h-EY
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 20:31:45 +0000
Date: Wed, 13 Aug 2008 13:31:24 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] kexec jump: fix compiling warning on xchg(&kexec_lock,
	0) in kernel_kexec()
In-Reply-To: <20080813132535.6cd4bab6.akpm@linux-foundation.org>
Message-ID: <alpine.LFD.1.10.0808131328380.3462@nehalem.linux-foundation.org>
References: <1218618760.24951.137.camel@caritas-dev.intel.com>
	<alpine.LFD.1.10.0808130956360.3462@nehalem.linux-foundation.org>
	<m1r68shjhb.fsf@frodo.ebiederm.org>
	<20080813124406.21091eae.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808131247320.3462@nehalem.linux-foundation.org>
	<20080813130749.c406ab6c.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808131310450.3462@nehalem.linux-foundation.org>
	<20080813132535.6cd4bab6.akpm@linux-foundation.org>
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
> 
> #2:

I thought you said there were things that want to sleep in the region?

If so, spinlocks will work as long as you don't have CONFIG_PREEMPT or 
lock validation (there's no way to deadlock thanks to all the lock getters 
using the "trylock" variant), but will blow up because a successful 
trylock will obviously also disable preemption and/or trigger all the lock 
detection.

So if there are potential sleepers, you'd need the mutex instead.

		Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
