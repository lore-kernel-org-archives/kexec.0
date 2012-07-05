Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcsinet15.oracle.com ([148.87.113.117])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SmnX1-0003QS-1V
 for kexec@lists.infradead.org; Thu, 05 Jul 2012 14:59:48 +0000
Date: Thu, 5 Jul 2012 16:58:39 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 0/5] crash: Small bundle of fixes for Xen
Message-ID: <20120705145839.GB2007@host-192-168-1-59.local.net-space.pl>
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
To: anderson@redhat.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, olaf@aepfle.de, crash-utility@redhat.com, kexec@lists.infradead.org, xen-devel@lists.xensource.com

Hi,

It looks that Xen support for crash have not been maintained
since 2009. I am trying to fix this. Here it is small
bundle of fixes:
  - xen: Always calculate max_cpus value,
  - xen: Read only crash notes for onlined CPUs,
  - x86/xen: Read variables from dynamically allocated per_cpu data,
  - xen: Get idle data from alternative source,
  - xen: Read data correctly from dynamically allocated console ring too.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
