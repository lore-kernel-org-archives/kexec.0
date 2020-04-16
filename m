Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jP4cT-0003Ab-1r
 for kexec@lists.infradead.org; Thu, 16 Apr 2020 13:31:54 +0000
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
References: <20200412080836.GM25745@shell.armlinux.org.uk>
 <87wo6klbw0.fsf@x220.int.ebiederm.org>
 <20200413023701.GA20265@MiWiFi-R3L-srv>
 <871rorjzmc.fsf@x220.int.ebiederm.org> <20200414064031.GB4247@MiWiFi-R3L-srv>
 <86e96214-7053-340b-5c1a-ff97fb94d8e0@redhat.com>
 <20200414092201.GD4247@MiWiFi-R3L-srv>
 <ad060c8a-8afe-3858-0a4f-27ff54ef4c68@redhat.com>
 <20200414143912.GE4247@MiWiFi-R3L-srv>
 <0085f460-b0c7-b25f-36a7-fa3bafaab6fe@redhat.com>
 <20200415023524.GG4247@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Message-ID: <18cf6afd-c651-25c7-aca3-3ca3c0e07547@redhat.com>
Date: Thu, 16 Apr 2020 15:31:40 +0200
MIME-Version: 1.0
In-Reply-To: <20200415023524.GG4247@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: piliu@redhat.com, Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>, linux-mm@kvack.org, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

> Not sure if I get the notifier idea clearly. If you mean 
> 
> 1) Add a common function to pick memory in unmovable zone;

Not strictly required IMHO. But, minor detail.

> 2) Let DLPAR, balloon register with notifier;

Yeah, or virtio-mem, or any other technology that adds/removes memory
dynamically.

> 3) In the common function, ask notified part to check if the picked
>    unmovable memory is available for locating kexec kernel;

Yeah.

> 
> Sounds doable to me, and not complicated.
> 
>> images. It would apply to
>>
>> - arm64 and filter out all hotadded memory (IIRC, only boot memory can
>>   be used).
> 
> Do you mean hot added memory after boot can't be recognized and added
> into system RAM on arm64?

See patch #3 of this patch set, which wants to avoid placing kexec
binaries on hotplugged memory. But I have no idea what the current plan
regarding arm64 is (this thread exploded :) ).

I would assume that we don't want to place kexec images on any
hotplugged (or rather: hot(un)pluggable) memory - on any architecture.

> 
> 
>> - powerpc to filter out all LMBs that can be removed (assuming not all
>>   memory corresponds to LMBs that can be removed, otherwise we're in
>>   trouble ... :) )
>> - virtio-mem to filter out all memory it added.
>> - hyper-v to filter out partially backed memory blocks (esp. the last
>>   memory block it added and only partially backed it by memory).
>>
>> This would make it work for kexec_file_load(), however, I do wonder how
>> we would want to approach that from userspace kexec-tools when handling
>> it from kexec_load().
> 
> Let's make kexec_file_load work firstly. Since this work is only first
> step to make kexec-ed kernel not break memory hotplug. After kexec
> rebooting, the KASLR may locate kernel into hotpluggable area too.

Can you elaborate how that would work?

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
