Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ia-in-x0229.1e100.net ([2607:f8b0:4001:c02::229]
 helo=mail-ia0-x229.google.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U00el-0000vB-Fy
 for kexec@lists.infradead.org; Tue, 29 Jan 2013 02:10:40 +0000
Received: by mail-ia0-f169.google.com with SMTP id j5so5282365iaf.14
 for <kexec@lists.infradead.org>; Mon, 28 Jan 2013 18:10:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <510721C6.6080705@zytor.com>
References: <1358868049-19884-1-git-send-email-trenn@suse.de>
 <CAE9FiQWJqWQJhoJb2dBn=iAsKjxuf3MJro-jz+6k+WNZor8-xQ@mail.gmail.com>
 <CAE9FiQWXcwagEb0jdFfdHvNcByNxtaLbvvoRC-jAppQmiGS22w@mail.gmail.com>
 <6950516.1uefDuthAH@hammer82.arch.suse.de>
 <510721C6.6080705@zytor.com>
Date: Mon, 28 Jan 2013 18:10:38 -0800
Message-ID: <CAE9FiQWDcFR+6L-GiR6rk60TC0zH=xewyH_h1Rx_QB+8PTiU3Q@mail.gmail.com>
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

On Mon, Jan 28, 2013 at 5:11 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> So I guess the final patch should be:
>>    - Add a new e820 type:
>>         E820_KDUMP_RESERVED /* Originally usable memory where the crashed
>>                                                     kernel kernel resided in */
>>   - Use Yinghai's last posted patch, but instead of:
>> +                     e820_update_range(0, ULLONG_MAX, E820_RAM,
>> +                                       E820_RESERVED);
>> ...
>> +                     e820_remove_range(start_at, mem_size, E820_RESERVED, 0);
>> do:
>> +                     e820_update_range(0, ULLONG_MAX, E820_RAM,
>> +                                       E820_KDUMP_RESERVED);
>> ...
>> +                     e820_remove_range(start_at, mem_size, E820_KDUMP_RESERVED, 0);
>>
>>   - Come up with another memmap=kdump_reserve_ram memmap option name
>>     or however it should get named...
>>
>> If this proposal gets accepted, I can send a tested patch...
>>
>
> Yes, this is much saner.  There really shouldn't need to be an option,
> even; since the tools need to be modified anyway, just modify the actual
> memory map data structure itself.

yes,

kexec-tools will change that to E820_KDUMP_RESERVED (or other good name).

We only need to update kernel to get old max_pfn by
checking E820_KDUMP_RESERVED.

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
