From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 3 May 2022 15:06:15 -0300
Subject: [PATCH 24/30] panic: Refactor the panic path
In-Reply-To: <PH0PR21MB302570C9407F80AAD09E209ED7C09@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-25-gpiccoli@igalia.com>
 <PH0PR21MB30252C55EB4F97F3D78021BDD7FC9@PH0PR21MB3025.namprd21.prod.outlook.com>
 <50178dfb-8e94-f35f-09c3-22fe197550ef@igalia.com>
 <PH0PR21MB302570C9407F80AAD09E209ED7C09@PH0PR21MB3025.namprd21.prod.outlook.com>
Message-ID: <12b5a753-c0f1-9da5-f269-483384752837@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 03/05/2022 14:31, Michael Kelley (LINUX) wrote:
> [...]
> 
> To me, it's a weak correlation between having a kmsg dumper, and
> wanting or not wanting the info level output to come before kdump.
> Hyper-V is one of only a few places that register a kmsg dumper, so most
> Linux instances outside of Hyper-V guest (and PowerPC systems?) will have
> the info level output after kdump.  It seems like anyone who cared strongly
> about the info level output would set the panic_notifier_level to 1 or to 3
> so that the result is more deterministic.  But that's just my opinion, and
> it's probably an opinion that is not as well informed on the topic as some
> others in the discussion. So keeping things as in your patch set is not a
> show-stopper for me.
> 
> However, I would request a clarification in the documentation.   The
> panic_notifier_level affects not only the hypervisor, informational,
> and pre_reboot lists, but it also affects panic_print_sys_info() and
> kmsg_dump().  Specifically, at level 1, panic_print_sys_info() and
> kmsg_dump() will not be run before kdump.  At level 3, they will
> always be run before kdump.  Your documentation above mentions
> "informational lists" (plural), which I take to vaguely include
> kmsg_dump() and panic_print_sys_info(), but being explicit about
> the effect would be better.
> 
> Michael

Thanks again Michael, to express your points and concerns - great idea
of documentation improvement here, I'll do that for V2, for sure.

The idea of "defaulting" to skip the info list on kdump (if no
kmsg_dump() is set) is again a mechanism that aims at accommodating all
users and concerns of antagonistic goals, kdump vs notifier lists.

Before this patch set, by default no notifier executed before kdump. So,
the "pendulum"  was strongly on kdump side, and clearly this was a
sub-optimal decision - proof of that is that both Hyper-V / PowerPC code
forcibly set the "crash_kexec_post_notifiers". The goal here is to have
a more lightweight list that by default runs before kdump, a secondary
list that only runs before kdump if there's usage for that (either user
sets that or kmsg_dumper set is considered a valid user), and the
remaining notifiers run by default only after kdump, all of that very
customizable through the levels idea.

Now, one thing we could do to improve consistency for the hyper-v case:
having a kmsg_dump_once() helper, and *for Hyper-V only*, call it on the
hypervisor list, within the info notifier (that would be moved to
hypervisor list, ofc).
Let's wait for more feedback on that, just throwing some ideas in order
we can have everyone happy with the end-result!

Cheers,


Guilherme

