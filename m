Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by pentafluge.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J4Hmg-0008BO-B1
	for kexec@lists.infradead.org; Mon, 17 Dec 2007 15:21:41 +0000
Date: Mon, 17 Dec 2007 16:16:42 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on
	boot cpu
Message-ID: <20071217151642.GA25081@elte.hu>
References: <20071211192434.GD10999@hmsreliant.think-freely.org>
	<86802c440712111151t29acd38kf9fac8e41743f3e4@mail.gmail.com>
	<20071211205955.GF10999@hmsreliant.think-freely.org>
	<20071212142132.GC4889@bingen.suse.de>
	<20071212155515.GA29735@hmsendeavour.rdu.redhat.com>
	<20071212160722.GD4889@bingen.suse.de>
	<m1prxbu2ah.fsf@ebiederm.dsl.xmission.com>
	<20071212202215.GB29735@hmsendeavour.rdu.redhat.com>
	<m1lk7ztx9p.fsf@ebiederm.dsl.xmission.com>
	<20071213143922.GA4674@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071213143922.GA4674@hmsreliant.think-freely.org>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, "Eric W. Biederman" <ebiederm@xmission.com>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, Yinghai Lu <yhlu.kernel@gmail.com>


* Neil Horman <nhorman@tuxdriver.com> wrote:

> Ok, new patch attached, taking into account Andi's request for a 
> cleaner method to implement single application quirks.  I've spoken 
> with Ben, who is continuing to retest, and reports that clean 
> methodical testing results in success with this patch.

thanks, i've added your patch to x86.git#mm - queued up for v2.6.25 
merging. But v2.6.24 merging would be too risky i think: it's not a 
regression fix and for a regular fix it's a bit late in the cycle for a 
bugfix that changes so many aspects of the early quirk code.

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
