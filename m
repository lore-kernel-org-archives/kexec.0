Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGWEt-0006Jz-6C
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 15:08:12 +0000
Date: Fri, 15 Mar 2013 16:07:54 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 0/2] crash: Bundle of fixes for Xen
Message-ID: <20130315150754.GA12758@debian70-amd64.local.net-space.pl>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: anderson@redhat.com, crash-utility@redhat.com, kexec@lists.infradead.org, xen-devel@lists.xensource.com

Hi,

Here is next bundle of fixes for crash Xen support:
  - xen: Improve calculation of beginning of virtual address space,
  - xen: Fix console buffer content length calculation.

All patches were tested with Xen versions up to latest unstable.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
