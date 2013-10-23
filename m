Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VYlzs-0000L8-37
 for kexec@lists.infradead.org; Wed, 23 Oct 2013 00:08:26 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 3F8E63EE1D6
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 09:07:57 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2F28D45DE50
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 09:07:57 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 167A045DE4D
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 09:07:57 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0731FE08003
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 09:07:57 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id AFCE81DB8038
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 09:07:56 +0900 (JST)
Message-ID: <526712B2.7070108@jp.fujitsu.com>
Date: Wed, 23 Oct 2013 09:05:06 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] x86, apic, kexec: Add disable_cpu_apic kernel
 parameter
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
 <20131022220803.GA32387@anatevka.fc.hp.com>
In-Reply-To: <20131022220803.GA32387@anatevka.fc.hp.com>
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
To: jerry.hoemann@hp.com
Cc: fengguang.wu@intel.com, jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, vgoyal@redhat.com

(2013/10/23 7:08), jerry.hoemann@hp.com wrote:
> On Wed, Oct 23, 2013 at 12:01:18AM +0900, HATAYAMA Daisuke wrote:
>> This patch set is to allow kdump 2nd kernel to wake up multiple CPUs
>> even if 1st kernel crashs on some AP, a continueing work from:
>>
>>    [PATCH v3 0/2] x86, apic, kdump: Disable BSP if boot cpu is AP
>>    https://lkml.org/lkml/2013/10/16/300.
>>
>> In this version, basic design has changed. Now users need to figure
>> out initial APIC ID of BSP in the 1st kernel and configures kernel
>> parameter for the 2nd kernel manually using disable_cpu_apic kernel
>> parameter to be newly introduced in this patch set. This design is
>> more flexible than the previous version in that we no longer have to
>> rely on ACPI/MP table to get initial APIC ID of BSP.
>>
>> Sorry, this patch set have not include in-source documentation
>> requested by Borislav Petkov yet, but I'll post it later separately,
>> which would be better to focus on documentation reviewing.
>>
>> ChangeLog
>>
>> v3 => v4)
>>
>> - Rebased on top of v3.12-rc6
>>
>> - Basic design has been changed. Now users need to figure out initial
>>    APIC ID of BSP in the 1st kernel and configures kernel parameter for
>>    the 2nd kernel manually using disable_cpu_apic kernel parameter to
>>    be newly introduced in this patch set. This design is more flexible
>>    than the previous version in that we no longer have to rely on
>>    ACPI/MP table to get initial APIC ID of BSP.
>
>
> Do you literally mean a human at each boot will have to configure
> the kdump configuration files for passing disable_cpu_apic?
> Or do you envision the setting of disable_cpu_apic being put into
> the kdump initialization scripts?
>
> thanks
>
> Jerry

Nearer to the former case, but this is not what a human should do. It's
a cumbersome task. I think, on fedora/RHEL system for example, kdump
service should check at each boot automatically.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
