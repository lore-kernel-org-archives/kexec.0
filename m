Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cqekD-0003Ia-TS
 for kexec@lists.infradead.org; Wed, 22 Mar 2017 11:48:07 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2MBhYPw074446
 for <kexec@lists.infradead.org>; Wed, 22 Mar 2017 07:47:40 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29b9vsg9ec-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 22 Mar 2017 07:47:39 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 22 Mar 2017 17:17:06 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2MBjnur15466644
 for <kexec@lists.infradead.org>; Wed, 22 Mar 2017 17:15:49 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2MBl2hu016163
 for <kexec@lists.infradead.org>; Wed, 22 Mar 2017 17:17:02 +0530
Subject: Re: [PATCH v3 1/3] kexec: Move vmcoreinfo out of the kernel's .bss
 section
References: <1489989033-1179-1-git-send-email-xlpang@redhat.com>
 <87pohbz4lo.fsf@xmission.com>
 <20170322025536.GA4424@dhcp-128-65.nay.redhat.com>
 <87pohaxam1.fsf@xmission.com>
 <20170322043004.GB4424@dhcp-128-65.nay.redhat.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 22 Mar 2017 17:16:56 +0530
MIME-Version: 1.0
In-Reply-To: <20170322043004.GB4424@dhcp-128-65.nay.redhat.com>
Message-Id: <0e9381e2-a44e-aa48-6463-45b571222203@linux.vnet.ibm.com>
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
To: Dave Young <dyoung@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>, Xunlei Pang <xlpang@redhat.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, holzheu@linux.vnet.ibm.com, kexec@lists.infradead.org

Hi Dave,


On Wednesday 22 March 2017 10:00 AM, Dave Young wrote:
> On 03/21/17 at 10:18pm, Eric W. Biederman wrote:
>> Dave Young <dyoung@redhat.com> writes:
>>
>>> On 03/20/17 at 10:33pm, Eric W. Biederman wrote:
>>>> Xunlei Pang <xlpang@redhat.com> writes:
>>>>
>>>>> As Eric said,
>>>>> "what we need to do is move the variable vmcoreinfo_note out
>>>>> of the kernel's .bss section.  And modify the code to regenerate
>>>>> and keep this information in something like the control page.
>>>>>
>>>>> Definitely something like this needs a page all to itself, and ideally
>>>>> far away from any other kernel data structures.  I clearly was not
>>>>> watching closely the data someone decided to keep this silly thing
>>>>> in the kernel's .bss section."
>>>>>
>>>>> This patch allocates extra pages for these vmcoreinfo_XXX variables,
>>>>> one advantage is that it enhances some safety of vmcoreinfo, because
>>>>> vmcoreinfo now is kept far away from other kernel data structures.
>>>> Can you preceed this patch with a patch that removes CRASHTIME from
>>>> vmcoreinfo?  If someone actually cares we can add a separate note that holds
>>>> a 64bit crashtime in the per cpu notes.
>>> I think makedumpfile is using it, but I also vote to remove the
>>> CRASHTIME. It is better not to do this while crashing and a makedumpfile
>>> userspace patch is needed to drop the use of it.
>>>
>>>> As we are looking at reliability concerns removing CRASHTIME should make
>>>> everything in vmcoreinfo a boot time constant.  Which should simplify
>>>> everything considerably.
>>> It is a nice improvement..
>> We also need to take a close look at what s390 is doing with vmcoreinfo.
>> As apparently it is reading it in a different kind of crashdump process.
> Yes, need careful review from s390 and maybe ppc64 especially about
> patch 2/3, better to have comments from IBM about s390 dump tool and ppc
> fadump. Added more cc.

w.r.t powerpc/fadump, this patch-set works fine..

Thanks
Hari


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
