Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20210526190531.62751-1-maz@kernel.org>
 <20210527173915.GH8661@arm.com>
In-Reply-To: <20210527173915.GH8661@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 31 May 2021 08:02:28 +0200
Message-ID: <CAMj1kXEMfDd=OVoZQ9C2hiJg7QbD8LvTjXRyrHDPvhOQYn=5cA@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: Make kexec_file_load honor iomem reservations
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, kexec@lists.infradead.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, Bhupesh SHARMA <bhupesh.sharma@linaro.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Dave Young <dyoung@redhat.com>, Moritz Fischer <mdf@kernel.org>, Android Kernel Team <kernel-team@android.com>

On Thu, 27 May 2021 at 19:39, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, May 26, 2021 at 08:05:27PM +0100, Marc Zyngier wrote:
> > This series is a complete departure from the approach I initially sent
> > almost a month ago[1]. Instead of trying to teach EFI, ACPI and other
> > subsystem to use memblock, I've decided to stick with the iomem
> > resource tree and use that exclusively for arm64.
> >
> > This means that my current approach is (despite what I initially
> > replied to both Dave and Catalin) to provide an arm64-specific
> > implementation of arch_kexec_locate_mem_hole() which walks the
> > resource tree and excludes ranges of RAM that have been registered for
> > any odd purpose. This is exactly what the userspace implementation
> > does, and I don't really see a good reason to diverge from it.
> >
> > Again, this allows my Synquacer board to reliably use kexec_file_load
> > with as little as 256M, something that would always fail before as it
> > would overwrite most of the reserved tables.
> >
> > Obviously, this is now at least 5.14 material. Given how broken
> > kexec_file_load is for non-crash kernels on arm64 at the moment,
> > should we at least disable it in 5.13 and all previous stable kernels?
>
> I think it makes sense to disable it in the current and earlier kernels.
>

Ack to that

> For this series:
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

and likewise for the series

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
