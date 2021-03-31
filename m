Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRd4D-006yUm-2K
 for kexec@lists.infradead.org; Wed, 31 Mar 2021 15:47:39 +0000
Subject: Re: [PATCH v1 1/3] crashdump/x86: dump any kind of "System RAM"
References: <20210323100111.8365-1-david@redhat.com>
 <20210323100111.8365-2-david@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <804fd275-25ec-554b-f55f-584557a67db5@intel.com>
Date: Wed, 31 Mar 2021 08:47:28 -0700
MIME-Version: 1.0
In-Reply-To: <20210323100111.8365-2-david@redhat.com>
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
To: David Hildenbrand <david@redhat.com>, kexec@lists.infradead.org
Cc: Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Baoquan He <bhe@redhat.com>, Simon Horman <horms@verge.net.au>

On 3/23/21 3:01 AM, David Hildenbrand wrote:
> Traditionally, we had "System RAM" only on the top level of in the
> kernel resource tree (-> /proc/iomem). Nowadays, we can also have
> "System RAM" on lower levels of the tree -- driver-managed device memory
> that is always detected and added via drivers. Current examples are
> memory added via dax/kmem -- ("System RAM (kmem)") and virtio-mem ("System
> RAM (virtio_mem)"). Note that in some kernel versions "System RAM
> (kmem)" was exposed as "System RAM", but similarly, on lower levels of
> the resource tree.
> 
> Let's add anything that contains "System RAM" to the elf core header, so
> it will be dumped for kexec_load(). Handling kexec_file_load() in the
> kernel is similarly getting fixed [1].

Although I don't do a lot of hacking in the crashdump code, this seems
sane to me.  As the perpetrator of the "System RAM (kmem)" trick:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
