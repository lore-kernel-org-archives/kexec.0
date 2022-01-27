From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Thu, 27 Jan 2022 13:47:34 -0300
Subject: [PATCH V4] panic: Move panic_print before kmsg dumpers
In-Reply-To: <20220126052246.GC2086@MiWiFi-R3L-srv>
References: <20220124203101.216051-1-gpiccoli@igalia.com>
 <20220126052246.GC2086@MiWiFi-R3L-srv>
Message-ID: <7b93afff-66a0-44ee-3bb7-3d1e12dd47c2@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 26/01/2022 02:22, Baoquan He wrote:
> [...]
>>  	if (!_crash_kexec_post_notifiers) {
>> +		if (kexec_crash_loaded())
>> +			panic_print_sys_info(false);
>> +
> 
> Please reconsider this change. As I said in another thread, it's not
> suggested when adding any action before kdump switching and the action
> doesn't benefit kdump switching.
> 
> We don't oppose execute handling before kdump switching as long as
> it's executed conditionally. For those conditional extra handling and
> the followoing crash dumping's stability, it's not under kdump's care.
> 

Hi Baoquan, thanks for your review - I understand your concern, so let's
reconsider the change, as you suggest. The only thing is that the
specific bit that concerns you is not really a code added by the hereby
proposed patch, but it was in another patch I submitted, that reached
linux-next.

So, Andrew : can I ask you to please remove the following patch from
linux-next?

"panic: allow printing extra panic information on kdump"
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=56439cb78293

(I'll also send this request in the original thread of the patch, for
completeness).

Baoquan: once it's removed from linux-next, I'll rework this proposed
patch and send a V5, hopefully a version that you consider more safe =)
Cheers,


Guilherme

