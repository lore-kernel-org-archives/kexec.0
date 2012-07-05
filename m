Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SmoA2-0001HM-5K
 for kexec@lists.infradead.org; Thu, 05 Jul 2012 15:40:38 +0000
Date: Thu, 05 Jul 2012 11:39:52 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Subject: Re: [PATCH 0/5] crash: Small bundle of fixes for Xen
Message-ID: <3afe7c6f-2802-4f4c-9376-62ad634e0c67@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20120705152950.GH2007@host-192-168-1-59.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, konrad wilk <konrad.wilk@oracle.com>, andrew cooper3 <andrew.cooper3@citrix.com>, kexec@lists.infradead.org, crash-utility@redhat.com



----- Original Message -----
> On Thu, Jul 05, 2012 at 11:15:29AM -0400, Dave Anderson wrote:
> >
> >
> > ----- Original Message -----
> > > Hi,
> > >
> > > It looks that Xen support for crash have not been maintained
> > > since 2009. I am trying to fix this. Here it is small
> > > bundle of fixes:
> > >   - xen: Always calculate max_cpus value,
> > >   - xen: Read only crash notes for onlined CPUs,
> > >   - x86/xen: Read variables from dynamically allocated per_cpu
> > >   data,
> > >   - xen: Get idle data from alternative source,
> > >   - xen: Read data correctly from dynamically allocated console
> > >   ring
> > >   too.
> > >
> > > Daniel
> >
> > Daniel,
> >
> > Can you absolutely confirm that these changes are all
> > backwards-compatible?
> 
> I have not done tests with older versions of Xen. However,
> I made all patches with backward compatibility in mind. Anyway,
> If you wish I could do tests with let's say Xen Ver. 3.4
> and Xen Linux Kernel Ver. 2.6.18 at least.
> 
> Daniel

That would be helpful -- I have very few Xen hypervisor sample dumpfiles,
and if I'm not mistaken, RHEL5 only went as far as Xen 3.1-something?

Dave

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
