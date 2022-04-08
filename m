From: Baoquan He <bhe@redhat.com>
Date: Fri, 8 Apr 2022 17:32:52 +0800
Subject: [PATCH v21 0/5] support reserving crashkernel above 4G on arm64
 kdump
In-Reply-To: <20220227030717.1464-1-thunder.leizhen@huawei.com>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
Message-ID: <YlABRPBEaTldZwuL@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi, Lei

On 02/27/22 at 11:07am, Zhen Lei wrote:
> Changes since [v20]:
> 1. Check whether crashkernel=Y,low is incorrectly configured or not configured. Do different processing.
> 2. Share the existing description of x86. The configuration of arm64 is the same as that of x86.
> 3. Define the value of macro CRASH_ADDR_HIGH_MAX as memblock.current_limit, instead of MEMBLOCK_ALLOC_ACCESSIBLE.
> 4. To improve readability, some lightweight code adjustments have been made to reserve_craskernel(), including comments.
> 5. The defined value of DEFAULT_CRASH_KERNEL_LOW_SIZE reconsiders swiotlb, just like x86, to share documents.

5.18 rc1 is already done, do you have plan to post a new version for
reviewing?

Thanks
Baoquan


