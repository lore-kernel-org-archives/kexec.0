Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lP1gm-00Gz7D-Ry
 for kexec@lists.infradead.org; Wed, 24 Mar 2021 11:28:43 +0000
References: <20210322160200.19633-1-david@redhat.com>
 <20210322160200.19633-2-david@redhat.com> <20210324111835.GA18855@linux>
From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 1/3] kernel/resource: make walk_system_ram_res() find
 all busy IORESOURCE_SYSTEM_RAM resources
Message-ID: <8aa6af09-6f8b-1f50-820f-90eab0993f1c@redhat.com>
Date: Wed, 24 Mar 2021 12:28:21 +0100
MIME-Version: 1.0
In-Reply-To: <20210324111835.GA18855@linux>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Keith Busch <keith.busch@intel.com>, Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>, Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org, kexec@lists.infradead.org

On 24.03.21 12:18, Oscar Salvador wrote:
> On Mon, Mar 22, 2021 at 05:01:58PM +0100, David Hildenbrand wrote:
>> It used to be true that we can have busy system RAM only on the first level
>> in the resourc tree. However, this is no longer holds for driver-managed
>> system RAM (i.e., added via dax/kmem and virtio-mem), which gets added on
>> lower levels.
> 
> Let me ask some rookie questions:
> 
> What does "busy" term stand for here?

IORESOURCE_BUSY - here: actually added, not just some reserved range / container.


> Why resources coming from virtio-mem are added at a lower levels?

Some information can be had from ebf71552bb0e690cad523ad175e8c4c89a33c333

commit ebf71552bb0e690cad523ad175e8c4c89a33c333
Author: David Hildenbrand <david@redhat.com>
Date:   Thu May 7 16:01:35 2020 +0200

     virtio-mem: Add parent resource for all added "System RAM"
     
     Let's add a parent resource, named after the virtio device (inspired by
     drivers/dax/kmem.c). This allows user space to identify which memory
     belongs to which virtio-mem device.
     
     With this change and two virtio-mem devices:
             :/# cat /proc/iomem
             00000000-00000fff : Reserved
             00001000-0009fbff : System RAM
             [...]
             140000000-333ffffff : virtio0
               140000000-147ffffff : System RAM
               148000000-14fffffff : System RAM
               150000000-157ffffff : System RAM
             [...]
             334000000-3033ffffff : virtio1
               338000000-33fffffff : System RAM
               340000000-347ffffff : System RAM
               348000000-34fffffff : System RAM
             [...]



For dax/kmem it comes naturally due to the "Persistent Memory" and
device parent resources like:

             140000000-33fffffff : Persistent Memory
               140000000-1481fffff : namespace0.0
               150000000-33fffffff : dax0.0
                 150000000-33fffffff : System RAM (kmem)
             3280000000-32ffffffff : PCI Bus 0000:00


Thanks

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
