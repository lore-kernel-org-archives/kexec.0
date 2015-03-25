Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <5512845E.40804@arm.com>
Date: Wed, 25 Mar 2015 09:48:14 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
Subject: Re: [RFC 1/4] arm64: kvm: add a cpu tear-down function
References: <1427111639-4575-1-git-send-email-takahiro.akashi@linaro.org>
 <1427111639-4575-2-git-send-email-takahiro.akashi@linaro.org>
 <551135AE.1080401@arm.com> <55126C6F.2080500@linaro.org>
In-Reply-To: <55126C6F.2080500@linaro.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Mark Rutland <Mark.Rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "geoff@infradead.org" <geoff@infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "david.griego@linaro.org" <david.griego@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "freddy77@gmail.com" <freddy77@gmail.com>

Hi Takahiro,

On 25/03/15 08:06, AKASHI Takahiro wrote:

>>> +	/* Switch back to boot page tables */
>>> +	msr	ttbr0_el2, x0
>>> +	isb
>>
>> This is the place where you want TLBI to occur.
> 
> Will remove tlbi above and put it here.

There is only need for one TLBI, if at all.

>>> +	/* Branch into PA space */
>>> +	adr	x0, 1f
>>> +	bfi	x1, x0, #0, #PAGE_SHIFT
>>> +	br	x1
>>> +
>>> +	/* We're now in idmap */
>>> +1:	/* Invalidate the old TLBs again */
>>> +	tlbi	alle2
>>> +	dsb	sy
>>
>> See? This is the only TLBI that actually makes sense. Now, given that
>> you are actually disabling the MMU, I'm not sure these TBLIs make much
>> sense.
> 
> Probably you're right, but
> otherwise, I guess, bogus TLB might remain and be used when MMU get enabled again.
> (MMU setting would be the same across disabling/enabling hyp mode though.)

Anyone enabling the MMU must invalidate the TLB before doing so (we've
been caught by that before). Invalidation on the way out doesn't hurt,
but it also give a false sense of security.

I'll leave it up to you.

Thanks,

	M.

-- 
Jazz is not dead. It just smells funny...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
