Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U00uw-0002v2-Ho
 for kexec@lists.infradead.org; Tue, 29 Jan 2013 02:27:23 +0000
In-Reply-To: <CAE9FiQVG4ShGKSdjzYhQaXNNhS=MVNJg=QqG1yW-mAUscErXMA@mail.gmail.com>
References: <1358868049-19884-1-git-send-email-trenn@suse.de>
 <CAE9FiQWJqWQJhoJb2dBn=iAsKjxuf3MJro-jz+6k+WNZor8-xQ@mail.gmail.com>
 <CAE9FiQWXcwagEb0jdFfdHvNcByNxtaLbvvoRC-jAppQmiGS22w@mail.gmail.com>
 <6950516.1uefDuthAH@hammer82.arch.suse.de> <510721C6.6080705@zytor.com>
 <CAE9FiQWDcFR+6L-GiR6rk60TC0zH=xewyH_h1Rx_QB+8PTiU3Q@mail.gmail.com>
 <51072FEF.50000@zytor.com>
 <CAE9FiQVG4ShGKSdjzYhQaXNNhS=MVNJg=QqG1yW-mAUscErXMA@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] x86 e820: Introduce memmap=resetusablemap for kdump
 usage
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 28 Jan 2013 18:27:15 -0800
Message-ID: <4302d59f-5c87-4b82-af16-9f54625fc9ce@email.android.com>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com

To be more clear: the max_pfn stuff seems like a relic of the past, and I am wondering what it would take to get rid of it.

It clearly has the wrong semantics, except perhaps in the most trivial allocator models.

Yinghai Lu <yinghai@kernel.org> wrote:

>On Mon, Jan 28, 2013 at 6:11 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> On 01/28/2013 06:10 PM, Yinghai Lu wrote:
>>>
>>>
>>> kexec-tools will change that to E820_KDUMP_RESERVED (or other good
>name).
>>>
>>> We only need to update kernel to get old max_pfn by
>>> checking E820_KDUMP_RESERVED.
>>>
>>
>> OK, I have asked this before, but I still have not gotten any
>acceptable
>> answer:
>>
>> Why do we still have max_*_pfn at all?  Shouldn't it all be based on
>> memblocks by now?
>
>saved_max_pfn is used for kdump:
>drivers/char/mem.c::read_oldmem will stop there.
>...
>        while (count) {
>                pfn = *ppos / PAGE_SIZE;
>                if (pfn > saved_max_pfn)
>                        return read;
>...

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
