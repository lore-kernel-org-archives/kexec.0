Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <56266A2C.7000005@arm.com>
Date: Tue, 20 Oct 2015 17:22:04 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] fixup! arm64: kvm: allows kvm cpu hotplug
References: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
 <1445327907-23274-3-git-send-email-takahiro.akashi@linaro.org>
In-Reply-To: <1445327907-23274-3-git-send-email-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com, broonie@kernel.org, david.griego@linaro.org, kexec@lists.infradead.org, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org

On 20/10/15 08:58, AKASHI Takahiro wrote:
> Without this patch, kvm cannot start a guest when cpuidle is enabled
> if the hardware does not retain cpu state (EL2) in idle state.
> 
> This patch re-initailizes EL2 state at CPU_PM_EXIT by calling
> kvm_arch_hardware_enable() if and only if kvm has been initialized
> before CPU_PM_ENTER, that is, if any vcpus have been created.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

This solves my issue with the v5 version here [0].
Tested-By: James Morse <james.morse@arm.com>


Thanks!

James

[0] https://lists.linaro.org/pipermail/linaro-kernel/2015-May/021575.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
