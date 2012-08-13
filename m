Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from acsinet15.oracle.com ([141.146.126.227])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T0pFP-0000Rn-I8
 for kexec@lists.infradead.org; Mon, 13 Aug 2012 07:39:36 +0000
Date: Mon, 13 Aug 2012 09:37:54 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 0/6] crash: Bundle of fixes for Xen
Message-ID: <20120813073754.GA2482@host-192-168-1-59.local.net-space.pl>
References: <20120810132357.GA2576@host-192-168-1-59.local.net-space.pl>
 <1568927206.9177777.1344625917898.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1568927206.9177777.1344625917898.JavaMail.root@redhat.com>
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

On Fri, Aug 10, 2012 at 03:11:57PM -0400, Dave Anderson wrote:
>
>
> ----- Original Message -----
> > Hi,
> >
> > It looks that Xen support for crash have not been maintained
> > since 2009. I am trying to fix this. Here it is bundle of fixes:
> >   - xen: Always calculate max_cpus value,
> >   - xen: Read only crash notes for onlined CPUs,
> >   - x86/xen: Read variables from dynamically allocated per_cpu data,
> >   - xen: Get idle data from alternative source,
> >   - xen: Read data correctly from dynamically allocated console ring, too
> >     (fixed in this release),
> >   - xen: Add support for 3 level P2M tree (new patch in this release).
> >
> > Daniel
>
> Hi Daniel,
>
> The original 5 updates specific to the Xen hypervisor look OK,
> but new patch 6/6 is going to take some studying/testing to
> alleviate my backwards-compatibility worries.  Can I ask whether
> you fully tested it with older 2-level P2M tree kernels?

As you asked me earlier I have tested all patches on Xen 3.1 and 4.1,
Linux Kernel Ver. 2.6.18 (P2M array), 2.6.36 (2 level P2M tree)
and 2.6.39 (3 level P2M tree). Additionaly, there were some internal
tests done by others in my company.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
