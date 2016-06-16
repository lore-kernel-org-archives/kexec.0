Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 16 Jun 2016 02:32:35 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Revert "mm: rename _count, field of the struct page, to
 _refcount"
Message-ID: <20160616093235.GA14640@infradead.org>
References: <1466068966-24620-1-git-send-email-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1466068966-24620-1-git-send-email-vkuznets@redhat.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, Hugh Dickins <hughd@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>

On Thu, Jun 16, 2016 at 11:22:46AM +0200, Vitaly Kuznetsov wrote:
> _count -> _refcount rename in commit 0139aa7b7fa12 ("mm: rename _count,
> field of the struct page, to _refcount") broke kdump. makedumpfile(8) does
> stuff like READ_MEMBER_OFFSET("page._count", page._count) and fails. While
> it is definitely possible to fix this particular tool I'm not sure about
> other tools which might be doing the same.
> 
> I suggest we remember the "we don't break userspace" rule and revert for
> 4.7 while it's not too late.

Err, sorry - this is not "userspace".  It's crazy crap digging into
kernel internal structure.

The rename was absolutely useful, so fix up your stinking pike in kdump.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
