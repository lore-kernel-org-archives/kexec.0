From: d.hatayama@fujitsu.com <d.hatayama@fujitsu.com>
Date: Mon, 9 May 2022 15:16:08 +0000
Subject: [PATCH 24/30] panic: Refactor the panic path
In-Reply-To: <20220427224924.592546-25-gpiccoli@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-25-gpiccoli@igalia.com>
Message-ID: <TYAPR01MB6507D01F5694BC33628BB7DB95C69@TYAPR01MB6507.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Sorry for the delayed response. Unfortunately, I had 10 days holidays
until yesterday...

>  .../admin-guide/kernel-parameters.txt         |  42 ++-
>  include/linux/panic_notifier.h                |   1 +
>  kernel/kexec_core.c                           |   8 +-
>  kernel/panic.c                                | 292 +++++++++++++-----
>  .../selftests/pstore/pstore_crash_test        |   5 +-
>  5 files changed, 252 insertions(+), 96 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3f1cc5e317ed..8d3524060ce3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
...snip...
> @@ -3784,6 +3791,33 @@
>                         timeout < 0: reboot immediately
>                         Format: <timeout>
> 
> +       panic_notifiers_level=
> +                       [KNL] Set the panic notifiers execution order.
> +                       Format: <unsigned int>
> +                       We currently have 4 lists of panic notifiers; based
> +                       on the functionality and risk (for panic success) the
> +                       callbacks are added in a given list. The lists are:
> +                       - hypervisor/FW notification list (low risk);
> +                       - informational list (low/medium risk);
> +                       - pre_reboot list (higher risk);
> +                       - post_reboot list (only run late in panic and after
> +                       kdump, not configurable for now).
> +                       This parameter defines the ordering of the first 3
> +                       lists with regards to kdump; the levels determine
> +                       which set of notifiers execute before kdump. The
> +                       accepted levels are:
> +                       0: kdump is the first thing to run, NO list is
> +                       executed before kdump.
> +                       1: only the hypervisor list is executed before kdump.
> +                       2 (default level): the hypervisor list and (*if*

Hmmm, why are you trying to change default setting?

Based on the current design of kdump, it's natural to put what the
handlers for these level 1 and level 2 handlers do in
machine_crash_shutdown(), as these are necessary by default, right?

Or have you already tried that and figured out it's difficult in some
reason and reached the current design? If so, why is that difficult?
Could you point to if there is already such discussion online?

kdump is designed to perform as little things as possible before
transferring the execution to the 2nd kernel in order to increase
reliability. Just detour to panic() increases risks of kdump failure
in the sense of increasing the executed codes in the abnormal
situation, which is very the note in the explanation of
crash_kexec_post_notifiers.

Also, the current implementation of crash_kexec_post_notifiers uses
the panic notifier, but this is not from the technical
reason. Ideally, it should have been implemented in the context of
crash_kexec() independently of panic().

That is, it looks to me that, in addition to changing design of panic
notifier, you are trying to integrate shutdown code of the crash kexec
and the panic paths. If so, this is a big design change for kdump.
I'm concerned about increase of reliability. I'd like you to discuss
them carefully.

Thanks.
HATAYAMA, Daisuke


