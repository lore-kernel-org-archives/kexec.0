Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KTJjV-0005J1-OG
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 17:02:02 +0000
Date: Wed, 13 Aug 2008 10:01:13 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] kexec jump: fix compiling warning on xchg(&kexec_lock,
	0) in kernel_kexec()
In-Reply-To: <20080813022712.4bea5fea.akpm@linux-foundation.org>
Message-ID: <alpine.LFD.1.10.0808130958220.3462@nehalem.linux-foundation.org>
References: <1218618760.24951.137.camel@caritas-dev.intel.com>
	<20080813022712.4bea5fea.akpm@linux-foundation.org>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Huang Ying <ying.huang@intel.com>, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>



On Wed, 13 Aug 2008, Andrew Morton wrote:
>
> We don't need to create that local.  I queued this:

No, please don't. 

Just don't take this whole patch-series until it's cleaned up. There is 
absolutely no excuse for using xchg as a locking primitive. Nothing like 
this should be queued anywhere, it should be burned and the ashes should 
be scattered over the atlantic so that nobody will ever see them again.

F*ck me with a spoon, if you have to use xchg() to do a trylock, why the 
hell isn't the unlock sequence then

	smp_mb();
	var = 0;

instead? Not that that's really right either, but at least it avoids the 
_ridiculous_ crap. The real solution is probably to use a spinlock and 
trylock/unlock.

		Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
