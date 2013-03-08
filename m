Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ia0-x22a.google.com ([2607:f8b0:4001:c02::22a])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDqub-0001HR-Qd
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 06:36:14 +0000
Received: by mail-ia0-f170.google.com with SMTP id h8so1214254iaa.29
 for <kexec@lists.infradead.org>; Thu, 07 Mar 2013 22:36:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUtDcwJkPMPfjur8LQ+u0Hc2J7sbxC=xkcemqRQ1_Gd8g@mail.gmail.com>
References: <51397D1D.5030602@redhat.com>
 <1750036321.11235774.1362722613994.JavaMail.root@redhat.com>
 <CAE9FiQUtDcwJkPMPfjur8LQ+u0Hc2J7sbxC=xkcemqRQ1_Gd8g@mail.gmail.com>
Date: Thu, 7 Mar 2013 22:36:12 -0800
Message-ID: <CAE9FiQU7ccdWCL=t=Zn1w33GHpHk56=JXTcotn-Huq9Wiqu7wg@mail.gmail.com>
Subject: Re: 3.9-rc1: crash kernel panic - not syncing: Can not allocate
 SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: CAI Qian <caiqian@redhat.com>
Cc: kexec <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>

On Thu, Mar 7, 2013 at 10:32 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Mar 7, 2013 at 10:03 PM, CAI Qian <caiqian@redhat.com> wrote:
>> CC'ing kexec ML. Also mentioned that 3.8 has no such issue.
>>
>> This message looks suspicious and out of range while 3.8 reservation
>> looks within the range.
>>
>> [    0.000000] Reserving 128MB of memory at 5216MB for crashkernel
>> (System RAM: 3977MB)
>>
>> Wondering if anything to do with memblock again...
>
> that is intended...
>
>> ----- Original Message -----
>>> From: "WANG Chao" <chaowang@redhat.com>
>>> To: "LKML" vger.kernel.org>
>>> Cc: "CAI Qian" <caiqian@redhat.com>
>>> Sent: Friday, March 8, 2013 1:54:37 PM
>>> Subject: 3.9-rc1: crash kernel panic - not syncing: Can not allocate SWIOTLB buffer earlier and can't now provide you
>>> with the DMA bounce buffer
>>>
>>> Hi, All
>>>
>>> On 3.9-rc1, I load crash kernel with latest kexec-tools(up to
>>> 28d413a), but
>>> 2nd kernel panic at early time:
>>> [    2.948076] Kernel panic - not syncing: Can not allocate SWIOTLB
>>> buffer earlier and can't now provide you with the DMA bounce buffer
>>> [    2.959958] Pid: 53, comm: khubd Not tainted 3.9.0-rc1+ #1
>
> You need to add crashkernel_low=64M in first kernel.
>
> As your system does not support DMA remapping.

looks like your system DO have DMAR table, please enable dmar
remapping in your kernel config.

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
