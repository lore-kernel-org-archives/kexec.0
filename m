From: Simon Horman <horms@verge.net.au>
Date: Fri, 14 Jan 2022 15:56:01 +0100
Subject: [PATCH v5] arm64: support more than one crash kernel regions
In-Reply-To: <20220110102008.502-1-thunder.leizhen@huawei.com>
References: <20220110102008.502-1-thunder.leizhen@huawei.com>
Message-ID: <20220114145601.GH16732@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Jan 10, 2022 at 06:20:08PM +0800, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> When crashkernel is reserved above 4G in memory, kernel should
> reserve some amount of low memory for swiotlb and some DMA buffers.
> So there may be two crash kernel regions, one is below 4G, the other
> is above 4G.
> 
> Currently, there is only one crash kernel region on arm64, and pass
> "linux,usable-memory-range = <BASE SIZE>" property to crash dump
> kernel.
> Now, we pass "linux,usable-memory-range = <BASE1 SIZE1 BASE2 SIZE2>"
> to crash dump kernel to support two crash kernel regions and load crash
> kernel high. Make the low memory region as the second range "BASE2 SIZE2"
> to keep compatibility with existing user-space and older kdump kernels.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Thanks, applied.

