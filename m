Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TJDMH-0005Yd-Av
 for kexec@lists.infradead.org; Wed, 03 Oct 2012 01:02:43 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B92E83EE0C3
 for <kexec@lists.infradead.org>; Wed,  3 Oct 2012 10:02:35 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 9C53E45DEB2
 for <kexec@lists.infradead.org>; Wed,  3 Oct 2012 10:02:35 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7D9AF45DEB7
 for <kexec@lists.infradead.org>; Wed,  3 Oct 2012 10:02:35 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6DE711DB8038
 for <kexec@lists.infradead.org>; Wed,  3 Oct 2012 10:02:35 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 1A3B61DB803B
 for <kexec@lists.infradead.org>; Wed,  3 Oct 2012 10:02:35 +0900 (JST)
Message-ID: <506B8D7B.8090004@jp.fujitsu.com>
Date: Wed, 03 Oct 2012 09:57:31 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] Reset PCIe devices to address DMA problem on kdump
 with iommu
References: <20121002074434.204.47750.sendpatchset@indoh>
 <m2mx04wtpz.fsf@firstfloor.org>
In-Reply-To: <m2mx04wtpz.fsf@firstfloor.org>
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
To: andi@firstfloor.org
Cc: martin.wilck@ts.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, mingo@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, vgoyal@redhat.com

(2012/10/03 4:37), Andi Kleen wrote:
> Takao Indoh <indou.takao@jp.fujitsu.com> writes:
>
>> These patches reset PCIe devices at boot time to address DMA problem on
>> kdump with iommu. When "reset_devices" is specified, a hot reset is
>> triggered on each PCIe root port and downstream port to reset its
>> downstream endpoint.
>
> Great. I've been pondering this for a long time, but you did finally
> implement it. I hope this will make kdump a lot more reliable at least
> on the systems that support per port reset.

Actually I got the idea of this patch from your comment below;-)
http://permalink.gmane.org/gmane.linux.network/162414

>
> Now the only question is: why make it a option and not default?

Except kdump I don't know the situation where this reset is useful, so I
introduced it as option so that it works only during kdump.

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
