Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J2Y7u-0007sW-4T
	for kexec@lists.infradead.org; Wed, 12 Dec 2007 20:24:25 +0000
Date: Wed, 12 Dec 2007 15:22:15 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
Message-ID: <20071212202215.GB29735@hmsendeavour.rdu.redhat.com>
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
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1prxbu2ah.fsf@ebiederm.dsl.xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, Yinghai Lu <yhlu.kernel@gmail.com>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com

On Wed, Dec 12, 2007 at 12:43:34PM -0700, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> >
> > It could enable the extended APIC IDs but not use them? 
> 
> In which case complaining is still correct (the BIOS was out of sync),
> enabling bit 17 is still correct and we are just in overkill mode.
> 
> > Anyways I haven't got docs on that NV bridge so I might be wrong.
> 
> This has everything to do with how AMD coherent hypertransport works and
> little if anything to do with how the NV bridge operated.
> 
> Basically the NV bridge seems to be sending a standard hypertransport
> x86 legacy interrupt packet (that doesn't have any target information)
> and when that packet  hits the coherent hypertransport domain it isn't
> being converted into whatever would send it to all cpus. 
> 
> .....
> 
> The real practical problem is if somehow the BIOS goofs up this way
> and it then decides to ask us to boot on one of these cpus with
> an extended apic id.  We will hang in calibrate_delay.  So far
> this only seems to happen in the kdump case but in theory the BIOS
> could be completely crazy.
> 


I think this just leaves us with deciding on a mechanism for how to do
single-application quirks.  I take Andi's point that adding a flag set to the
quirk data structure is a fine solution, but I'm really ok with static integers
in individual functions.  Do we have consensus on how to handle that?  I'm happy
either way, but I'd rather have agreement on how to handle it before I post
another iteration of this patch.  

Thanks & Regards
Neil

> Eric

-- 
/***************************************************
 *Neil Horman
 *nhorman@tuxdriver.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
