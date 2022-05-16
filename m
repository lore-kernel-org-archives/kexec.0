From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 16 May 2022 13:33:51 -0300
Subject: [PATCH 21/30] panic: Introduce the panic pre-reboot notifier list
In-Reply-To: <bed66b9467254a5a8bafc1983dad643a@intel.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-22-gpiccoli@igalia.com> <YoJgcC8c6LaKADZV@alley>
 <63a74b56-89ef-8d1f-d487-cdb986aab798@igalia.com>
 <bed66b9467254a5a8bafc1983dad643a@intel.com>
Message-ID: <e895ce94-e6b9-caf6-e5d3-06bf0149445c@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 16/05/2022 13:18, Luck, Tony wrote:
>> [...]
> Would it be possible to have some global "kdump is configured + enabled" flag?
> 
> Then notifiers could make an informed choice on whether to deep dive to
> get all the possible details (when there is no kdump) or just skim the high
> level stuff (to maximize chance of getting a successful kdump).
> 
> -Tony

Good idea Tony! What if I wire a kexec_crash_loaded() in the notifier?

With that, are you/Petr/Dinh OK in moving it for the info list?
Cheers,


Guilherme

