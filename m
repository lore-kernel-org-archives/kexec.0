Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Krxz5-0003Rs-Ho
	for kexec@lists.infradead.org; Mon, 20 Oct 2008 16:52:00 +0000
Date: Mon, 20 Oct 2008 12:51:01 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH] x86, dumpstack: some more unification
Message-ID: <20081020165101.GC13856@hmsendeavour.rdu.redhat.com>
References: <20081017210013.GD23591@hmsreliant.think-freely.org>
	<20081020121339.GE10594@elte.hu>
	<20081020134211.GA15574@hmsreliant.think-freely.org>
	<20081020150731.GA25999@mailshack.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081020150731.GA25999@mailshack.com>
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
To: Alexander van Heukelum <heukelum@mailshack.com>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, mingo@redhat.com, tglx@linutronix.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, vgoyal@redhat.com

On Mon, Oct 20, 2008 at 05:07:31PM +0200, Alexander van Heukelum wrote:
> Hi Ingo, Neil,
> 
> Doing more unification of dumpstack is/was on my
> TODO list, but it got sidetracked with some other
> hobby projects.
> 
> I did unify oops_begin, oops_end, die and die_nmi,
> and it seems to work. It needs more careful testing,
> I think, but if someone (Neil?) wants to take a
> look and validate the result...
> 
> Greetings,
>     Alexander
> 
Please send me the patch, If/when I get a few moments, I'd be happy to give it a
spin here.  

Thanks!
Neil

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
/***************************************************
 *Neil Horman
 *Senior Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
