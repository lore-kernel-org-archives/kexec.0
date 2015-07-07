Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <559B83BC.5080309@arm.com>
Date: Tue, 07 Jul 2015 08:46:04 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/2] arm64: kvm: allows kvm cpu hotplug
References: <1432877920-12527-1-git-send-email-takahiro.akashi@linaro.org>	
 <1432877920-12527-2-git-send-email-takahiro.akashi@linaro.org>	
 <557729A0.1030700@arm.com> <559A964D.30500@arm.com>
 <1436201874.22232.3.camel@infradead.org> <559B8308.4000200@linaro.org>
In-Reply-To: <559B8308.4000200@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "david.griego@linaro.org" <david.griego@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "freddy77@gmail.com" <freddy77@gmail.com>

On 07/07/15 08:43, AKASHI Takahiro wrote:
> On 07/07/2015 01:57 AM, Geoff Levand wrote:
>> Hi Marc,
>>
>> On Mon, 2015-07-06 at 15:53 +0100, Marc Zyngier wrote:
>>> So this has now been a whole month since I reviewed this, and I haven't
>>> seen any repost of this series. Any hope to see this within a reasonable
>>> time frame? Or is it considered dead already?
>>
>> I was hoping to do some work on updating the base kexec patches
>> last week, but all my time was taken up but other things.  I'll
>> try to start on it this week.
> 
> I also have some update, and so will submit my patchset
> after Geoff. Pratyush's patch should also be synced.

Please coordinate between all of you and post a consistent series. It
was painful enough to review the KVM stuff independently of the rest of
the series, so I'd really really want to see a single series that
addresses the issue end to end.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
