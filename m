Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kp1Pg-000523-3G
	for kexec@lists.infradead.org; Sun, 12 Oct 2008 13:55:16 +0000
Date: Sun, 12 Oct 2008 15:55:05 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [RFC] powerpc: add kexec support on Book-E
Message-ID: <20081012135505.GB7536@Chamillionaire.breakpoint.cc>
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
	<1222896024-22172-2-git-send-email-sebastian@breakpoint.cc>
	<1223610826.8157.142.camel@pasglop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1223610826.8157.142.camel@pasglop>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org

* Benjamin Herrenschmidt | 2008-10-10 14:53:46 [+1100]:

>On Wed, 2008-10-01 at 23:20 +0200, Sebastian Andrzej Siewior wrote:
>
>> +#define KEXEC_MODE_NOMMU 1
>> +#define KEXEC_MODE_BOOKE 2
>
>No need for runtime detection here, you cannot and likely never will be
>able to build a kernel that does bot BookE and real mode...
okay.

>> +
>> +/* 1. Find the index of the entry we're executing in */
>> +	bl	invstr			/* Find our address */
>> +invstr:
>> +	mflr	r6			/* Make it accessible */
>> +	mfmsr	r7
>> +	rlwinm	r4,r7,27,31,31		/* extract MSR[IS] */
>> +	mfspr	r7, SPRN_PID0
>> +	slwi	r7,r7,16
>> +	or	r7,r7,r4
>> +	mtspr	SPRN_MAS6,r7
>> +	tlbsx	0,r6			/* search MSR[IS], SPID=PID0 */
>> +	mfspr	r7,SPRN_MAS1
>> +	andis.	r7,r7,MAS1_VALID@h
>> +	bne	match_TLB
>
>This isn't just BookE .. it's specifically FSL BookE (or "merged"
>architecture). This isn't going to work on 44x for example. You need to
>make it clearer.
Okay, I did know that. So I put a ifdef CONFIG_FSL_BOOKE around. May I
leave that MMU setup here? Moving it over to head_fsl_booke.S would make
it clear but than I have to copy the page-copy-code as well.

Thanks for looking over these bits Ben.

>Cheers,
>Ben.

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
