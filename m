From: Michael Kelley (LINUX) <mikelley@microsoft.com>
Date: Thu, 10 Feb 2022 17:26:46 +0000
Subject: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <7b45bc2b-f74d-8604-bd8a-4930f7b8f926@igalia.com>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com> <YfPxvzSzDLjO5ldp@alley>
 <e2d39675-5df6-73fb-fa24-df906a97ee50@igalia.com>
 <YgMLd+avxyBplfk2@MiWiFi-R3L-srv>
 <7b45bc2b-f74d-8604-bd8a-4930f7b8f926@igalia.com>
Message-ID: <MWHPR21MB1593C36268FFB3FD654074A5D72F9@MWHPR21MB1593.namprd21.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Thursday, February 10, 2022 8:40 AM
> 
> On 08/02/2022 21:31, bhe at redhat.com wrote:
> > [...]
> >> So, what are the opinions from kdump maintainers about this idea?
> >> Baoquan / Vivek / Dave, does it make sense to you? Do you have any
> >> suggestions/concerns to add on top of Petr draft?
> >
> > Yeah, it's reasonable. As I replied to Michael in another thread, I
> > think splitting the current notifier list is a good idea. At least the
> > code to archieve hyper-V's goal with panic_notifier is a little odd and
> > should be taken out and execute w/o conditional before kdump, and maybe
> > some others Petr has combed out.
> >
> > For those which will be switched on with the need of adding panic_notifier
> > or panic_print into cmdline, the heavy users like HATAYAMA and Masa can
> > help check.
> >
> > For Petr's draft code, does it mean hyper-V need another knob to trigger
> > the needed notifiers? Will you go with the draft direclty? Hyper-V now
> > runs panic notifiers by default, just a reminder.
> >
> 
> Hi Baoquan, thanks for your comments.
> 
> I'll need to study the Hyper-V code and how it's done today -

Let me know if you need any assistance or explanation as you look
at the Hyper-V code.

Michael Kelley
Principal SW Engineer
Linux Systems Group
Microsoft Corporation

> I guess
> most part of this implementation will be studying the notifiers we have
> currently, split them among the 3 new notifiers and comb them into
> patches, so they can be reviewed for all relevant maintainers (who know
> the code we are changing).
> 
> I'm not sure if I go directly with the draft, likely it'll have some
> changes, but the draft should be the skeleton of the new implementation.
> Specially if you/other kdump maintainers agree it's a good idea =)
> 
> Cheers,
> 
> 
> Guilherme
