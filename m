Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J2pnV-0000so-V9
	for kexec@lists.infradead.org; Thu, 13 Dec 2007 15:16:32 +0000
Date: Thu, 13 Dec 2007 16:16:29 +0100
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
Message-ID: <20071213151629.GB31269@one.firstfloor.org>
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
Mime-Version: 1.0
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

On Thu, Dec 13, 2007 at 09:39:22AM -0500, Neil Horman wrote:
> 
> Ok, new patch attached, taking into account Andi's request for a cleaner method

Sorry for not noticing that earlier, but was there a specific reason this needs
to be an early quirk at all? kexec can only happen after the standard quirks ran.
I think it should be fine as a standard "late" quirk.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
