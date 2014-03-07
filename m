Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226] helo=dev.rtsoft.ru)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WLmzk-0007KM-KI
 for kexec@lists.infradead.org; Fri, 07 Mar 2014 05:06:53 +0000
From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
Subject: Re: [PATCH] kexec/powerpc: fix exporting memory limit
Date: Fri, 7 Mar 2014 08:38:05 +0400
References: <1394115854-11709-1-git-send-email-nyushchenko@dev.rtsoft.ru>
 <1394153258.21206.1.camel@concordia>
In-Reply-To: <1394153258.21206.1.camel@concordia>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <201403070838.07820@blacky.localdomain>
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
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: yadviga@dev.rtsoft.ru, Benjamin Herrenschmidt <benh@kernel.crashing.org>, lugovskoy@dev.rtsoft.ru, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>, Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org

> On Thu, 2014-03-06 at 18:24 +0400, Nikita Yushchenko wrote:
> > When preparing dump-capturing kernel, kexec userspace tool needs to
> > know actual amount of memory used by the running kernel. This may
> > differ from extire available DRAM for a couple of reasons. To address
> > this issue, kdump kernel support code injects several attributes into
> > device tree that are later captured by userspace kexec tool via /proc
> > interface.
> >
> > One such attrubute is 'chosen/linux,memory_limit' that is used to pass
> > memory limit of the running kernel.
> >
> > This was initialized using kernel's 'memory_limit' variable, that is
> > set by early init code based on mem= kernel parameter and other
> > reasons.
> >
> > But there are cases when memory_limit variable does not contain proper
> > information. One such case is when !CONFIG_HIGHMEM kernel runs on
> > system with memory large enough not to fit into lowmem.
>
> Why doesn't the !CONFIG_HIGHMEM code update memory_limit to reflect
> reality.

I guess because memory_limit is used for ... well, memory limit, set by 
mem=. And for the rest memblock is used (and it *is* updated).

And code elsewhere does use memblock, see e.g. numa_enforce_memory_limit() 
in arch/powerpc/mm/numa.c

In MMU init (MMU_init() in arch/powerpc/mm/init_32.c -which is the point 
where final memory configuration is set) memblock, not memory_limit, is 
both used and updated.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
