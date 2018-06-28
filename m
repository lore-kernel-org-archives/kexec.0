Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fYOct-0005OW-OH
 for kexec@lists.infradead.org; Thu, 28 Jun 2018 04:33:49 +0000
Subject: Re: kexec failures on ipq4019
References: <CAAGQ2nQNQ-aFkcrQHNA6H5TZ1tTovtfO_0Ohfndn9jXy13Hc6A@mail.gmail.com>
 <b741eca8c2d1bee8a8db7136c3061064@codeaurora.org>
 <CAAGQ2nSG2QGHrOv+S77qTs8hdMgEEsNBFoDGa9wLiEKE1nDZmA@mail.gmail.com>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <fa6d7ce8-8e0e-7373-d645-9f5f164a9078@codeaurora.org>
Date: Thu, 28 Jun 2018 10:03:33 +0530
MIME-Version: 1.0
In-Reply-To: <CAAGQ2nSG2QGHrOv+S77qTs8hdMgEEsNBFoDGa9wLiEKE1nDZmA@mail.gmail.com>
Content-Language: en-US
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
To: Andy Strohman <andy@uplevelsystems.com>
Cc: linux-arm-msm@vger.kernel.org, kexec@lists.infradead.org, linux-arm-msm-owner@vger.kernel.org

Hi Andy,

On 6/27/2018 2:47 AM, Andy Strohman wrote:
> On Sun, Jun 17, 2018 at 11:31 PM,  <sricharan@codeaurora.org> wrote:
>> Hi Andy,
>>
>> On 2018-06-16 06:37, Andy Strohman wrote:
>>>
>>> Hi,
>>>
>>>   I'm trying to get kexec to work consistently for ipq4019.  I load
>>> the crash kernel like this:
>>>
>>> kexec --type zImage -p zImage-initramfs
>>> --dtb=image-qcom-ipq4019-eap1300.dtb --append="maxcpus=1
>>> reset_devices" --image-size=34419456
>>>
>>>   I have reserved 64MB of memory for the crash kernel with parameter:
>>> crashkernel=64M
>>>
>>>   This seems to work ~70% of the time. When it doesn't work, I see the
>>> "bye!" message followed by a 5-10 second hang without output.  Then
>>> the machine resets.
>>>
>>>   I've been testing with:
>>> echo c > /proc/sysrq-trigger
>>>
>>>   Does anyone have an idea of what may be causing the failures or how
>>> to troubleshoot this?
>>>
>>
>>  I will try to reproduce this and get back to you shortly.
>>
>> Regards,
>>  Sricharan
>>
>>
>>>   I'm using OpenWRT with kernel 4.14.37.   I added the following patch
>>> in order to load the crash kernel:
>>>
>>> --- a/arch/arm/mach-qcom/platsmp.c
>>> +++ b/arch/arm/mach-qcom/platsmp.c
>>> @@ -332,6 +332,12 @@ static void __init qcom_smp_prepare_cpus
>>>   }
>>>  }
>>>
>>> +/* Needed by kexec and platform_can_cpu_hotplug() */
>>> +int qcom_cpu_kill(unsigned int cpu)
>>> +{
>>> +    return 1;
>>> +}
>>> +
>>>  static const struct smp_operations smp_msm8660_ops __initconst = {
>>>   .smp_prepare_cpus = qcom_smp_prepare_cpus,
>>>   .smp_secondary_init = qcom_secondary_init,
>>> @@ -358,6 +364,7 @@ static const struct smp_operations qcom_
>>>   .smp_boot_secondary = kpssv2_boot_secondary,
>>>  #ifdef CONFIG_HOTPLUG_CPU
>>>   .cpu_die = qcom_cpu_die,
>>> +    .cpu_kill       = qcom_cpu_kill,
>>>  #endif
>>>  };
>>>  CPU_METHOD_OF_DECLARE(qcom_smp_kpssv2, "qcom,kpss-acc-v2",
>>> &qcom_smp_kpssv2_ops);
>>>
>>>
>>> Thanks,
>>>
>>> Andy
> 
> Hi Sricharan,
> 
>   Thanks for your response.  Did you get a chance to try this out?  If
> so, were you able to reproduce?
> 

   I have been trying to kexec while chroot'ing for a different reason.
   I did not observe a issue so far. But that is with a 4.4.60 openwrt kernel.
   Can you point me a link to the kernel that you are trying with ?

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
