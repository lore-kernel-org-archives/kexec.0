Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hXbwg-0007L5-CO
 for kexec@lists.infradead.org; Mon, 03 Jun 2019 01:39:32 +0000
Subject: Re: [PATCH] arm64: support more than one crash kernel regions
References: <20190403025504.30480-1-chenzhou10@huawei.com>
 <20190531092854.by4sgjggjyozgyaw@verge.net.au>
From: Chen Zhou <chenzhou10@huawei.com>
Message-ID: <0c438a39-81af-e2e1-3e45-946f694a6125@huawei.com>
Date: Mon, 3 Jun 2019 09:39:10 +0800
MIME-Version: 1.0
In-Reply-To: <20190531092854.by4sgjggjyozgyaw@verge.net.au>
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
Cc: takahiro.akashi@linaro.org, wangkefeng.wang@huawei.com, kexec@lists.infradead.org

Hi Simon,

On 2019/5/31 17:28, Simon Horman wrote:
> On Wed, Apr 03, 2019 at 10:55:04AM +0800, Chen Zhou wrote:
>> When crashkernel is reserved above 4G in memory, kernel should
>> reserve some amount of low memory for swiotlb and some DMA buffers.
>> So there may be two crash kernel regions, one is below 4G, the other
>> is above 4G.
>>
>> Currently, there is only one crash kernel region on arm64, and pass
>> "linux,usable-memory-range = <BASE SIZE>" property to crash dump
>> kernel. Now, we pass
>> "linux,usable-memory-range = <BASE1 SIZE1 BASE2 SIZE2>" to crash
>> dump kernel to support two crash kernel regions and load crash
>> kernel high.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> 
> Sorry for letting this slip through the cracks.
> Please let me know if this is still relevant.
> 

This is still relevant and the kernel patches are still under discussion.

Thanks,
Chen Zhou


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
