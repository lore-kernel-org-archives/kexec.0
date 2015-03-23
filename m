Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1427126213.27739.3.camel@infradead.org>
Subject: Re: [RFC 2/4] arm64: kexec: fix kvm issue
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 23 Mar 2015 08:56:53 -0700
In-Reply-To: <1427111639-4575-3-git-send-email-takahiro.akashi@linaro.org>
References: <1427111639-4575-1-git-send-email-takahiro.akashi@linaro.org>
 <1427111639-4575-3-git-send-email-takahiro.akashi@linaro.org>
Mime-Version: 1.0
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
Cc: mark.rutland@arm.com, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, broonie@kernel.org, david.griego@linaro.org, kexec@lists.infradead.org, christoffer.dall@linaro.org, freddy77@gmail.com

On Mon, 2015-03-23 at 20:53 +0900, AKASHI Takahiro wrote:
> The current kvm implementation keeps EL2 vector table installed even
> when the system is shut down. This prevents kexec from putting the system
> with kvm back into EL2 when starting a new kernel.

This is a kvm bug fix, so I think the subject should
be something like 'arm64/kvm: Fix shutdown issue'.

-Geoff



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
