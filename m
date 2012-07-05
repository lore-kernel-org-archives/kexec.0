Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Smrbo-0001Ls-0V
 for kexec@lists.infradead.org; Thu, 05 Jul 2012 19:21:03 +0000
Date: Thu, 05 Jul 2012 15:20:50 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Subject: Re: [PATCH 0/5] crash: Small bundle of fixes for Xen
Message-ID: <a6431ecc-fcff-4831-8196-c85d5b60ecda@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <cd5c6d38-c888-4272-b1ba-13c82acb6a12@zmail15.collab.prod.int.phx2.redhat.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, andrew cooper3 <andrew.cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, crash-utility@redhat.com



----- Original Message -----
> 
> 
> ----- Original Message -----
> > On Thu, Jul 05, 2012 at 05:29:50PM +0200, Daniel Kiper wrote:
> > > On Thu, Jul 05, 2012 at 11:15:29AM -0400, Dave Anderson wrote:
> > > >
> > > >
> > > > ----- Original Message -----
> > > > > Hi,
> > > > >
> > > > > It looks that Xen support for crash have not been maintained
> > > > > since 2009. I am trying to fix this. Here it is small
> > > > > bundle of fixes:
> > > > >   - xen: Always calculate max_cpus value,
> > > > >   - xen: Read only crash notes for onlined CPUs,
> > > > >   - x86/xen: Read variables from dynamically allocated
> > > > >   per_cpu
> > > > >   data,
> > > > >   - xen: Get idle data from alternative source,
> > > > >   - xen: Read data correctly from dynamically allocated
> > > > >   console
> > > > >   ring
> > > > >   too.
> > > > >
> > > > > Daniel
> > > >
> > > > Daniel,
> > > >
> > > > Can you absolutely confirm that these changes are all
> > > > backwards-compatible?
> > > 
> > > I have not done tests with older versions of Xen. However,
> > > I made all patches with backward compatibility in mind. Anyway,
> > > If you wish I could do tests with let's say Xen Ver. 3.4
> > > and Xen Linux Kernel Ver. 2.6.18 at least.
> > 
> > I think Dave is worried about it breaking with the version that is bundled
> > with RHEL5U8?
> 
> Correct...
> 
> Dave
>  

And as it turns out, it does break RHEL5 xen, at least the changes
you made for the log command:

  crash> log
  log: invalid kernel virtual address: 616e69625f64616f  type: "conring contents"
  crash>

Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
