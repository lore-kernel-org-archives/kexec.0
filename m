Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from acsinet15.oracle.com ([141.146.126.227])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SzpDY-0004aK-6J
 for kexec@lists.infradead.org; Fri, 10 Aug 2012 13:25:32 +0000
Date: Fri, 10 Aug 2012 15:23:57 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v2 0/6] crash: Bundle of fixes for Xen
Message-ID: <20120810132357.GA2576@host-192-168-1-59.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
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
To: anderson@redhat.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, olaf@aepfle.de, jbeulich@suse.com, ptesarik@suse.cz, crash-utility@redhat.com, kexec@lists.infradead.org, xen-devel@lists.xensource.com

Hi,

It looks that Xen support for crash have not been maintained
since 2009. I am trying to fix this. Here it is bundle of fixes:
  - xen: Always calculate max_cpus value,
  - xen: Read only crash notes for onlined CPUs,
  - x86/xen: Read variables from dynamically allocated per_cpu data,
  - xen: Get idle data from alternative source,
  - xen: Read data correctly from dynamically allocated console ring, too
    (fixed in this release),
  - xen: Add support for 3 level P2M tree
    (new patch in this release).

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
