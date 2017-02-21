Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cfzBx-0000E2-Hy
 for kexec@lists.infradead.org; Tue, 21 Feb 2017 01:24:35 +0000
Subject: Re: [PATCH v2] x86/mce: Don't participate in rendezvous process once
 nmi_shootdown_cpus() was made
References: <1487571037-10821-1-git-send-email-xlpang@redhat.com>
 <20170220110941.vwcm3je3e4kkei6o@pd.tnic> <58AAEF34.9000303@redhat.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <58AB9745.6060507@redhat.com>
Date: Tue, 21 Feb 2017 09:26:29 +0800
MIME-Version: 1.0
In-Reply-To: <58AAEF34.9000303@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>, Xunlei Pang <xlpang@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Dave Young <dyoung@redhat.com>

On 02/20/2017 at 09:29 PM, Xunlei Pang wrote:
> On 02/20/2017 at 07:09 PM, Borislav Petkov wrote:
>> On Mon, Feb 20, 2017 at 02:10:37PM +0800, Xunlei Pang wrote:
>>> @@ -1128,8 +1129,9 @@ void do_machine_check(struct pt_regs *regs, long error_code)
>>>  	 */
>>>  	int lmce = 1;
>>>  
>>> -	/* If this CPU is offline, just bail out. */
>>> -	if (cpu_is_offline(smp_processor_id())) {
>>> +	/* If nmi shootdown happened or this CPU is offline, just bail out. */
>>> +	if (cpus_shotdown() ||
>> I don't like "cpus_shotdown" - it doesn't hint at all that this is
>> special-handling crash/kdump.
>>
>> And more importantly, I want it to be obvious that we do let the
>> crashing CPU into the MCE handler.
> Ok, I will export crashing_cpu and use it directly in mce handler.

Forget to mention, one reason I introduced cpus_shotdown() is that "crashing_cpu"
is defined with CONFIG_SMP=y, so we have to export it unconditionally if we don't want
to add the conditional code(i.e. with #ifdef CONFIG_SMP quoted) in mce.c.

Regards,
Xunlei

>
>> Why?
>>
>> If we didn't, you will not handle *any* MCE, even a fatal one, during
>> dumping memory so if that dump is corrupted from the MCE, you won't
>> know. And I don't want to be the one staring at the corrupted dump and
>> wondering why I'm seeing what I'm seeing.
>>
>> IOW, if we get a fatal MCE during dumping then we should go and die.
>> This is much better than silently corrupting the dump and not even
>> saying anything about it.
>>
> My thought is that it doesn't matter after kdump boots as new mce handler
> will be installed. If we get a fatal MCE during kdumping, the new handler will
> handle the cpus running kdump kernel correctly.
>
> There is a small window between crash and kdump kernel boot, so if a SRAO comes
> within this window it will also cause the mce synchronization problem on the crashing
> cpu if we don't bail out the crashing cpu.
>
> Regards,
> Xunlei


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
