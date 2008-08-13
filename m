Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KT8MY-0002LJ-KG
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 04:53:36 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1218510861.24951.40.camel@caritas-dev.intel.com>
	<20080812204900.db63deaa.akpm@linux-foundation.org>
Date: Tue, 12 Aug 2008 21:47:22 -0700
In-Reply-To: <20080812204900.db63deaa.akpm@linux-foundation.org> (Andrew
	Morton's message of "Tue, 12 Aug 2008 20:49:00 -0700")
Message-ID: <m1ej4tikrp.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH -v3 1/7] kexec jump: clean up #ifdef and comments
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Huang Ying <ying.huang@intel.com>, mingo@elte.hu, Linus Torvalds <torvalds@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 12 Aug 2008 11:14:21 +0800 Huang Ying <ying.huang@intel.com> wrote:
>
>>  	xchg(&kexec_lock, 0);
>
> kernel/kexec.c: In function 'kernel_kexec':
> kernel/kexec.c:1501: warning: value computed is not used

A good question is why we are warned.

> Is there any reason why we cannot use the more conventional
> test_and_set_bit() etc, rather than this peculiarity?
>
> Or perhaps spin_trylock?

Totally odd.

Let me stop and take a look and see what has been changed.  The original
code used a xchg based read copy update scheme, which was extremely
compatible with a lot of goals.  The primary one being no blocking paths
in a successful kexec, and minimal dependence on library functions.

We need that minimal dependence to handle the kexec on panic case.

That doesn't rule out something like test_and_set_bit.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
