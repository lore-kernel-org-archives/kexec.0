Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V2MTp-00033J-JF
 for kexec@lists.infradead.org; Thu, 25 Jul 2013 14:25:22 +0000
Date: Thu, 25 Jul 2013 10:24:46 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] PCI: Reset PCIe devices to stop ongoing DMA
Message-ID: <20130725142446.GK11993@redhat.com>
References: <1368509365-2260-1-git-send-email-indou.takao@jp.fujitsu.com>
 <CAErSpo4t_2Xw76p3Z9FVzyyK-MBovavDu9D=pYoPMjESSxgT=w@mail.gmail.com>
 <51B19DF3.2070009@jp.fujitsu.com>
 <CAErSpo6dfEnzriHD_aWZB_3E-kSzauhNRHPd+VuFX5HONVKgqw@mail.gmail.com>
 <51B6BEDB.3000509@jp.fujitsu.com>
 <CAErSpo5u8qGALt6C+tuPYXdd2YgyMH6fnPnA+afUteEZ7kY0iw@mail.gmail.com>
 <51B93221.2040505@jp.fujitsu.com>
 <CAErSpo5tVK-Z3aOdMTzab-S8o5zLVtDOFQ8-LSYpUgbrJSsxuw@mail.gmail.com>
 <51BA7BB6.1080104@jp.fujitsu.com> <51EF7466.20703@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51EF7466.20703@jp.fujitsu.com>
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
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: alex.williamson@redhat.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, bill.sumner@hp.com

On Wed, Jul 24, 2013 at 03:29:58PM +0900, Takao Indoh wrote:
> Sorry for letting this discussion slide, I was busy on other works:-(
> Anyway, the summary of previous discussion is:
> - My patch adds new initcall(fs_initcall) to reset all PCIe endpoints on
>   boot. This expects PCI enumeration is done before IOMMU
>   initialization as follows.
>     (1) PCI enumeration
>     (2) fs_initcall ---> device reset
>     (3) IOMMU initialization
> - This works on x86, but does not work on other architecture because
>   IOMMU is initialized before PCI enumeration on some architectures. So,
>   device reset should be done where IOMMU is initialized instead of
>   initcall.
> - Or, as another idea, we can reset devices in first kernel(panic kernel)
> 
> Resetting devices in panic kernel is against kdump policy and seems not to
> be good idea. So I think adding reset code into iommu initialization is
> better. I'll post patches for that.

I don't understand all the details but I agree that idea of trying to
reset IOMMU in crashed kernel might not fly.

> 
> Another discussion point is how to handle buggy devices. Resetting buggy
> devices makes system more unstable. One of ideas is using boot parameter
> so that user can choose to reset devices or not.

So who would decide which device is buggy and don't reset it. Give
some details here.

Can't we simply blacklist associated module, so that it never loads
and then it never tries to reset the devices?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
