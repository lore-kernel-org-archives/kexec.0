From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 9 May 2022 11:25:06 -0300
Subject: [PATCH 24/30] panic: Refactor the panic path
In-Reply-To: <7518924e-5bb4-e6e9-0e3e-3f5cb03bf946@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-25-gpiccoli@igalia.com>
 <4fe85e9c-4e96-e9d5-9fd8-f062bafcda4f@infradead.org>
 <7518924e-5bb4-e6e9-0e3e-3f5cb03bf946@igalia.com>
Message-ID: <260dccd8-a4f6-882c-8767-5bc27576df14@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 29/04/2022 13:04, Guilherme G. Piccoli wrote:
> On 27/04/2022 21:28, Randy Dunlap wrote:
>>
>>
>> On 4/27/22 15:49, Guilherme G. Piccoli wrote:
>>> +	crash_kexec_post_notifiers
>>> +			This was DEPRECATED - users should always prefer the
>>
>> 			This is DEPRECATED - users should always prefer the
>>
>>> +			parameter "panic_notifiers_level" - check its entry
>>> +			in this documentation for details on how it works.
>>> +			Setting this parameter is exactly the same as setting
>>> +			"panic_notifiers_level=4".
>>
> 
> Thanks Randy, for your suggestion - but I confess I couldn't understand
> it properly. It's related to spaces/tabs, right? What you suggest me to
> change in this formatting? Just by looking the email I can't parse.
> 
> Cheers,
> 
> 
> Guilherme

Complete lack of attention from me, apologies!
The suggestions was s/was/is - already fixed for V2, thanks Randy.

