Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t5425.austin.hp.com ([15.216.225.55])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yp6jo-0006Xb-Ct
 for kexec@lists.infradead.org; Mon, 04 May 2015 03:08:08 +0000
Message-ID: <5546E240.5090403@hp.com>
Date: Mon, 04 May 2015 11:06:40 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
 <20150429112024.GB5799@dhcp-16-116.nay.redhat.com>
 <20150503085530.GK15033@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20150503085530.GK15033@dhcp-16-116.nay.redhat.com>
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
Cc: indou.takao@jp.fujitsu.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, joro@8bytes.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, alex.williamson@redhat.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

Hi baoquan,
Could you paste the kernel log of the first kernel ?

Thanks
Zhenhua
On 05/03/2015 04:55 PM, Baoquan He wrote:
> On 04/29/15 at 07:20pm, Baoquan He wrote:
>> Bad news, I rebuilt a kernel with your patchset on 4.0.0+ (this commit
>> f614c81). Now dmar fault is  seen again.
>>
>> The lspci log and kdump log are attached, please check:
>
> I found the lspci log previously attached is emtyp, resend it again.
>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
