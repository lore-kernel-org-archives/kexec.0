Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZcgBV-0000o2-Kv
 for kexec@lists.infradead.org; Thu, 17 Sep 2015 20:53:38 +0000
Received: by padhk3 with SMTP id hk3so28883313pad.3
 for <kexec@lists.infradead.org>; Thu, 17 Sep 2015 13:53:16 -0700 (PDT)
Message-ID: <55fb283c.f039440a.427ff.fffff187@mx.google.com>
Date: Thu, 17 Sep 2015 13:53:16 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 03/13] Move COMPAT_ATM_ADDPARTY to net/atm/svc.c
In-Reply-To: <15268.1442483832@warthog.procyon.org.uk>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: dhowells@redhat.com
Cc: dave@sr71.net, linux-xtensa@linux-xtensa.org, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, dyoung@redhat.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, jikos@kernel.org, a.p.zijlstra@chello.nl, arnd@arndb.de, plagnioj@jcrosoft.com, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

On Thu, 17 Sep 2015 02:57:12 PDT (-0700), dhowells@redhat.com wrote:
> Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
>> +#ifdef CONFIG_COMPAT
>> +/* It actually takes struct sockaddr_atmsvc, not struct atm_iobuf */
>> +#define COMPAT_ATM_ADDPARTY _IOW('a', ATMIOC_SPECIAL+4, struct compat_atm_iobuf)
>> +#endif
>
> I wonder if it would hurt to ditch the conditionals entirely.  It only eats
> cpp namespace, not C namespace so it won't affect the output if it is not used
> because the code that uses it is compiled out.

Makes sense to me.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
