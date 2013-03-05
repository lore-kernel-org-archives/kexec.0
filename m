Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCh4P-00076R-9N
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 01:53:33 +0000
Date: Tue, 5 Mar 2013 10:53:30 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec x86: drop truncation warning for crash kernel
Message-ID: <20130305015330.GC28547@verge.net.au>
References: <E1UA2LP-0007z2-2z@eag09.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1UA2LP-0007z2-2z@eag09.americas.sgi.com>
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
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org

On Mon, Feb 25, 2013 at 12:00:07PM -0600, Cliff Wickman wrote:
> From: Cliff Wickman <cpw@sgi.com>
> 
> On kexec set-up of a crash kernel on a very large memory machine we
> sometimes see the worrisome warning:
>   Too many memory ranges, truncating...
> meaning that the total count of e820 ram, reserved and ACPI spaces is over 128.
> 
> Per the comment in do_bzImage_load():
>                 /* If using bzImage for capture kernel, then we will not be
>                  * executing real mode code. setup segment can be loaded
>                  * anywhere as we will be just reading command line.
>                  */
> So if I understand, the e820 table built here and added to the 'real_mode'
> area is not going to be used.
> So the warning message can be omitted.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
