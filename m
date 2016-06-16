Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bDUZN-0006R6-BY
 for kexec@lists.infradead.org; Thu, 16 Jun 2016 10:30:41 +0000
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] Revert "mm: rename _count, field of the struct page,
 to _refcount"
References: <1466068966-24620-1-git-send-email-vkuznets@redhat.com>
 <20160616093235.GA14640@infradead.org>
Date: Thu, 16 Jun 2016 12:30:16 +0200
In-Reply-To: <20160616093235.GA14640@infradead.org> (Christoph Hellwig's
 message of "Thu, 16 Jun 2016 02:32:35 -0700")
Message-ID: <87eg7xfmtj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
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
To: Christoph Hellwig <hch@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, Hugh Dickins <hughd@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Jun 16, 2016 at 11:22:46AM +0200, Vitaly Kuznetsov wrote:
>> _count -> _refcount rename in commit 0139aa7b7fa12 ("mm: rename _count,
>> field of the struct page, to _refcount") broke kdump. makedumpfile(8) does
>> stuff like READ_MEMBER_OFFSET("page._count", page._count) and fails. While
>> it is definitely possible to fix this particular tool I'm not sure about
>> other tools which might be doing the same.
>> 
>> I suggest we remember the "we don't break userspace" rule and revert for
>> 4.7 while it's not too late.
>
> Err, sorry - this is not "userspace".  It's crazy crap digging into
> kernel internal structure.
>
> The rename was absolutely useful, so fix up your stinking pike in kdump.

Ok, sure, I'll send a patch to it. I was worried about other tools out
there which e.g. inspect /proc/vmcore. As it is something we support
some conservatism around it is justified.

-- 
  Vitaly

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
