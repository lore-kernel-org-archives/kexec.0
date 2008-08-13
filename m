Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KTJfZ-0002JT-0f
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 16:57:57 +0000
Date: Wed, 13 Aug 2008 09:57:33 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] kexec jump: fix compiling warning on xchg(&kexec_lock,
	0) in kernel_kexec()
In-Reply-To: <1218618760.24951.137.camel@caritas-dev.intel.com>
Message-ID: <alpine.LFD.1.10.0808130956360.3462@nehalem.linux-foundation.org>
References: <1218618760.24951.137.camel@caritas-dev.intel.com>
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
To: Huang Ying <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>



On Wed, 13 Aug 2008, Huang Ying wrote:
>
> -	xchg(&kexec_lock, 0);
> +	locked = xchg(&kexec_lock, 0);
> +	BUG_ON(!locked);

Why do you want to do this at all? 

And why do you implement your locks with xchg() in the first place? That's 
total and utter crap.

Hint: we have _real_ locking primitives in the kernel.

			Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
