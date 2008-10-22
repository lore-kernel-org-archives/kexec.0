Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KsjHO-0006Dg-IT
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 19:22:02 +0000
Date: Wed, 22 Oct 2008 15:19:48 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] x86: make oops_begin and oops_end equal
Message-ID: <20081022191948.GB20423@hmsreliant.think-freely.org>
References: <20081017210013.GD23591@hmsreliant.think-freely.org>
	<20081020121339.GE10594@elte.hu>
	<20081020134211.GA15574@hmsreliant.think-freely.org>
	<20081020150731.GA25999@mailshack.com>
	<20081020150834.GA26018@mailshack.com>
	<20081021144505.GA25750@hmsreliant.think-freely.org>
	<1224670721.25843.1280616145@webmail.messagingengine.com>
	<20081022104513.GA18951@hmsreliant.think-freely.org>
	<20081022120222.GE8095@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081022120222.GE8095@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alexander van Heukelum <heukelum@mailshack.com>, Andrew Morton <akpm@linux-foundation.org>, vgoyal@redhat.com

On Wed, Oct 22, 2008 at 02:02:22PM +0200, Ingo Molnar wrote:
> 
> * Neil Horman <nhorman@tuxdriver.com> wrote:
> 
> > > Thanks for the review. I've sent a redone patch series just a moment 
> > > ago, based on your comments. There was also another problem with 
> > > these two patches: oops_end(flags, regs, signr) had special 
> > > behaviour for regs=NULL that I did not consider before. The series 
> > > has grown due to this issue...
> 
> [...]
> > Copy that.  Thanks for the quick turn-around.
> 
> applied to tip/x86/dumpstack, thanks guys!
> 
> Could you please also create arch/x86/kernel/dumpstack.c and move all 
> the now-unified bits there - before they get out of sync again?
> 
I can do this in the next day or so, unless you have an urge to Alexander
Neil

> 	Ingo
> 

-- 
/****************************************************
 * Neil Horman <nhorman@tuxdriver.com>
 * Software Engineer, Red Hat
 ****************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
