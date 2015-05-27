Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YxTwn-0002u3-5h
 for kexec@lists.infradead.org; Wed, 27 May 2015 05:32:09 +0000
Received: by pdea3 with SMTP id a3so110354511pde.2
 for <kexec@lists.infradead.org>; Tue, 26 May 2015 22:31:46 -0700 (PDT)
Message-ID: <556556B9.7070607@linaro.org>
Date: Wed, 27 May 2015 14:31:37 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
MIME-Version: 1.0
Subject: Re: [v4 4/4] arm: kvm: add stub implementation for kvm_cpu_reset()
References: <1431047884-5637-1-git-send-email-takahiro.akashi@linaro.org>
 <1431047884-5637-5-git-send-email-takahiro.akashi@linaro.org>
 <55643EA4.4080206@arm.com>
In-Reply-To: <55643EA4.4080206@arm.com>
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
To: Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com
Cc: linaro-kernel@lists.linaro.org, christoffer.dall@linaro.org, geoff@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, broonie@kernel.org, david.griego@linaro.org, linux-arm-kernel@lists.infradead.org, freddy77@gmail.com

On 05/26/2015 06:36 PM, Marc Zyngier wrote:
> On 08/05/15 02:18, AKASHI Takahiro wrote:
>> Just to avoid compiling errors on arm.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>   arch/arm/include/asm/kvm_asm.h  |    1 +
>>   arch/arm/include/asm/kvm_host.h |   12 ++++++++++++
>>   arch/arm/include/asm/kvm_mmu.h  |    5 +++++
>>   arch/arm/kvm/init.S             |    6 ++++++
>>   4 files changed, 24 insertions(+)
>>
(snip)
>
> So before this patch, KVM is broken on ARM. This is not acceptable.
> Please merge it with patch #1.

OK.

-Takahiro AKASHI


> Thanks,
>
> 	M.
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
