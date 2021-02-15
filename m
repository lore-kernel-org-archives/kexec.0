Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBj5U-0006Rq-N2
 for kexec@lists.infradead.org; Mon, 15 Feb 2021 18:59:14 +0000
Received: by mail-qt1-x82b.google.com with SMTP id e11so5512338qtg.6
 for <kexec@lists.infradead.org>; Mon, 15 Feb 2021 10:59:11 -0800 (PST)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH 0/1] fix machine_kexec_post_load prototype.
Date: Mon, 15 Feb 2021 13:59:07 -0500
Message-Id: <20210215185908.257724-1-pasha.tatashin@soleen.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: pasha.tatashin@soleen.com, linux-arm-kernel@lists.infradead.org, jmorris@namei.org, linux-kernel@vger.kernel.org, tyhicks@linux.microsoft.com, will@kernel.org, james.morse@arm.com, ebiederm@xmission.com, kexec@lists.infradead.org

This is against for-next/kexec, fix for machine_kexec_post_load
warning.

Reported by kernel test robot [1].

[1] https://lore.kernel.org/linux-arm-kernel/202102030727.gqTokACH-lkp@intel.com

Pavel Tatashin (1):
  kexec: move machine_kexec_post_load() to public interface

 include/linux/kexec.h   | 2 ++
 kernel/kexec_internal.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
