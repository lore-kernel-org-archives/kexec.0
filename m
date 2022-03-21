From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 21 Mar 2022 15:04:34 -0300
Subject: Question about the Broadcom Always On register panic handling
In-Reply-To: <781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com>
References: <6dac422b-d509-b863-0b31-98a07808ac0d@igalia.com>
 <781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com>
Message-ID: <307799df-fddd-6c46-7dd5-323ea5628892@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 21/03/2022 13:32, Florian Fainelli wrote:
> [...]
> The AON (standing for always-on) is a small domain in the SoC that can 
> retain its state across various system wide sleep states and specific 
> reset conditions. The AON DATA RAM is a small ram of a few words (< 1KB) 
> which can store persistent information across such events.
> 
> The purpose of this write was initially to help with indicating to the 
> boot loader that a panic occurred and so that it should try its best to 
> preserve the DRAM contents holding that buffer for recovery by the Linux 
> kernel as opposed to wiping out DRAM clean again. I cannot go into the 
> mechanics of what happens publicly unfortunately.
> 

Thanks a lot Florian! This is very good information, it's enough for me
- I'd like to be sure it's not rebooting the board or something
"extreme" like that, so in the end...it's kinda the opposite, it's
preserving the DRAM.


>>
>> Any information that helps me to document such panic event is very
>> welcome, and in case you have AON documentation, it'd be also pretty great!
> 
> Why are you asking specifically about this if I may ask? If you are a 
> legitimate Broadcom STB customer you can reach out to our support and I 
> am sure the question will come back for me to answer.

Oh I'm not a Broadcom STB customer, I'm just working in the panic
notifiers and was curious about this one. When I submit my series (soon)
it's likely that there  will be a small refactor of this notifier plus a
comment, with your great explanation.

Regarding the full AON documentation, I just asked in case it's public
and I couldn't find - it's unfortunate that a lot of code in the kernel
is based on closed specifications, but I understand we can't do much
about that. Your response was very useful, and enough for my work =)

Cheers,


Guilherme

