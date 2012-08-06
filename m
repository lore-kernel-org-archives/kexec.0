Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SyU50-0001MQ-Tw
 for kexec@lists.infradead.org; Mon, 06 Aug 2012 20:39:12 +0000
Date: Mon, 6 Aug 2012 16:39:02 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC][PATCH] Reset PCIe devices to address DMA problem on kdump
 with iommu
Message-ID: <20120806203902.GH25559@redhat.com>
References: <501BB4EF.7080909@jp.fujitsu.com>
 <20120803114643.GA28330@redhat.com>
 <501F4877.5050605@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <501F4877.5050605@jp.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: martin.wilck@ts.fujitsu.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com

On Mon, Aug 06, 2012 at 01:30:47PM +0900, Takao Indoh wrote:
> Hi Vivek,
> 
> (2012/08/03 20:46), Vivek Goyal wrote:
> > On Fri, Aug 03, 2012 at 08:24:31PM +0900, Takao Indoh wrote:
> >> Hi all,
> >>
> >> This patch adds kernel parameter "reset_pcie_devices" which resets PCIe
> >> devices at boot time to address DMA problem on kdump with iommu. When
> >> this parameter is specified, a hot reset is triggered on each PCIe root
> >> port and downstream port to reset its downstream endpoint.
> >
> > Hi Takao,
> >
> > Why not use existing "reset_devices" parameter instead of introducing
> > a new one?
> 
> "reset_devices" is used for each driver to reset their own device, and
> this patch resets all devices forcibly, so I thought they were different
> things.

Yes reset_devices currently is used for driver to reset its device. I
thought one could very well extend its reach to reset pci express devices
at bus level.

Having them separate is not going to be much useful from kdump
perspective. We will end up passing both reset_devices and
reset_pcie_devices to second kernel whill lead to bus level reset as well
as device level reset.

Ideal situation would be that somehow detect that bus level reset has been
done and skip device level reset (assuming bus level reset obviates the
need of device level reset, please correct me if that's not the case). 

After pcie reset, can we store the state in a variable and drivers can
use that variable to check if PCIe level reset was done or not. If yes,
skip device level reset (Assuming driver knows that device is on a
PCIe slot).

In that case we will not have to introduce new kernel command line, and
also avoid double reset?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
