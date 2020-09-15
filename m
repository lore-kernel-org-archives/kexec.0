Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kI5Wm-0002J1-1u
 for kexec@lists.infradead.org; Tue, 15 Sep 2020 07:37:24 +0000
Subject: Re: [PATCH v2 2/7] kernel/resource: move and rename
 IORESOURCE_MEM_DRIVER_MANAGED
References: <20200908201012.44168-1-david@redhat.com>
 <20200908201012.44168-3-david@redhat.com>
 <20200915022023.GD2007@L-31X9LVDL-1304.local>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b4eced44-00af-fcd2-be0d-d7abf8a2cc99@redhat.com>
Date: Tue, 15 Sep 2020 09:37:09 +0200
MIME-Version: 1.0
In-Reply-To: <20200915022023.GD2007@L-31X9LVDL-1304.local>
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
To: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, linux-acpi@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-nvdimm@lists.01.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Eric Biederman <ebiederm@xmission.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>

On 15.09.20 04:20, Wei Yang wrote:
> On Tue, Sep 08, 2020 at 10:10:07PM +0200, David Hildenbrand wrote:
>> IORESOURCE_MEM_DRIVER_MANAGED currently uses an unused PnP bit, which is
>> always set to 0 by hardware. This is far from beautiful (and confusing),
>> and the bit only applies to SYSRAM. So let's move it out of the
>> bus-specific (PnP) defined bits.
>>
>> We'll add another SYSRAM specific bit soon. If we ever need more bits for
>> other purposes, we can steal some from "desc", or reshuffle/regroup what we
>> have.
> 
> I think you make this definition because we use IORESOURCE_SYSRAM_RAM for
> hotpluged memory? So we make them all in IORESOURCE_SYSRAM_XXX family?

Yeah, to specify based on the extended MEM type SYSRAM. Because it
really only applies to that.

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
