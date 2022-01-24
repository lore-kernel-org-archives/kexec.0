From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 24 Jan 2022 11:48:44 -0300
Subject: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <20220124135902.GB8305@MiWiFi-R3L-srv>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <Yel8WQiBn/HNQN83@alley> <ccd9332e-2917-3020-3590-447fa660ff56@igalia.com>
 <20220122105514.GA18258@MiWiFi-R3L-srv>
 <20220123220711.44f1484c9b510eea8cda9c47@kernel.org>
 <20220124135902.GB8305@MiWiFi-R3L-srv>
Message-ID: <ff3bc2cf-80bf-3bb0-0dcd-7f9cacdae45a@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 24/01/2022 10:59, Baoquan He wrote:
> [...]
> About pre_dump, if the dump is crash dump, hope those pre_dump notifiers
> will be executed under conditional check, e.g only if 'crash_kexec_post_notifiers'
> is specified in kernel cmdline. 

Hi Baoquan, based on Petr's suggestion, I think pre_dump would be
responsible for really *non-intrusive/non-risky* tasks and should be
always executed in the panic path (before kdump), regardless of
"crash_kexec_post_notifiers".

The idea is that the majority of the notifiers would be executed in the
post_dump portion, and for that, we have the
"crash_kexec_post_notifiers" conditional. I also suggest we have
blacklist options (based on function names) for both notifiers, in order
to make kdump issues debug easier.

Do you agree with that? Feel free to comment with suggestions!
Cheers,


Guilherme


