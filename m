Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T1Hj4-0001bS-MI
 for kexec@lists.infradead.org; Tue, 14 Aug 2012 14:04:08 +0000
Date: Tue, 14 Aug 2012 10:04:00 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1543188889.13757694.1344953040454.JavaMail.root@redhat.com>
In-Reply-To: <20120814061408.GA2471@host-192-168-1-59.local.net-space.pl>
Subject: Re: [PATCH v2 0/6] crash: Bundle of fixes for Xen
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
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, konrad wilk <konrad.wilk@oracle.com>, andrew cooper3 <andrew.cooper3@citrix.com>, ptesarik@suse.cz, jbeulich@suse.com, kexec@lists.infradead.org



----- Original Message -----
> On Mon, Aug 13, 2012 at 03:16:53PM -0400, Dave Anderson wrote:
> 
> [...]
> 
> > OK good.  It tests OK on a few older pvops kernels that I have on
> > hand.
> >
> > The only thing I've changed is to handle compiler warnings in x86_64.c and
> > x86.c by initializing p2m_top to NULL in x86_64_pvops_xendump_p2m_l3_create()
> > and x86_pvops_xendump_p2m_l3_create().  I also used GETBUF() in those two
> > functions to avoid having to add the malloc-failure line.
> 
> No problem. However, I am a bit surprised that you have seen some warnings.
> I have not seen any. Did you compiled crash with extra options or something
> like that? Or maybe there is a diffrence in our compilers (mine is gcc version
>  4.1.2 20061115 (prerelease) (Debian 4.1.1-21) - quite ancient).

Extra options (also with gcc 4.1.2) -- try building with "make warn".  It adds:

 WARNING_OPTIONS=-Wall -O2 -Wstrict-prototypes -Wmissing-prototypes -fstack-protector

or "make Warn", which adds -Werror to the above.

In those two functions there are "goto err" statements prior to allocating
p2m_top, and so the free(p2m_top) could receive a random stack value.  Of
course even if it did get by the free() call in that highly unlikely case,
the crash session is just about to fatally shut itself down.

Thanks,
  Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
