Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZ1wH-00027n-0e
 for kexec@lists.infradead.org; Thu, 15 Nov 2012 16:05:14 +0000
Date: Thu, 15 Nov 2012 11:04:56 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 1/7] Initialize and setup eppic
Message-ID: <20121115160456.GG2529@redhat.com>
References: <20121108133554.28410.99763.stgit@aravinda>
 <20121108133804.28410.99166.stgit@aravinda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121108133804.28410.99166.stgit@aravinda>
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
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, buendgen@de.ibm.com

On Thu, Nov 08, 2012 at 07:08:04PM +0530, Aravinda Prasad wrote:

[..]
> diff --git a/Makefile b/Makefile
> index d5fc09e..3ac8e63 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -55,6 +55,13 @@ LIBS := -llzo2 $(LIBS)
>  CFLAGS += -DUSELZO
>  endif
>  
> +ifeq ($(EPPIC), on)
> +LIBS := -leppic -ltinfo $(LIBS)

So you also pull in libarary "tinfo". Does that 1MB number include this
too? What's the total size bloat for makedumpfile once we compile with
EPPIC on.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
