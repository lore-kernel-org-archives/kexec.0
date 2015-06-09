Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <557729A0.1030700@arm.com>
Date: Tue, 09 Jun 2015 19:00:00 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/2] arm64: kvm: allows kvm cpu hotplug
References: <1432877920-12527-1-git-send-email-takahiro.akashi@linaro.org>
 <1432877920-12527-2-git-send-email-takahiro.akashi@linaro.org>
In-Reply-To: <1432877920-12527-2-git-send-email-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Mark Rutland <Mark.Rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "geoff@infradead.org" <geoff@infradead.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "david.griego@linaro.org" <david.griego@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "freddy77@gmail.com" <freddy77@gmail.com>

Hi Takahiro,

On 29/05/15 06:38, AKASHI Takahiro wrote:
> The current kvm implementation on arm64 does cpu-specific initialization
> at system boot, and has no way to gracefully shutdown a core in terms of
> kvm. This prevents, especially, kexec from rebooting the system on a boot
> core in EL2.
> 
> This patch adds a cpu tear-down function and also puts an existing cpu-init
> code into a separate function, kvm_arch_hardware_disable() and
> kvm_arch_hardware_enable() respectively.
> We don't need arm64-specific cpu hotplug hook any more.
> 
> Since this patch modifies common part of code between arm and arm64, one
> stub definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
> compiling errors.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

This is starting to look good. Any chance you or Geoff could repost the
whole series? This would help getting a better view of the whole thing,
and hopefully put it on track for 4.3.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
