Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RTMuD-0000Wc-DN
 for kexec@lists.infradead.org; Thu, 24 Nov 2011 00:11:14 +0000
Date: Thu, 24 Nov 2011 09:10:58 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kdump: crashk_res init check for
 /sys/kernel/kexec_crash_size
Message-ID: <20111124001058.GB10562@verge.net.au>
References: <1322043068.10119.7.camel@br98xy6r>
 <20111123102214.GA4914@verge.net.au>
 <1322054283.10119.11.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1322054283.10119.11.camel@br98xy6r>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Wed, Nov 23, 2011 at 02:18:03PM +0100, Michael Holzheu wrote:
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> Currently it is possible to set the crash_size via the sysfs
> /sys/kernel/kexec_crash_size even if no crash kernel memory has
> been defined with the "crashkernel" parameter. In this case
> "crashk_res" is not initialized and crashk_res.start = crashk_res.end = 0.
> Unfortunately resource_size(&crashk_res) returns 1 in this case.
> This breaks the s390 implementation of crash_(un)map_reserved_pages().
> 
> To fix the problem the correct "old_size" is now calculated in
> crash_shrink_memory(). "old_size is set to "0" if crashk_res is
> not initialized. With this change crash_shrink_memory() will do nothing,
> when "crashk_res" is not initialized. It will return "0" for
> "echo 0 > /sys/kernel/kexec_crash_size" and -EINVAL for
> "echo [not zero] > /sys/kernel/kexec_crash_size".
> 
> In addition to that this patch also simplifies the "ret = -EINVAL"
> vs. "ret = 0" logic as suggested by Simon Horman.
> 
> Cc: Simon Horman <horms@verge.net.au>
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Thanks Michael,

Reviewed-by: Simon Horman <horms@verge.net.au>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
