Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g2t2353.austin.hp.com ([15.217.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsLml-0007ir-Ec
 for kexec@lists.infradead.org; Wed, 13 May 2015 01:48:36 +0000
Message-ID: <5552AD1B.6030208@hp.com>
Date: Wed, 13 May 2015 09:47:07 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v11 05/10] iommu/vt-d: Add functions to load and save
 old re
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-6-git-send-email-zhen-hual@hp.com>
 <20150512083745.GE4561@localhost.localdomain>
In-Reply-To: <20150512083745.GE4561@localhost.localdomain>
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
To: Dave Young <dyoung@redhat.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li,
 ZhenHua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

On 05/12/2015 04:37 PM, Dave Young wrote:
> Seems the subject was truncated? Maybe "re" means root entry? Then please fix it
>
> On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
>> Add functions to load root entry table from old kernel, and to save updated
>> root entry table.
>> Add two member in struct intel_iommu, to store the RTA in old kernel, and
>> the mapped virt address of it.
>
> Please explain a bit what is "RTA" in patch log, it is unclear to most of people
> who do not know iommu details.
>
>>

If people want to understand this patchset, I assume they have read the 
vt-d specs. RTA is defined clearly in this spec.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
