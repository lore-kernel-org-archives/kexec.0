Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cJY2Z-0005VE-Vj
 for kexec@lists.infradead.org; Wed, 21 Dec 2016 03:58:09 +0000
Received: by mail-wm0-f50.google.com with SMTP id u144so38230425wmu.1
 for <kexec@lists.infradead.org>; Tue, 20 Dec 2016 19:57:47 -0800 (PST)
Subject: Re: [PATCHv2 2/2] [fs] proc/vmcore: check the dummy place holder for
 offline cpu to avoid warning
References: <1482113327-19103-1-git-send-email-piliu@redhat.com>
 <1482113327-19103-2-git-send-email-piliu@redhat.com>
 <20161219024018.GB29921@dhcp-128-65.nay.redhat.com>
 <6691e874-e47a-0028-a2f8-59e431613d6f@redhat.com>
 <5859F65D.1060506@redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <569964b8-aa13-11cf-5825-bb830a940277@redhat.com>
Date: Wed, 21 Dec 2016 09:27:37 +0530
MIME-Version: 1.0
In-Reply-To: <5859F65D.1060506@redhat.com>
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
To: xlpang@redhat.com, Dave Young <dyoung@redhat.com>, Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, kernelfans@gmail.com



On Wednesday 21 December 2016 08:56 AM, Xunlei Pang wrote:
> On 12/20/2016 at 11:38 PM, Pratyush Anand wrote:
>>
>>
>> On Monday 19 December 2016 08:10 AM, Dave Young wrote:
>>> Hi, Pingfan
>>>
>>> On 12/19/16 at 10:08am, Pingfan Liu wrote:
>>>>> kexec-tools always allocates program headers for present cpus. But
>>>>> when crashing, offline cpus have dummy headers. We do not copy these
>>>>> dummy notes into ELF file, also have no need of warning on them.
>>> I still think it is not worth such a fix, if you feel a lot of warnings
>>> in case large cpu numbers, I think you can change the pr_warn to
>>> pr_warn_once, we do not care the null cpu notes if it has nothing bad
>>> to the vmcore.
>>>
>>
>> I agree. Warning is more like information here. May be, we can count the number of times real_sz was 0, and then can print an info at the end in stead of warning, like..."N number of CPUs would have been offline, PT_NOTE entries was absent for them."
>
> Well, OTOH the warning may also be due to some user-space misuse, we can't distinguish that without extra information added.

Yes, yes..I agree, I meant that the above info is just indicative. May 
be "might have been" could be better word than "would have been" in the 
above info print message.


>
> Another possible user-space fix would be: Firstly fix kexec-tools to add notes only for online cpus,
> then utilize udev rules(cpu online/offline events) to automatically trigger kdump kernel reload.

Hummm..this is certainly possible. But can we do much even when we get 
the info that the PT_NOTE was compromised by user space?

Therefore, I am of the view that if at all we are concerned about number 
of warning messages in case of multiple offline cpu, then we can just 
print the total number of NULL PT_NOTE at the end of loop.

~Pratyush



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
