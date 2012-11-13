Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TYJ4L-00060f-FN
 for kexec@lists.infradead.org; Tue, 13 Nov 2012 16:10:40 +0000
Date: Tue, 13 Nov 2012 17:10:00 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 0/5] crash: Bundle of fixes for Xen
Message-ID: <20121113161000.GA2942@host-192-168-1-59.local.net-space.pl>
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

Here is next bundle of fixes for crash Xen support:
  - xen: Fix page tables caching issues,
  - xen: Use init_tss array or per_cpu__init_tss,
  - xen: Use per_cpu__crash_notes or crash_notes array,
  - xen: Try hard to get max_cpus value,
  - xen: Use cpu_present_map instead of cpu_online_map.

All patches were tested with Xen versions up to 4.2.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
