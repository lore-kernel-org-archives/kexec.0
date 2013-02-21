Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8aOy-00074E-M6
 for kexec@lists.infradead.org; Thu, 21 Feb 2013 17:57:50 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 0/4] kexec-tools: add support for Xen 4.3
Date: Thu, 21 Feb 2013 17:57:36 +0000
Message-ID: <1361469460-18771-1-git-send-email-david.vrabel@citrix.com>
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
To: xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>

The series adds support for the new hypercall ABI which should be
provided by Xen 4.3.  Images are loaded into Xen directly with no
kernel involvement.

Do not apply until the hypervisor side patches are applied to Xen.

Patch 1 is unrelated but kexec wouldn't work for me without it. Not
sure why I had problems, perhaps a toolstack specific issue?

Patch 2 makes libxc 4.3 mandatory for Xen support.

Patch 3 removes a use of /proc/iomem in favour of libxc.

Patch 4 adds the support for loading an image into Xen.

This series explicitly drops support for older version of libxc/Xen as
supporting kexec on these hypervisors requires kernel support that
will never be available upstream.

David


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
