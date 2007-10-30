Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from www.tglx.de ([62.245.132.106])
	by bombadil.infradead.org with esmtps (Exim 4.66 #1 (Red Hat Linux))
	id 1ImfaK-0006eU-Ij
	for kexec@lists.infradead.org; Mon, 29 Oct 2007 21:08:06 -0400
Date: Tue, 30 Oct 2007 02:06:43 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Revert x86: add lapic_shutdown for x86_64
In-Reply-To: <4726753D.3010601@ct.jp.nec.com>
Message-ID: <alpine.LFD.0.9999.0710300203040.3186@localhost.localdomain>
References: <47195763.1090803@ct.jp.nec.com> <47195807.6030809@ct.jp.nec.com>
	<20071024062933.GA4622@in.ibm.com> <47266132.5050001@ct.jp.nec.com>
	<20071029161534.6e7f0db6@laptopd505.fenrus.org>
	<4726753D.3010601@ct.jp.nec.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>, Arjan van de Ven <arjan@infradead.org>

On Mon, 29 Oct 2007, Hiroshi Shimamoto wrote:

> Arjan van de Ven wrote:
> > On Mon, 29 Oct 2007 15:39:46 -0700
> > Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com> wrote:
> > 
> >> lapic_shutdown is useless on x86_64.
> >>
> > 
> > .... but since the goal is to get apic_32.c and apic_64.c to be more
> > converging (to the point of becoming the same file)... isn't your patch
> > going in the opposite direction?
> > 
> Hmm, I'm not sure that this revert affects x86 unification.
> Vivek said that probably we don't have to introduce lapic_shutdown() for 64bit.
> So I submitted this patch which reverts my previous post, it was applied before
> the comment.

Don't worry, we sort this out. There is some inevitable friction loss
for now, but we are getting closer. I gave the apic code some care to
get a readable diff out of it. Result is in:

git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git cleanup

Thanks,

	tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
