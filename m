Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bDTjf-0007JM-MR
 for kexec@lists.infradead.org; Thu, 16 Jun 2016 09:37:17 +0000
Subject: Re: [PATCH] Revert "mm: rename _count, field of the struct page, to
 _refcount"
References: <1466068966-24620-1-git-send-email-vkuznets@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d7049c89-7b78-ee1c-7216-90d8dd69d1b5@suse.cz>
Date: Thu, 16 Jun 2016 11:36:47 +0200
MIME-Version: 1.0
In-Reply-To: <1466068966-24620-1-git-send-email-vkuznets@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>, linux-mm@kvack.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, Hugh Dickins <hughd@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>

On 06/16/2016 11:22 AM, Vitaly Kuznetsov wrote:
> _count -> _refcount rename in commit 0139aa7b7fa12 ("mm: rename _count,
> field of the struct page, to _refcount") broke kdump. makedumpfile(8) does
> stuff like READ_MEMBER_OFFSET("page._count", page._count) and fails. While
> it is definitely possible to fix this particular tool I'm not sure about
> other tools which might be doing the same.
>
> I suggest we remember the "we don't break userspace" rule and revert for
> 4.7 while it's not too late.

I don't think the rule applies to tools such as kdump and crash, or e.g. 
systemtap, that interact with kernel internals even though they are 
technically "userspace". They have to adapt to new kernel versions all 
the time, the internal APIs are not frozen. Otherwise we would be quite 
limited in evolving the kernel...

So even though the change in question is not essential (field rename) 
and reverting wouldn't really hurt technical progress, this is not a 
sufficient reason, IMO. Thus, NAK.

Vlastimil

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
