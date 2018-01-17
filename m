Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2nam01on0626.outbound.protection.outlook.com
 ([2a01:111:f400:fe42::626]
 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ebwae-0007WK-Kk
 for kexec@lists.infradead.org; Wed, 17 Jan 2018 22:53:55 +0000
Subject: Re: kexec reboot fails with extra wbinvd introduced for AME SME
From: Tom Lendacky <thomas.lendacky@amd.com>
References: <20171213025256.GA1913@dhcp-128-65.nay.redhat.com>
 <20171213155746.GA29572@yu-chen.sh.intel.com>
 <20171214092429.GA2004@dhcp-128-65.nay.redhat.com>
 <20180104031537.GA1819@dhcp-128-65.nay.redhat.com>
 <20180117072123.GA1866@dhcp-128-65.nay.redhat.com>
 <CA+55aFxCuz2K_kE3Huu3Ar32LVmWav__2CPL_=zs2g0devx9-Q@mail.gmail.com>
 <09bd24bd-480b-8075-a1c4-c5040401195a@amd.com>
Message-ID: <d60aa430-e9ce-d9f1-d66c-977a3559e338@amd.com>
Date: Wed, 17 Jan 2018 16:53:32 -0600
MIME-Version: 1.0
In-Reply-To: <09bd24bd-480b-8075-a1c4-c5040401195a@amd.com>
Content-Language: en-US
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Dave Young <dyoung@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>, Yu Chen <yu.c.chen@intel.com>, Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, Ingo Molnar <mingo@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>, ebiederm@redhat.com, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On 1/17/2018 2:01 PM, Tom Lendacky wrote:
> On 1/17/2018 1:42 PM, Linus Torvalds wrote:
>> On Tue, Jan 16, 2018 at 11:22 PM, Dave Young <dyoung@redhat.com> wrote:
>>>
>>> For the kexec reboot hang, if I remove the wbinvd in stop_this_cpu()
>>> then kexec works fine. like this:
>>
>> Honestly, I think we should apply that patch regardless.
>>
>> Using 'wbinvd' should not be some "just because of random reasons".
>> There are CPU's with errata on wbinvd, and the thing in general is
>> slow and nasty.
>>
>> Doing the wbinvd in a loop sounds even stranger.
>>
>> If we're only doing it because of some SME issue, why isn't it
>> dependent on SME? And why is it inside that loop at all?
> 
> My original patches did check for X86_FEATURE_SME and only do the
> wbinvd if SME was supported (although still in the loop).  The general
> consensus was to just do the wbinvd no matter what and so it is as it is
> today.
> 
> It can probably be outside of the loop.  The issue I was seeing was
> memory corruption from the stack when using halt() with paravirt ops
> enabled.  So a native_halt() should be used.
> 
>>
>> Anyway, does it work for you if you just do the wbinvd() once, outside
>> the loop? Admittedly the loop shouldn't actually loop (hlt with
>> interrupts disabled), but who the hell knows.. Some of the errata
>> around SME have been about machine check exceptions or something.
> 
> I think that should work as long as it's a native_wbinvd() call and it
> can also be conditional on boot_cpu_has(X86_FEATURE_SME).
> 
> I'll do some testing.

Looks like everything is good with the suggested changes.  Patch to follow
shortly.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
>> See commit a68e5c94f7d3 ("x86, hotplug: Move WBINVD back outside the
>> play_dead loop") for another example where wbinvd was inside a loop
>> and apparently caused some odd issues.
>>
>>               Linus
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
