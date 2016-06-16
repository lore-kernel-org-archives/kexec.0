Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bDV1c-0004iB-C5
 for kexec@lists.infradead.org; Thu, 16 Jun 2016 10:59:52 +0000
Received: by mail-wm0-f65.google.com with SMTP id m124so10496035wme.3
 for <kexec@lists.infradead.org>; Thu, 16 Jun 2016 03:59:31 -0700 (PDT)
Date: Thu, 16 Jun 2016 12:59:28 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] Revert "mm: rename _count, field of the struct page, to
 _refcount"
Message-ID: <20160616105928.GA12437@dhcp22.suse.cz>
References: <1466068966-24620-1-git-send-email-vkuznets@redhat.com>
 <20160616093235.GA14640@infradead.org>
 <87eg7xfmtj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87eg7xfmtj.fsf@vitty.brq.redhat.com>
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
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, Hugh Dickins <hughd@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>

On Thu 16-06-16 12:30:16, Vitaly Kuznetsov wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > On Thu, Jun 16, 2016 at 11:22:46AM +0200, Vitaly Kuznetsov wrote:
> >> _count -> _refcount rename in commit 0139aa7b7fa12 ("mm: rename _count,
> >> field of the struct page, to _refcount") broke kdump. makedumpfile(8) does
> >> stuff like READ_MEMBER_OFFSET("page._count", page._count) and fails. While
> >> it is definitely possible to fix this particular tool I'm not sure about
> >> other tools which might be doing the same.
> >> 
> >> I suggest we remember the "we don't break userspace" rule and revert for
> >> 4.7 while it's not too late.
> >
> > Err, sorry - this is not "userspace".  It's crazy crap digging into
> > kernel internal structure.
> >
> > The rename was absolutely useful, so fix up your stinking pike in kdump.
> 
> Ok, sure, I'll send a patch to it. I was worried about other tools out
> there which e.g. inspect /proc/vmcore. As it is something we support
> some conservatism around it is justified.

struct page layout as some others that such a tool might depend on has
changes several times in the past so I fail to see how is it any
different this time. struct page is nothing the userspace should depend
on.

-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
