From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Fri, 29 Apr 2022 11:01:59 -0300
Subject: [PATCH 09/30] coresight: cpu-debug: Replace mutex with
 mutex_trylock on panic notifier
In-Reply-To: <3cafe4fd-8a0b-2633-44a3-2995abd6c38c@arm.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-10-gpiccoli@igalia.com>
 <3cafe4fd-8a0b-2633-44a3-2995abd6c38c@arm.com>
Message-ID: <79472351-c6ce-a060-ef24-f64b6dce1637@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 28/04/2022 05:11, Suzuki K Poulose wrote:
> Hi Guilherme,
> [...] 
> How would you like to proceed with queuing this ? I am happy
> either way. In case you plan to push this as part of this
> series (I don't see any potential conflicts) :
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks for your review Suzuki, much appreciated!

About your question, I'm not sure yet - in case the core changes would
take a while (like if community find them polemic, require many changes,
etc) I might split this series in 2 parts, the fixes part vs the
improvements per se. Either way, a V2 is going to happen for sure, and
in that moment, I'll let you know what I think it's best.

But either way, any choice you prefer is fine by me as well (like if you
want to merge it now or postpone to get merged in the future), this is
not an urgent fix I think =)
Cheers,


Guilherme

