Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZx0B-0000AQ-Bi
 for kexec@lists.infradead.org; Sun, 18 Nov 2012 05:01:03 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
 <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
 <87fw48zldz.fsf@xmission.com>
 <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
 <CAE9FiQXNDEPw6WhfgYspqZsy+VVrPoA7M4kKo+5N95=22WBpkQ@mail.gmail.com>
 <50A86563.30303@zytor.com> <876253sej9.fsf@xmission.com>
 <50A86A4D.8090503@zytor.com>
Date: Sat, 17 Nov 2012 21:00:08 -0800
In-Reply-To: <50A86A4D.8090503@zytor.com> (H. Peter Anvin's message of "Sat,
 17 Nov 2012 20:55:41 -0800")
Message-ID: <87haonqzdz.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/8] add mem64_min/max control
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 11/17/2012 08:47 PM, Eric W. Biederman wrote:
>>>
>>> I don't think that is feasible; we need access to this structure
>>> extremely early.  I think if you're using the 64-bit entry point it
>>> has to be an entry condition that those structures are mapped.  It
>>> simply becomes a precondition for using the 64-bit entry point.
>>
>> 64bit purgatory coming from kexec should be running with a page table
>> that identity maps everything loaded by kexec and in practice all of
>> memory.
>>
>> We should still be using that page table when we enter the new kernel.
>>
>> However then the 64bit kernel switches to it's own page tables.
>>
>> So after that point we potentially need early_ioremap, because the
>> kernel's page tables may not have covered the boot_params.  Certainly we
>> need to do something to ensure the kernels page table covers boot_params.
>>
>
> The easy way to fix that is to do what we do on 32 bits: we copy it
> into the bss before we turn paging on (the 64-bit equivalent is before
> we switch to the new page tables.)  That way we know where it is, at
> least for the bounded-size data items.

Whatever works.  It sounds like six of one half a dozen of the other to
me.  Last I looked early_ioremap works as soon as paging is enabled on
x86_64.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
