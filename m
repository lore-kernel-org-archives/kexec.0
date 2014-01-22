Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W5wCv-000380-90
 for kexec@lists.infradead.org; Wed, 22 Jan 2014 11:42:58 +0000
Date: Wed, 22 Jan 2014 11:42:15 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] ARM: Premit ioremap() to map reserved pages
Message-ID: <20140122114215.GZ15937@n2100.arm.linux.org.uk>
References: <1390389916-8711-1-git-send-email-wangnan0@huawei.com>
 <1390389916-8711-2-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1390389916-8711-2-git-send-email-wangnan0@huawei.com>
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
To: Wang Nan <wangnan0@huawei.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mm@kvack.org, Eric Biederman <ebiederm@xmission.com>, Geng Hui <hui.geng@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org

On Wed, Jan 22, 2014 at 07:25:14PM +0800, Wang Nan wrote:
> This patch relaxes the restriction set by commit 309caa9cc, which
> prohibit ioremap() on all kernel managed pages.
> 
> Other architectures, such as x86 and (some specific platforms of) powerpc,
> allow such mapping.
> 
> ioremap() pages is an efficient way to avoid arm's mysterious cache control.
> This feature will be used for arm kexec support to ensure copied data goes into
> RAM even without cache flushing, because we found that flush_cache_xxx can't
> reliably flush code to memory.

Yes, let's bypass the check and allow this in violation of the
architecture specification by allowing mapping the same memory with
different types, which leads to unpredictable behaviour.  Yes, that's
a very good idea, because what we want to do is far more important than
following the requirements of the architecture.

So... NAK.

Yes, flush_cache_xxx() doesn't flush back to physical RAM, that's not
what it's defined to do - it's defined that it flushes enough of the
cache to ensure that page table updates are safe (such as when tearing
down a page mapping.)  So it's hardly surprising that doesn't work.

If you want to be able to have DMA access to memory, then you need to
use an API which has been designed for that purpose, and if there isn't
one, then you need to discuss your requirements, rather than trying to
hack around the problem.

The issue here will be that the APIs we currently have for DMA become
extremely expensive when you want to deal with (eg) all system RAM.
Or, there's flush_cache_all() which should flush all levels of cache
in the system, and thus push all data back to RAM.

Now, why are you copying your patches to the stable people?  That makes
no sense - they haven't been reviewed and they haven't been integrated
into an existing kernel.  So, they don't meet the basic requirements
for stable tree submission...

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
