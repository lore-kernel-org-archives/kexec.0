Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UuNsQ-00081s-0P
 for kexec@lists.infradead.org; Wed, 03 Jul 2013 14:17:47 +0000
Date: Wed, 3 Jul 2013 10:16:35 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
Message-ID: <20130703141635.GC1460@redhat.com>
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130702154214.GC22603@redhat.com>
 <20130703155933.3f3de4b9@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130703155933.3f3de4b9@holzheu>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Wed, Jul 03, 2013 at 03:59:33PM +0200, Michael Holzheu wrote:
> On Tue, 2 Jul 2013 11:42:14 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > On Mon, Jul 01, 2013 at 09:32:37PM +0200, Michael Holzheu wrote:
> 
> [snip]
> 
> > > This handler works as follows:
> > > 
> > > * Get already available or new page from page cache (find_or_create_page)
> > > * Check if /proc/vmcore page is filled with data (PageUptodate)
> > > * If yes:
> > >   Return that page
> > > * If no:
> > >   Fill page using __vmcore_read(), set PageUptodate, and return page
> > > 
> > > Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > 
> > In general vmcore related changes look fine to me. I am not very familiar
> > with the logic of finding pages in page cache and using page uptodate
> > flag.
> > 
> > Hatayama, can you please review it.
> > 
> > Acked-by: Vivek Goyal <vgoyal@redhat.com>
> 
> Hello Vivek,
> 
> If Hatayama accepts the patch, should we then send the patch series to
> Andrew Morton?

Yes, once hatayama reviews the patch, please send it to Anderew Morton for
for inclusion of paches.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
