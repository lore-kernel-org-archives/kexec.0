Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 0/5] arm64: Make kexec_file_load honor iomem reservations
Date: Mon, 31 May 2021 10:57:15 +0100
Message-Id: <20210531095720.77469-1-maz@kernel.org>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, Bhupesh SHARMA <bhupesh.sharma@linaro.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Moritz Fischer <mdf@kernel.org>, kernel-team@android.com

This series is a complete departure from the approach I initially sent
almost a month ago[0]. Instead of trying to teach EFI, ACPI and other
subsystem to use memblock, I've decided to stick with the iomem
resource tree and use that exclusively for arm64.

This means that my current approach is (despite what I initially
replied to both Dave and Catalin) to provide an arm64-specific
implementation of arch_kexec_locate_mem_hole() which walks the
resource tree and excludes ranges of RAM that have been registered for
any odd purpose. This is exactly what the userspace implementation
does, and I don't really see a good reason to diverge from it.

Again, this allows my Synquacer board to reliably use kexec_file_load
with as little as 256M, something that would always fail before as it
would overwrite most of the reserved tables.

Although this series still targets 5.14, the initial patch is a
-stable candidate, and disables non-kdump uses of kexec_file_load. I
have limited it to 5.10, as earlier kernels will require a different,
probably more invasive approach.

Catalin, Ard: although this series has changed a bit compared to v1,
I've kept your AB/RB tags. Should anything seem odd, please let me
know and I'll drop them.

Thanks,

	M.

* From v1 [1]:
  - Move the overlap exclusion into find_next_iomem_res()
  - Handle child resource not overlapping with parent
  - Provide walk_system_ram_excluding_child_res() as a top level
    walker
  - Simplify arch-specific code
  - Add initial patch disabling non-crash kernels

[0] https://lore.kernel.org/r/20210429133533.1750721-1-maz@kernel.org
[1] https://lore.kernel.org/r/20210526190531.62751-1-maz@kernel.org

Marc Zyngier (5):
  arm64: kexec_file: Forbid non-crash kernels
  kexec_file: Make locate_mem_hole_callback global
  kernel/resource: Allow find_next_iomem_res() to exclude overlapping
    child resources
  kernel/resource: Introduce walk_system_ram_excluding_child_res()
  arm64: kexec_image: Restore full kexec functionnality

 arch/arm64/kernel/kexec_image.c | 39 ++++++++++++++++
 include/linux/ioport.h          |  3 ++
 include/linux/kexec.h           |  1 +
 kernel/kexec_file.c             |  6 +--
 kernel/resource.c               | 82 +++++++++++++++++++++++++++++----
 5 files changed, 119 insertions(+), 12 deletions(-)

-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
