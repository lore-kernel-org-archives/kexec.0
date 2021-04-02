Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSGhH-00ChAq-7H
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 10:06:42 +0000
Date: Fri, 2 Apr 2021 12:06:31 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v1 0/3] crashdump/x86: dump dax/kmem and virito-mem added
 System RAM
Message-ID: <20210402100631.GG18086@vergenet.net>
References: <20210323100111.8365-1-david@redhat.com>
 <1c014e9b-88f3-085c-2e67-38007e21c031@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1c014e9b-88f3-085c-2e67-38007e21c031@redhat.com>
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
Cc: kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>

On Tue, Mar 30, 2021 at 10:58:28AM +0200, David Hildenbrand wrote:
> On 23.03.21 11:01, David Hildenbrand wrote:
> > Let's properly support dumping any kind of "System RAM" that is not on the
> > top level of the kernel resource tree in /proc/iomem, processing any
> > /proc/iomem entry that contains "System RAM". In addition, increase
> > the maximum number of crash memory ranges to fully support virtio-mem
> > even in corner cases where we end up with a lot of individual memory
> > ranges.
> > 
> > David Hildenbrand (3):
> >    crashdump/x86: dump any kind of "System RAM"
> >    crashdump/x86: iterate only over actual crash memory ranges
> >    crashdump/x86: increase CRASH_MAX_MEMORY_RANGES to 32k
> > 
> >   kexec/arch/i386/crashdump-x86.c | 18 +++++++++++++-----
> >   kexec/arch/i386/crashdump-x86.h |  3 ++-
> >   2 files changed, 15 insertions(+), 6 deletions(-)
> > 
> 
> Gentle ping.

Thanks, and sorry for the delay.

Series applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
