Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by pentafluge.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J4IDC-0000A9-2X
	for kexec@lists.infradead.org; Mon, 17 Dec 2007 15:49:05 +0000
Date: Mon, 17 Dec 2007 10:47:13 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
Message-ID: <20071217154713.GB18036@hmsendeavour.rdu.redhat.com>
References: <86802c440712111151t29acd38kf9fac8e41743f3e4@mail.gmail.com>
	<20071211205955.GF10999@hmsreliant.think-freely.org>
	<20071212142132.GC4889@bingen.suse.de>
	<20071212155515.GA29735@hmsendeavour.rdu.redhat.com>
	<20071212160722.GD4889@bingen.suse.de>
	<m1prxbu2ah.fsf@ebiederm.dsl.xmission.com>
	<20071212202215.GB29735@hmsendeavour.rdu.redhat.com>
	<m1lk7ztx9p.fsf@ebiederm.dsl.xmission.com>
	<20071213143922.GA4674@hmsreliant.think-freely.org>
	<20071217151642.GA25081@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071217151642.GA25081@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, "Eric W. Biederman" <ebiederm@xmission.com>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, Yinghai Lu <yhlu.kernel@gmail.com>

On Mon, Dec 17, 2007 at 04:16:42PM +0100, Ingo Molnar wrote:
> 
> * Neil Horman <nhorman@tuxdriver.com> wrote:
> 
> > Ok, new patch attached, taking into account Andi's request for a 
> > cleaner method to implement single application quirks.  I've spoken 
> > with Ben, who is continuing to retest, and reports that clean 
> > methodical testing results in success with this patch.
> 
> thanks, i've added your patch to x86.git#mm - queued up for v2.6.25 
> merging. But v2.6.24 merging would be too risky i think: it's not a 
> regression fix and for a regular fix it's a bit late in the cycle for a 
> bugfix that changes so many aspects of the early quirk code.
> 
> 	Ingo

Copy that, thanks Ingo!
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
