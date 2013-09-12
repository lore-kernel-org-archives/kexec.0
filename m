Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKD4h-0005Hx-3a
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 20:01:11 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCHv4 0/5] kexec-tools: add support for Xen 4.3
Date: Thu, 12 Sep 2013 21:00:37 +0100
Message-ID: <1379016042-22510-1-git-send-email-david.vrabel@citrix.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>

The series adds support for the new hypercall ABI which should be
provided by Xen 4.4.  Images are loaded into Xen directly with no
kernel involvement.

Please do not apply until the hypervisor side patches are applied to
Xen.

Patch 1 is unrelated but kexec wouldn't work for me without it. Not
sure why I had problems, perhaps a toolstack specific issue?

Patch 2 makes libxc 4.4 mandatory for Xen support.

Patch 3-4 removes a use of /proc/iomem in favour of libxc.

Patch 5 adds the support for loading, unloading, and exec'ing an image
in Xen.

This series explicitly drops support for older version of libxc/Xen as
supporting kexec on these hypervisors requires kernel support that
will never be available upstream.

Changes in v4:
- KEXEC_ARCH_DEFAULT => EM_386
- add segment in the crash case for the backup src.

Changes in v3 (not posted):
- Rebased

Changes in v2:
- Patch from Don Sultz: use libxc for vmcoreinfo.
- Use xc_get_max_cpus() to get number of PCPUs.
- Enable unload and exec of images.

David


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
