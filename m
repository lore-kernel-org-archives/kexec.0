Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x243.google.com ([2607:f8b0:400e:c03::243])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bGDC1-0008Bw-NR
 for kexec@lists.infradead.org; Thu, 23 Jun 2016 22:33:50 +0000
Received: by mail-pa0-x243.google.com with SMTP id hf6so7404381pac.2
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 15:33:28 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] kexec_file_load implementation for PowerPC
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <2895031.4C8tZ3BP2G@hactar> <576B25FF.1010307@gmail.com>
 <1612090.Qxo4UiJulB@hactar>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <576C63B4.8060302@gmail.com>
Date: Fri, 24 Jun 2016 08:33:24 +1000
MIME-Version: 1.0
In-Reply-To: <1612090.Qxo4UiJulB@hactar>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org



On 24/06/16 02:44, Thiago Jung Bauermann wrote:
> Am Donnerstag, 23 Juni 2016, 09:57:51 schrieb Balbir Singh:
>> On 23/06/16 03:02, Thiago Jung Bauermann wrote:
>>>>> 3. have IMA pass-on its event log (where integrity measurements are
>>>>>
>>>>>    registered) accross kexec to the second kernel, so that the event
>>>>>    history is preserved.
>>>>
>>>> OK.. and this is safe? Do both the kernels need to be signed by the
>>>> same certificate?
>>>
>>> They don't. The integrity of the event log (assuming that is what you
>>> mean by "this" in "this is safe") is guaranteed by the TPM device. Each
>>> event in the measurement list extends a PCR and records its PCR value.
>>> It is cryptographically guaranteed that if you replay the PCR extends
>>> recorded in the event log and in the end of the process they match the
>>> current PCR values in the TPM device, then that event log is correct.
>>
>> What I meant was how does the new kernel know that the old kernel did not
>> cheat while passing on the values? I presume because we trust that kernel
>> via a signature.
> 
> Sorry, I still don't understand your concern. What kind of cheating? Which 
> values? If it's the values in the event log, there's no need to trust the 
> old kernel. The new kernel knows that the old kernel didn't pass wrong 
> measurement values in the event log because it can recalculate the PCR 
> extend operations recorded in the log and compare the results of the replay 
> with the current PCR values stored in the TPM device. If they match, then 
> the event log is guaranteed to be correct. If they don't match, either the 
> memory was corrupted somehow during the kexec process, or the old kernel 
> tried to pass a falsified event log.
> 

Yep, get it/got it. My concern was anything using passed on the values should
compare the results with the current PCR values.

BTW, what do we gain by passing the values if we are relying on the PCR registers
anyway, can't we directly read them off from there? Aren't we going to ready anyway
to compare, what does passing the values gain?

[snip]

>> and
>>
>> How do we know the new kernel is safe to load - I guess via a signature
>> that the new kernel is signed with (assuming it is present in the key
>> ring).
> 
> Correct. That goal is met by signature verification, not by integrity 
> assurance.
> 
> I'll note that even with both of my patch series there's still code missing 
> for kernel signature verification in PowerPC. I believe there's not a file 
> format defined yet for how to store a signature in a PowerPC kernel image.
> 
> Integrity assurance doesn't depend on kernel signature verification though. 
> There's value in both my patch series even without kernel signature 
> verification support. They're complementary features.
>  

Thanks for clarifying

Balbir Singh.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
