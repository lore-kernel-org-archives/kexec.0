From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Fri, 14 Jan 2022 09:32:58 -0300
Subject: [PATCH V2] panic: Move panic_print before kmsg dumpers
In-Reply-To: <20220114122651.GB17817@pathway.suse.cz>
References: <20220106212835.119409-1-gpiccoli@igalia.com>
 <Yd/0K1x7ILw3Qa46@alley> <ba0e29ba-0e08-df6e-ade5-eb58ae2495e3@igalia.com>
 <YeA1pXz7f0wqSnah@alley> <f25672a4-e4dd-29e8-b2db-f92dd9ff9f8a@igalia.com>
 <20220114122651.GB17817@pathway.suse.cz>
Message-ID: <811109b0-ada6-83b4-6d6d-b26b156d279d@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 14/01/2022 09:26, Petr Mladek wrote:
> [...]
> I see. OK, it makes sense to call it after the panic notifiers when
> they are used. It would be nice to mention the above in the commit
> message and explain why the 2nd call is there.
> 
> Just an idea. It might be better to move the 1st call below
> if (!_crash_kexec_post_notifiers). It would make it more
> clear that it is intended for this code path. I mean:
> 
> 	if (!_crash_kexec_post_notifiers) {
> 		/* ... */
> 		if (kexec_crash_loaded())
> 			panic_print_sys_info(false);
> 
> 		__crash_kexec(NULL);
> 	...
> 
> Best Regards,
> Petr

Perfect Petr, thanks again for the very good ideas! I'll work on V3 and
submit today.
Cheers,


Guilherme

