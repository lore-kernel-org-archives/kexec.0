Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UMbcq-0001U5-L9
 for kexec@lists.infradead.org; Mon, 01 Apr 2013 10:06:05 +0000
Message-ID: <51595C03.6030302@nod.at>
Date: Mon, 01 Apr 2013 12:05:55 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Re: [PATCH] purgatory: compile sha256.c only on ia64 with -O0
References: <1364763549-10790-1-git-send-email-richard@nod.at>
 <20130401050431.GJ16289@verge.net.au> <51591849.2000502@cn.fujitsu.com>
In-Reply-To: <51591849.2000502@cn.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

Simon, Zhang,

Am 01.04.2013 07:16, schrieb Zhang Yanfei:
>> I believe the above portion will break make dist my
>> causing it to omit purgatory/arch/* other than
>> purgatory/arch/$(ARCH)
>
> Ah, I've missed this in my review, too.
>
> Other than this, the change about purgatory/sha256.o below looks sound,
> right?

The dist mechanism is quite strange and error prone.
Why can't you just use git archive in the $(TARBALL) target?
I'll happily send a patch...

Back to the purgatory/sha256.o issue, I did some more tests.
First I thought memcpy() within purgatory is slow, but it isn't.
Does kexec reset the CPU so some kind of legacy mode during purgatory?
It looks like the same code in sha256.o is fast in normal user space
but very slow during purgatory.

Computing sha256 of a 9MiB blob takes less than a second in user space
and 16 seconds (with my patch). Otherwise it takes > 25 seconds.

Thanks,
//richard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
