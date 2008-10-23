Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KswOp-0008Et-GS
	for kexec@lists.infradead.org; Thu, 23 Oct 2008 09:22:35 +0000
Message-Id: <1224753754.1503.1280816335@webmail.messagingengine.com>
From: "Alexander van Heukelum" <heukelum@fastmail.fm>
Content-Disposition: inline
MIME-Version: 1.0
References: <20081017210013.GD23591@hmsreliant.think-freely.org>
	<20081020121339.GE10594@elte.hu>
	<20081020134211.GA15574@hmsreliant.think-freely.org>
	<20081020150731.GA25999@mailshack.com>
	<20081020150834.GA26018@mailshack.com>
	<20081021144505.GA25750@hmsreliant.think-freely.org>
	<1224670721.25843.1280616145@webmail.messagingengine.com>
	<20081022104513.GA18951@hmsreliant.think-freely.org>
	<20081022120222.GE8095@elte.hu>
	<20081022191948.GB20423@hmsreliant.think-freely.org>
Subject: Re: [PATCH] x86: make oops_begin and oops_end equal
In-Reply-To: <20081022191948.GB20423@hmsreliant.think-freely.org>
Date: Thu, 23 Oct 2008 11:22:34 +0200
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
To: Neil Horman <nhorman@tuxdriver.com>, Ingo Molnar <mingo@elte.hu>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alexander van Heukelum <heukelum@mailshack.com>, Andrew Morton <akpm@linux-foundation.org>, vgoyal@redhat.com

On Wed, 22 Oct 2008 15:19:48 -0400, "Neil Horman"
<nhorman@tuxdriver.com> said:
> On Wed, Oct 22, 2008 at 02:02:22PM +0200, Ingo Molnar wrote:
> > 
> > * Neil Horman <nhorman@tuxdriver.com> wrote:
> > 
> > > > Thanks for the review. I've sent a redone patch series just a moment 
> > > > ago, based on your comments. There was also another problem with 
> > > > these two patches: oops_end(flags, regs, signr) had special 
> > > > behaviour for regs=NULL that I did not consider before. The series 
> > > > has grown due to this issue...
> > 
> > [...]
> > > Copy that.  Thanks for the quick turn-around.
> > 
> > applied to tip/x86/dumpstack, thanks guys!
> > 
> > Could you please also create arch/x86/kernel/dumpstack.c and move all 
> > the now-unified bits there - before they get out of sync again?
> > 
> I can do this in the next day or so, unless you have an urge to Alexander

Hi Neil,

Many thanks for the review of the patches, and please go ahead
and finish the unification!

Greetings,
    Alexander

> Neil
> 
> > 	Ingo
> > 
> 
> -- 
> /****************************************************
>  * Neil Horman <nhorman@tuxdriver.com>
>  * Software Engineer, Red Hat
>  ****************************************************/
-- 
  Alexander van Heukelum
  heukelum@fastmail.fm

-- 
http://www.fastmail.fm - A fast, anti-spam email service.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
