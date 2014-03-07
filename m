Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2402:b800:7003:1:1::1])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WLixN-0001yl-0s
 for kexec@lists.infradead.org; Fri, 07 Mar 2014 00:48:10 +0000
Message-ID: <1394153258.21206.1.camel@concordia>
Subject: Re: [PATCH] kexec/powerpc: fix exporting memory limit
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 07 Mar 2014 11:47:38 +1100
In-Reply-To: <1394115854-11709-1-git-send-email-nyushchenko@dev.rtsoft.ru>
References: <1394115854-11709-1-git-send-email-nyushchenko@dev.rtsoft.ru>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
Cc: yadviga@dev.rtsoft.ru, Benjamin Herrenschmidt <benh@kernel.crashing.org>, lugovskoy@dev.rtsoft.ru, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>, Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org

On Thu, 2014-03-06 at 18:24 +0400, Nikita Yushchenko wrote:
> When preparing dump-capturing kernel, kexec userspace tool needs to know
> actual amount of memory used by the running kernel. This may differ from
> extire available DRAM for a couple of reasons. To address this issue,
> kdump kernel support code injects several attributes into device tree that
> are later captured by userspace kexec tool via /proc interface.
> 
> One such attrubute is 'chosen/linux,memory_limit' that is used to pass
> memory limit of the running kernel.
> 
> This was initialized using kernel's 'memory_limit' variable, that is set
> by early init code based on mem= kernel parameter and other reasons.
> 
> But there are cases when memory_limit variable does not contain proper
> information. One such case is when !CONFIG_HIGHMEM kernel runs on system
> with memory large enough not to fit into lowmem.

Why doesn't the !CONFIG_HIGHMEM code update memory_limit to reflect reality.

cheers



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
