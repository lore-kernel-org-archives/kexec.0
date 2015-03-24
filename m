Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <55112467.207@arm.com>
Date: Tue, 24 Mar 2015 08:46:31 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
Subject: Re: [RFC 2/4] arm64: kexec: fix kvm issue
References: <1427111639-4575-1-git-send-email-takahiro.akashi@linaro.org>	
 <1427111639-4575-3-git-send-email-takahiro.akashi@linaro.org>
 <1427126213.27739.3.camel@infradead.org>
In-Reply-To: <1427126213.27739.3.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "david.griego@linaro.org" <david.griego@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "freddy77@gmail.com" <freddy77@gmail.com>

On 23/03/15 15:56, Geoff Levand wrote:
> On Mon, 2015-03-23 at 20:53 +0900, AKASHI Takahiro wrote:
>> The current kvm implementation keeps EL2 vector table installed even
>> when the system is shut down. This prevents kexec from putting the system
>> with kvm back into EL2 when starting a new kernel.
> 
> This is a kvm bug fix, so I think the subject should
> be something like 'arm64/kvm: Fix shutdown issue'.

Not quite. On its own, this doesn't fix anything in KVM. It simply plugs
a deficiency in the arm64 kexec implementation. If you want to be
completely true to the content of the patch, it should read:

"arm64: KVM: Allow EL2 context to be reset on shutdown"

Can we now drop the blame game and get back to the actual code?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
