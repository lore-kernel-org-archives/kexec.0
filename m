Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vo2qQ-0000sX-1X
 for kexec@lists.infradead.org; Wed, 04 Dec 2013 03:09:47 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 08DD33EE0DE
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 12:09:15 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id EBC1145DD76
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 12:09:14 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id C43A045DEB5
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 12:09:14 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id B60161DB8044
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 12:09:14 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 62E2E1DB803C
 for <kexec@lists.infradead.org>; Wed,  4 Dec 2013 12:09:14 +0900 (JST)
Message-ID: <529E9CA6.5040200@jp.fujitsu.com>
Date: Wed, 04 Dec 2013 12:08:22 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9] x86, apic, kexec, Documentation: Add disable_cpu_apic
 kernel parameter
References: <529D34AA.1000809@jp.fujitsu.com>
 <20131203152536.GE4251@redhat.com>
In-Reply-To: <20131203152536.GE4251@redhat.com>
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

(2013/12/04 0:25), Vivek Goyal wrote:
> On Tue, Dec 03, 2013 at 10:32:26AM +0900, HATAYAMA Daisuke wrote:
>
> [..]
>>
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>> index 50680a5..dd77bec 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -774,6 +774,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>   	disable=	[IPV6]
>>   			See Documentation/networking/ipv6.txt.
>>
>> +	disable_cpu_apicid= [X86,APIC,KEXEC,SMP]
>
> Hi Hatayama,
>
> We are almost there. A minor nit. Why have we specified KEXEC here. This
> parameter disabled_cpu_apicid does not seem to dependon CONFIG_KEXEC?
>
> Jerry, this patch looks good to me. Does it work on your system?
>

Because primary user for the option is currently kexec/kdump only.

I referred to acpi_rsdp description:

         acpi_rsdp=      [ACPI,EFI,KEXEC]
                         Pass the RSDP address to the kernel, mostly used
                         on machines running EFI runtime service to boot the
                         second kernel for kdump.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
