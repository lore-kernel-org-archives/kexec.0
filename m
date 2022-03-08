From: Petr Mladek <pmladek@suse.com>
Date: Tue, 8 Mar 2022 13:54:59 +0100
Subject: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <788ab36d-ef65-4cc8-4edf-a46d2687d97e@igalia.com>
References: <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com>
 <YfPxvzSzDLjO5ldp@alley>
 <73011b6f-084b-43f5-cc01-1818a8a57e56@igalia.com>
 <YiV/HbXftVF2iAvU@MiWiFi-R3L-srv>
 <e1033adc-46ff-5dbc-e739-1bf725b6fed0@igalia.com>
 <YiYQ/w6Hn5Zb67di@MiWiFi-R3L-srv>
 <788ab36d-ef65-4cc8-4edf-a46d2687d97e@igalia.com>
Message-ID: <YidSI33Uk8wHDuO9@alley>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon 2022-03-07 11:25:30, Guilherme G. Piccoli wrote:
> On 07/03/2022 11:04, bhe at redhat.com wrote:
> > [...]
> > Ah, sorry, I even didn't notice that. That's awesome if we can make use
> > of that. While I still have concerns:
> > 
> 
> Thanks, nice that you liked the idea.
> 
> > 1) about those we have decided to take out from panic notifier list and
> > put before kdump, e.g the Hypver-V notifier, how will we do with it? Are
> > we going to handle them as we have discussed?
> > 
> 
> While implementing that I will think of something, but if
> understood/remember correctly Hyper-V gonna be one of the first to run
> in the first notifier list proposed by Petr - so we might still use
> ordering by priority there, having Hyper-V being the first heh

My understanding is that the problem is not a priority but an ordering
against other operations.

Namely, Hyper-V must be called even before crash dump. Some others before
kmsg_dump(). And the rest only when the crash dump is not called at all.


> > 2) Combing and settling priority for all existing panic notifier looks
> > great, even though it will take some effort. How about the later newly
> > added one? How can we guarantee that those new notifiers are getting
> > appropriate priority to mark their order? Sometime we even don't know
> > a new panic notifier is added since code change may be made in any
> > component or driver.
> > 
> 
> This is a great point! How to do it? One idea is to have a special
> registering function for panic notifiers that checks for priority field
> missing, and good documentation is a good idea as well, always.
> 
> But if you / others have other suggestions, let me know - appreciate that.
> Cheers,

Honestly, I am not that keen about enforcing the priorities.

It would make sense only when the ordering is really important.
Then there should be some rules. It should be obvious why
something has to be done earlier than something else.

From my POV, it is just another complexity. Someone will need to
assign the priority to the existing notifiers. People will wonder
about it for newly added notifiers.

Reproducibility seems to be the only motivation. Is it really a
problem? Do the notifiers affect each other?

Also the notifiers are typically registered by some early boot
code. It will define some ordering out of box.

Best Regards,
Petr

