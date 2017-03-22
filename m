Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cqcdD-000284-0h
 for kexec@lists.infradead.org; Wed, 22 Mar 2017 09:32:43 +0000
Subject: Re: [PATCH v3 1/3] kexec: Move vmcoreinfo out of the kernel's .bss
 section
References: <1489989033-1179-1-git-send-email-xlpang@redhat.com>
 <87pohbz4lo.fsf@xmission.com>
 <20170322025536.GA4424@dhcp-128-65.nay.redhat.com>
 <87pohaxam1.fsf@xmission.com>
 <20170322043004.GB4424@dhcp-128-65.nay.redhat.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <58D24543.5020700@redhat.com>
Date: Wed, 22 Mar 2017 17:34:59 +0800
MIME-Version: 1.0
In-Reply-To: <20170322043004.GB4424@dhcp-128-65.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>, Xunlei Pang <xlpang@redhat.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Petr Tesarik <ptesarik@suse.cz>, linux-kernel@vger.kernel.org, hbathini@linux.vnet.ibm.com, akpm@linux-foundation.org, holzheu@linux.vnet.ibm.com, kexec@lists.infradead.org

On 03/22/2017 at 12:30 PM, Dave Young wrote:
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

By moving the CRASHTIME info to the cpu note of crashed cpu may be a good
way. In kdump kernel, notes of vmcore elfhdr will be merged into one big note
section, I don't know how makedumpfile or crash handle the big note section?
If they process the note in some order, breakage will definitely happen...

There is also a fadump may be affected.

Regards,
Xunlei

>>>> As we are looking at reliability concerns removing CRASHTIME should make
>>>> everything in vmcoreinfo a boot time constant.  Which should simplify
>>>> everything considerably.
>>> It is a nice improvement..
>> We also need to take a close look at what s390 is doing with vmcoreinfo.
>> As apparently it is reading it in a different kind of crashdump process.
> Yes, need careful review from s390 and maybe ppc64 especially about
> patch 2/3, better to have comments from IBM about s390 dump tool and ppc
> fadump. Added more cc.
>
> Thanks
> Dave
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
