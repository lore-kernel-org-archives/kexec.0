Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jOFdQ-0000BJ-FV
 for kexec@lists.infradead.org; Tue, 14 Apr 2020 07:05:29 +0000
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-2-james.morse@arm.com>
 <321e6bf7-e898-7701-dd60-6c25237ff9cd@redhat.com>
 <a21d90ea-2566-a2bc-ad2f-6464a416c97f@arm.com>
 <9cb4ea0d-34c3-de42-4b3f-ee25a59c4835@redhat.com>
 <b0443908-e36f-9bc4-4a8a-4206cb782d4b@arm.com>
 <72672e2c-a57a-8df9-0cff-8035cbce7740@redhat.com>
 <34274b02-60ba-eb78-eacd-6dc1146ed3cd@arm.com>
 <80e4d1d7-f493-3f66-f700-86f18002d692@redhat.com>
 <dfacf85f-d79d-8742-7a13-1ac0a67bad04@arm.com>
 <ba481c82-c69e-043c-4b66-2d2c7732cf07@redhat.com>
 <20200410121013.03b609fd572504c03a666f4a@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4ed2fa36-fcd8-7150-03d1-35f15e595ebb@redhat.com>
Date: Tue, 14 Apr 2020 09:05:18 +0200
MIME-Version: 1.0
In-Reply-To: <20200410121013.03b609fd572504c03a666f4a@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, James Morse <james.morse@arm.com>, Eric Biederman <ebiederm@xmission.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

On 10.04.20 21:10, Andrew Morton wrote:
> It's unclear (to me) what is the status of this patchset.  But it does appear that
> an new version can be expected?
> 

I'd suggest to unqueue the patches until we have a consensus.

While there are a couple of ideas floating around here, my current
suggestion would be either

1. Indicate all hotplugged memory as "System RAM (hotplugged)" in
/proc/iomem and the firmware memmap (on all architectures). This will
require kexec changes, but I would have assume that kexec has to be
updated in lock-step with the kernel just like e.g., makedumpfile.
Modify kexec() to not place the kexec kernel on these areas (easy) but
still consider them as crash regions to dump. When loading a kexec
kernel, validate in the kernel that the memory is appropriate.

2. Make kexec() reload the the kernel whenever we e.g., get a udev event
for removal of memory in /sys/devices/system/memory/. On every
remove_memory(), invalidate the loaded kernel in the kernel.


As I mentioned somewhere, 1. will be interesting for virtio-mem, where
we don't want any kexec kernel to be placed on virtio-mem-added memory.

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
