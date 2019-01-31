Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpM3o-00016m-DM
 for kexec@lists.infradead.org; Thu, 31 Jan 2019 23:47:58 +0000
Date: Fri, 1 Feb 2019 00:47:40 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190131234740.GO6749@zn.tnic>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic> <20190131222732.GA946@anatevka>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131222732.GA946@anatevka>
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

On Thu, Jan 31, 2019 at 03:27:32PM -0700, Jerry Hoemann wrote:
> So even if a system administrator is diligent and tests
> that a chosen kdump configuration works, that configuration
> might not work on some random reboot 7 months in the future.

Jerry, did you read the rest of the thread where I'm *actually*
suggesting to make the allocation code more robust against such
failures?

Doesn't look like it...

Now let's look at the code:

The "high" allocation does:

                crash_base = memblock_find_in_range(CRASH_ALIGN,
                                                    high ? CRASH_ADDR_HIGH_MAX
                                                         : CRASH_ADDR_LOW_MAX,
                                                    crash_size, CRASH_ALIGN);

where high=true and CRASH_ADDR_HIGH_MAX on 64-bit is MAXMEM:

# define CRASH_ADDR_HIGH_MAX    MAXMEM

The second fallback in the suggested patch does the same:

+               /*
+                * crashkernel=X reserve below 4G fails? Try MAXMEM
+                */
+               if (!high && !crash_base)
+                       crash_base = memblock_find_in_range(CRASH_ALIGN,
+                                               CRASH_ADDR_HIGH_MAX,
+                                               crash_size, CRASH_ALIGN);

and yet I get back that falling back to "high" if the first allocation
doesn't succeed is not something we should do by default because of
reasons. But this patch *practically* *does* it.

So no, until this hasn't been done cleanly and properly explained, we'll
be in a holding pattern.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
