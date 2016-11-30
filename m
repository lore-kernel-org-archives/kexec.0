Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cC02H-0002gC-Lr
 for kexec@lists.infradead.org; Wed, 30 Nov 2016 08:14:38 +0000
Subject: Re: [PATCH] iommu/vt-d: Flush old iotlb for kdump when the device
 gets context mapped
References: <1479286950-21885-1-git-send-email-xlpang@redhat.com>
 <582C232F.6080205@redhat.com>
 <CAL-B5D1kkWE4e6P1xY1Cgkf-7+nBXH=C7g21=phEzmM4FPZRRQ@mail.gmail.com>
 <582D1A40.409@redhat.com> <20161129143547.GG2078@8bytes.org>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <583E8A9B.7070906@redhat.com>
Date: Wed, 30 Nov 2016 16:15:23 +0800
MIME-Version: 1.0
In-Reply-To: <20161129143547.GG2078@8bytes.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Joerg Roedel <joro@8bytes.org>, xlpang@redhat.com
Cc: Don Brace <don.brace@microsemi.com>, Myron Stowe <myron.stowe@redhat.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Myron Stowe <myron.stowe@gmail.com>, Dave Young <dyoung@redhat.com>, David Woodhouse <dwmw2@infradead.org>

On 11/29/2016 at 10:35 PM, Joerg Roedel wrote:
> On Thu, Nov 17, 2016 at 10:47:28AM +0800, Xunlei Pang wrote:
>> As per the comment, the code here only needs to flush context caches
>> for the special domain 0 which is used to tag the
>> non-present/erroneous caches, seems we should flush the old domain id
>> of present entries for kdump according to the analysis, other than the
>> new-allocated domain id. Let me ponder more on this.
> Flushing the context entry only is fine. The old domain-id will not be
> re-used anyway, so there is no point in reading it out of the context
> table and flush it.

Do you mean to flush the context entry using the new-allocated domain id?

Yes, old domain-id will not be re-used as they were reserved when copy, but
may still be cached by in-flight DMA access.

Here is what the things seem to be from my understanding, and why I want to
flush using the old domain id:
1) In kdump mode, old tables are copied, and all the iommu caches are flushed.
2) There comes some in-flight DMA before the device's new context is mapped,
    so translation caches(context, iotlb, etc) are created tagging old domain-id
    in the iommu hardware.
3) At the driver probe stage, the device is reset , and no in-flight DMA will exist.
    Here I assumed that the device reset won't flush the old caches in the iommu
    hardware related to this device. I haven't found any relevant specification, please
    correct me if I am wrong.
4) Then new context is setup, and new DMA is initiated, hit old cache that was
    created in 2) as currently there's no such flush action, so DMAR fault happens.

I already posted v2 to flush context/iotlb using the old domain-id:
https://lkml.org/lkml/2016/11/18/514

Regards,
Xunlei

>
> Also, please add a Fixes-tag when you re-post this patch.
>
>
> 	Joerg
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
