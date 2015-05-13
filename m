Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsSkI-0001Mn-32
 for kexec@lists.infradead.org; Wed, 13 May 2015 09:14:31 +0000
Message-ID: <555315A1.5020402@hp.com>
Date: Wed, 13 May 2015 17:13:05 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v11 04/10] iommu/vt-d: functions to copy data from old mem
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-5-git-send-email-zhen-hual@hp.com>
 <20150513090035.GE3736@dhcp-128-28.nay.redhat.com>
In-Reply-To: <20150513090035.GE3736@dhcp-128-28.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li,
 ZhenHua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com, vgoyal@redhat.com

Hi Baoquan,
I am using a list here to store all the mapped addresses, and unmap them 
out of iounmap.

About the reason, please check the old mails. I cannot remember the 
detailed reasons.

Thanks
Zhenhua

On 05/13/2015 05:00 PM, Baoquan He wrote:
> On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
>> Add some functions to copy the data from old kernel.
>> These functions are used to copy context tables and page tables.
>>
>> To avoid calling iounmap between spin_lock_irqsave and spin_unlock_irqrestore,
>> use a link here, store the pointers , and then use iounmap to free them in
>> another place.
>
> Hi Zhenhua,
>
> I remember you mentioned iounmap will cause error inside
> spin_lock_irqsave. Do you know why it happened now? And could you also
> describe why avoid calling iounmap between
> spin_lock_irqsave/unlock_irqsave  is needed here and what's the status
> now?
>
> I think other reviewer may want to know it too.
>
> Thanks
> Baoquan
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
