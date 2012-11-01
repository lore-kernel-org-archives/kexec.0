Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TTnla-0005X4-Lt
 for kexec@lists.infradead.org; Thu, 01 Nov 2012 05:56:36 +0000
Message-ID: <50920EB8.3020400@cn.fujitsu.com>
Date: Thu, 01 Nov 2012 13:55:04 +0800
From: zhangyanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] KVM: make crash_clear_loaded_vmcss valid when
 loading kvm_intel module
References: <50909B55.2070901@cn.fujitsu.com> <50909C35.9080702@cn.fujitsu.com>
 <33710E6CAA200E4583255F4FB666C4E20AACCA2F@G01JPEXMBYT03>
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E20AACCA2F@G01JPEXMBYT03>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Avi Kivity <avi@redhat.com>

于 2012年10月31日 17:01, Hatayama, Daisuke 写道:
> 
> 
>> -----Original Message-----
>> From: kexec-bounces@lists.infradead.org
>> [mailto:kexec-bounces@lists.infradead.org] On Behalf Of zhangyanfei
>> Sent: Wednesday, October 31, 2012 12:34 PM
>> To: x86@kernel.org; kexec@lists.infradead.org; Avi Kivity; Marcelo
>> Tosatti
>> Cc: linux-kernel@vger.kernel.org; kvm@vger.kernel.org
>> Subject: [PATCH v3 2/2] KVM: make crash_clear_loaded_vmcss valid when
>> loading kvm_intel module
>>
>> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> [...]
> 
>> @@ -7230,6 +7231,10 @@ static int __init vmx_init(void)
>>  	if (r)
>>  		goto out3;
>>
>> +#ifdef CONFIG_KEXEC
>> +	crash_clear_loaded_vmcss = vmclear_local_loaded_vmcss;
>> +#endif
>> +
> 
> Assignment here cannot cover the case where NMI is initiated after VMX is on in kvm_init and before vmclear_local_loaded_vmcss is assigned, though rare but can happen.
> 

By saying "VMX is on in kvm init", you mean kvm_init enables the VMX feature in the logical processor?
No, only there is a vcpu to be created, kvm will enable the VMX feature.

I think there is no difference with this assignment before or after kvm_init because the vmcs linked
list must be empty before vmx_init is finished.

Thanks
Zhang Yanfei

> What does happen if calling vmclear_local_loaded_vmcss before kvm_init? I think it no problem since the list is initially empty.
> 
>>  	vmx_disable_intercept_for_msr(MSR_FS_BASE, false);
>>  	vmx_disable_intercept_for_msr(MSR_GS_BASE, false);
>>  	vmx_disable_intercept_for_msr(MSR_KERNEL_GS_BASE, true);
>> @@ -7265,6 +7270,10 @@ static void __exit vmx_exit(void)
>>  	free_page((unsigned long)vmx_io_bitmap_b);
>>  	free_page((unsigned long)vmx_io_bitmap_a);
>>
>> +#ifdef CONFIG_KEXEC
>> +	crash_clear_loaded_vmcss = NULL;
>> +#endif
>> +
>>  	kvm_exit();
>>  }
> 
> Also, this is converse to the above.
> 
> Thanks.
> HATAYAMA, Daisuke
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
