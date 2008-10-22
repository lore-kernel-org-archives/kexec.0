Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KscQF-0003FN-Db
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 12:02:43 +0000
Date: Wed, 22 Oct 2008 14:02:22 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86: make oops_begin and oops_end equal
Message-ID: <20081022120222.GE8095@elte.hu>
References: <20081017210013.GD23591@hmsreliant.think-freely.org>
	<20081020121339.GE10594@elte.hu>
	<20081020134211.GA15574@hmsreliant.think-freely.org>
	<20081020150731.GA25999@mailshack.com>
	<20081020150834.GA26018@mailshack.com>
	<20081021144505.GA25750@hmsreliant.think-freely.org>
	<1224670721.25843.1280616145@webmail.messagingengine.com>
	<20081022104513.GA18951@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081022104513.GA18951@hmsreliant.think-freely.org>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alexander van Heukelum <heukelum@mailshack.com>, Andrew Morton <akpm@linux-foundation.org>, vgoyal@redhat.com


* Neil Horman <nhorman@tuxdriver.com> wrote:

> > Thanks for the review. I've sent a redone patch series just a moment 
> > ago, based on your comments. There was also another problem with 
> > these two patches: oops_end(flags, regs, signr) had special 
> > behaviour for regs=NULL that I did not consider before. The series 
> > has grown due to this issue...

[...]
> Copy that.  Thanks for the quick turn-around.

applied to tip/x86/dumpstack, thanks guys!

Could you please also create arch/x86/kernel/dumpstack.c and move all 
the now-unified bits there - before they get out of sync again?

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
