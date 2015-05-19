Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YuW6Z-0004uz-VJ
 for kexec@lists.infradead.org; Tue, 19 May 2015 01:14:00 +0000
Date: Tue, 19 May 2015 09:13:22 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v11 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Message-ID: <20150519011322.GA7065@dhcp-128-76.nay.redhat.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <5552AEE9.80408@hp.com> <5559B97B.5090805@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5559B97B.5090805@hp.com>
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
To: "Li, ZhenHua" <zhen-hual@hp.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

Hi,

On 05/18/15 at 06:05pm, Li, ZhenHua wrote:
> Hi Joerg,
> 
> Testing from HP: passed.
> Testing from He Baoquan(Redhat): passed
> 
> The problem that dmar fault came again when running v10 with latest
> kernel is fixed.
> And I think there is no need to update the code to a new version now.
> 
> So please tell me if there are still any code need to be changed.

Have you reviewed all my comments? Although it is only iommu driver fixes,
The patches are sent to lkml, no? If you do not want other people's comments
why will you send to us? I would say do not assume it is a closed circle for
only iommu driver.

It is not easy to review patches actually, frankly I feel kernel code review
is not so strict like the early days, maybe one reason is people are getting
tired to argue.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
