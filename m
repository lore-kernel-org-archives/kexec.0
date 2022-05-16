From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 16 May 2022 20:06:51 +0100
Subject: [PATCH] arm64: kdump: Do not allocate crash low memory if not
 needed
In-Reply-To: <20220511032033.426-1-thunder.leizhen@huawei.com>
References: <20220511032033.426-1-thunder.leizhen@huawei.com>
Message-ID: <165272800400.3869992.18113408678309495430.b4-ty@arm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, 11 May 2022 11:20:32 +0800, Zhen Lei wrote:
> When "crashkernel=X,high" is specified, the specified "crashkernel=Y,low"
> memory is not required in the following corner cases:
> 1. If both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 are disabled, it means
>    that the devices can access any memory.
> 2. If the system memory is small, the crash high memory may be allocated
>    from the DMA zones. If that happens, there's no need to allocate
>    another crash low memory because there's already one.
> 
> [...]

Applied to arm64 (for-next/crashkernel), thanks!

[1/1] arm64: kdump: Do not allocate crash low memory if not needed
      https://git.kernel.org/arm64/c/8f0f104e2ab6

-- 
Catalin


