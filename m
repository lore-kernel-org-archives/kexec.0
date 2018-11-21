Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPRVx-0000Nm-4O
 for kexec@lists.infradead.org; Wed, 21 Nov 2018 12:21:54 +0000
Subject: Re: [PATCH v1 8/8] PM / Hibernate: exclude all PageOffline() pages
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101616.8901-9-david@redhat.com>
 <11E3C0B0-AEED-42C6-A21C-1820F4B47A68@oracle.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <88f19102-9830-1ed0-1f46-56e11316ca09@redhat.com>
Date: Wed, 21 Nov 2018 13:21:08 +0100
MIME-Version: 1.0
In-Reply-To: <11E3C0B0-AEED-42C6-A21C-1820F4B47A68@oracle.com>
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
To: William Kucharski <william.kucharski@oracle.com>
Cc: Len Brown <len.brown@intel.com>, Michal Hocko <mhocko@suse.com>, linux-pm@vger.kernel.org, pv-drivers@vmware.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-doc@vger.kernel.org, kexec-ml <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Linux-MM <linux-mm@kvack.org>, "Michael S. Tsirkin" <mst@redhat.com>, Pavel Machek <pavel@ucw.cz>, xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, devel@linuxdriverproject.org, Andrew Morton <akpm@linux-foundation.org>

On 21.11.18 12:35, William Kucharski wrote:
> If you are adding PageOffline(page) to the condition list of the already existing if in
> saveable_highmem_page(), why explicitly add it as a separate statement in saveable_page()?
> 
> It would seem more consistent to make the second check:
> 
> -	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
> +	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page) ||
> +		PageOffline(page))
> 
> instead.
> 
> It's admittedly a nit but it just seems cleaner to either do that or, if your intention
> was to separate the Page checks from the swsusp checks, to break the calls to
> PageReserved() and PageOffline() into their own check in saveable_highmem_page().

I'll split PageReserved() and PageOffline() off from the swsusp checks,
thanks for your comment!

> 
> Thanks!
>     -- Bill


-- 

Thanks,

David / dhildenb

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
