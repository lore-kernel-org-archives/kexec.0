Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KsbFM-0003NC-FV
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 10:47:25 +0000
Date: Wed, 22 Oct 2008 06:45:13 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] x86: make oops_begin and oops_end equal
Message-ID: <20081022104513.GA18951@hmsreliant.think-freely.org>
References: <20081017210013.GD23591@hmsreliant.think-freely.org>
	<20081020121339.GE10594@elte.hu>
	<20081020134211.GA15574@hmsreliant.think-freely.org>
	<20081020150731.GA25999@mailshack.com>
	<20081020150834.GA26018@mailshack.com>
	<20081021144505.GA25750@hmsreliant.think-freely.org>
	<1224670721.25843.1280616145@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1224670721.25843.1280616145@webmail.messagingengine.com>
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
To: Alexander van Heukelum <heukelum@fastmail.fm>
Cc: Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Alexander van Heukelum <heukelum@mailshack.com>, Thomas Gleixner <tglx@linutronix.de>, vgoyal@redhat.com

On Wed, Oct 22, 2008 at 12:18:41PM +0200, Alexander van Heukelum wrote:
> On Tue, 21 Oct 2008 10:45:05 -0400, "Neil Horman"
> <nhorman@tuxdriver.com> said:
> > On Mon, Oct 20, 2008 at 05:08:34PM +0200, Alexander van Heukelum wrote:
> > > Mostly use the x86_64 version of oops_begin() and oops_end() on
> > > i386 too. Changes to the original x86_64 version:
> > > 
> > Hey, doing a sight review this am here.  Didn't find anything major, but
> > I did
> > find a few little nits.  comments inlie
> 
> Hi Neil,
> 
> Thanks for the review. I've sent a redone patch series just a moment
> ago, based on your comments. There was also another problem with these
> two patches: oops_end(flags, regs, signr) had special behaviour for
> regs=NULL that I did not consider before. The series has grown due
> to this issue...
> 
> >> [...]
> > Hmm.  I think this creates the same case that I just fixed in my initial
> > post. If we start using oops_end with this here, it may be possible to call
> > crash_kexec with the console_sem held.  If that happens, we deadlock.  I
> > think you should be able to move this clause up above the bust_spinlocks(0)
> > without any issue, and that would take care of that
> 
> Indeed. The new series does exactly that.
> 
> >> [...]
> > This undoes my previous patch.  I realize your second patch fixes it
> > properly so the ordering is correct when oops_begin and oops_end are used, but if you
> > could rediff so this isn't here, I'd appreciate it.  If these patches are
> > committed separately, you'll avoid having the tree in a state where that deadlock
> > can reoccur (even if it is just for one commit)
> 
> Yeah, I quickly rediffed the patches I already had. The new series
> leaves
> it as is until die_nmi is replaced by the oops_begin/oops_end version.
> 
> >> [...]
> > If you're going to add the crash_kexec here (which looking at the call
> > sites, makes sense to me), you should likely remove it from the critical section
> > of die and die_nmi, just to avoid the redundancy.  Same issue as the 32 bit
> > version above applies, this needs to happen before you call bust_spinlocks(0).
> 
> Indeed.
> 
> > Fix those issues, and the rest looks good to me.
> 
> I think I've done that ;).
> 
> Thanks,
> Greetings,
>     Alexander
> 
> (I will probably not be able to respond to e-mail until after the
> weekend)
Copy that.  Thanks for the quick turn-around.

Best
Neil

> -- 
>   Alexander van Heukelum
>   heukelum@fastmail.fm
> 
> -- 
> http://www.fastmail.fm - mmm... Fastmail...
> 
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
