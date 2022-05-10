From: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 10 May 2022 23:53:56 +1000
Subject: [PATCH 08/30] powerpc/setup: Refactor/untangle panic notifiers
In-Reply-To: <f9c3de3c-1709-a1aa-2ece-c9fbfd5e6d6a@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-9-gpiccoli@igalia.com>
 <3c34d8e2-6f84-933f-a4ed-338cd300d6b0@linux.ibm.com>
 <f9c3de3c-1709-a1aa-2ece-c9fbfd5e6d6a@igalia.com>
Message-ID: <87fslh8pe3.fsf@mpe.ellerman.id.au>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

"Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:
> On 05/05/2022 15:55, Hari Bathini wrote:
>> [...] 
>> The change looks good. I have tested it on an LPAR (ppc64).
>> 
>> Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
>> 
>
> Hi Michael. do you think it's possible to add this one to powerpc/next
> (or something like that), or do you prefer a V2 with his tag?

Ah sorry, I assumed it was going in as part of the whole series. I guess
I misread the cover letter.

So you want me to take this patch on its own via the powerpc tree?

cheers

