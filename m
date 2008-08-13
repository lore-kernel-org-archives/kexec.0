Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KTKdC-0004gT-Au
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 17:59:34 +0000
Date: Wed, 13 Aug 2008 19:59:15 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] kexec jump: fix compiling warning on xchg(&kexec_lock,
	0) in kernel_kexec()
Message-ID: <20080813175915.GA3938@elte.hu>
References: <1218618760.24951.137.camel@caritas-dev.intel.com>
	<20080813022712.4bea5fea.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808130958220.3462@nehalem.linux-foundation.org>
	<20080813102504.7ce478eb.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080813102504.7ce478eb.akpm@linux-foundation.org>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Huang Ying <ying.huang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>


* Andrew Morton <akpm@linux-foundation.org> wrote:

> > instead? Not that that's really right either, but at least it avoids 
> > the _ridiculous_ crap. The real solution is probably to use a 
> > spinlock and trylock/unlock.
> 
> Or test_and_set_bit().  That's what I've been saying too, only 
> differently ;)
> 
> But cleaning up the long-standing silly usage of xchg() is a different 
> activity from suppressing this recently-added compile warning.

actually, in this case i disagree: the warning here is a canary that 
there's something wrong about this code - i.e. gcc is _right_ about 
warning us. The warning is also totally harmless - the warning shows us 
the suckiness of the code structure - and squashing the warning doesnt 
fix that.

So im coal-mine analogies, i disagree with squashing the canary, we 
should find and fix the shaft that emits the smelly methane instead ;-)

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
