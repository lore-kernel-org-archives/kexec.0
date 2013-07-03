Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107])
 by casper.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UuNbo-0007FD-2a
 for kexec@lists.infradead.org; Wed, 03 Jul 2013 14:00:38 +0000
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 3 Jul 2013 14:54:10 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id C33051B08023
 for <kexec@lists.infradead.org>; Wed,  3 Jul 2013 14:59:36 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r63DxP1f53477572
 for <kexec@lists.infradead.org>; Wed, 3 Jul 2013 13:59:25 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r63DxZXU018771
 for <kexec@lists.infradead.org>; Wed, 3 Jul 2013 07:59:35 -0600
Date: Wed, 3 Jul 2013 15:59:33 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
Message-ID: <20130703155933.3f3de4b9@holzheu>
In-Reply-To: <20130702154214.GC22603@redhat.com>
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130702154214.GC22603@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Tue, 2 Jul 2013 11:42:14 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Mon, Jul 01, 2013 at 09:32:37PM +0200, Michael Holzheu wrote:

[snip]

> > This handler works as follows:
> > 
> > * Get already available or new page from page cache (find_or_create_page)
> > * Check if /proc/vmcore page is filled with data (PageUptodate)
> > * If yes:
> >   Return that page
> > * If no:
> >   Fill page using __vmcore_read(), set PageUptodate, and return page
> > 
> > Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> In general vmcore related changes look fine to me. I am not very familiar
> with the logic of finding pages in page cache and using page uptodate
> flag.
> 
> Hatayama, can you please review it.
> 
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

Hello Vivek,

If Hatayama accepts the patch, should we then send the patch series to
Andrew Morton?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
