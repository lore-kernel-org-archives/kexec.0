Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fNdbd-0005xp-0j
 for kexec@lists.infradead.org; Tue, 29 May 2018 12:22:01 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20180521025337.GA4627@dhcp-128-65.nay.redhat.com>
 <20180521120215.117d963a7619eb0d1f54bced@linux-foundation.org>
 <20180523070641.GA1689@dhcp-128-65.nay.redhat.com>
 <877enucqr0.fsf@xmission.com>
 <20180523222236.5a96732e@ezekiel.suse.cz>
 <20180524014905.GB2031@dhcp-128-65.nay.redhat.com>
 <20180524085708.31aa311d@ezekiel.suse.cz>
 <87k1rt3tdu.fsf@xmission.com>
 <20180525065943.03bcb911@ezekiel.suse.cz>
 <87d0xjwlo2.fsf@xmission.com>
 <20180528143400.4fc68de4@ezekiel.suse.cz>
Date: Tue, 29 May 2018 07:19:16 -0500
In-Reply-To: <20180528143400.4fc68de4@ezekiel.suse.cz> (Petr Tesarik's message
 of "Mon, 28 May 2018 14:34:00 +0200")
Message-ID: <874liqu01n.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kdump: add default crashkernel reserve kernel config
 options
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.cz>
Cc: dzickus@redhat.com, Neil Horman <nhorman@redhat.com>, Tony Luck <tony.luck@intel.com>, bhe@redhat.com, Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Cong Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Petr Tesarik <ptesarik@suse.cz> writes:

> On Fri, 25 May 2018 15:00:13 -0500
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>>[...]
>> The ultimate point is that the absolute best we can do is to run a
>> kernel in memory that we never use for anything else and then we have a
>> fighting chance of getting the system working and getting a report of
>> the failure out to somewhere.
>>
>> > Anyway, of course we would still have to keep the current method,
>> > because user pages are not always filtered. For example, a major SUSE
>> > account runs a database in user space and also inspects its data
>> > structures in case of a system crash.  
>> 
>> And I understand the memory pressures that will encourage people to use
>> user pages for extra memory to run the dump capture kernel in.  Short of
>> the presence of an IOMMU that all DMA transfers must go through I don't
>> see how those user pages could reliably be used.
>
> Absolutely. I fully understand that a system which reuses first
> kernel's memory in some way must be less reliable than the current
> state. However, some people are willing to trade less reliability for
> reduced resource consumption.

That is the kind of tradeoff that can easily result in the crash kernel
eating your data.  I will nack any patch that I see that goes anywhere
near that kind of solution for the kernel that takes the crash.

> Note that we're not talking about reserving a few gigs on a single
> machine with some terabytes of memory (i.e. less than 1% of total RAM),
> rather a few hundred megs of each 4-gig VM on an s390x machine (i.e.
> about 10% of total RAM).

You should be able to get away with tens of gigs instead of hundreds.
The biggest reservation I remember anyone ever making is about 100Meg.
And that was a general purpose configuration not tuned at all.  With the
maximum size dealing with large machines.

kexec on panic grew up on machines with 4Gig or less as it arrived
before everyone was 64bit.  It should be possible to tune your crash
dump taking kernel so things run in a reasonable amount of memory for
the configuration you are talking about.  The usual trade-off is time
vs generality.  Usually I simply have not seen people with non-embedded
configurations take the time to tune things.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
