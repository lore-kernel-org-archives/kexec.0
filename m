Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVV6N-00ASUA-6n
 for kexec@lists.infradead.org; Wed, 29 Sep 2021 08:38:08 +0000
Received: by mail-wm1-f71.google.com with SMTP id
 5-20020a1c00050000b02902e67111d9f0so874677wma.4
 for <kexec@lists.infradead.org>; Wed, 29 Sep 2021 01:38:04 -0700 (PDT)
Subject: Re: [PATCH v1 8/8] virtio-mem: kdump mode to sanitize /proc/vmcore
 access
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-9-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e01cdc7f-cda8-3268-c971-1255a71fb8ac@redhat.com>
Date: Wed, 29 Sep 2021 10:38:01 +0200
MIME-Version: 1.0
In-Reply-To: <20210928182258.12451-9-david@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, Mike Rapoport <rppt@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org

[...]

> +
> +static bool virtio_mem_vmcore_pfn_is_ram(struct vmcore_cb *cb,
> +					 unsigned long pfn)
> +{
> +	struct virtio_mem *vm = container_of(cb, struct virtio_mem,
> +					     vmcore_cb);
> +	uint64_t addr = PFN_PHYS(pfn);
> +	bool is_ram;
> +	int rc;
> +
> +	if (!virtio_mem_contains_range(vm, addr, addr + PAGE_SIZE))

Some more testing revealed that this has to be

if (!virtio_mem_contains_range(vm, addr, PAGE_SIZE))


-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
