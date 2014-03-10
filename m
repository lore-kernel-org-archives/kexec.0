Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WN7zD-0006jf-2B
 for kexec@lists.infradead.org; Mon, 10 Mar 2014 21:43:51 +0000
Date: Mon, 10 Mar 2014 17:43:18 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCHv3 0/6] Crashdump Accepting Active IOMMU
Message-ID: <20140310214318.GJ4352@redhat.com>
References: <1389391652-52422-1-git-send-email-bill.sumner@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1389391652-52422-1-git-send-email-bill.sumner@hp.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Bill Sumner <bill.sumner@hp.com>
Cc: indou.takao@jp.fujitsu.com, bhe@redhat.com, linux-pci@vger.kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, zhenhua@hp.com, dwmw2@infradead.org

On Fri, Jan 10, 2014 at 03:07:26PM -0700, Bill Sumner wrote:

[..]
> This patch set modifies the behavior of the iommu in the (new) crashdump kernel: 
> 1. to accept the iommu hardware in an active state, 
> 2. to leave the current translations in-place so that legacy DMA will continue
>    using its current buffers until the device drivers in the crashdump kernel
>    initialize and initialize their devices,
> 3. to use different portions of the iova address ranges for the device drivers
>    in the crashdump kernel than the iova ranges that were in-use at the time
>    of the panic.  

Conceptually, above makes sense to me. I have few queries.

- Do we need to pass any kind of data from first kernel to second kernel, 
  like table size etc? Calgary IOMMU was using first kernel's tables
  also and it was determining previous kernel's table size using saved_max_pfn.

- I don't know how IOMMU translation tables look like, but are new DMA
  zones setup by drivers in second kernel part of same table? How do we
  make sure that sufficient space is available. I am not sure if possible
  table corruption from crashed kernel is an issue here or not.

In general, I think changelogs of these patches need to be little better.
There seem to be lot of text and still I can't quickly wrap my head around
what a particular patch is supposed to be doing.

But we definitely need to fix this issue. IOMMU issues with kdump have
been troubling us for a very long time.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
