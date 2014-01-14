Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W32Nq-0001Ac-E6
 for kexec@lists.infradead.org; Tue, 14 Jan 2014 11:42:15 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 4E8563EE0BC
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 20:41:52 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 41B8C45DD76
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 20:41:52 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 15D3445DE4D
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 20:41:52 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 08EB51DB803E
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 20:41:52 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id B18461DB8037
 for <kexec@lists.infradead.org>; Tue, 14 Jan 2014 20:41:51 +0900 (JST)
Message-ID: <52D52269.6070705@jp.fujitsu.com>
Date: Tue, 14 Jan 2014 20:41:29 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v10] x86, apic, kexec, Documentation: Add disable_cpu_apic
 kernel parameter
References: <529EE392.6060400@jp.fujitsu.com>
 <20131210144910.GC13909@redhat.com>
In-Reply-To: <20131210144910.GC13909@redhat.com>
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
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Jingbai Ma <jingbai.ma@hp.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Fengguang Wu <fengguang.wu@intel.com>, Vivek Goyal <vgoyal@redhat.com>

(2013/12/10 23:49), Vivek Goyal wrote:
> On Wed, Dec 04, 2013 at 05:10:58PM +0900, HATAYAMA Daisuke wrote:
>> This patch set is to allow kdump 2nd kernel to wake up multiple CPUs,
>> a continueing work from:
>>
>>    [PATCH v3 0/2] x86, apic, kdump: Disable BSP if boot cpu is AP
>>    https://lkml.org/lkml/2013/10/16/300.
>>
>> At v4, basic design has changed. Now users need to figure out initial
>> APIC ID of BSP in the 1st kernel and configures kernel parameter for
>> the 2nd kernel manually using disable_cpu_apicid kernel parameter,
>> which is newly introduced by this patch set. This design is more
>> flexible than the previous version in that we no longer have to rely
>> on ACPI/MP table to get initial APIC ID of BSP.
>>
>> Sorry, this patch set have not include in-source documentation
>> requested by Borislav Petkov yet, but I'll post it later separately,
>> which would be better to focus on documentation reviewing.
>
> Hi hpa,
>
> Can you please consider this patch for inclusion.
>
> Thanks
> Vivek
>

Hello HPA,

Could you please give me a next feedback for inclusion?

This patch set has already been acked by Vivek and now I'm waiting for a reaction of x86 maintainers.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
