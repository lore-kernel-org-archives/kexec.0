Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ia0-x22a.google.com ([2607:f8b0:4001:c02::22a])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U00my-00025v-9i
 for kexec@lists.infradead.org; Tue, 29 Jan 2013 02:19:09 +0000
Received: by mail-ia0-f170.google.com with SMTP id k20so5289821iak.15
 for <kexec@lists.infradead.org>; Mon, 28 Jan 2013 18:19:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <51072FEF.50000@zytor.com>
References: <1358868049-19884-1-git-send-email-trenn@suse.de>
 <CAE9FiQWJqWQJhoJb2dBn=iAsKjxuf3MJro-jz+6k+WNZor8-xQ@mail.gmail.com>
 <CAE9FiQWXcwagEb0jdFfdHvNcByNxtaLbvvoRC-jAppQmiGS22w@mail.gmail.com>
 <6950516.1uefDuthAH@hammer82.arch.suse.de>
 <510721C6.6080705@zytor.com>
 <CAE9FiQWDcFR+6L-GiR6rk60TC0zH=xewyH_h1Rx_QB+8PTiU3Q@mail.gmail.com>
 <51072FEF.50000@zytor.com>
Date: Mon, 28 Jan 2013 18:19:07 -0800
Message-ID: <CAE9FiQVG4ShGKSdjzYhQaXNNhS=MVNJg=QqG1yW-mAUscErXMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86 e820: Introduce memmap=resetusablemap for kdump
 usage
From: Yinghai Lu <yinghai@kernel.org>
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
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com

On Mon, Jan 28, 2013 at 6:11 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 01/28/2013 06:10 PM, Yinghai Lu wrote:
>>
>>
>> kexec-tools will change that to E820_KDUMP_RESERVED (or other good name).
>>
>> We only need to update kernel to get old max_pfn by
>> checking E820_KDUMP_RESERVED.
>>
>
> OK, I have asked this before, but I still have not gotten any acceptable
> answer:
>
> Why do we still have max_*_pfn at all?  Shouldn't it all be based on
> memblocks by now?

saved_max_pfn is used for kdump:
drivers/char/mem.c::read_oldmem will stop there.
...
        while (count) {
                pfn = *ppos / PAGE_SIZE;
                if (pfn > saved_max_pfn)
                        return read;
...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
