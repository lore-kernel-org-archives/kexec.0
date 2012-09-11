Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TBRgY-0007dl-7e
 for kexec@lists.infradead.org; Tue, 11 Sep 2012 14:43:31 +0000
Date: Tue, 11 Sep 2012 10:43:23 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC][PATCH] Reset PCIe devices to address DMA problem on kdump
 with iommu
Message-ID: <20120911144323.GF12039@redhat.com>
References: <501BB4EF.7080909@jp.fujitsu.com>
 <20120803114643.GA28330@redhat.com>
 <501F4877.5050605@jp.fujitsu.com>
 <20120806203902.GH25559@redhat.com>
 <50473306.1070803@jp.fujitsu.com> <20120910143604.GB639@redhat.com>
 <504F1343.7030607@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <504F1343.7030607@jp.fujitsu.com>
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

On Tue, Sep 11, 2012 at 07:32:35PM +0900, Takao Indoh wrote:

[..]
> I'll post new patch which clears bus master bit and resets devices in
> second kernel.
> 
> As to the boot parameter to enable this function, you suggested using
> reset_devices. I found that on a certain platform resetting devices
> caused PCIe error due to a hardware bug. Therefore I think we need
> new parameter apart from reset_devices to disable this function on
> such a machine.

Can you explain a bit more how the error happens. I still don't think
that because of a bug in a platform somewhere we should be introducing
a separate command line parameter and not reuse the exisiting one. Also
you have not explained what's the bug and how a new parameter will 
avoid the bug.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
