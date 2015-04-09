Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yg3Y4-0007pO-4i
 for kexec@lists.infradead.org; Thu, 09 Apr 2015 03:54:36 +0000
Received: by pddn5 with SMTP id n5so138160175pdd.2
 for <kexec@lists.infradead.org>; Wed, 08 Apr 2015 20:54:14 -0700 (PDT)
Message-ID: <5525F7D6.2040304@linaro.org>
Date: Thu, 09 Apr 2015 12:53:58 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
MIME-Version: 1.0
Subject: Re: [v3 1/5] arm64: kvm: add a cpu tear-down function
References: <1427953216-11737-1-git-send-email-takahiro.akashi@linaro.org>
 <1427953216-11737-2-git-send-email-takahiro.akashi@linaro.org>
 <20150408130221.GA5977@leverpostej>
In-Reply-To: <20150408130221.GA5977@leverpostej>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "geoff@infradead.org" <geoff@infradead.org>, "broonie@kernel.org" <broonie@kernel.org>, "david.griego@linaro.org" <david.griego@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "freddy77@gmail.com" <freddy77@gmail.com>

On 04/08/2015 10:02 PM, Mark Rutland wrote:
>> +	/* We're now in idmap, disable MMU */
>> +1:	mrs	x0, sctlr_el2
>> +	and	x1, x0, #SCTLR_EL2_EE
>> +	orr	x0, x0, x1		// preserve endianness of EL2
>> +	ldr	x1, =SCTLR_EL2_FLAGS
>> +	eor	x1, x1, xzr
>> +	bic	x0, x0, x1		// Clear SCTL_M and etc
>> +	msr	sctlr_el2, x0
>> +	isb
>
> This can instead be:
>
> 1:	mrs	x0, sctlr_el2
> 	ldr	x1, =SCTLR_EL2_FLAGS
> 	bic	x0, x0, x1
> 	msr	sctlr_el2, x0
> 	isb
>
> As SCTLR_EL2_FLAGS doesn't contain the EE bit.

Oops. I will fix it.

Thanks,
-Takahiro AKASHI

> Mark.
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
