Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from theia.rz.uni-saarland.de ([134.96.7.31])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Krx64-00087c-DI
	for kexec@lists.infradead.org; Mon, 20 Oct 2008 15:55:09 +0000
Date: Mon, 20 Oct 2008 17:07:31 +0200
From: Alexander van Heukelum <heukelum@mailshack.com>
Subject: [PATCH] x86, dumpstack: some more unification
Message-ID: <20081020150731.GA25999@mailshack.com>
References: <20081017210013.GD23591@hmsreliant.think-freely.org>
	<20081020121339.GE10594@elte.hu>
	<20081020134211.GA15574@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081020134211.GA15574@hmsreliant.think-freely.org>
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
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, vgoyal@redhat.com

Hi Ingo, Neil,

Doing more unification of dumpstack is/was on my
TODO list, but it got sidetracked with some other
hobby projects.

I did unify oops_begin, oops_end, die and die_nmi,
and it seems to work. It needs more careful testing,
I think, but if someone (Neil?) wants to take a
look and validate the result...

Greetings,
    Alexander

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
