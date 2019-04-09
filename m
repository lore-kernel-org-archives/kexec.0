Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hDhv6-0001t8-4l
 for kexec@lists.infradead.org; Tue, 09 Apr 2019 03:59:38 +0000
Received: by mail-lf1-f67.google.com with SMTP id 10so11130673lfr.8
 for <kexec@lists.infradead.org>; Mon, 08 Apr 2019 20:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190408092239.18012-1-chenzhou10@huawei.com>
 <20190408093626.dlv7u44o355xfwus@verge.net.au>
In-Reply-To: <20190408093626.dlv7u44o355xfwus@verge.net.au>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 9 Apr 2019 11:59:21 +0800
Message-ID: <CACi5LpMQGPYfF=5cRJNv3vu-41Qf_4bewD544=z0R0tADn43oA@mail.gmail.com>
Subject: Re: [RESEND PATCH] arm64: support more than one crash kernel regions
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Chen Zhou <chenzhou10@huawei.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangkefeng.wang@huawei.com, kexec mailing list <kexec@lists.infradead.org>

Hi Simon, Chen,

On Mon, Apr 8, 2019 at 5:36 PM Simon Horman <horms@verge.net.au> wrote:
>
> On Mon, Apr 08, 2019 at 05:22:39PM +0800, Chen Zhou wrote:
> > When crashkernel is reserved above 4G in memory, kernel should
> > reserve some amount of low memory for swiotlb and some DMA buffers.
> > So there may be two crash kernel regions, one is below 4G, the other
> > is above 4G.
> >
> > Currently, there is only one crash kernel region on arm64, and pass
> > "linux,usable-memory-range = <BASE SIZE>" property to crash dump
> > kernel. Now, we pass
> > "linux,usable-memory-range = <BASE1 SIZE1 BASE2 SIZE2>" to crash
> > dump kernel to support two crash kernel regions and load crash
> > kernel high.
> >
> > This patch paves the way for the use of arm64 reserving crashkernel
> > above 4G. The details are as below:
> > Link: https://lore.kernel.org/linux-arm-kernel/20190403030546.23718-1-chenzhou10@huawei.com/T/#t
> >
> > Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>
> Thanks, applied.

Sorry, but I think the kernel patch which adds this functionality is
still under discussion and review (see [1]).
May be we can wait for the kernel change to be first discussed and
absorbed and then integrate this patch in kexec-tools.

What do you think?

[1]. https://lkml.org/lkml/2019/4/2/1173

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
