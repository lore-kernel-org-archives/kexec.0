Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOfAR-00EiA8-8X
 for kexec@lists.infradead.org; Tue, 23 Mar 2021 11:25:49 +0000
References: <20210322160200.19633-1-david@redhat.com>
 <20210322160200.19633-2-david@redhat.com>
 <YFnLyJF4u5HVXcc2@smile.fi.intel.com>
From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 1/3] kernel/resource: make walk_system_ram_res() find
 all busy IORESOURCE_SYSTEM_RAM resources
Message-ID: <73a96145-848d-66ea-4d45-fb759003d1de@redhat.com>
Date: Tue, 23 Mar 2021 12:25:27 +0100
MIME-Version: 1.0
In-Reply-To: <YFnLyJF4u5HVXcc2@smile.fi.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Keith Busch <keith.busch@intel.com>, Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>, Oscar Salvador <osalvador@suse.de>, Eric Biederman <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org, kexec@lists.infradead.org

On 23.03.21 12:06, Andy Shevchenko wrote:
> On Mon, Mar 22, 2021 at 05:01:58PM +0100, David Hildenbrand wrote:
>> It used to be true that we can have busy system RAM only on the first level
>> in the resourc tree. However, this is no longer holds for driver-managed
>> system RAM (i.e., added via dax/kmem and virtio-mem), which gets added on
>> lower levels.
>>
>> We have two users of walk_system_ram_res(), which currently only
>> consideres the first level:
>> a) kernel/kexec_file.c:kexec_walk_resources() -- We properly skip
>>     IORESOURCE_SYSRAM_DRIVER_MANAGED resources via
>>     locate_mem_hole_callback(), so even after this change, we won't be
>>     placing kexec images onto dax/kmem and virtio-mem added memory. No
>>     change.
>> b) arch/x86/kernel/crash.c:fill_up_crash_elf_data() -- we're currently
>>     not adding relevant ranges to the crash elf info, resulting in them
>>     not getting dumped via kdump.
>>
>> This change fixes loading a crashkernel via kexec_file_load() and including
> 
> "...fixes..." effectively means to me that Fixes tag should be provided.

We can certainly add, although it doesn't really affect the running 
kernel, but only crashdumps taken in the kdump kernel:

Fixes: ebf71552bb0e ("virtio-mem: Add parent resource for all added 
"System RAM"")
Fixes: c221c0b0308f ("device-dax: "Hotplug" persistent memory for use 
like normal RAM")

Thanks

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
