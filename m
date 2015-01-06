Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y8OEW-0006YL-3k
 for kexec@lists.infradead.org; Tue, 06 Jan 2015 07:07:16 +0000
Message-ID: <54AB894A.3070601@hp.com>
Date: Tue, 06 Jan 2015 15:05:46 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1419239729-26529-1-git-send-email-zhen-hual@hp.com>
 <20150106063718.GA2454@dhcp-16-105.nay.redhat.com>
In-Reply-To: <20150106063718.GA2454@dhcp-16-105.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>, indou.takao@jp.fujitsu.com
Cc: alex.williamson@redhat.com, tom.vaden@hp.com, dwmw2@infradead.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com, vgoyal@redhat.com

According to Takao Indoh's testing, seems adding flush after loading old 
irte and updating old irte does not fix the dmar faults.

According to Takao Indoh's log and your log, the faults happens while 
and after driver is loaded.  Maybe I am using incorrect code in 08/10.


On 01/06/2015 02:37 PM, Baoquan He wrote:
> Hi Zhenhua,
>
> I just tested your patchset based on 3.19.0-rc2+, and found several dmar
> fault and intr-remap fault, it seems not the same as Takao's, please
> check the attachment.
>
> Thanks
> Baoquan
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
