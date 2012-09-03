Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T8NZp-0004JL-02
 for kexec@lists.infradead.org; Mon, 03 Sep 2012 03:43:55 +0000
Date: Mon, 3 Sep 2012 12:42:33 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: keep dumpfile pages in a cache
Message-Id: <20120903124233.61eafa52ffaed6a38a23710d@mxc.nes.nec.co.jp>
In-Reply-To: <201208281949.50286.ptesarik@suse.cz>
References: <201208281949.50286.ptesarik@suse.cz>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ptesarik@suse.cz
Cc: kexec@lists.infradead.org

Hello Petr,

On Tue, 28 Aug 2012 19:49:49 +0200
Petr Tesarik <ptesarik@suse.cz> wrote:

> Add a simple cache for pages read from the dumpfile.
> 
> This is a big win if we read consecutive data from one page, e.g.
> page descriptors, or even page table entries.
> 
> Note that makedumpfile now always reads a complete page. This was already
> the case with kdump-compressed and sadump formats, but makedumpfile was
> throwing most of the data away. For the kdump-compressed case, we may
> actually save a lot of decompression, too.
> 
> I tried to keep the cache small to minimize memory footprint, but it should
> be big enough to hold all pages to do 4-level paging plus some data. This
> is needed e.g. for vmalloc areas or Xen page frame table data, which are not
> contiguous in physical memory.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

It's interesting to me. I want to know how performance will be improved
with this patch, so do you have speed measurements ?


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
