Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vo5uV-0003Q3-MG
 for kexec@lists.infradead.org; Wed, 04 Dec 2013 06:26:13 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id E1A323EE0BC
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 15:25:44 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id D21AA45DE52
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 15:25:44 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.nic.fujitsu.com [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id B75EE45DE4D
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 15:25:44 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id AA78CE38001
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 15:25:44 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5E1E51DB803A
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 15:25:44 +0900 (JST)
Message-ID: <529ECAAB.8040309@jp.fujitsu.com>
Date: Wed, 04 Dec 2013 15:24:43 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9] x86, apic, kexec, Documentation: Add disable_cpu_apic
 kernel parameter
References: <529D34AA.1000809@jp.fujitsu.com>
 <20131203152536.GE4251@redhat.com> <529E9CA6.5040200@jp.fujitsu.com>
In-Reply-To: <529E9CA6.5040200@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "H. Peter Anvin" <hpa@linux.intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jerry Hoemann <jerry.hoemann@hp.com>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Fengguang Wu <fengguang.wu@intel.com>, Jingbai Ma <jingbai.ma@hp.com>

(2013/12/04 12:08), HATAYAMA Daisuke wrote:
> (2013/12/04 0:25), Vivek Goyal wrote:
>> On Tue, Dec 03, 2013 at 10:32:26AM +0900, HATAYAMA Daisuke wrote:
>>
>> [..]
>>>
>>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>>> index 50680a5..dd77bec 100644
>>> --- a/Documentation/kernel-parameters.txt
>>> +++ b/Documentation/kernel-parameters.txt
>>> @@ -774,6 +774,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>>       disable=    [IPV6]
>>>               See Documentation/networking/ipv6.txt.
>>>
>>> +    disable_cpu_apicid= [X86,APIC,KEXEC,SMP]
>>
>> Hi Hatayama,
>>
>> We are almost there. A minor nit. Why have we specified KEXEC here. This
>> parameter disabled_cpu_apicid does not seem to dependon CONFIG_KEXEC?
>>
>> Jerry, this patch looks good to me. Does it work on your system?
>>
>
> Because primary user for the option is currently kexec/kdump only.
>
> I referred to acpi_rsdp description:
>
>          acpi_rsdp=      [ACPI,EFI,KEXEC]
>                          Pass the RSDP address to the kernel, mostly used
>                          on machines running EFI runtime service to boot the
>                          second kernel for kdump.
>

Indo-san, who introduced acpi_rsdp and KEXEC tag, told me that historical reason
why KEXEC tag was introduced. disable_cpu_apicid is generic at least in the
current version, so the tag doesn't need to be specified here.

I'll post a new version soon.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
