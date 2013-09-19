Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMWpe-00058l-VS
 for kexec@lists.infradead.org; Thu, 19 Sep 2013 05:31:17 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: A few patches to consider
Date: Thu, 19 Sep 2013 05:00:02 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971B21A4@BPXM01GP.gisp.nec.co.jp>
References: <E1VEnuJ-0000Jl-CC@eag09.americas.sgi.com>
 <521FF655.8000909@jp.fujitsu.com> <52391760.9000106@mxc.nes.nec.co.jp>
 <523A5D9A.7040509@jp.fujitsu.com>
Content-Language: ja-JP
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Cc: "ptesarik@suse.cz" <ptesarik@suse.cz>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "cpw@sgi.com" <cpw@sgi.com>

(2013/09/19 11:13), HATAYAMA Daisuke wrote:
> (2013/09/18 12:00), Atsushi Kumagai wrote:
>> (2013/08/30 10:33), HATAYAMA Daisuke wrote:
>>> (2013/08/29 7:08), Cliff Wickman wrote:
>>>> From: Cliff Wickman <cpw@sgi.com>
>>>>
>>>> I am submitting 6 patches that I have found helpful in speeding the dump
>>>> process or clarifying the progress report.
>>>> They are not a series, and should not be interdependent.  But if you
>>>> find any dependencies I apply them in this order:
>>>> [PATCH] makedumpfile: reverse -c and -p if using snappy compression
>>>> [PATCH] makedumpfile: use non-cyclic when possible
>>>> [PATCH] makedumpfile: shorten cyclic exclude-unnecessary passes
>>>> [PATCH] makedumpfile: shorten cyclic unnecessary-page scans
>>>> [PATCH] makedumpfile: show needed memory
>>>> [PATCH] makedumpfile: search for a debug vmlinux
>>>>
>>>> The last one (search for a debug vmlinux) is useful in identifying huge
>>>> pages with the PG_head/PG-tail flags.  There was a patch from Petr Tesarik
>>>> that enables that huge page filtering. I don't think you are taking that one
>>>> as-is, but are reworking it. Seems like Hatayama-san was doing that work.
>>>
>>> No. If I have good memory, Kumagai-san was investigating how to integrate
>>> huge page filtering into current memory types currently supported by
>>> makedumpfile.
>>
>> Yes, I was investigating it but I'm not working for it now.
>>
>> I think main features should work without vmlinux,
>> but it was impossible about his patch as said by himself:
>>
>>> This patch depends on exporting the relevant PG_* flags from the
>>> kernel (in VMCOREINFO), and that's where I got stuck, because depending
>>> on the number of available bits for the page flags, the kernel either
>>> has PG_head and PG_tail, or only PG_compound, so I needed a #ifdef, and
>>> the kernel maintainers didn't like the conditional.
>>> I can restart the discussion with kernel maintainers and see what I can do
>>
>> Therefore, I waited that his work is finished and I was going to continue
>> my work, but I didn't say my thinking definitely, sorry.
>>
>> Anyway, I should cooperate with Petr to develop huge page filtering,
>> so could you let me know the status of your work ?
>>
>
> To whom do you make this question? It seems Cliff according to content of this question.
> If so you should resend. If to me, I have not done huge page filtering work at all so far
> as I already said in the previous mail in this thread.

Sorry for confusing you, I asked Petr.
According to Cliff's 1st mail:

> From: Cliff Wickman <cpw@sgi.com>
>
> This fix comes from Petr Tesarik <ptesarik@suse.cz>, and was applied
> to the SuSE version of makedumpfile.
> I don't see it in the mmap version.
> It is important to filtering out a great deal of user memory.
>
> But this from Petr on 5/15:
>> This patch depends on exporting the relevant PG_* flags from the
>> kernel (in VMCOREINFO), and that's where I got stuck, because depending
>> on the number of available bits for the page flags, the kernel either
>> has PG_head and PG_tail, or only PG_compound, so I needed a #ifdef, and
>> the kernel maintainers didn't like the conditional.
>> I can restart the discussion with kernel maintainers and see what I can do
> So I'm not sending to the kexec list until he's ready.

I understood Petr tried to add PG_* flags into VMCOREINFO,
but it seems not completed in linux-next at this time.
To prepare the flags is important to huge page filtering,
I want to know the status of Petr's work.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
