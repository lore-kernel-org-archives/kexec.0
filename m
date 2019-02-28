Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gzRci-0004Cf-F2
 for kexec@lists.infradead.org; Thu, 28 Feb 2019 19:45:43 +0000
Date: Thu, 28 Feb 2019 11:45:35 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/8] mm/kdump: allow to exclude pages that are
 logically offline
Message-Id: <20190228114535.150dfaebbe4d00ae48716bf0@linux-foundation.org>
In-Reply-To: <20190227053214.GA12302@dhcp-128-65.nay.redhat.com>
References: <20181122100627.5189-1-david@redhat.com>
 <20190227053214.GA12302@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>
Cc: Pankaj gupta <pagupta@redhat.com>, Michal Hocko <mhocko@suse.com>, Lianbo Jiang <lijiang@redhat.com>, linux-doc@vger.kernel.org, pv-drivers@vmware.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Nadav Amit <namit@vmware.com>, Pavel Machek <pavel@ucw.cz>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Omar Sandoval <osandov@fb.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Stefano Stabellini <sstabellini@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, xen-devel@lists.xenproject.org, Alexey Dobriyan <adobriyan@gmail.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, Xavier Deguillard <xdeguillard@vmware.com>, Haiyang Zhang <haiyangz@microsoft.com>, Julien Freche <jfreche@vmware.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Konstantin Khlebnikov <koct9i@gmail.com>, Juergen Gross <jgross@suse.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Kairui Song <kasong@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Hansen <chansen3@cisco.com>, kexec-ml <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Miles Chen <miles.chen@mediatek.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-fsdevel@vger.kernel.org, devel@linuxdriverproject.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

On Wed, 27 Feb 2019 13:32:14 +0800 Dave Young <dyoung@redhat.com> wrote:

> This series have been in -next for some days, could we get this in
> mainline? 

It's been in -next for two months?

> Andrew, do you have plan about them, maybe next release?

They're all reviewed except for "xen/balloon: mark inflated pages
PG_offline". 
(https://ozlabs.org/~akpm/mmotm/broken-out/xen-balloon-mark-inflated-pages-pg_offline.patch).
Yes, I plan on sending these to Linus during the merge window for 5.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
