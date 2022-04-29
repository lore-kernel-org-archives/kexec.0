From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Fri, 29 Apr 2022 17:38:08 -0300
Subject: [PATCH 24/30] panic: Refactor the panic path
In-Reply-To: <PH0PR21MB30252C55EB4F97F3D78021BDD7FC9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-25-gpiccoli@igalia.com>
 <PH0PR21MB30252C55EB4F97F3D78021BDD7FC9@PH0PR21MB3025.namprd21.prod.outlook.com>
Message-ID: <50178dfb-8e94-f35f-09c3-22fe197550ef@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 29/04/2022 14:53, Michael Kelley (LINUX) wrote:
> From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Wednesday, April 27, 2022 3:49 PM
>> [...]
>> +	panic_notifiers_level=
>> +			[KNL] Set the panic notifiers execution order.
>> +			Format: <unsigned int>
>> +			We currently have 4 lists of panic notifiers; based
>> +			on the functionality and risk (for panic success) the
>> +			callbacks are added in a given list. The lists are:
>> +			- hypervisor/FW notification list (low risk);
>> +			- informational list (low/medium risk);
>> +			- pre_reboot list (higher risk);
>> +			- post_reboot list (only run late in panic and after
>> +			kdump, not configurable for now).
>> +			This parameter defines the ordering of the first 3
>> +			lists with regards to kdump; the levels determine
>> +			which set of notifiers execute before kdump. The
>> +			accepted levels are:
>> +			0: kdump is the first thing to run, NO list is
>> +			executed before kdump.
>> +			1: only the hypervisor list is executed before kdump.
>> +			2 (default level): the hypervisor list and (*if*
>> +			there's any kmsg_dumper defined) the informational
>> +			list are executed before kdump.
>> +			3: both the hypervisor and the informational lists
>> +			(always) execute before kdump.
> 
> I'm not clear on why level 2 exists.  What is the scenario where
> execution of the info list before kdump should be conditional on the
> existence of a kmsg_dumper?   Maybe the scenario is described
> somewhere in the patch set and I just missed it.
> 

Hi Michael, thanks for your review/consideration. So, this idea started
kind of some time ago. It all started with a need of exposing more
information on kernel log *before* kdump and *before* pstore -
specifically, we're talking about panic_print. But this cause some
reactions, Baoquan was very concerned with that [0]. Soon after, I've
proposed a panic notifiers filter (orthogonal) approach, to which Petr
suggested instead doing a major refactor [1] - it finally is alive in
the form of this series.

The theory behind the level 2 is to allow a scenario of kdump with the
minimum amount of notifiers - what is the point in printing more
information if the user doesn't care, since it's going to kdump? Now, if
there is a kmsg dumper, it means that there is likely some interest in
collecting information, and that might as well be required before the
potential kdump (which is my case, hence the proposal on [0]).

Instead of forcing one of the two behaviors (level 1 or level 3), we
have a middle-term/compromise: if there's interest in collecting such
data (in the form of a kmsg dumper), we then execute the informational
notifiers before kdump. If not, why to increase (even slightly) the risk
for kdump?

I'm OK in removing the level 2 if people prefer, but I don't feel it's a
burden, quite opposite - seems a good way to accommodate the somewhat
antagonistic ideas (jump to kdump ASAP vs collecting more info in the
panicked kernel log).

[0] https://lore.kernel.org/lkml/20220126052246.GC2086 at MiWiFi-R3L-srv/

[1] https://lore.kernel.org/lkml/YfPxvzSzDLjO5ldp at alley/


>[...]
>> +	 * Based on the level configured (smaller than 4), we clear the
>> +	 * proper bits in "panic_notifiers_bits". Notice that this bitfield
>> +	 * is initialized with all notifiers set.
>> +	 */
>> +	switch (panic_notifiers_level) {
>> +	case 3:
>> +		clear_bit(PN_PRE_REBOOT_BIT, &panic_notifiers_bits);
>> +		break;
>> +	case 2:
>> +		clear_bit(PN_PRE_REBOOT_BIT, &panic_notifiers_bits);
>> +
>> +		if (!kmsg_has_dumpers())
>> +			clear_bit(PN_INFO_BIT, &panic_notifiers_bits);
>> +		break;
>> +	case 1:
>> +		clear_bit(PN_PRE_REBOOT_BIT, &panic_notifiers_bits);
>> +		clear_bit(PN_INFO_BIT, &panic_notifiers_bits);
>> +		break;
>> +	case 0:
>> +		clear_bit(PN_PRE_REBOOT_BIT, &panic_notifiers_bits);
>> +		clear_bit(PN_INFO_BIT, &panic_notifiers_bits);
>> +		clear_bit(PN_HYPERVISOR_BIT, &panic_notifiers_bits);
>> +		break;
>> +	}
> 
> I think the above switch statement could be done as follows:
> 
> if (panic_notifiers_level <= 3)
> 	clear_bit(PN_PRE_REBOOT_BIT, &panic_notifiers_bits);
> if (panic_notifiers_level <= 2)
> 	if (!kmsg_has_dumpers())
> 		clear_bit(PN_INFO_BIT, &panic_notifiers_bits);
> if (panic_notifiers_level <=1)
> 	clear_bit(PN_INFO_BIT, &panic_notifiers_bits);
> if (panic_notifiers_level == 0)
> 	clear_bit(PN_HYPERVISOR_BIT, &panic_notifiers_bits);
> 
> That's about half the lines of code.  It's somewhat a matter of style,
> so treat this as just a suggestion to consider.  I just end up looking
> for a better solution when I see the same line of code repeated
> 3 or 4 times!
> 

It's a good idea - I liked your code. The switch seems more
natural/explicit for me, even duplicating some lines, but in case more
people prefer your way, I can definitely change the code - thanks for
the suggestion.
Cheers,


Guilherme

