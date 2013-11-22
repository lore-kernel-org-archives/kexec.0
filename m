Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjeqS-0002KD-L8
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 00:43:41 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 1FA253EE0C2
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 09:43:14 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id ED72845DEBF
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 09:43:13 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id CEF2345DD76
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 09:43:13 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id BDA14E1800A
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 09:43:13 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7045CE18006
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 09:43:13 +0900 (JST)
Message-ID: <528EA874.9010609@jp.fujitsu.com>
Date: Fri, 22 Nov 2013 09:42:28 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 2/3] x86, apic: Add disable_cpu_apicid kernel parameter
References: <20131121015951.2748.47826.stgit@localhost6.localdomain6>
 <20131121020044.2748.70221.stgit@localhost6.localdomain6>
 <20131121213300.GR16208@redhat.com>
In-Reply-To: <20131121213300.GR16208@redhat.com>
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
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

(2013/11/22 6:33), Vivek Goyal wrote:
> On Thu, Nov 21, 2013 at 11:00:44AM +0900, HATAYAMA Daisuke wrote:
>
> [..]
>> @@ -2122,6 +2129,19 @@ void generic_processor_info(int apicid, int version)
>>   	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
>>   				phys_cpu_present_map);
>>
>> +	if (disabled_cpu_apicid != BAD_APICID &&
>> +	    disabled_cpu_apicid != boot_cpu_physical_apicid &&
>
> Hi Hatayama,
>
> So we are comparing disabled_cpu_apicid with boot_cpu_physical_apicid
> to make sure that one can not disable the cpu we are booting on. Can
> we just read the apic id of booting cpu in local variable and compare
> against that?
>
> Something like as follows.
>
> 	if (disabled_cpu_apicid != BAD_APICID &&
> 	    disabled_cpu_apicid == apicid &&
> 	    disabled_cpu_apicid != read_apic_id()) {
> 		/* Disable cpu */	
> 	}
>
> If above works, you will not need first patch in the series?
>

Yes, I came up with the idea, too. But doing this means we leave two different
ways boot_cpu_physical_apicid is used at boot, which seemed incomplete as a
patch. Also, then we could even lost the reason why boot_cpu_physical_apicid
exists.

But, it's true that the 1st patch causes one more reviewing point. I'll
remove it and fix the 2nd patch just as you suggested here.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
