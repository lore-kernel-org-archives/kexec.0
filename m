Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KTMNj-0000Fn-El
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 19:51:43 +0000
Date: Wed, 13 Aug 2008 12:50:57 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] kexec jump: fix compiling warning on xchg(&kexec_lock,
	0) in kernel_kexec()
In-Reply-To: <20080813124406.21091eae.akpm@linux-foundation.org>
Message-ID: <alpine.LFD.1.10.0808131247320.3462@nehalem.linux-foundation.org>
References: <1218618760.24951.137.camel@caritas-dev.intel.com>
	<alpine.LFD.1.10.0808130956360.3462@nehalem.linux-foundation.org>
	<m1r68shjhb.fsf@frodo.ebiederm.org>
	<20080813124406.21091eae.akpm@linux-foundation.org>
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
Cc: nigel@nigel.suspend2.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, "Eric W. Biederman" <ebiederm@xmission.com>, pavel@ucw.cz, ying.huang@intel.com, mingo@elte.hu, vgoyal@redhat.com



On Wed, 13 Aug 2008, Andrew Morton wrote:
> - * in interrupt context :)
> + * Return true if we acquired the lock
>   */
> -static int kexec_lock;
> +static inline bool kexec_trylock(void)
> +{
> +	return !test_and_set_bit(0, &kexec_bitlock);

Nope. That needs to be an "unsigned long".

But more importantl, why not just make it a lock in the first place?

	static DEFINE_SPINLOCK(kexec_lock);

	#define kexec_trylock() spin_trylock(&kexec_lock)
	#define kexec_unlock() spin_unlock(&kexec_lock)

and then you get it all right and clear and obvious.

Yeah, and I didn't check whether there is anything that is supposed to be 
able to sleep. If there is, use a mutex instead of a spinlock, of course.

		Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
