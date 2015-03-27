Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <55157920.3050003@arm.com>
Date: Fri, 27 Mar 2015 15:37:04 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
Subject: Re: [RFC v2 0/5] arm64: kvm: reset hyp context for kexec
References: <1427358326-3708-1-git-send-email-takahiro.akashi@linaro.org>
 <20150327153131.GK12400@redacted.bos.redhat.com>
In-Reply-To: <20150327153131.GK12400@redacted.bos.redhat.com>
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
To: Kyle McMartin <kmcmarti@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "geoff@infradead.org" <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "david.griego@linaro.org" <david.griego@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "freddy77@gmail.com" <freddy77@gmail.com>

On 27/03/15 15:31, Kyle McMartin wrote:
> On Thu, Mar 26, 2015 at 05:25:21PM +0900, AKASHI Takahiro wrote:
>> 1) Call kvm_cpu_reset() on non-boot cpus in reboot notifier
>>    We don't have to do so in kexec-specific case. But the current code runs
>>    the function on each cpu for safety since we use a general reboot hook.
>> 2) Flush D$ in kvm_cpu_reset()
>>    Currently doesn't do so because all the cpus are just going to shut down,
>>    and we actually flush D$ on boot cpu in Geoff's cpu_reset().
>> 3) Compatibility with arm implementation
>>    Frediano[2] is no longer working on this issue on arm as he left his
>>    company. But my approach here is based on a generic interface and can be
>>    applied to arm in a similar way.
>>
> 
> i'm hitting this when rebooting with your patchset applied...
> 
> Rebooting.
> [  236.260863] Kernel panic - not syncing: HYP panic:
> [  236.260863] PS:600003c9 PC:000003ffffff0830 ESR:0000000096000006

It would be interesting if you could find out what you have at offset
0x830 of hyp-init.o (the stack trace is for EL1, and is not going to
help much).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
