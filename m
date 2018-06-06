Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: panic kexec broken on ARM64?
References: <20180605100151.7fd54381@ezekiel.suse.cz>
 <8028219f-0d14-eafd-86b7-359ee927bcd3@arm.com>
 <5e539510-01b7-ebc5-778e-b49a5261f9bc@i2se.com>
From: James Morse <james.morse@arm.com>
Message-ID: <2865150f-ebca-4c6b-fc4b-93bfab5f0e91@arm.com>
Date: Wed, 6 Jun 2018 12:37:02 +0100
MIME-Version: 1.0
In-Reply-To: <5e539510-01b7-ebc5-778e-b49a5261f9bc@i2se.com>
Content-Language: en-US
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
To: Stefan Wahren <stefan.wahren@i2se.com>, Petr Tesarik <ptesarik@suse.cz>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>, Matthias Brugger <mbrugger@suse.com>, kexec mailing list <kexec@lists.infradead.org>, linux-arm-kernel@lists.infradead.org

Hi Stefan,

On 06/06/18 08:02, Stefan Wahren wrote:
> Am 05.06.2018 um 19:46 schrieb James Morse:
>> On 05/06/18 09:01, Petr Tesarik wrote:
>>> I attached a hardware debugger and found
>>> out that all CPU cores were stopped except one which was stuck in the
>>> idle thread. It seems that irq_set_irqchip_state() may sleep, which is
>>> definitely not safe after a kernel panic.

>> I don't know much about irqchip stuff, but __irq_get_desc_lock() takes a
>> raw_spin_lock(), and calls gic_irq_get_irqchip_state() which is just poking
>> around in mmio registers, this should all be safe unless you re-entered the same
>> code.

>>> If I'm right, then this is broken in general, but I have only ever seen
>>> it on RPi 3 Model B+ (even RPi3 Model B works fine), so the issue may
>>> be more subtle.

>> Is there a hardware difference around the interrupt controller on these?

> No, but the RPi 3 B has a different USB network chip on board (smsc95xx, Fast
> ethernet) instead of lan78xx (Gigabit ethernet).

Bingo: its the lan78xx driver that is sleeping from the irqchip callbacks; The
smsc95xx driver doesn't have a struct irq_chip, which is why the RPi-3-B doesn't
do this.

It may be valid for kdump to only teardown the 'root irqdomain' (if that even
means anything). I assume these secondary irqchip's would have a
summary-interrupt that goes to another irqchip. But I can't see a way to tell
them apart..,

I think we need to wait until after the merge window for Marc's wisdom on this!


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
