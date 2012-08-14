Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcsinet15.oracle.com ([148.87.113.117])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T1AQ0-0003eg-QZ
 for kexec@lists.infradead.org; Tue, 14 Aug 2012 06:15:57 +0000
Date: Tue, 14 Aug 2012 08:14:08 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 0/6] crash: Bundle of fixes for Xen
Message-ID: <20120814061408.GA2471@host-192-168-1-59.local.net-space.pl>
References: <20120813073754.GA2482@host-192-168-1-59.local.net-space.pl>
 <1827880283.12350529.1344885413402.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1827880283.12350529.1344885413402.JavaMail.root@redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, konrad wilk <konrad.wilk@oracle.com>, andrew cooper3 <andrew.cooper3@citrix.com>, ptesarik@suse.cz, jbeulich@suse.com, kexec@lists.infradead.org, crash-utility@redhat.com

On Mon, Aug 13, 2012 at 03:16:53PM -0400, Dave Anderson wrote:

[...]

> OK good.  It tests OK on a few older pvops kernels that I have on hand.
>
> The only thing I've changed is to handle compiler warnings in x86_64.c and
> x86.c by initializing p2m_top to NULL in x86_64_pvops_xendump_p2m_l3_create()
> and x86_pvops_xendump_p2m_l3_create().  I also used GETBUF() in those two
> functions to avoid having to add the malloc-failure line.

No problem. However, I am a bit surprised that you have seen some warnings.
I have not seen any. Did you compiled crash with extra options or something
like that? Or maybe there is a diffrence in our compilers (mine
is gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21) - quite ancient).

> Queued for crash-6.0.9.

Thanks.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
