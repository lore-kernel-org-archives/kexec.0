From: Catalin Marinas <catalin.marinas@arm.com>
Date: Sat,  7 May 2022 20:12:09 +0100
Subject: [PATCH v24 0/6] support reserving crashkernel above 4G on arm64
 kdump
In-Reply-To: <20220506114402.365-1-thunder.leizhen@huawei.com>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
Message-ID: <165195066216.355842.15333560704698747541.b4-ty@arm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, 6 May 2022 19:43:56 +0800, Zhen Lei wrote:
> Changes since [v23]:
> Do two minor updates:
> 1. Change the value of CRASH_ADDR_HIGH_MAX from memblock.current_limit to (PHYS_MASK + 1).
> 2. The 'high' and 'low' are only take effect when crashkernel=X[@offset] does not exist.
>    If the value of crashkernel=X is invalid, the reservation of crash fails, even if 'high'
>    and 'low' are configured correctly.
> 
> [...]

Applied to arm64 (for-next/crashkernel), finally ;). Thanks!

Only patches on top please for the fall-back implementation.

[1/6] kdump: return -ENOENT if required cmdline option does not exist
      https://git.kernel.org/arm64/c/2e5920bb073a
[2/6] arm64: Use insert_resource() to simplify code
      https://git.kernel.org/arm64/c/e6b394425c61
[3/6] arm64: kdump: Reimplement crashkernel=X
      https://git.kernel.org/arm64/c/944a45abfabc
[4/6] of: fdt: Add memory for devices by DT property "linux,usable-memory-range"
      https://git.kernel.org/arm64/c/fb319e77a0e7
[5/6] of: Support more than one crash kernel regions for kexec -s
      https://git.kernel.org/arm64/c/8af6b91f5834
[6/6] docs: kdump: Update the crashkernel description for arm64
      https://git.kernel.org/arm64/c/5832f1ae5060

-- 
Catalin


