Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YqWgG-0000Bh-4Y
 for kexec@lists.infradead.org; Fri, 08 May 2015 01:02:20 +0000
Message-ID: <554C0AC7.2080705@hp.com>
Date: Fri, 08 May 2015 09:00:55 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
 <20150429112024.GB5799@dhcp-16-116.nay.redhat.com>
 <20150503085530.GK15033@dhcp-16-116.nay.redhat.com> <5546E240.5090403@hp.com>
 <20150504031749.GF5799@dhcp-16-116.nay.redhat.com>
 <20150507173200.GF20611@8bytes.org>
In-Reply-To: <20150507173200.GF20611@8bytes.org>
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
To: Joerg Roedel <joro@8bytes.org>
Cc: "Li, ZhenHua" <zhen-hual@hp.com>, indou.takao@jp.fujitsu.com, Baoquan He <bhe@redhat.com>, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, alex.williamson@redhat.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

Hi Joerg,
This problem is caused by the latest updates in iommu module, and we are 
trying to fix it.
When it is fixed, we will send out a new version of the patchset.

Thanks
Zhenhua

On 05/08/2015 01:32 AM, Joerg Roedel wrote:
> Hi Baoquan, ZhenHua,
>
> On Mon, May 04, 2015 at 11:17:49AM +0800, Baoquan He wrote:
>> On 05/04/15 at 11:06am, Li, ZhenHua wrote:
>>> Hi baoquan,
>>> Could you paste the kernel log of the first kernel ?
>
> Please let me know when you have worked this issue out.
>
>
> Thanks,
>
> 	Joerg
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
