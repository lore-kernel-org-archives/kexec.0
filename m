Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1TFH-00080t-5J
 for kexec@lists.infradead.org; Fri, 10 Jan 2014 03:58:56 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 389093EE0C0
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 12:58:28 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2190145DEBE
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 12:58:28 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id F251E45DD77
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 12:58:27 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E5DA41DB803B
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 12:58:27 +0900 (JST)
Received: from g01jpfmpwyt02.exch.g01.fujitsu.local
 (g01jpfmpwyt02.exch.g01.fujitsu.local [10.128.193.56])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7CFD81DB803F
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 12:58:27 +0900 (JST)
Message-ID: <52CF6FBE.8000005@jp.fujitsu.com>
Date: Fri, 10 Jan 2014 12:57:50 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] acpi memory hotplug, add parameter to disable memory
 hotplug for kexec
References: <1389220181-14474-1-git-send-email-prarit@redhat.com>
 <3476878.EqQiEtA2Ag@vostro.rjw.lan> <20140109150053.GD25897@redhat.com>
 <CAHGf_=oaPZNE8tVsZ1C1z3mHee8MK6CkuZ0YBTcJpRrTWgVn6g@mail.gmail.com>
 <20140109214425.GD12111@redhat.com>
In-Reply-To: <20140109214425.GD12111@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, Prarit Bhargava <prarit@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, KOSAKI Motohiro <kosaki.motohiro@gmail.com>, Dave Young <dyoung@redhat.com>, Len Brown <lenb@kernel.org>

(2014/01/10 6:44), Vivek Goyal wrote:
> On Thu, Jan 09, 2014 at 04:34:16PM -0500, KOSAKI Motohiro wrote:
>> On Thu, Jan 9, 2014 at 10:00 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
>>> On Thu, Jan 09, 2014 at 12:00:29AM +0100, Rafael J. Wysocki wrote:
>>>
>>> [..]
>>>>> The system then panics and the kdump/kexec kernel boots.  During this boot
>>>>> ACPi is initialized and the kernel (as can be seen above)
>>>>
>>>> Which is a bug.  You're not supposed to initialize ACPI twice in a row.
>>>
>>> [CC lkml, kexec mailing list, dave young]
>>>
>>> It is a fresh instance of kernel booting and it is initializing its data
>>> structures fresh. It is *not* re-initializing ACPI in same kernel.
>>>
>>>>> This patchset resolves the problem by adding a kernel parameter,
>>>>> no_memory_hotplug, to disable ACPI memory hotplug.  It can be added by default
>>>>> as a parameter to the kexec/kdump kernel so the kernel boots correctly.
>>>>
>>>> This problem is specific to kexec/kdump, so please don't add *generic* command
>>>> line parameters to address this.
>>>>
>>>
>>> There are other command line options to solve kdump problems. In general
>>> one might want to disable memory hogplug on the fly even if it is compiled
>>> in the kernel. So it can act as a good debugging aid.
>>>
>>> Secondly, it can be specified with memmap=exactmap and mem=X paramters to
>>> make sure no memory is hot added in the system.
>>>
>>> So I can see other usages of this parameter. To me it makes sense to have
>>> a separate command line option to disable memory hotplug feature on the
>>> fly.
>>
>> I'm ok this option. But note, even if this option is specified, SH,
>> Power and S390 still
>> be able to use memory hotplug because their firmware are totally
>> different from ACPI.
>>
>> Maybe, adding acpi prefix provides good clarification.
>

> Makes sense. Something like "acpi_no_memhotplug" or "acpi_disable_memhotplug"
> or something else.

I like Prarit's patch and the boot option name. If it is updated,
I'll test it.

Thanks,
Yasuaki Ishimatsu

>
> Thanks
> Vivek
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
