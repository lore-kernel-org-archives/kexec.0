Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZcVwv-0000Ss-Sa
 for kexec@lists.infradead.org; Thu, 17 Sep 2015 09:57:54 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1442271047-4908-4-git-send-email-palmer@dabbelt.com>
References: <1442271047-4908-4-git-send-email-palmer@dabbelt.com>
 <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
Subject: Re: [PATCH 03/13] Move COMPAT_ATM_ADDPARTY to net/atm/svc.c
MIME-Version: 1.0
Content-ID: <15267.1442483832.1@warthog.procyon.org.uk>
Date: Thu, 17 Sep 2015 10:57:12 +0100
Message-ID: <15268.1442483832@warthog.procyon.org.uk>
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
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: dave@sr71.net, linux-xtensa@linux-xtensa.org, dhowells@redhat.com, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, dyoung@redhat.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, jikos@kernel.org, a.p.zijlstra@chello.nl, arnd@arndb.de, plagnioj@jcrosoft.com, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

Palmer Dabbelt <palmer@dabbelt.com> wrote:

> +#ifdef CONFIG_COMPAT
> +/* It actually takes struct sockaddr_atmsvc, not struct atm_iobuf */
> +#define COMPAT_ATM_ADDPARTY _IOW('a', ATMIOC_SPECIAL+4, struct compat_atm_iobuf)
> +#endif

I wonder if it would hurt to ditch the conditionals entirely.  It only eats
cpp namespace, not C namespace so it won't affect the output if it is not used
because the code that uses it is compiled out.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
