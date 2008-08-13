Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KT8E9-0005es-Ia
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 04:44:54 +0000
Subject: Re: [PATCH -v3 1/7] kexec jump: clean up #ifdef and comments
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <20080812204900.db63deaa.akpm@linux-foundation.org>
References: <1218510861.24951.40.camel@caritas-dev.intel.com>
	<20080812204900.db63deaa.akpm@linux-foundation.org>
Date: Wed, 13 Aug 2008 12:44:49 +0800
Message-Id: <1218602689.24951.89.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, mingo@elte.hu, Linus Torvalds <torvalds@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, 2008-08-12 at 20:49 -0700, Andrew Morton wrote:
> On Tue, 12 Aug 2008 11:14:21 +0800 Huang Ying <ying.huang@intel.com> wrote:
> 
> >  	xchg(&kexec_lock, 0);
> 
> kernel/kexec.c: In function 'kernel_kexec':
> kernel/kexec.c:1501: warning: value computed is not used
> 
> Is there any reason why we cannot use the more conventional
> test_and_set_bit() etc, rather than this peculiarity?
> 
> Or perhaps spin_trylock?

Hi, Andrew,

I think it is of no problem to replace xchg() with test_and_set_bit() or
spin_trylock().

Hi, Eric,

Do you have some reason to use xchg() instead of others?

Best Regards,
Huang Ying



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
