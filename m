Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58] helo=smtp.tuxdriver.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Krv3b-0003kc-UE
	for kexec@lists.infradead.org; Mon, 20 Oct 2008 13:44:28 +0000
Date: Mon, 20 Oct 2008 09:42:11 -0400
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] kexec: fix hang on i386 when panic occurs while
	console_sem is held
Message-ID: <20081020134211.GA15574@hmsreliant.think-freely.org>
References: <20081017210013.GD23591@hmsreliant.think-freely.org>
	<20081020121339.GE10594@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081020121339.GE10594@elte.hu>
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
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org, vgoyal@redhat.com

On Mon, Oct 20, 2008 at 02:13:39PM +0200, Ingo Molnar wrote:
> 
> * Neil Horman <nhorman@tuxdriver.com> wrote:
> 
> > Hey all-
> > 	Theres a corner case in 32 bit x86 kdump at the moment.  When 
> > the box panics via nmi, we call bust_spinlocks(1) to disable 
> > sensitivity to the console_sem (allowing us to print to the console in 
> > all cases), but we don't call crash_kexec, until after we call 
> > bust_spinlocks(0), which re-enables console_sem sensitivity.  The 
> > result is that, if we get an nmi while the console_sem is held and 
> > kdump is configured, and we try to print something to the console 
> > during kdump shutdown (which we often do) we deadlock the box.  The 
> > fix is to simply do what 64 bit die_nmi does which is to not call 
> > bust_spinlocks(0) until after we call crash_kexec.  Patch below tested 
> > successfully by me:
> 
> applied to tip/x86/urgent, thanks Neil!
> 
Thanks, Ingo!

> >  dumpstack_32.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> would be nice to unify this code some more - to create a new 
> arch/x86/kernel/dumpstack.c and fill it in with die_nmi() as a 
> beginning?
> 
Agreed, I'll try look into that as soon as I have some free time.

Regards
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
