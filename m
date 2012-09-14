Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TCcHP-0004Rj-6H
 for kexec@lists.infradead.org; Fri, 14 Sep 2012 20:14:24 +0000
Received: by qafk1 with SMTP id k1so173122qaf.15
 for <kexec@lists.infradead.org>; Fri, 14 Sep 2012 13:14:20 -0700 (PDT)
Date: Fri, 14 Sep 2012 16:03:36 -0400
From: Konrad Rzeszutek Wilk <konrad@kernel.org>
Subject: Re: [RFC][PATCH] Reset PCIe devices to address DMA problem on kdump
 with iommu
Message-ID: <20120914200334.GA9041@phenom.dumpdata.com>
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
Cc: martin.wilck@ts.fujitsu.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, vgoyal@redhat.com

> As to the boot parameter to enable this function, you suggested using
> reset_devices. I found that on a certain platform resetting devices
> caused PCIe error due to a hardware bug. Therefore I think we need
> new parameter apart from reset_devices to disable this function on
> such a machine.

Wouldn't a DMI quirk be better for this? That way the second kernel
internally would know not to do this.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
