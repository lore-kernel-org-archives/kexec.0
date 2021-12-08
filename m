Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mux9a-00Cobd-Cq
 for kexec@lists.infradead.org; Wed, 08 Dec 2021 13:38:39 +0000
Received: by mail-wm1-f70.google.com with SMTP id
 j193-20020a1c23ca000000b003306ae8bfb7so1308068wmj.7
 for <kexec@lists.infradead.org>; Wed, 08 Dec 2021 05:38:28 -0800 (PST)
Message-ID: <9230f9cc-1001-e3ce-aa74-10b766c8cdb0@redhat.com>
Date: Wed, 8 Dec 2021 14:38:22 +0100
MIME-Version: 1.0
Subject: Re: [RFC v2 4/6] crash hp: generic crash hotplug support
 infrastructure
References: <20211207195204.1582-1-eric.devolder@oracle.com>
 <20211207195204.1582-5-eric.devolder@oracle.com>
From: David Hildenbrand <david@redhat.com>
In-Reply-To: <20211207195204.1582-5-eric.devolder@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com, robh@kernel.org, efault@gmx.de, rppt@kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com

> +#if defined(CONFIG_MEMORY_HOTPLUG)
> +static int crash_memhp_notifier(struct notifier_block *nb,
> +	unsigned long val, void *v)
> +{
> +	struct memory_notify *mhp = v;
> +	unsigned long start, end;
> +
> +	start = mhp->start_pfn << PAGE_SHIFT;
> +	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
> +
> +	switch (val) {
> +	case MEM_GOING_ONLINE:
> +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
> +			start, end-start);
> +		break;
> +
> +	case MEM_OFFLINE:
> +	case MEM_CANCEL_ONLINE:
> +		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
> +			start, end-start);

Any reason you don't handle this after the effects completely, meaning
MEM_ONLINE and MEM_OFFLINE?

-- 
Thanks,

David / dhildenb


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
