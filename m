Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-out2.uio.no ([129.240.10.58])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KTMks-00083J-1j
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 20:15:38 +0000
Subject: Re: [PATCH] kexec jump: fix compiling warning on xchg(&kexec_lock,
	0) in kernel_kexec()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <20080813124406.21091eae.akpm@linux-foundation.org>
References: <1218618760.24951.137.camel@caritas-dev.intel.com>
	<alpine.LFD.1.10.0808130956360.3462@nehalem.linux-foundation.org>
	<m1r68shjhb.fsf@frodo.ebiederm.org>
	<20080813124406.21091eae.akpm@linux-foundation.org>
Date: Wed, 13 Aug 2008 16:15:04 -0400
Message-Id: <1218658504.9042.61.camel@localhost>
Mime-Version: 1.0
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
Cc: nigel@nigel.suspend2.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, "Eric W. Biederman" <ebiederm@xmission.com>, pavel@ucw.cz, ying.huang@intel.com, mingo@elte.hu, torvalds@linux-foundation.org, vgoyal@redhat.com

On Wed, 2008-08-13 at 12:44 -0700, Andrew Morton wrote:

> - Is xchg() guaranteed to be atomic?  That's what atomic_xchg() is for.

Yes, xchg() is guaranteed to be atomic. atomic_xchg() applies only to
the atomic_t type, and is almost always #defined to xchg().

> - xchg() isn't guaranteed to exist on all architectures.  atomic_xchg() is.

You appear to be confusing xchg() with cmpxchg(). AFAIK, xchg() exists
on all architectures, and is used in several instances of generic code.
It is particularly extensively used in the networking layer.

Trond


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
