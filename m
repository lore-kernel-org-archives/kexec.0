Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Marc Zyngier <maz@kernel.org>
Subject: [PATCH 0/4] arm64: Make kexec_file_load honor iomem reservations
Date: Wed, 26 May 2021 20:05:27 +0100
Message-Id: <20210526190531.62751-1-maz@kernel.org>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, Bhupesh SHARMA <bhupesh.sharma@linaro.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Dave Young <dyoung@redhat.com>, Moritz Fischer <mdf@kernel.org>, kernel-team@android.com

This series is a complete departure from the approach I initially sent
almost a month ago[1]. Instead of trying to teach EFI, ACPI and other
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

Obviously, this is now at least 5.14 material. Given how broken
kexec_file_load is for non-crash kernels on arm64 at the moment,
should we at least disable it in 5.13 and all previous stable kernels?

Thanks,

	M.

[1] https://lore.kernel.org/r/20210429133533.1750721-1-maz@kernel.org

Marc Zyngier (4):
  kexec_file: Make locate_mem_hole_callback global
  kernel/resource: Populate child pointer in find_next_iomem_res()
  kernel/resource: Add walk_excluding_child_res() helper
  arm64: kexec_image: Implement arch_kexec_locate_mem_hole()

 arch/arm64/kernel/kexec_image.c | 45 ++++++++++++++++++
 include/linux/ioport.h          |  4 ++
 include/linux/kexec.h           |  1 +
 kernel/kexec_file.c             |  6 +--
 kernel/resource.c               | 81 +++++++++++++++++++++++++++++++++
 5 files changed, 134 insertions(+), 3 deletions(-)

-- 
2.30.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
