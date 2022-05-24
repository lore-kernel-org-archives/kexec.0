From: Petr Mladek <pmladek@suse.com>
Date: Tue, 24 May 2022 10:04:51 +0200
Subject: [PATCH 19/30] panic: Add the panic hypervisor notifier list
In-Reply-To: <0fac8c71-6f18-d15c-23f5-075dbc45f3f9@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com>
 <YoJZVZl/MH0KiE/J@alley>
 <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com>
 <YoOpyW1+q+Z5as78@alley>
 <d72b9aab-675c-ac89-b73a-b1de4a0b722d@igalia.com>
 <81878a67-21f1-fee8-1add-f381bc8b05df@broadcom.com>
 <edbaa4fa-561c-6f5e-f2ab-43ae68acaede@igalia.com>
 <d1cc0bee-2a98-0c2e-8796-6fb7fae6b803@broadcom.com>
 <0fac8c71-6f18-d15c-23f5-075dbc45f3f9@igalia.com>
Message-ID: <YoyRo6gJrr4lsFpD@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon 2022-05-23 11:56:12, Guilherme G. Piccoli wrote:
> On 19/05/2022 16:20, Scott Branden wrote:
> > [...] 
> >> Hi Scott / Desmond, thanks for the detailed answer! Is this adapter
> >> designed to run in x86 only or you have other architectures' use cases?
> > The adapter may be used in any PCIe design that supports DMA.
> > So it may be possible to run in arm64 servers.
> >>
> >> [...]
> >> With that said, and given this is a lightweight notifier that ideally
> >> should run ASAP, I'd keep this one in the hypervisor list. We can
> >> "adjust" the semantic of this list to include lightweight notifiers that
> >> reset adapters.
> > Sounds the best to keep system operating as tested today.
> >>
> >> With that said, Petr has a point - not always such list is going to be
> >> called before kdump. So, that makes me think in another idea: what if we
> >> have another list, but not on panic path, but instead in the custom
> >> crash_shutdown()? Drivers could add callbacks there that must execute
> >> before kexec/kdump, no matter what.
> > It may be beneficial for some other drivers but for our use we would 
> > then need to register for the panic path and the crash_shutdown path. 
> > We notify the VK card for 2 purposes: one to stop DMA so memory stop 
> > changing during a kdump.  And also to get the card into a good state so 
> > resets happen cleanly.
> 
> Thanks Scott! With that, I guess it's really better to keep this
> notifier in this hypervisor/early list - I'm planning to do that for V2.
> Unless Petr or somebody has strong feelings against that, of course.

I am fine with it because we do not have a better solution at the
moment.

It might be a good candidate for the 5th notifier list mentioned
in the thread https://lore.kernel.org/r/YoyQyHHfhIIXSX0U at alley .
But I am not sure if the 5th list is worth the complexity.

Best Regards,
Petr

