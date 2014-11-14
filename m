Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g2t2354.austin.hp.com ([15.217.128.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XpC04-0001tk-O6
 for kexec@lists.infradead.org; Fri, 14 Nov 2014 08:13:01 +0000
Message-ID: <5465B952.3010702@hp.com>
Date: Fri, 14 Nov 2014 16:12:02 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] x86/iommu: fix incorrect bit operations in setting
 values
References: <1415172619-4801-1-git-send-email-zhen-hual@hp.com>
 <20141112112832.GA3334@dhcp-17-108.nay.redhat.com> <546474AF.2030902@hp.com>
 <20141113133708.GA1678@dhcp-17-102.nay.redhat.com> <54655B0F.5070204@hp.com>
In-Reply-To: <54655B0F.5070204@hp.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: Minfei Huang <mhuang@redhat.com>, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Li, ZhenHua" <zhen-hual@hp.com>, dwmw2@infradead.org


> 1st step shows we should NOT disable the iommu when it is already
> enabled. But current code does disable-enable. So there is still works
> to do.
>

The original kernel does a disable and re-enable , Bill's patchset 
removed the disable operation.

> I think step 2 is necessary, because when the driver initializes, the
> device need a new map, and the old data from the old kernel can not be
> used for the new driver.
>
> Now I am trying to implement these ideas.
>
>> Thanks

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
