Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TRbIo-0006a0-8C
 for kexec@lists.infradead.org; Fri, 26 Oct 2012 04:13:46 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <5085B0D0.9020508@zytor.com> <87mwze8abu.fsf@xmission.com>
 <5085E663.6040307@zytor.com>
 <20121026.122406.13396329.d.hatayama@jp.fujitsu.com>
Date: Thu, 25 Oct 2012 21:13:25 -0700
In-Reply-To: <20121026.122406.13396329.d.hatayama@jp.fujitsu.com> (HATAYAMA
 Daisuke's message of "Fri, 26 Oct 2012 12:24:06 +0900 (JST)")
Message-ID: <87r4oloopm.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/2] x86, apic: Disable BSP if boot cpu is AP
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: len.brown@intel.com, fenghua.yu@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, hpa@zytor.com, tglx@linutronix.de, mingo@elte.hu, vgoyal@redhat.com

HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:

> From: "H. Peter Anvin" <hpa@zytor.com>
> Subject: Re: [PATCH v1 2/2] x86, apic: Disable BSP if boot cpu is AP
> Date: Mon, 22 Oct 2012 17:35:47 -0700
>
>> On 10/22/2012 02:29 PM, Eric W. Biederman wrote:
>>>>
>>>> As I said, I thought Fenghua tried that but it didn't work,
>>>> experimentally.
>>>
>>> Fair enough.  You described the problem with clearing bit 8 in a weird
>>> way.
>>>
>>> If the best we can muster are fuzzy memories it may be worth
>>> revisiting.
>>> Perhaps it works on enough cpu models to be interesting.
>>>
>> 
>> It isn't fuzzy memories... this was done as late as 1-2 months ago.  I
>> just don't know the details.
>> 
>> Fenghua, could you help fill us in?
>> 
>
> I overlooked completely the fact that BSP flag is rewritable.
>
> I tried Eric's suggestion using attached test programs and saw it
> worked fine at least on the three cpus around me below:
>
> - Intel(R) Xeon(R) CPU E7- 4820  @ 2.00GHz
> - Intel(R) Xeon(R) CPU E7- 8870  @ 2.40GHz
> - Intel(R) Xeon(TM) CPU 1.80GHz
>   - 32 bits CPU
>
> Next I found the description about this in 8.4.2, IASDM Vol.3:
>
>   The MP initialization protocol imposes the following requirements
>   and restrictions on the system:
>
>   * The MP protocol is executed only after a power-up or RESET. If the
>     MP protocol has completed and a BSP is chosen, subsequent INITs
>     (either to a specific processor or system wide) do not cause the
>     MP protocol to be repeated. Instead, each logical processor
>     examines its BSP flag (in the IA32_APIC_BASE MSR) to determine
>     whether it should execute the BIOS boot-strap code (if it is the
>     BSP) or enter a wait-for-SIPI state (if it is an AP).
>
> So this is no longer undocumented behaviour for recent cpus, I think.

The underdocumented bit is the ability to clear the flag.
And of course these are processor specific registers.

> Considering these, I'll make a patch to clear BSP flag at appropreate
> position in kernel boot-up code. OTOH, according to the discussion, it
> was reported that clearing BSP flag affected some BIOSes. To deal with
> this, I'll prepare a kernel option to decide whether to clear BSP flag
> or not.
>
> Does anyone have any comments now? Or please comment after I submit a
> new patch.

I think you are on right track with preparing some patches, and this
certainly looks like worth experimenting with.

At least for i386 the code need to verify you have a cpu new enough to
have an APIC_BASE_MSR, but I don't think that is going to be hard.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
