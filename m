From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 11 May 2022 17:03:51 -0300
Subject: [PATCH 23/30] printk: kmsg_dump: Introduce helper to inform
 number of dumpers
In-Reply-To: <20220510134014.3923ccba@gandalf.local.home>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-24-gpiccoli@igalia.com>
 <20220510134014.3923ccba@gandalf.local.home>
Message-ID: <c8818906-f113-82b6-b58b-d47ae0c16b4f@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 10/05/2022 14:40, Steven Rostedt wrote:
> On Wed, 27 Apr 2022 19:49:17 -0300
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
>> Currently we don't have a way to check if there are dumpers set,
>> except counting the list members maybe. This patch introduces a very
>> simple helper to provide this information, by just keeping track of
>> registered/unregistered kmsg dumpers. It's going to be used on the
>> panic path in the subsequent patch.
> 
> FYI, it is considered "bad form" to reference in the change log "this
> patch". We know this is a patch. The change log should just talk about what
> is being done. So can you reword your change logs (you do this is almost
> every patch). Here's what I would reword the above to be:
> 
>  Currently we don't have a way to check if there are dumpers set, except
>  perhaps by counting the list members. Introduce a very simple helper to
>  provide this information, by just keeping track of registered/unregistered
>  kmsg dumpers. This will simplify the refactoring of the panic path.

Thanks for the hint, you're right - it's almost in all of my patches.
I'll reword all of them (except the ones already merged) to remove this
"bad form".

Cheers,


Guilherme

