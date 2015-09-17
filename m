Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZcWQz-0007X6-HD
 for kexec@lists.infradead.org; Thu, 17 Sep 2015 10:28:57 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2023922.x7a6gQp0x7@wuerfel>
References: <2023922.x7a6gQp0x7@wuerfel>
 <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-10-git-send-email-palmer@dabbelt.com>
 <20150915080607.GW16853@twins.programming.kicks-ass.net>
Subject: Re: [PATCH 09/13] Move bp_type_idx to kernel/event/hw_breakpoint.c
MIME-Version: 1.0
Content-ID: <16774.1442485700.1@warthog.procyon.org.uk>
Date: Thu, 17 Sep 2015 11:28:20 +0100
Message-ID: <16775.1442485700@warthog.procyon.org.uk>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: dave@sr71.net, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, dhowells@redhat.com, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, dyoung@redhat.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, jikos@kernel.org, plagnioj@jcrosoft.com, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

Arnd Bergmann <arnd@arndb.de> wrote:

> That seems unlikely to work, so I suspect it gets a different definition.
> If it uses this definition and it does work, we can probably use
> 
> #if defined(__KERNEL__) && defined(CONFIG_HAVE_MIXED_BREAKPOINTS_REGS)
> 
> but that requires a comment explaining exactly why that works.

Are you suggesting wrapping the entire construct in this within the UAPI
header?

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
