Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vbk93-0006hS-Fh
 for kexec@lists.infradead.org; Thu, 31 Oct 2013 04:46:10 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B45A33EE1DD
 for <kexec@lists.infradead.org>; Thu, 31 Oct 2013 13:45:42 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 671F045DEBA
 for <kexec@lists.infradead.org>; Thu, 31 Oct 2013 13:45:42 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 4DBB445DEB7
 for <kexec@lists.infradead.org>; Thu, 31 Oct 2013 13:45:42 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 353711DB8044
 for <kexec@lists.infradead.org>; Thu, 31 Oct 2013 13:45:42 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id DC3981DB803F
 for <kexec@lists.infradead.org>; Thu, 31 Oct 2013 13:45:41 +0900 (JST)
Message-ID: <5271DFEC.7070802@jp.fujitsu.com>
Date: Thu, 31 Oct 2013 13:43:24 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] x86, apic, kexec: Add disable_cpu_apic kernel
 parameter
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
 <20131022220803.GA32387@anatevka.fc.hp.com> <526712B2.7070108@jp.fujitsu.com>
 <20131031005812.GA15459@anatevka.fc.hp.com>
In-Reply-To: <20131031005812.GA15459@anatevka.fc.hp.com>
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

(2013/10/31 9:58), jerry.hoemann@hp.com wrote:
> On Wed, Oct 23, 2013 at 09:05:06AM +0900, HATAYAMA Daisuke wrote:
>>>>
>>>> - Rebased on top of v3.12-rc6
>>>>
>>>> - Basic design has been changed. Now users need to figure out initial
>>>>    APIC ID of BSP in the 1st kernel and configures kernel parameter for
>>>>    the 2nd kernel manually using disable_cpu_apic kernel parameter to
>>>>    be newly introduced in this patch set. This design is more flexible
>>>>    than the previous version in that we no longer have to rely on
>>>>    ACPI/MP table to get initial APIC ID of BSP.
>>>
>>>
>>> Do you literally mean a human at each boot will have to configure
>>> the kdump configuration files for passing disable_cpu_apic?
>>> Or do you envision the setting of disable_cpu_apic being put into
>>> the kdump initialization scripts?
>>>
>>> thanks
>>>
>>> Jerry
>>
>> Nearer to the former case, but this is not what a human should do. It's
>> a cumbersome task. I think, on fedora/RHEL system for example, kdump
>> service should check at each boot automatically.
>>
>> HATAYAMA, Daisuke
>
>
> Daisuke,
>
> Are you planning on making changes to the kexec tools to automate
> the setting of disable_cpu_apic to the capture kernel? Or do you
> know someone who is planning this?
>
> I back ported the kernel side changes to a 4.2.32 based kernel.
> I tested the patch on a prototype system which exhibits a stable
> initial_apic_id for CPU 0.  While not something that would be suitable
> for customers, it does allow me to test the kernel portion of the patch.
>
> I will report the results of the testing later this week.
>

I'll do that after this patch is merged in kernel. But it is still under
reviewing.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
