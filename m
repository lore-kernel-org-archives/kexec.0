Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwsVu-00BOQc-5d
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 21:05:39 +0000
Date: Mon, 13 Dec 2021 13:05:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/5] Avoid requesting page from DMA zone when no
 managed pages
Message-Id: <20211213130534.af47c7956c219797e6b56687@linux-foundation.org>
In-Reply-To: <20211213122712.23805-1-bhe@redhat.com>
References: <20211213122712.23805-1-bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org

On Mon, 13 Dec 2021 20:27:07 +0800 Baoquan He <bhe@redhat.com> wrote:

> Background information can be checked in cover letter of v2 RESEND POST
> as below:
> https://lore.kernel.org/all/20211207030750.30824-1-bhe@redhat.com/T/#u

Please include all relevant info right here, in the [0/n].  For a
number of reasons, one of which is that the text is more likely to be
up to date as the patchset evolves.

It's unusual that this patchset has two non-urgent patches and the
final three patches are cc:stable.  It makes one worry that patches 3-5
might have dependencies on 1-2.  Also, I'd expect to merge the three
-stable patches during 5.16-rcX which means I have to reorder things,
redo changelogs, update links and blah blah.

So can I ask that you redo all of this as two patch series?  A 3-patch
series which is targeted at -stable, followed by a separate two-patch
series which is targeted at 5.17-rc1.  Each series with its own fully
prepared [0/n] cover.

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
