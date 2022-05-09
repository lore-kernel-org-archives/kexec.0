From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 9 May 2022 10:09:21 -0300
Subject: [PATCH 09/30] coresight: cpu-debug: Replace mutex with
 mutex_trylock on panic notifier
In-Reply-To: <3cafe4fd-8a0b-2633-44a3-2995abd6c38c@arm.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-10-gpiccoli@igalia.com>
 <3cafe4fd-8a0b-2633-44a3-2995abd6c38c@arm.com>
Message-ID: <65f24bc5-2211-0139-ee12-b2608e81ceb1@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 28/04/2022 05:11, Suzuki K Poulose wrote:
> Hi Guilherme,
> 
> On 27/04/2022 23:49, Guilherme G. Piccoli wrote:
>> The panic notifier infrastructure executes registered callbacks when
>> a panic event happens - such callbacks are executed in atomic context,
>> with interrupts and preemption disabled in the running CPU and all other
>> CPUs disabled. That said, mutexes in such context are not a good idea.
>>
>> This patch replaces a regular mutex with a mutex_trylock safer approach;
>> given the nature of the mutex used in the driver, it should be pretty
>> uncommon being unable to acquire such mutex in the panic path, hence
>> no functional change should be observed (and if it is, that would be
>> likely a deadlock with the regular mutex).
>>
>> Fixes: 2227b7c74634 ("coresight: add support for CPU debug module")
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> How would you like to proceed with queuing this ? I am happy
> either way. In case you plan to push this as part of this
> series (I don't see any potential conflicts) :
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Hi Suzuki, some other maintainers are taking the patches to their next
branches for example. I'm working on V2, and I guess in the end would be
nice to reduce the size of the series a bit.

So, do you think you could pick this one for your coresight/next branch
(or even for rc cycle, your call - this is really a fix)?
This way, I won't re-submit this one in V2, since it's gonna be merged
already in your branch.

Thanks in advance,


Guilherme

