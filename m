Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VM86h-0006hg-Lb
 for kexec@lists.infradead.org; Wed, 18 Sep 2013 03:07:13 +0000
Message-ID: <52391760.9000106@mxc.nes.nec.co.jp>
Date: Wed, 18 Sep 2013 12:00:48 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: A few patches to consider
References: <E1VEnuJ-0000Jl-CC@eag09.americas.sgi.com>
 <521FF655.8000909@jp.fujitsu.com>
In-Reply-To: <521FF655.8000909@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: ptesarik@suse.cz, kexec@lists.infradead.org, cpw@sgi.com

(2013/08/30 10:33), HATAYAMA Daisuke wrote:
> (2013/08/29 7:08), Cliff Wickman wrote:
>> From: Cliff Wickman <cpw@sgi.com>
>>
>> I am submitting 6 patches that I have found helpful in speeding the dump
>> process or clarifying the progress report.
>> They are not a series, and should not be interdependent.  But if you
>> find any dependencies I apply them in this order:
>> [PATCH] makedumpfile: reverse -c and -p if using snappy compression
>> [PATCH] makedumpfile: use non-cyclic when possible
>> [PATCH] makedumpfile: shorten cyclic exclude-unnecessary passes
>> [PATCH] makedumpfile: shorten cyclic unnecessary-page scans
>> [PATCH] makedumpfile: show needed memory
>> [PATCH] makedumpfile: search for a debug vmlinux
>>
>> The last one (search for a debug vmlinux) is useful in identifying huge
>> pages with the PG_head/PG-tail flags.  There was a patch from Petr Tesarik
>> that enables that huge page filtering. I don't think you are taking that one
>> as-is, but are reworking it. Seems like Hatayama-san was doing that work.
>
> No. If I have good memory, Kumagai-san was investigating how to integrate
> huge page filtering into current memory types currently supported by
> makedumpfile.

Yes, I was investigating it but I'm not working for it now.

I think main features should work without vmlinux,
but it was impossible about his patch as said by himself:

> This patch depends on exporting the relevant PG_* flags from the
> kernel (in VMCOREINFO), and that's where I got stuck, because depending
> on the number of available bits for the page flags, the kernel either
> has PG_head and PG_tail, or only PG_compound, so I needed a #ifdef, and
> the kernel maintainers didn't like the conditional.
> I can restart the discussion with kernel maintainers and see what I can do

Therefore, I waited that his work is finished and I was going to continue
my work, but I didn't say my thinking definitely, sorry.

Anyway, I should cooperate with Petr to develop huge page filtering,
so could you let me know the status of your work ?


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
