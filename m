Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGYDo-0002RU-Ka
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 17:15:13 +0000
Date: Fri, 15 Mar 2013 18:15:04 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [PATCH 1/2] xen: Improve calculation of beginning of
 virtual address space
Message-ID: <20130315171504.GG12758@debian70-amd64.local.net-space.pl>
References: <20130315150921.GB12758@debian70-amd64.local.net-space.pl>
 <20130315165636.GA16644@phenom.dumpdata.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130315165636.GA16644@phenom.dumpdata.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: kexec@lists.infradead.org, xen-devel@lists.xensource.com, anderson@redhat.com, crash-utility@redhat.com

On Fri, Mar 15, 2013 at 12:56:36PM -0400, Konrad Rzeszutek Wilk wrote:
> On Fri, Mar 15, 2013 at 04:09:21PM +0100, Daniel Kiper wrote:
> > Xen changeset 26447 (x86: re-introduce map_domain_page() et al) once again
> > altered virtual address space. Current algorithm calculating its start could
> > not cope with that change. New version establishes this value on the base of
> > image start address and is more generic.
>
> And it works with the older (3.4) hypervisors binary image?

It works without any issue.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
