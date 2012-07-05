Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcsinet15.oracle.com ([148.87.113.117])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Smo1B-0000bK-IG
 for kexec@lists.infradead.org; Thu, 05 Jul 2012 15:30:58 +0000
Date: Thu, 5 Jul 2012 17:29:50 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 0/5] crash: Small bundle of fixes for Xen
Message-ID: <20120705152950.GH2007@host-192-168-1-59.local.net-space.pl>
References: <20120705145839.GB2007@host-192-168-1-59.local.net-space.pl>
 <1a4623fc-cef2-42b5-894c-98607a623c86@zmail15.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1a4623fc-cef2-42b5-894c-98607a623c86@zmail15.collab.prod.int.phx2.redhat.com>
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
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, konrad wilk <konrad.wilk@oracle.com>, andrew cooper3 <andrew.cooper3@citrix.com>, kexec@lists.infradead.org, crash-utility@redhat.com

On Thu, Jul 05, 2012 at 11:15:29AM -0400, Dave Anderson wrote:
>
>
> ----- Original Message -----
> > Hi,
> >
> > It looks that Xen support for crash have not been maintained
> > since 2009. I am trying to fix this. Here it is small
> > bundle of fixes:
> >   - xen: Always calculate max_cpus value,
> >   - xen: Read only crash notes for onlined CPUs,
> >   - x86/xen: Read variables from dynamically allocated per_cpu data,
> >   - xen: Get idle data from alternative source,
> >   - xen: Read data correctly from dynamically allocated console ring
> >   too.
> >
> > Daniel
>
> Daniel,
>
> Can you absolutely confirm that these changes are all backwards-compatible?

I have not done tests with older versions of Xen. However,
I made all patches with backward compatibility in mind. Anyway,
If you wish I could do tests with let's say Xen Ver. 3.4
and Xen Linux Kernel Ver. 2.6.18 at least.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
