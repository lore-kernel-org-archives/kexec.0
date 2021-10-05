Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXq6P-00BefT-O2
 for kexec@lists.infradead.org; Tue, 05 Oct 2021 19:27:50 +0000
Subject: Re: [PATCH v2 2/9] x86/xen: simplify xen_oldmem_pfn_is_ram()
References: <20211005121430.30136-1-david@redhat.com>
 <20211005121430.30136-3-david@redhat.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <ded331ac-f967-fdd3-e2e6-b79c37ebaa1f@oracle.com>
Date: Tue, 5 Oct 2021 15:26:54 -0400
In-Reply-To: <20211005121430.30136-3-david@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>, Mike Rapoport <rppt@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org


On 10/5/21 8:14 AM, David Hildenbrand wrote:
> Let's simplify return handling.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
