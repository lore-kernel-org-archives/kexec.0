Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YpW8U-0006Ow-US
 for kexec@lists.infradead.org; Tue, 05 May 2015 06:15:19 +0000
Date: Tue, 5 May 2015 14:14:23 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Message-ID: <20150505061423.GC31063@dhcp-128-4.nay.redhat.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
 <20150415005731.GC19051@localhost.localdomain>
 <552DFB56.1070600@hp.com>
 <20150415064803.GF19051@localhost.localdomain>
 <20150424080147.GC4458@dhcp-16-116.nay.redhat.com>
 <20150424082528.GA23912@dhcp-128-91.nay.redhat.com>
 <20150424083530.GD4458@dhcp-16-116.nay.redhat.com>
 <20150424084957.GC23912@dhcp-128-91.nay.redhat.com>
 <20150504162318.GH15736@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150504162318.GH15736@8bytes.org>
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
To: Joerg Roedel <joro@8bytes.org>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, Baoquan He <bhe@redhat.com>, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li, ZhenHua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

On 05/04/15 at 06:23pm, Joerg Roedel wrote:
> On Fri, Apr 24, 2015 at 04:49:57PM +0800, Dave Young wrote:
> > I'm more than happy to see this issue can be fixed in the patchset, I
> > do not agree to add the code there with such problems. OTOH, for now
> > seems there's no way to fix it.
> 
> And that's the point. We discuss this issue and possible solutions for
> years by now, and what ZhenHua implemented is what we agreed to be the
> best-effort on what we can do in the kdump case with IOMMU enabled.
> 
> Of course there are still failure scenarios left, but that is not
> different from systems without any IOMMU.

The failure is nothing different, but as I said in another reply the
difference is we could use corrupted data to possiblly cause more failure. 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
