Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RYI28-00013B-Jx
 for kexec@lists.infradead.org; Wed, 07 Dec 2011 13:59:42 +0000
Date: Wed, 07 Dec 2011 08:59:35 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Subject: Re: [Crash-utility] [RFC] makedumpfile, crash: LZO compression support
Message-ID: <0d1c78c5-fb53-4747-9038-6f3700c064f6@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20111207.100342.59655738.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
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
To: "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org



----- Original Message -----
> Hello Kumagai-san,
> 
> Thanks for the evaluation.
> 
> So I'll re-post the patch soon removing RFC prefix in header. But
> there is a remaining fix for checking command-line parameters relevant
> to addition of the 'l' option.
> 
> How about the patch adding compression/IO time report?
> I intended it only for the presentation of this RFC.
> 
> I'll post the corresponding patch in crash's side after crash 6.0.2 is
> released, waiting for new configuration editing feature as Dave has
> explained.

FYI, it's already in 6.0.1:

       - Allow the user to append data to the CFLAGS and LDFLAGS variables in 
         the top-level Makefile.  The extra data should be put in files named
         "CFLAGS.extra" and "LDFLAGS.extra" in the top-level directory; if
         either or both files exist, the extra data within them will be 
         appended to the relevant variable.  Typically the LDFLAGS.extra file
         will contain "-l<library>" strings, and the CFLAGS.extra file will
         contain "-D<value>" strings.  This will allow the crash utility to
         be built with optional libraries, and the code that references them
         to be encapsulated with associated "#ifdef <value>" sections.  The
         extra CFLAGS data will also be passed to extension modules that are 
         built within the local "crash-<version>/extensions" subdirectory.
         (anderson@redhat.com)

> Thanks.
> HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
