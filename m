Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOfBN-00EiE1-9Z
 for kexec@lists.infradead.org; Tue, 23 Mar 2021 11:26:47 +0000
Subject: Re: [PATCH v1 2/3] kernel/resource: make walk_mem_res() find all busy
 IORESOURCE_MEM resources
References: <20210322160200.19633-1-david@redhat.com>
 <20210322160200.19633-3-david@redhat.com>
 <YFnMOK6VuIBsoKWr@smile.fi.intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <16bfac8e-cee1-c8ce-14f1-70e697e4f2f1@redhat.com>
Date: Tue, 23 Mar 2021 12:26:27 +0100
MIME-Version: 1.0
In-Reply-To: <YFnMOK6VuIBsoKWr@smile.fi.intel.com>
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

On 23.03.21 12:08, Andy Shevchenko wrote:
> On Mon, Mar 22, 2021 at 05:01:59PM +0100, David Hildenbrand wrote:
>> It used to be true that we can have system RAM only on the first level
>> in the resourc tree. However, this is no longer holds for driver-managed
>> system RAM (i.e., dax/kmem and virtio-mem).
>>
>> The function walk_mem_res() only consideres the first level and is
>> used in arch/x86/mm/ioremap.c:__ioremap_check_mem() only. We currently
>> fail to identify System RAM added by dax/kmem and virtio-mem as
>> "IORES_MAP_SYSTEM_RAM", for example, allowing for remapping of such
>> "normal RAM" in __ioremap_caller().
> 
> Here I dunno, but consider to add Fixes tag if it fixes known bad behaviour.

Haven't observed it in the wild. We can add the same fixes tags as to 
patch #1.

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
