Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 19 May 2021 16:19:44 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/2] arm64: kexec_file_load vs memory reservations
Message-ID: <20210519151942.GB21619@arm.com>
References: <20210429133533.1750721-1-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210429133533.1750721-1-maz@kernel.org>
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
To: Marc Zyngier <maz@kernel.org>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, Bhupesh Sharma <bhsharma@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kernel-team@android.com

On Thu, Apr 29, 2021 at 02:35:31PM +0100, Marc Zyngier wrote:
> It recently became apparent that using kexec with kexec_file_load() on
> arm64 is pretty similar to playing Russian roulette.
> 
> Depending on the amount of memory, the HW supported and the firmware
> interface used, your secondary kernel may overwrite critical memory
> regions without which the secondary kernel cannot boot (the GICv3 LPI
> tables being a prime example of such reserved regions).
> 
> It turns out that there is at least two ways for reserved memory
> regions to be described to kexec: /proc/iomem for the userspace
> implementation, and memblock.reserved for kexec_file. And of course,
> our LPI tables are only reserved using the resource tree, leading to
> the aforementioned stamping. Similar things could happen with ACPI
> tables as well.

So which one of these (/proc/iomem and memblock.reserved) would be the
correct option? If none of them, is their intersection any better?
Looking at the default kexec_locate_mem_hole(), it uses the resources
tree if !CONFIG_ARCH_KEEP_MEMBLOCK, otherwise memblock.

PowerPC implements its own arch_kexec_locate_mem_hole() to skip specific
arch regions. We could do something similar for arm64 if the arch code
knows where the LPI reservation is or the ACPI tables.

If we conclude that we need some intersection of resource reservations
and memblock, maybe we should change the default kexec_locate_mem_hole()
implementation to check for both (e.g. start with the resource tree and
only consider a range valid if not in memblock.reserved).

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
