From: Scott Branden <scott.branden@broadcom.com>
Date: Thu, 19 May 2022 12:20:54 -0700
Subject: [PATCH 19/30] panic: Add the panic hypervisor notifier list
In-Reply-To: <edbaa4fa-561c-6f5e-f2ab-43ae68acaede@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com> <YoJZVZl/MH0KiE/J@alley>
 <ad082ce7-db50-13bb-3dbb-9b595dfa78be@igalia.com> <YoOpyW1+q+Z5as78@alley>
 <d72b9aab-675c-ac89-b73a-b1de4a0b722d@igalia.com>
 <81878a67-21f1-fee8-1add-f381bc8b05df@broadcom.com>
 <edbaa4fa-561c-6f5e-f2ab-43ae68acaede@igalia.com>
Message-ID: <d1cc0bee-2a98-0c2e-8796-6fb7fae6b803@broadcom.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 2022-05-19 05:19, Guilherme G. Piccoli wrote:
> On 18/05/2022 19:17, Scott Branden wrote:
>> Hi Guilherme,
>>
>> +Desmond
>> [...]
>>>>> I'm afraid it breaks kdump if this device is not reset beforehand - it's
>>>>> a doorbell write, so not high risk I think...
>>>>>
>>>>> But in case the not-reset device can be probed normally in kdump kernel,
>>>>> then I'm fine in moving this to the reboot list! I don't have the HW to
>>>>> test myself.
>>>>
>>>> Good question. Well, it if has to be called before kdump then
>>>> even "hypervisor" list is a wrong place because is not always
>>>> called before kdump.
>>> [...]
>> We register to the panic notifier so that we can kill the VK card ASAP
>> to stop DMAing things over to the host side.  If it is not notified then
>> memory may not be frozen when kdump is occurring.
>> Notifying the card on panic is also needed to allow for any type of
>> reset to occur.
>>
>> So, the only thing preventing moving the notifier later is the chance
>> that memory is modified while kdump is occurring.  Or, if DMA is
>> disabled before kdump already then this wouldn't be an issue and the
>> notification to the card (to allow for clean resets) can be done later.
> 
> Hi Scott / Desmond, thanks for the detailed answer! Is this adapter
> designed to run in x86 only or you have other architectures' use cases?
The adapter may be used in any PCIe design that supports DMA.
So it may be possible to run in arm64 servers.
> 
> I'm not expert on that, but I guess whether DMA is "kept" or not depends
> a bit if IOMMU is used. IIRC, there was a copy of the DMAR table in
> kdump (at least for Intel IOMMU). Also, devices are not properly
> quiesced on kdump IIUC, we don't call shutdown/reset handlers, they're
> skip due to the crash nature - so there is a risk of devices doing bad
> things in the new kernel.
> 
> With that said, and given this is a lightweight notifier that ideally
> should run ASAP, I'd keep this one in the hypervisor list. We can
> "adjust" the semantic of this list to include lightweight notifiers that
> reset adapters.
Sounds the best to keep system operating as tested today.
> 
> With that said, Petr has a point - not always such list is going to be
> called before kdump. So, that makes me think in another idea: what if we
> have another list, but not on panic path, but instead in the custom
> crash_shutdown()? Drivers could add callbacks there that must execute
> before kexec/kdump, no matter what.
It may be beneficial for some other drivers but for our use we would 
then need to register for the panic path and the crash_shutdown path. 
We notify the VK card for 2 purposes: one to stop DMA so memory stop 
changing during a kdump.  And also to get the card into a good state so 
resets happen cleanly.
> 
> Let me know your thoughts Scott / Desmond / Petr and all interested parties.
> Cheers,
> 
> 
> Guilherme
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4212 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/kexec/attachments/20220519/da0525db/attachment-0001.p7s>
