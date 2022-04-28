From: Suzuki K Poulose <suzuki.poulose@arm.com>
Date: Thu, 28 Apr 2022 09:11:10 +0100
Subject: [PATCH 09/30] coresight: cpu-debug: Replace mutex with
 mutex_trylock on panic notifier
In-Reply-To: <20220427224924.592546-10-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-10-gpiccoli@igalia.com>
Message-ID: <3cafe4fd-8a0b-2633-44a3-2995abd6c38c@arm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Guilherme,

On 27/04/2022 23:49, Guilherme G. Piccoli wrote:
> The panic notifier infrastructure executes registered callbacks when
> a panic event happens - such callbacks are executed in atomic context,
> with interrupts and preemption disabled in the running CPU and all other
> CPUs disabled. That said, mutexes in such context are not a good idea.
> 
> This patch replaces a regular mutex with a mutex_trylock safer approach;
> given the nature of the mutex used in the driver, it should be pretty
> uncommon being unable to acquire such mutex in the panic path, hence
> no functional change should be observed (and if it is, that would be
> likely a deadlock with the regular mutex).
> 
> Fixes: 2227b7c74634 ("coresight: add support for CPU debug module")
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

How would you like to proceed with queuing this ? I am happy
either way. In case you plan to push this as part of this
series (I don't see any potential conflicts) :

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

