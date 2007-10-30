Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by bombadil.infradead.org with esmtp (Exim 4.66 #1 (Red Hat Linux))
	id 1ImecL-0003SI-9V
	for kexec@lists.infradead.org; Mon, 29 Oct 2007 20:06:08 -0400
Message-ID: <4726753D.3010601@ct.jp.nec.com>
Date: Mon, 29 Oct 2007 17:05:17 -0700
From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Revert x86: add lapic_shutdown for x86_64
References: <47195763.1090803@ct.jp.nec.com>	<47195807.6030809@ct.jp.nec.com>	<20071024062933.GA4622@in.ibm.com>	<47266132.5050001@ct.jp.nec.com>
	<20071029161534.6e7f0db6@laptopd505.fenrus.org>
In-Reply-To: <20071029161534.6e7f0db6@laptopd505.fenrus.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, tglx@linutronix.de

Arjan van de Ven wrote:
> On Mon, 29 Oct 2007 15:39:46 -0700
> Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com> wrote:
> 
>> lapic_shutdown is useless on x86_64.
>>
> 
> .... but since the goal is to get apic_32.c and apic_64.c to be more
> converging (to the point of becoming the same file)... isn't your patch
> going in the opposite direction?
> 
Hmm, I'm not sure that this revert affects x86 unification.
Vivek said that probably we don't have to introduce lapic_shutdown() for 64bit.
So I submitted this patch which reverts my previous post, it was applied before
the comment.

Thanks
Hiroshi Shimamoto

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
