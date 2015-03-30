Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YcQH5-0001iQ-Ga
 for kexec@lists.infradead.org; Mon, 30 Mar 2015 03:22:04 +0000
Received: by padcy3 with SMTP id cy3so153778429pad.3
 for <kexec@lists.infradead.org>; Sun, 29 Mar 2015 20:21:40 -0700 (PDT)
Message-ID: <5518C13B.6070201@linaro.org>
Date: Mon, 30 Mar 2015 12:21:31 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] arm64: kdump: do not go into EL2 before starting
 a crash dump kernel
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>	
 <1427358533-3754-4-git-send-email-takahiro.akashi@linaro.org>
 <1427408957.6526.1.camel@infradead.org>
In-Reply-To: <1427408957.6526.1.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, hbabus@us.ibm.com, linaro-kernel@lists.linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, broonie@kernel.org, david.griego@linaro.org, kexec@lists.infradead.org, vgoyal@redhat.com

On 03/27/2015 07:29 AM, Geoff Levand wrote:
> On Thu, 2015-03-26 at 17:28 +0900, AKASHI Takahiro wrote:
>> @@ -64,7 +65,11 @@ void soft_restart(unsigned long addr)
>>   	setup_mm_for_reboot();
>>
>>   	cpu_soft_restart(virt_to_phys(cpu_reset),
>> -		is_hyp_mode_available(), addr);
>> +#ifdef CONFIG_KEXEC
>> +		!in_crash_kexec &&
>> +#endif
>
> Why not define in_crash_kexec without condition on CONFIG_KEXEC, say
> here in process.c and then avoid these preprocessor conditionals.

Well, I thought of that, but as its name suggested, the variable should
be basically part of kdump code.
Moreover, I suspect that some one might reject a whole idea of patch #3.

-Takahiro AKASHI

>> +		is_hyp_mode_available(),
>> +		addr);
>>
>>   	/* Should never get here */
>>   	BUG();
>
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
