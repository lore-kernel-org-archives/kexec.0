From: Luck, Tony <tony.luck@intel.com>
Date: Mon, 16 May 2022 16:18:04 +0000
Subject: [PATCH 21/30] panic: Introduce the panic pre-reboot notifier list
In-Reply-To: <63a74b56-89ef-8d1f-d487-cdb986aab798@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-22-gpiccoli@igalia.com> <YoJgcC8c6LaKADZV@alley>
 <63a74b56-89ef-8d1f-d487-cdb986aab798@igalia.com>
Message-ID: <bed66b9467254a5a8bafc1983dad643a@intel.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

> So, my reasoning here is: this notifier should fit the info list,
> definitely! But...it's very high risk for kdump. It deep dives into the
> regmap API (there are locks in such code) plus there is an (MM)IO write
> to the device and an ARM firmware call. So, despite the nature of this
> notifier _fits the informational list_, the _code is risky_ so we should
> avoid running it before a kdump.
>
> Now, we indeed have a chicken/egg problem: want to avoid it before
> kdump, BUT in case kdump is not set, kmsg_dump() (and console flushing,
> after your suggestion Petr) will run before it and not save collected
> information from EDAC PoV.

Would it be possible to have some global "kdump is configured + enabled" flag?

Then notifiers could make an informed choice on whether to deep dive to
get all the possible details (when there is no kdump) or just skim the high
level stuff (to maximize chance of getting a successful kdump).

-Tony
