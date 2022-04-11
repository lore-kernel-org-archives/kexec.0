From: Baoquan He <bhe@redhat.com>
Date: Mon, 11 Apr 2022 10:56:42 +0800
Subject: [PATCH v21 0/5] support reserving crashkernel above 4G on arm64
 kdump
In-Reply-To: <3a0bb9a9-c2a1-2e3a-8f23-16109ae1e525@huawei.com>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <YlABRPBEaTldZwuL@MiWiFi-R3L-srv>
 <3a0bb9a9-c2a1-2e3a-8f23-16109ae1e525@huawei.com>
Message-ID: <YlOY6jGpl2EBs6zE@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 04/08/22 at 05:47pm, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/4/8 17:32, Baoquan He wrote:
> > Hi, Lei
> > 
> > On 02/27/22 at 11:07am, Zhen Lei wrote:
> >> Changes since [v20]:
> >> 1. Check whether crashkernel=Y,low is incorrectly configured or not configured. Do different processing.
> >> 2. Share the existing description of x86. The configuration of arm64 is the same as that of x86.
> >> 3. Define the value of macro CRASH_ADDR_HIGH_MAX as memblock.current_limit, instead of MEMBLOCK_ALLOC_ACCESSIBLE.
> >> 4. To improve readability, some lightweight code adjustments have been made to reserve_craskernel(), including comments.
> >> 5. The defined value of DEFAULT_CRASH_KERNEL_LOW_SIZE reconsiders swiotlb, just like x86, to share documents.
> > 
> > 5.18 rc1 is already done, do you have plan to post a new version for
> > reviewing?
> 
> Yes, v5.18-rc1 has added a new patch
> commit  031495635b46 ("arm64: Do not defer reserve_crashkernel() for platforms with no DMA memory zones")
> to allow block mapping again, so my patches need to be modified. It should be post next week.

Sounds great, thanks. Just a reminder, please take your time.


