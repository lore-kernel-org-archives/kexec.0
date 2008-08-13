Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KTL0V-0002p2-Ox
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 18:23:41 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1218618760.24951.137.camel@caritas-dev.intel.com>
	<alpine.LFD.1.10.0808130956360.3462@nehalem.linux-foundation.org>
Date: Wed, 13 Aug 2008 11:12:48 -0700
In-Reply-To: <alpine.LFD.1.10.0808130956360.3462@nehalem.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 13 Aug 2008 09:57:33 -0700 (PDT)")
Message-ID: <m1r68shjhb.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec jump: fix compiling warning on xchg(&kexec_lock,
	0) in kernel_kexec()
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Huang Ying <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 13 Aug 2008, Huang Ying wrote:
>>
>> -	xchg(&kexec_lock, 0);
>> +	locked = xchg(&kexec_lock, 0);
>> +	BUG_ON(!locked);
>
> Why do you want to do this at all? 
>
> And why do you implement your locks with xchg() in the first place? That's 
> total and utter crap.
>
> Hint: we have _real_ locking primitives in the kernel.

This part certainly.

The way the code should work, and the way it has in the past is:
image = xchg(&kexec_image, NULL)
if (!image)
   return -EINVAL;

Very simple and very obvious and very easy to get right, and it has
been that way for years.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
