From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Fri, 29 Apr 2022 10:46:35 -0300
Subject: [PATCH 17/30] tracing: Improve panic/die notifiers
In-Reply-To: <20220429092351.10bca4dd@gandalf.local.home>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-18-gpiccoli@igalia.com>
 <b8771b37-01f5-f50b-dbb3-9db4ee26e67e@gmail.com>
 <20220429092351.10bca4dd@gandalf.local.home>
Message-ID: <832eecc5-9569-1d95-6ab8-f029b660dfcb@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 29/04/2022 10:23, Steven Rostedt wrote:
> On Fri, 29 Apr 2022 12:22:44 +0300
> Sergei Shtylyov <sergei.shtylyov@gmail.com> wrote:
> 
>>> +	switch (ev) {
>>> +	case DIE_OOPS:
>>> +		do_dump = 1;
>>> +		break;
>>> +	case PANIC_NOTIFIER:
>>> +		do_dump = 1;
>>> +		break;  
>>
>>    Why not:
>>
>> 	case DIE_OOPS:
>> 	case PANIC_NOTIFIER:
>> 		do_dump = 1;
>> 		break;
> 
> Agreed.
> 
> Other than that.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Thanks Sergei and Steven, good idea! I thought about the switch change
you propose, but I confess I got a bit confused by the "fallthrough"
keyword - do I need to use it?

About the s/int/bool, for sure! Not sure why I didn't use bool at
first...heheh

Cheers,


Guilherme

