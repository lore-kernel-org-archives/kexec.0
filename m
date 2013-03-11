Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UErD8-0005W0-19
 for kexec@lists.infradead.org; Mon, 11 Mar 2013 01:07:32 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id E27A13EE0BB
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 10:07:27 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id C278D45DE55
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 10:07:27 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8F41D45DE4D
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 10:07:27 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7DAE51DB8048
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 10:07:27 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 300EC1DB803E
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 10:07:27 +0900 (JST)
Date: Mon, 11 Mar 2013 10:07:21 +0900 (JST)
Message-Id: <20130311.100721.32982204.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v1 2/2] x86, apic: Disable BSP if boot cpu is AP
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <87r4oloopm.fsf@xmission.com>
References: <5085E663.6040307@zytor.com>
 <20121026.122406.13396329.d.hatayama@jp.fujitsu.com>
 <87r4oloopm.fsf@xmission.com>
Mime-Version: 1.0
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
To: ebiederm@xmission.com
Cc: len.brown@intel.com, fenghua.yu@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, hpa@zytor.com, tglx@linutronix.de, mingo@elte.hu, vgoyal@redhat.com

From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v1 2/2] x86, apic: Disable BSP if boot cpu is AP
Date: Thu, 25 Oct 2012 21:13:25 -0700

> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:
> 
>> From: "H. Peter Anvin" <hpa@zytor.com>
>> Subject: Re: [PATCH v1 2/2] x86, apic: Disable BSP if boot cpu is AP
>> Date: Mon, 22 Oct 2012 17:35:47 -0700
>>
>>> On 10/22/2012 02:29 PM, Eric W. Biederman wrote:
<cut>
>> Considering these, I'll make a patch to clear BSP flag at appropreate
>> position in kernel boot-up code. OTOH, according to the discussion, it
>> was reported that clearing BSP flag affected some BIOSes. To deal with
>> this, I'll prepare a kernel option to decide whether to clear BSP flag
>> or not.
>>
>> Does anyone have any comments now? Or please comment after I submit a
>> new patch.
> 
> I think you are on right track with preparing some patches, and this
> certainly looks like worth experimenting with.
> 
> At least for i386 the code need to verify you have a cpu new enough to
> have an APIC_BASE_MSR, but I don't think that is going to be hard.

Eric, you have probably forgotten this work but I want to restart the
work to allow multiple CPUs on the 2nd kernel. But on my
investigation, I have a question about inconsistent states kdump
framework assumes in the crash path on the 1st kernel.

Now I'm re-investigating how to unset BSP flag on the 1st kernel in a
safe manner. But then I must discuss possibility of BSP flag being set
again after the unsetting of BSP. This includes firmware that assumes
BSP flag is kept set throughtout system execution, but I noticed,
fundamentally, it can happen even only with kernel code in the
inconsistent state from the point where any bug happpens to before
entering 2nd kernel.

For example, some bug that causes buffer overrun can rewrite kdump
code so some part of it be wrmsr but any other part is safe enough to
boot 2nd kernel successfully... Although this is very low, but it must
actually happen. Of course, we face the same situation if we put
unsetting code in machine_shutdown() path, which is similarly not
guaranteed to work well in inconsistent state.

Different from kernel state and similar to any other device states, it
seems to me that it's impossible to unset BSP flag in a safe manner
together with inconsistent state kdump framework considers. Then, it
seems to me that disabling BSP on 2nd kernel is a final resort.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
