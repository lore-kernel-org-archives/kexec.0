Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1IwyVJ-00072S-TP
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 11:21:26 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<20071127105503.GD24223@one.firstfloor.org>
Date: Tue, 27 Nov 2007 04:19:48 -0700
In-Reply-To: <20071127105503.GD24223@one.firstfloor.org> (Andi Kleen's message
	of "Tue, 27 Nov 2007 11:55:03 +0100")
Message-ID: <m1lk8kkka3.fsf@ebiederm.dsl.xmission.com>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, ak@suse.de, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com

Andi Kleen <andi@firstfloor.org> writes:

> On Mon, Nov 26, 2007 at 08:47:40PM -0500, Neil Horman wrote:
>> Hey all-
>> 	I've been working on an issue lately involving multi socket x86_64
>> systems connected via hypertransport bridges.  It appears that some systems,
>> disable the hypertransport connections during a kdump operation when all but
> the
>> crashing processor gets halted in machine_crash_shutdown.  This becomes a
>
> That would be hard to believe. Linux cannot shut down CPUs
> completely (put them back to SINIT state) because there is no generic
> interface for this and it might be impossible. They just get put 
> into a HLT loop.
>
> And even if they were in SINIT they would still need the HT connections
> otherwise it would be impossible to ever wake them up.

If forget off the top of my head.  But my memory is that if you send
the proper IPI cpus go back into SINIT.  However linux doesn't do this
currently.

> The way HT setup is normally done is that the BIOS sets it all up
> and then it never changes (except for some error conditions that 
> may cause SYNC flood) 

Yep.

> It would be better to properly root cause before applying.

Agreed.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
