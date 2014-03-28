Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTZtZ-0004kJ-Gz
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 16:44:41 +0000
Date: Fri, 28 Mar 2014 09:44:20 -0700
From: Simon Horman <horms@verge.net.au>
Subject: Re: [kexec-tools PATCH v2] x86, kaslr: add alternative way to locate
 kernel text mapping area
Message-ID: <20140328164420.GC3745@verge.net.au>
References: <1395990300-17830-1-git-send-email-chaowang@redhat.com>
 <20140328140522.GF2089@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140328140522.GF2089@redhat.com>
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
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>

On Fri, Mar 28, 2014 at 10:05:22AM -0400, Vivek Goyal wrote:
> On Fri, Mar 28, 2014 at 03:05:00PM +0800, WANG Chao wrote:
> > When kASLR is enabled (CONFIG_RANDOMIZED_BASE=y), kernel text mapping
> > base is randomized. The max base offset of such randomization is
> > configured at compile time through CONFIG_RANDOMIZE_MAX_BASE_OFFSET (by
> > default 1G).
> > 
> > Currently kexec-tools is using hard code macro X86_64__START_KERNEL_map
> > (0xffffffff80000000) and X86_64_KERNEL_TEXT_SIZE (512M) to determine
> > kernel text mapping from kcore's PT_LOAD. With kASLR, the mapping is
> > changed as the following:
> > 
> > ffffffff80000000 - (ffffffff80000000+CONFIG_RANDOMIZE_BASE_MAX_OFFSET)
> > 
> > As Vivek suggested, we can get _stext kernel symbol address from
> > /proc/kallsyms, and search for kcore's PT_LOAD which contains _stext,
> > and we can say that this area represents the kernel mapping area.
> > 
> > Let's first use this way to find out kernel text mapping. If failed for
> > whatever reason, fall back to use the old way.
> > 
> > Suggested-by: Vivek Goyal <vgoyal@redhat.com>
> > Signed-off-by: WANG Chao <chaowang@redhat.com>
> 
> Looks good to me.
> 
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
