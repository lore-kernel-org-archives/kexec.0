Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fATg4-0007eh-BW
 for kexec@lists.infradead.org; Mon, 23 Apr 2018 05:06:14 +0000
Received: by mail-pf0-f193.google.com with SMTP id f15so8253171pfn.0
 for <kexec@lists.infradead.org>; Sun, 22 Apr 2018 22:06:02 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 0/2] Remove obsolete kdump tool and add missing uninstall rule
Date: Mon, 23 Apr 2018 10:30:20 +0530
Message-Id: <1524459622-2059-1-git-send-email-bhsharma@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: rmk@armlinux.org.uk, Russell King <rmk@arm.linux.org.uk>, Bhupesh Sharma <bhsharma@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, horms@verge.net.au, ebiederm@xmission.com, bhupesh.linux@gmail.com, dyoung@redhat.com, vgoyal@redhat.com

This patchset contains two patches:

[1/2] - Adds a missing uninstall rule to 'Makefile.in' to allow easier
	uninstallation of executables and man pages installed via
	'make install'
[2/2] - Removes obsolete kdump tool as per the discussion on kexec
	mailing list (see [1] for details), where a conclusion was
	reached that with the availability of tools like crash/gdb the
	analysis of the crashdump core has become rather easy, and it
	makes the kdump tool obsolete.

	Also the same naming convention (man page) causes confusion
	when compared to similarly named distribution specific kdump
	service/utilities, so its better to remove the same from
	kexec-tools.

I tested the patchset on my apm mustang and qualcomm arm64 boards and
the changes seem to work fine.

[1] http://lists.infradead.org/pipermail/kexec/2018-April/020483.html

Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>

Bhupesh Sharma (2):
  Makefile.in: Add uninstall rule
  Remove obsolete kdump tool

 Makefile.in         |  92 +++++++++++++--
 kdump/Makefile      |  30 -----
 kdump/kdump.8       |  39 -------
 kdump/kdump.c       | 327 ----------------------------------------------------
 kexec-tools.spec.in |   2 -
 5 files changed, 83 insertions(+), 407 deletions(-)
 delete mode 100644 kdump/Makefile
 delete mode 100644 kdump/kdump.8
 delete mode 100644 kdump/kdump.c

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
