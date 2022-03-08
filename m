From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 8 Mar 2022 10:04:06 -0300
Subject: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <YidSI33Uk8wHDuO9@alley>
References: <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com> <YfPxvzSzDLjO5ldp@alley>
 <73011b6f-084b-43f5-cc01-1818a8a57e56@igalia.com>
 <YiV/HbXftVF2iAvU@MiWiFi-R3L-srv>
 <e1033adc-46ff-5dbc-e739-1bf725b6fed0@igalia.com>
 <YiYQ/w6Hn5Zb67di@MiWiFi-R3L-srv>
 <788ab36d-ef65-4cc8-4edf-a46d2687d97e@igalia.com> <YidSI33Uk8wHDuO9@alley>
Message-ID: <23044cc6-ae58-d464-d5d1-3b5e6d4202c8@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 08/03/2022 09:54, Petr Mladek wrote:
> [...]
> Honestly, I am not that keen about enforcing the priorities.
> 
> It would make sense only when the ordering is really important.
> Then there should be some rules. It should be obvious why
> something has to be done earlier than something else.
> 
> From my POV, it is just another complexity. Someone will need to
> assign the priority to the existing notifiers. People will wonder
> about it for newly added notifiers.
> 
> Reproducibility seems to be the only motivation. Is it really a
> problem? Do the notifiers affect each other?
> 
> Also the notifiers are typically registered by some early boot
> code. It will define some ordering out of box.
> 
> Best Regards,
> Petr

OK Petr, makes sense. I feel that one the pros of the approach would be
to document all the notifiers in the header, but I guess nothing
prevents me to do that heh
I don't need enforcing the priorities for this.

I liked the idea of having everything "reproducible" as you said, but we
could face the problem of how to order some independent notifiers...
would be something "ad-hoc".

I'll progress here without priorities for now, if somebody see an
advantage for that, we can use it.

Thanks for your points,


Guilherme

