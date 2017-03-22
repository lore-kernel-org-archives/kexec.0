Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cqfC1-0000H4-Ne
 for kexec@lists.infradead.org; Wed, 22 Mar 2017 12:16:47 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2MCDrh4042716
 for <kexec@lists.infradead.org>; Wed, 22 Mar 2017 08:16:25 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vn9p79-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 22 Mar 2017 08:16:24 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 22 Mar 2017 22:16:22 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2MCGCMM29425880
 for <kexec@lists.infradead.org>; Wed, 22 Mar 2017 23:16:20 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2MCFmau001408
 for <kexec@lists.infradead.org>; Wed, 22 Mar 2017 23:15:48 +1100
Subject: Re: [PATCH v3 1/3] kexec: Move vmcoreinfo out of the kernel's .bss
 section
References: <1489989033-1179-1-git-send-email-xlpang@redhat.com>
 <87pohbz4lo.fsf@xmission.com>
 <20170322025536.GA4424@dhcp-128-65.nay.redhat.com>
 <87pohaxam1.fsf@xmission.com>
 <20170322043004.GB4424@dhcp-128-65.nay.redhat.com>
 <58D24543.5020700@redhat.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 22 Mar 2017 17:45:28 +0530
MIME-Version: 1.0
In-Reply-To: <58D24543.5020700@redhat.com>
Message-Id: <30b07524-0558-7edb-3b0f-ba5e4976ffb7@linux.vnet.ibm.com>
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
To: xlpang@redhat.com, Dave Young <dyoung@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, holzheu@linux.vnet.ibm.com

Hi Xunlei,


On Wednesday 22 March 2017 03:04 PM, Xunlei Pang wrote:
> On 03/22/2017 at 12:30 PM, Dave Young wrote:
>> On 03/21/17 at 10:18pm, Eric W. Biederman wrote:
>>> Dave Young <dyoung@redhat.com> writes:
>>>
>>>> On 03/20/17 at 10:33pm, Eric W. Biederman wrote:
>>>>> Xunlei Pang <xlpang@redhat.com> writes:
>>>>>
>>>>>> As Eric said,
>>>>>> "what we need to do is move the variable vmcoreinfo_note out
>>>>>> of the kernel's .bss section.  And modify the code to regenerate
>>>>>> and keep this information in something like the control page.
>>>>>>
>>>>>> Definitely something like this needs a page all to itself, and ideally
>>>>>> far away from any other kernel data structures.  I clearly was not
>>>>>> watching closely the data someone decided to keep this silly thing
>>>>>> in the kernel's .bss section."
>>>>>>
>>>>>> This patch allocates extra pages for these vmcoreinfo_XXX variables,
>>>>>> one advantage is that it enhances some safety of vmcoreinfo, because
>>>>>> vmcoreinfo now is kept far away from other kernel data structures.
>>>>> Can you preceed this patch with a patch that removes CRASHTIME from
>>>>> vmcoreinfo?  If someone actually cares we can add a separate note that holds
>>>>> a 64bit crashtime in the per cpu notes.
>>>> I think makedumpfile is using it, but I also vote to remove the
>>>> CRASHTIME. It is better not to do this while crashing and a makedumpfile
>>>> userspace patch is needed to drop the use of it.
>>>>
> By moving the CRASHTIME info to the cpu note of crashed cpu may be a good
> way. In kdump kernel, notes of vmcore elfhdr will be merged into one big note
> section, I don't know how makedumpfile or crash handle the big note section?
> If they process the note in some order, breakage will definitely happen...
>
> There is also a fadump may be affected.
>

Would like to keep a tab of such change as fadump builds cpu notes 
differently
and such change may have an impact on it considering it depends on the same
tools - crash, makedumpfile..

Thanks
Hari


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
