From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 17 Jan 2022 09:58:21 -0300
Subject: [PATCH V3] panic: Move panic_print before kmsg dumpers
In-Reply-To: <20220117061315.GF2388@MiWiFi-R3L-srv>
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220117033344.GA2523@MiWiFi-R3L-srv> <20220117061315.GF2388@MiWiFi-R3L-srv>
Message-ID: <5c52f546-a821-6195-b531-8251f108f587@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 17/01/2022 03:13, Baoquan He wrote:
> [...]
>>
>> Patch can'e be applied on the latest code of linus's tree, can you tell
>> which branch your code are based on?
> 
> OK, this is based on linux-next, I will apply this patch on the
> linux-next/master and have a look.
> 

Indeed, I'm sorry for that - should have mentioned, but I forgot in the V3.
It's based on linux-next because it's on top of some patches there - if
I base in Linus tree, it wouldn't work on -next heh

Thanks in advance for the reviews/test =)
Cheers,


Guilherme

