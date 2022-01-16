From: Baoquan He <bhe@redhat.com>
Date: Sun, 16 Jan 2022 21:11:29 +0800
Subject: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <20220108153451.195121-1-gpiccoli@igalia.com>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
Message-ID: <20220116131129.GD2388@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 01/08/22 at 12:34pm, Guilherme G. Piccoli wrote:
...... 
> So, this patch aims to ease this decision: we hereby introduce a filter
> for the panic notifier list, in which users may select specifically
> which callbacks they wish to run, allowing a safer kdump. The allowlist
> should be provided using the parameter "panic_notifier_filter=a,b,..."
> where a, b are valid callback names. Invalid symbols are discarded.
> 
> Currently up to 16 symbols may be passed in this list, we consider
> that this numbers allows enough flexibility (and no matter what
> architecture is used, at most 30 panic callbacks are registered).
> In an experiment using a qemu x86 virtual machine, by default only
> six callbacks are registered in the panic notifier list.
> Once a valid callback name is provided in the list, such function
> is allowed to be registered/unregistered in the panic_notifier_list;
> all other panic callbacks are ignored. Notice that this filter is
> only for the panic notifiers and has no effect in the other notifiers.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

This patch looks good to me, thx.

Acked-by: Baoquan He <bhe@redhat.com>


