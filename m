From: Coiby Xu <coxu@redhat.com>
Date: Mon, 21 Mar 2022 09:41:50 +0800
Subject: [RFC 0/4] Support kdump with LUKS encryption by reusing LUKS
 master key
In-Reply-To: <c06a21cc-e1c1-e627-f908-ebc2a041e29a@igalia.com>
References: <20220318103423.286410-1-coxu@redhat.com>
 <c06a21cc-e1c1-e627-f908-ebc2a041e29a@igalia.com>
Message-ID: <20220321014150.w6wux5azabweu7dr@Rk>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Sat, Mar 19, 2022 at 05:13:21PM -0300, Guilherme G. Piccoli wrote:
>On 18/03/2022 07:34, Coiby Xu wrote:
>> [...]
>> Based on Milan's feedback [1] on Kairui's ideas to support kdump with
>> LUKS encryption, this patch set addresses the above issues by
>>  1) first saving the LUKS master key to kexec when opening the encrypted
>>     device
>>  2) then saving the master key to the reserved memory for kdump when
>>     loading kdump kernel image.
>>
>> So the LUKS master key never leaves the kernel space and once the key has
>> been saved to the reserved memory for kdump, it would be wiped
>> immediately. If there is no security concern with this approach or any
>> other concern, I will drop the following assumptions made for this RFC
>> version in v1,
>>  - only x86 is supported
>>  - there is only one LUKS device for the system
>>
>> to extend the support to other architectures including POWER, ARM and
>> s390x and address the case of multiple LUKS devices. Any feedback will be
>> appreciated, thanks!
>>
>
>Hi Coiby, thanks for the very interesting work!

Hi Guilherme,

I'm glad this work interests you and thanks for sharing your thoughts!

>I confess I didn't review the code as I have not much experience in
>dm-crypt/key management, but I have a generic question related with the
>motivation of the patch set.
>
>My understanding is that one (the main?) motivation of this series would
>be to protect the saved memory (vmcore) from being read by some
>"unauthorized" entity - in order to achieve this goal, it is hereby
>proposed to allow kdump kernel to access a memory-saved key and with
>that, mount an encrypted volume, saving the vmcore over there correct?

>
>So, what if instead of playing with the volume key, users with this
>concern address that by reserving some *unencrypted partition* for
>saving the vmcore, but then *encrypt the vmcore* itself! So, instead of
>requiring saving a full-volume key, mount everything, risk data
>corruption if something goes bad...we just have makedumpfile encrypting
>the vmcore with some preloaded key (which might be saved inside the
>kdump minimal intird, for example), and saving the encrypted file into a
>clear/unencrypted volume? This way we also prevent excessive memory
>consumption during kdump due to the lvm/dm-userspace paraphernalia usage.

I believe some users have security concern for where to save vmcore.
This use case exactly fits your description and your proposed solution
shall be good for this type of users. But I think many more users may
just choose to encrypt the hard drive when installing the system and
they would naturally expect kdump to work for the case of full disk
encryption. So your proposed solution may not address the latter case 
where there is a much large user base.

>
>Does it make sense or am I being silly or missing something?
>Cheers,
>
>
>Guilherme
>
>_______________________________________________
>kexec mailing list
>kexec at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec
>

-- 
Best regards,
Coiby


