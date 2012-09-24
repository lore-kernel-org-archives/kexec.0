Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TG6ey-0002Vv-0k
 for kexec@lists.infradead.org; Mon, 24 Sep 2012 11:17:09 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 85C2B3EE0BD
 for <kexec@lists.infradead.org>; Mon, 24 Sep 2012 20:17:02 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6553D45DE5E
 for <kexec@lists.infradead.org>; Mon, 24 Sep 2012 20:17:02 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4DA8245DE5A
 for <kexec@lists.infradead.org>; Mon, 24 Sep 2012 20:17:02 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3E2B51DB804F
 for <kexec@lists.infradead.org>; Mon, 24 Sep 2012 20:17:02 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id DF2FC1DB8051
 for <kexec@lists.infradead.org>; Mon, 24 Sep 2012 20:17:01 +0900 (JST)
Message-ID: <50604002.8050500@jp.fujitsu.com>
Date: Mon, 24 Sep 2012 20:12:02 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Reset PCIe devices to address DMA problem on kdump
 with iommu
References: <501BB4EF.7080909@jp.fujitsu.com>
 <20120803114643.GA28330@redhat.com> <501F4877.5050605@jp.fujitsu.com>
 <20120806203902.GH25559@redhat.com> <50473306.1070803@jp.fujitsu.com>
 <20120910143604.GB639@redhat.com> <504F1343.7030607@jp.fujitsu.com>
 <20120914200334.GA9041@phenom.dumpdata.com> <505CAAA1.3040409@redhat.com>
In-Reply-To: <505CAAA1.3040409@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ddutile@redhat.com
Cc: martin.wilck@ts.fujitsu.com, hbabu@us.ibm.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, konrad@kernel.org, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, vgoyal@redhat.com

(2012/09/22 2:57), Don Dutile wrote:
> On 09/14/2012 04:03 PM, Konrad Rzeszutek Wilk wrote:
>>> As to the boot parameter to enable this function, you suggested using
>>> reset_devices. I found that on a certain platform resetting devices
>>> caused PCIe error due to a hardware bug. Therefore I think we need
>>> new parameter apart from reset_devices to disable this function on
>>> such a machine.
>>
>> Wouldn't a DMI quirk be better for this? That way the second kernel
>> internally would know not to do this.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> a DMI quirk for a PCIe switch?  pci-quirk maybe?  there is a hook
> in per-device pci reset code path, which could be setup for such
> a case.

Yep, I think early-quirk is better.

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
