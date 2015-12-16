Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a950i-0001Gj-S2
 for kexec@lists.infradead.org; Wed, 16 Dec 2015 05:52:25 +0000
Received: by mail-pa0-f51.google.com with SMTP id tl7so1413pab.3
 for <kexec@lists.infradead.org>; Tue, 15 Dec 2015 21:52:04 -0800 (PST)
Subject: Re: [PATCH v12 16/16] arm64: kdump: relax BUG_ON() if more than one
 cpus are still active
References: <cover.1448403503.git.geoff@infradead.org>
 <83db66df70fc1f7cd4da8b580d264b9320991cf0.1448403503.git.geoff@infradead.org>
 <20151215170523.GA353@arm.com>
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Message-ID: <5670FBCD.2030600@linaro.org>
Date: Wed, 16 Dec 2015 14:51:09 +0900
MIME-Version: 1.0
In-Reply-To: <20151215170523.GA353@arm.com>
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
To: Will Deacon <will.deacon@arm.com>, Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org

On 12/16/2015 02:05 AM, Will Deacon wrote:
> On Tue, Nov 24, 2015 at 10:25:34PM +0000, Geoff Levand wrote:
>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>
>> We should try best in case of kdump.
>> So even if not all secondary cpus have shut down, we do kdump anyway.
>> ---
>>   arch/arm64/kernel/machine_kexec.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
>> index d2d7e90..482aae7 100644
>> --- a/arch/arm64/kernel/machine_kexec.c
>> +++ b/arch/arm64/kernel/machine_kexec.c
>> @@ -148,7 +148,13 @@ void machine_kexec(struct kimage *kimage)
>>   	phys_addr_t reboot_code_buffer_phys;
>>   	void *reboot_code_buffer;
>>
>> -	BUG_ON(num_online_cpus() > 1);
>> +	if (num_online_cpus() > 1) {
>> +		if (in_crash_kexec)
>> +			pr_warn("kdump might fail because %d cpus are still online\n",
>> +					num_online_cpus());
>> +		else
>> +			BUG();
>> +	}
>
> Can you just rewrite the existing BUG_ON as:
>
>    BUG_ON(num_online_cpus() && !WARN_ON(in_crash_kexec));
>
> ?

Yes, but
      BUG_ON((num_online_cpus() > 1) && !WARN_ON(in_crash_kexec));

Thanks,
-Takahiro AKASHI

> Will
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
