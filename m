Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Szuct-00068V-Rc
 for kexec@lists.infradead.org; Fri, 10 Aug 2012 19:12:05 +0000
Date: Fri, 10 Aug 2012 15:11:57 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1568927206.9177777.1344625917898.JavaMail.root@redhat.com>
In-Reply-To: <20120810132357.GA2576@host-192-168-1-59.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, konrad wilk <konrad.wilk@oracle.com>, andrew cooper3 <andrew.cooper3@citrix.com>, ptesarik@suse.cz, jbeulich@suse.com, kexec@lists.infradead.org, crash-utility@redhat.com



----- Original Message -----
> Hi,
> 
> It looks that Xen support for crash have not been maintained
> since 2009. I am trying to fix this. Here it is bundle of fixes:
>   - xen: Always calculate max_cpus value,
>   - xen: Read only crash notes for onlined CPUs,
>   - x86/xen: Read variables from dynamically allocated per_cpu data,
>   - xen: Get idle data from alternative source,
>   - xen: Read data correctly from dynamically allocated console ring, too
>     (fixed in this release),
>   - xen: Add support for 3 level P2M tree (new patch in this release).
> 
> Daniel
> 

Hi Daniel,

The original 5 updates specific to the Xen hypervisor look OK,
but new patch 6/6 is going to take some studying/testing to
alleviate my backwards-compatibility worries.  Can I ask whether
you fully tested it with older 2-level P2M tree kernels? 

Thanks,
  Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
