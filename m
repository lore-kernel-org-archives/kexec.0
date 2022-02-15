From: Will Deacon <will@kernel.org>
Date: Tue, 15 Feb 2022 16:44:23 +0000
Subject: [PATCH] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP
 ranges
In-Reply-To: <20220209092642.9181-1-shijie@os.amperecomputing.com>
References: <20220209092642.9181-1-shijie@os.amperecomputing.com>
Message-ID: <20220215164423.GB8458@willie-the-truck>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Feb 09, 2022 at 09:26:42AM +0000, Huang Shijie wrote:
> The following interrelated ranges are needed by the kdump crash tool:
> 	MODULES_VADDR ~ MODULES_END,
> 	VMALLOC_START ~ VMALLOC_END,
> 	VMEMMAP_START ~ VMEMMAP_END
> 
> Since these values change from time to time, it is preferable to export
> them via vmcoreinfo than to change the crash's code frequently.

Please can you explain _why_ they are needed?

Will

