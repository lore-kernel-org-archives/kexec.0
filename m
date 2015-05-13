Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsSr3-0007v6-7m
 for kexec@lists.infradead.org; Wed, 13 May 2015 09:21:30 +0000
Date: Wed, 13 May 2015 17:21:02 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v11 04/10] iommu/vt-d: functions to copy data from old mem
Message-ID: <20150513092102.GG3736@dhcp-128-28.nay.redhat.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-5-git-send-email-zhen-hual@hp.com>
 <20150513090035.GE3736@dhcp-128-28.nay.redhat.com>
 <555315A1.5020402@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <555315A1.5020402@hp.com>
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
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com, vgoyal@redhat.com

On 05/13/15 at 05:13pm, Li, ZhenHua wrote:
> Hi Baoquan,
> I am using a list here to store all the mapped addresses, and unmap
> them out of iounmap.

> 
> About the reason, please check the old mails. I cannot remember the
> detailed reasons.

Yeah, I understand that the list is used to collect all mapped addresses
and unmap them all after spin_unlock_irqsave. 

that's why it's better to put the reason in patch log. Patch log is used
to record this kind of explanation so that you needn't say it again and
again. My personal opinion.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
