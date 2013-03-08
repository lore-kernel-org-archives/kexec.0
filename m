Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDrby-0007DI-Og
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 07:21:04 +0000
Message-ID: <51399154.5030500@redhat.com>
Date: Fri, 08 Mar 2013 15:20:52 +0800
From: WANG Chao <chaowang@redhat.com>
MIME-Version: 1.0
Subject: Re: 3.9-rc1: crash kernel panic - not syncing: Can not allocate
 SWIOTLB
 buffer earlier and can't now provide you with the DMA bounce buffer
References: <51397D1D.5030602@redhat.com>
 <1750036321.11235774.1362722613994.JavaMail.root@redhat.com>
 <CAE9FiQUtDcwJkPMPfjur8LQ+u0Hc2J7sbxC=xkcemqRQ1_Gd8g@mail.gmail.com>
 <CAE9FiQU7ccdWCL=t=Zn1w33GHpHk56=JXTcotn-Huq9Wiqu7wg@mail.gmail.com>
In-Reply-To: <CAE9FiQU7ccdWCL=t=Zn1w33GHpHk56=JXTcotn-Huq9Wiqu7wg@mail.gmail.com>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: CAI Qian <caiqian@redhat.com>, kexec <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@linux.intel.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 03/08/2013 02:36 PM, Yinghai Lu wrote:
> On Thu, Mar 7, 2013 at 10:32 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Thu, Mar 7, 2013 at 10:03 PM, CAI Qian <caiqian@redhat.com> wrote:
>>> CC'ing kexec ML. Also mentioned that 3.8 has no such issue.
>>>
>>> This message looks suspicious and out of range while 3.8 reservation
>>> looks within the range.
>>>
>>> [    0.000000] Reserving 128MB of memory at 5216MB for crashkernel
>>> (System RAM: 3977MB)
>>>
>>> Wondering if anything to do with memblock again...
>>
>> that is intended...
>>
>>> ----- Original Message -----
>>>> From: "WANG Chao" <chaowang@redhat.com>
>>>> To: "LKML" vger.kernel.org>
>>>> Cc: "CAI Qian" <caiqian@redhat.com>
>>>> Sent: Friday, March 8, 2013 1:54:37 PM
>>>> Subject: 3.9-rc1: crash kernel panic - not syncing: Can not allocate SWIOTLB buffer earlier and can't now provide you
>>>> with the DMA bounce buffer
>>>>
>>>> Hi, All
>>>>
>>>> On 3.9-rc1, I load crash kernel with latest kexec-tools(up to
>>>> 28d413a), but
>>>> 2nd kernel panic at early time:
>>>> [    2.948076] Kernel panic - not syncing: Can not allocate SWIOTLB
>>>> buffer earlier and can't now provide you with the DMA bounce buffer
>>>> [    2.959958] Pid: 53, comm: khubd Not tainted 3.9.0-rc1+ #1
>>
>> You need to add crashkernel_low=64M in first kernel.
>>
>> As your system does not support DMA remapping.
> 
> looks like your system DO have DMAR table, please enable dmar
> remapping in your kernel config.

I've already got following config:
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_IRQ_REMAP=y

but I don't have intel_iommu=on in kernel cmdline. IIRC, iommu will prevent
2nd kernel from booting ...

I tested crashkernel=128M and crashkernel_low=64M, seems 2nd-kernel/kexec only
works when two params are used in combination.

Thanks,
WANG Chao

> 
> Yinghai
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
