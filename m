Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TBitA-0000Zu-Ae
 for kexec@lists.infradead.org; Wed, 12 Sep 2012 09:05:41 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 52F913EE0BB
 for <kexec@lists.infradead.org>; Wed, 12 Sep 2012 18:05:35 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 37C3C45DE5A
 for <kexec@lists.infradead.org>; Wed, 12 Sep 2012 18:05:35 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1E94B45DE56
 for <kexec@lists.infradead.org>; Wed, 12 Sep 2012 18:05:35 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id EC4E01DB803C
 for <kexec@lists.infradead.org>; Wed, 12 Sep 2012 18:05:34 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9E69A1DB8051
 for <kexec@lists.infradead.org>; Wed, 12 Sep 2012 18:05:34 +0900 (JST)
Message-ID: <50504F47.80909@jp.fujitsu.com>
Date: Wed, 12 Sep 2012 18:00:55 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Reset PCIe devices to address DMA problem on kdump
 with iommu
References: <501BB4EF.7080909@jp.fujitsu.com>
 <20120803114643.GA28330@redhat.com> <501F4877.5050605@jp.fujitsu.com>
 <20120806203902.GH25559@redhat.com> <50473306.1070803@jp.fujitsu.com>
 <20120910143604.GB639@redhat.com> <504F1343.7030607@jp.fujitsu.com>
 <20120911144323.GF12039@redhat.com>
In-Reply-To: <20120911144323.GF12039@redhat.com>
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
To: vgoyal@redhat.com
Cc: martin.wilck@ts.fujitsu.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com

(2012/09/11 23:43), Vivek Goyal wrote:
> On Tue, Sep 11, 2012 at 07:32:35PM +0900, Takao Indoh wrote:
>
> [..]
>> I'll post new patch which clears bus master bit and resets devices in
>> second kernel.
>>
>> As to the boot parameter to enable this function, you suggested using
>> reset_devices. I found that on a certain platform resetting devices
>> caused PCIe error due to a hardware bug. Therefore I think we need
>> new parameter apart from reset_devices to disable this function on
>> such a machine.
>
> Can you explain a bit more how the error happens. I still don't think
> that because of a bug in a platform somewhere we should be introducing
> a separate command line parameter and not reuse the exisiting one. Also
> you have not explained what's the bug and how a new parameter will
> avoid the bug.

The bug I mentioned is that ACS Violation occurs at PCIe switch when
reading PCI configuration after device reset. I got information that
this violation is caused by PCIe switch bug. The machine becomes fatal
status by this error.

The reason why I try to introduce new parameter is that I want to avoid
regression by this patch. Let's say this patch was included in kernel
and its reset function was enabled by reset_devices as you said. AFAIK
reset_devices is always needed for kdump, so it means that devices are
always reset at kdump boot time. It causes a regression that system
always becomes abnormal status when we run kdump on the machine which has
a bug I mentioned.

To avoid this regression, I want to separate reset_devices from this
reset function. Or how about this?
- if user specify reset_devices, devices are reset by this patch, as you
   said.
- To avoid a regression I said, add new parameter like "pci=noreset".
   If this parameter is specified, the reset function I add is disabled
   and we can avoid regression.

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
