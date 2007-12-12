Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J2ZDC-0003RV-4u
	for kexec@lists.infradead.org; Wed, 12 Dec 2007 21:33:50 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
References: <m1ve75z1v3.fsf@ebiederm.dsl.xmission.com>
	<20071211182254.GB10999@hmsreliant.think-freely.org>
	<m1ejdtysqd.fsf@ebiederm.dsl.xmission.com>
	<20071211192434.GD10999@hmsreliant.think-freely.org>
	<86802c440712111151t29acd38kf9fac8e41743f3e4@mail.gmail.com>
	<20071211205955.GF10999@hmsreliant.think-freely.org>
	<20071212142132.GC4889@bingen.suse.de>
	<20071212155515.GA29735@hmsendeavour.rdu.redhat.com>
	<20071212160722.GD4889@bingen.suse.de>
	<m1prxbu2ah.fsf@ebiederm.dsl.xmission.com>
	<20071212202215.GB29735@hmsendeavour.rdu.redhat.com>
Date: Wed, 12 Dec 2007 14:32:02 -0700
In-Reply-To: <20071212202215.GB29735@hmsendeavour.rdu.redhat.com> (Neil
	Horman's message of "Wed, 12 Dec 2007 15:22:15 -0500")
Message-ID: <m1lk7ztx9p.fsf@ebiederm.dsl.xmission.com>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, Yinghai Lu <yhlu.kernel@gmail.com>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com

Neil Horman <nhorman@tuxdriver.com> writes:

> I think this just leaves us with deciding on a mechanism for how to do
> single-application quirks.  I take Andi's point that adding a flag set to the
> quirk data structure is a fine solution, but I'm really ok with static integers
> in individual functions.  Do we have consensus on how to handle that?  I'm happy
> either way, but I'd rather have agreement on how to handle it before I post
> another iteration of this patch.  

As long as the solution is simple, small and concise I don't care.

And since what will make Andi happy seems to meet those criteria,
that should be fine.


Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
