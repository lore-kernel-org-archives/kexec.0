From: Petr Mladek <pmladek@suse.com>
Date: Tue, 17 May 2022 16:11:00 +0200
Subject: [PATCH 21/30] panic: Introduce the panic pre-reboot notifier list
In-Reply-To: <e895ce94-e6b9-caf6-e5d3-06bf0149445c@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-22-gpiccoli@igalia.com>
 <YoJgcC8c6LaKADZV@alley>
 <63a74b56-89ef-8d1f-d487-cdb986aab798@igalia.com>
 <bed66b9467254a5a8bafc1983dad643a@intel.com>
 <e895ce94-e6b9-caf6-e5d3-06bf0149445c@igalia.com>
Message-ID: <YoOs9GJ5Ovq63u5Q@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon 2022-05-16 13:33:51, Guilherme G. Piccoli wrote:
> On 16/05/2022 13:18, Luck, Tony wrote:
> >> [...]
> > Would it be possible to have some global "kdump is configured + enabled" flag?
> > 
> > Then notifiers could make an informed choice on whether to deep dive to
> > get all the possible details (when there is no kdump) or just skim the high
> > level stuff (to maximize chance of getting a successful kdump).
> > 
> > -Tony
> 
> Good idea Tony! What if I wire a kexec_crash_loaded() in the notifier?

I like this idea.

One small problem is that kexec_crash_loaded() has valid result
only under kexec_mutex. On the other hand, it should stay true
once loaded so that the small race window should be innocent.

> With that, are you/Petr/Dinh OK in moving it for the info list?

Sounds good to me.

Best Regards,
Petr

