Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Marc Zyngier <maz@kernel.org>
Subject: [PATCH 0/2] arm64: kexec_file_load vs memory reservations
Date: Thu, 29 Apr 2021 14:35:31 +0100
Message-Id: <20210429133533.1750721-1-maz@kernel.org>
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
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, Bhupesh Sharma <bhsharma@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kernel-team@android.com

It recently became apparent that using kexec with kexec_file_load() on
arm64 is pretty similar to playing Russian roulette.

Depending on the amount of memory, the HW supported and the firmware
interface used, your secondary kernel may overwrite critical memory
regions without which the secondary kernel cannot boot (the GICv3 LPI
tables being a prime example of such reserved regions).

It turns out that there is at least two ways for reserved memory
regions to be described to kexec: /proc/iomem for the userspace
implementation, and memblock.reserved for kexec_file. And of course,
our LPI tables are only reserved using the resource tree, leading to
the aforementioned stamping. Similar things could happen with ACPI
tables as well.

On my 24xA53 system artificially limited to 256MB of RAM (yes, it
boots with that little memory), trying to kexec a secondary kernel
failed every times. I can only presume that this was mostly tested
using kdump, which preserves the entire kernel memory range.

This small series aims at triggering a discussion on what are the
expectations for kexec_file, and whether we should unify the two
reservation mechanisms.

And in the meantime, it gets things going...

Marc Zyngier (2):
  firmware/efi: Tell memblock about EFI reservations
  ACPI: arm64: Reserve the ACPI tables in memblock

 arch/arm64/kernel/acpi.c   |  1 +
 drivers/firmware/efi/efi.c | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
