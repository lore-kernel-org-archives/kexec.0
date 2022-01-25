From: d.hatayama@fujitsu.com <d.hatayama@fujitsu.com>
Date: Tue, 25 Jan 2022 13:06:47 +0000
Subject: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
Message-ID: <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

> Hi, thanks for the review. First of all, notice that it's very likely
> this patch isn't gonna get merged this way, we are considering a
> refactor that included 2 panic notifiers: one a bit earlier (pre_dump),
> that includes functions less risky, as watchdog unloaders, kernel offset
> dump, etc, and the second panic notifier (post_dump) will keep the
> majority of callbacks, and can be conditionally executed on kdump
> through the usage of "crash_kexec_post_notifiers".

But the pre_dump cannot avoid calling multiple unnecessary handlers, right?
It's more risky than the previous idea...

> Anyway, I'm curious with your code review - how can we use this filter
> with modules, if the filter setup is invoked as early_param(), before
> modules load? In that case, module functions won't have a valid address,
> correct? So, in that moment, this lookup fails, we cannot record an
> unloaded module address in such list. Please, correct me if I'm wrong.

For example, how about simply maintaining function symbol names in the list
as string, not address.

Thanks.
HATAYAMA, Daisuke

