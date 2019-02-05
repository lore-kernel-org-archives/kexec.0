Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqvtj-0000lM-Jk
 for kexec@lists.infradead.org; Tue, 05 Feb 2019 08:16:06 +0000
Date: Tue, 5 Feb 2019 09:15:52 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190205081552.GG21801@zn.tnic>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic> <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic> <20190204223016.GB11986@anatevka>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190204223016.GB11986@anatevka>
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
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Baoquan He <bhe@redhat.com>, yinghai@kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Mon, Feb 04, 2019 at 03:30:16PM -0700, Jerry Hoemann wrote:
> Is your objection only to the second fallback of allocating
> memory above >= 4GB?   Or are you objecting to allocating from
> (896 .. 4GB) as well?

My problem is why should the user need to specify high or low allocation
explicitly when we can handle all that in the kernel automatically.

The presence of crashkernel= on the cmdline sure means that the user
wants to allocate memory for a second kernel.

Now, if the requested allocation fails, we say:

  Error reserving crashkernel

So, instead of saying that, we can *try* *again* and say

  Error reserving requested crashkernel at @..., attempting a high range.

and run memblock_find_in_range() on the other regions which we deemed
are ok to allocate from.

Why aren't we doing that by default instead of placing all those
different options in front of the user and expecting her/him to know
something about all those magic ranges?

I don't think most of the users care about where the kernel gets
allocated - all they want is a working kdump setup.

> Falling back to allocating < 4GB probably satisfes most of the cases
> where the original allocation fails.

Yes. Now make that automatic.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
