Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TfQwa-0002uO-6x
 for kexec@lists.infradead.org; Mon, 03 Dec 2012 08:00:01 +0000
Date: Mon, 3 Dec 2012 16:59:56 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: Fix compile errors in  crashdump-mips.c
Message-ID: <20121203075956.GA7239@verge.net.au>
References: <1354219369-10520-1-git-send-email-ddaney.cavm@gmail.com>
 <20121130000243.GC21935@verge.net.au> <50B7F9F6.1030806@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50B7F9F6.1030806@gmail.com>
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
To: David Daney <ddaney.cavm@gmail.com>
Cc: kexec@lists.infradead.org, ralf@linux-mips.org, David Daney <david.daney@cavium.com>

On Thu, Nov 29, 2012 at 04:12:38PM -0800, David Daney wrote:
> On 11/29/2012 04:02 PM, Simon Horman wrote:
> >On Thu, Nov 29, 2012 at 12:02:49PM -0800, David Daney wrote:
> >>From: David Daney <david.daney@cavium.com>
> >>
> >>When building configured as '--host=mips64-octeon-linux-gnu' using
> >>GCC-4.7.0 there are two compile errors, fix them.
> >>
> >>Signed-off-by: David Daney <david.daney@cavium.com>
> >
> >Thanks, is the first hunk also ok on 32bit?
> 
> Yes,  in crashdump.h kern_size is declared as type unsigned long, so
> the proper printf format is ABI independent and should be "%lx"

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
