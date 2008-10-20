Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Krte5-0004Gb-8n
	for kexec@lists.infradead.org; Mon, 20 Oct 2008 12:14:01 +0000
Date: Mon, 20 Oct 2008 14:13:39 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] kexec: fix hang on i386 when panic occurs while
	console_sem is held
Message-ID: <20081020121339.GE10594@elte.hu>
References: <20081017210013.GD23591@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081017210013.GD23591@hmsreliant.think-freely.org>
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
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, akpm@linux-foundation.org, vgoyal@redhat.com


* Neil Horman <nhorman@tuxdriver.com> wrote:

> Hey all-
> 	Theres a corner case in 32 bit x86 kdump at the moment.  When 
> the box panics via nmi, we call bust_spinlocks(1) to disable 
> sensitivity to the console_sem (allowing us to print to the console in 
> all cases), but we don't call crash_kexec, until after we call 
> bust_spinlocks(0), which re-enables console_sem sensitivity.  The 
> result is that, if we get an nmi while the console_sem is held and 
> kdump is configured, and we try to print something to the console 
> during kdump shutdown (which we often do) we deadlock the box.  The 
> fix is to simply do what 64 bit die_nmi does which is to not call 
> bust_spinlocks(0) until after we call crash_kexec.  Patch below tested 
> successfully by me:

applied to tip/x86/urgent, thanks Neil!

>  dumpstack_32.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

would be nice to unify this code some more - to create a new 
arch/x86/kernel/dumpstack.c and fill it in with die_nmi() as a 
beginning?

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
