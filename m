Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TE9Ys-0007g6-75
 for kexec@lists.infradead.org; Wed, 19 Sep 2012 01:58:47 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 143463EE0AE
 for <kexec@lists.infradead.org>; Wed, 19 Sep 2012 10:58:40 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id F2DBB45DE4E
 for <kexec@lists.infradead.org>; Wed, 19 Sep 2012 10:58:39 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id DC59245DE4D
 for <kexec@lists.infradead.org>; Wed, 19 Sep 2012 10:58:39 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id CED5E1DB802C
 for <kexec@lists.infradead.org>; Wed, 19 Sep 2012 10:58:39 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 885E51DB8038
 for <kexec@lists.infradead.org>; Wed, 19 Sep 2012 10:58:39 +0900 (JST)
Message-ID: <5059256B.2010708@jp.fujitsu.com>
Date: Wed, 19 Sep 2012 10:52:43 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Reset PCIe devices to address DMA problem on kdump
 with iommu
References: <501BB4EF.7080909@jp.fujitsu.com>
 <20120803114643.GA28330@redhat.com> <501F4877.5050605@jp.fujitsu.com>
 <20120806203902.GH25559@redhat.com> <50473306.1070803@jp.fujitsu.com>
 <20120910143604.GB639@redhat.com> <504F1343.7030607@jp.fujitsu.com>
 <20120914200334.GA9041@phenom.dumpdata.com>
In-Reply-To: <20120914200334.GA9041@phenom.dumpdata.com>
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
To: konrad@kernel.org
Cc: martin.wilck@ts.fujitsu.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, vgoyal@redhat.com

(2012/09/15 5:03), Konrad Rzeszutek Wilk wrote:
>> As to the boot parameter to enable this function, you suggested using
>> reset_devices. I found that on a certain platform resetting devices
>> caused PCIe error due to a hardware bug. Therefore I think we need
>> new parameter apart from reset_devices to disable this function on
>> such a machine.
>
> Wouldn't a DMI quirk be better for this? That way the second kernel
> internally would know not to do this.

That sounds good. I'll try it, thanks.

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
