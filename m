Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 27 May 2021 18:37:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4/4] arm64: kexec_image: Implement
 arch_kexec_locate_mem_hole()
Message-ID: <20210527173736.GG8661@arm.com>
References: <20210526190531.62751-1-maz@kernel.org>
 <20210526190531.62751-5-maz@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210526190531.62751-5-maz@kernel.org>
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
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Eric Biederman <ebiederm@xmission.com>, Bhupesh SHARMA <bhupesh.sharma@linaro.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Dave Young <dyoung@redhat.com>, Moritz Fischer <mdf@kernel.org>, kernel-team@android.com

On Wed, May 26, 2021 at 08:05:31PM +0100, Marc Zyngier wrote:
> Provide an arm64-specific implementation for arch_kexec_locate_mem_hole(),
> using the resource tree instead of memblock, and respecting
> the reservations added by EFI.
> 
> This ensures that kexec_file is finally reliable.
> 
> Reported-by: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

It would have been clearer if __walk_iomem_res_desc() was able to do
such child res excluding callback (if asked via a new flag/arg) directly
but it's too late in the day to figure out if it's possible. It would
save us from another callback in the arch code. But if it's not possible
or you want to stick to this approach, fine by me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
