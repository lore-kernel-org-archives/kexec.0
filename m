Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsMQP-0000ow-5R
 for kexec@lists.infradead.org; Wed, 13 May 2015 02:29:33 +0000
Message-ID: <5552B6B4.5080206@hp.com>
Date: Wed, 13 May 2015 10:28:04 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v11 07/10] iommu/vt-d: enable kdump support in iommu module
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-8-git-send-email-zhen-hual@hp.com>
 <20150513021027.GA3736@dhcp-128-28.nay.redhat.com>
In-Reply-To: <20150513021027.GA3736@dhcp-128-28.nay.redhat.com>
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

>> +static u8 g_translation_pre_enabled;
> Hi Zhenhua,
>
> I haven't checked patch one by one, am going through the code flow.
>
> About g_translation_pre_enabled, I don't think it's necessary to define
> it as a global variable. Both its assignment and judgement are in
> init_dmars(). In this situation a local variable translation_pre_enabled
> in init_dmars() is enough.
>
> You can assign value to it here:
>
> 		iommu_check_pre_te_status(iommu);
> 		if (iommu->pre_enabled_trans) {
> 			translation_pre_enabled = 1;
> 			...
> 		}
>
> Thanks
> Baoquan
>
Hi Baoquan,
This variable is only be used in this file, for it is defined as static.
Till now, I think both global and local variable are fine, got the same
thing.
But I believe global is better, because if other functions want to know 
whether translation is enabled, this global variable is a good choice.

Thanks
Zhenhua






_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
