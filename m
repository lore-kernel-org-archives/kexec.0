From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Tue, 10 May 2022 11:10:40 -0300
Subject: [PATCH 08/30] powerpc/setup: Refactor/untangle panic notifiers
In-Reply-To: <87fslh8pe3.fsf@mpe.ellerman.id.au>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-9-gpiccoli@igalia.com>
 <3c34d8e2-6f84-933f-a4ed-338cd300d6b0@linux.ibm.com>
 <f9c3de3c-1709-a1aa-2ece-c9fbfd5e6d6a@igalia.com>
 <87fslh8pe3.fsf@mpe.ellerman.id.au>
Message-ID: <58837e3d-0e2a-42ac-f198-9fe7be7aa823@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 10/05/2022 10:53, Michael Ellerman wrote:
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:
>> On 05/05/2022 15:55, Hari Bathini wrote:
>>> [...] 
>>> The change looks good. I have tested it on an LPAR (ppc64).
>>>
>>> Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
>>>
>>
>> Hi Michael. do you think it's possible to add this one to powerpc/next
>> (or something like that), or do you prefer a V2 with his tag?
> 
> Ah sorry, I assumed it was going in as part of the whole series. I guess
> I misread the cover letter.
> 
> So you want me to take this patch on its own via the powerpc tree?
> 
> cheers

Hi Michael, thanks for the prompt response!

You didn't misread, that was the plan heh
But some maintainers start to take patches and merge in their trees, and
in the end, it seems to make sense - almost half of this series are
fixes or clean-ups, that are not really necessary to get merged altogether.

So, if you can take this one, I'd appreciate - it'll make V2 a bit
smaller =)

Cheers,


Guilherme

