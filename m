From: Will Deacon <will@kernel.org>
Date: Mon,  7 Mar 2022 22:03:35 +0000
Subject: [PATCH] arm64: crash_core: Export MODULES, VMALLOC,
 and VMEMMAP ranges
In-Reply-To: <20220209092642.9181-1-shijie@os.amperecomputing.com>
References: <20220209092642.9181-1-shijie@os.amperecomputing.com>
Message-ID: <164668834766.3268493.2965341441709965895.b4-ty@kernel.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, 9 Feb 2022 09:26:42 +0000, Huang Shijie wrote:
> The following interrelated ranges are needed by the kdump crash tool:
> 	MODULES_VADDR ~ MODULES_END,
> 	VMALLOC_START ~ VMALLOC_END,
> 	VMEMMAP_START ~ VMEMMAP_END
> 
> Since these values change from time to time, it is preferable to export
> them via vmcoreinfo than to change the crash's code frequently.
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP ranges
      https://git.kernel.org/arm64/c/2369f171d5c5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

