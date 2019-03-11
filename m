Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h3Hnk-0005s2-LL
 for kexec@lists.infradead.org; Mon, 11 Mar 2019 10:04:59 +0000
Date: Mon, 11 Mar 2019 18:04:38 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 3/8] kexec: export PG_offline to VMCOREINFO
Message-ID: <20190311100438.GA12545@dhcp-128-65.nay.redhat.com>
References: <20181122100627.5189-1-david@redhat.com>
 <20181122100627.5189-4-david@redhat.com>
 <20190311090402.GA12071@dhcp-128-65.nay.redhat.com>
 <d9e578c3-5ae6-5e82-a0a8-14c7e12c729f@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d9e578c3-5ae6-5e82-a0a8-14c7e12c729f@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, linux-pm@vger.kernel.org, pv-drivers@vmware.com, Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org, kexec-ml <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, devel@linuxdriverproject.org, Andrew Morton <akpm@linux-foundation.org>, Omar Sandoval <osandov@fb.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lianbo Jiang <lijiang@redhat.com>

> > The patch has been merged, would you mind to send a documentation patch
> > for the vmcoreinfo, which is added recently in Documentation/kdump/vmcoreinfo.txt
> > 
> > A brief description about how this vmcoreinfo field is used is good to
> > have.
> > 
> 
> Turns out, it was already documented
> 
> PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|PG_hwpoision
> |PG_head_mask|PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)
> |PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
> -----------------------------------------------------------------
> 
> Page attributes. These flags are used to filter various unnecessary for
> dumping pages.

Good enough, just ignore the request!

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
