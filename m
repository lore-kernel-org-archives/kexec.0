Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZoRpV-0005AK-35
 for kexec@lists.infradead.org; Tue, 20 Oct 2015 07:59:34 +0000
Received: by pacfv9 with SMTP id fv9so14397628pac.3
 for <kexec@lists.infradead.org>; Tue, 20 Oct 2015 00:59:11 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 0/2] arm64: kexec/kdump fixes for v10
Date: Tue, 20 Oct 2015 16:58:25 +0900
Message-Id: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, geoff@infradead.org, marc.zyngier@arm.com
Cc: mark.rutland@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, broonie@kernel.org, david.griego@linaro.org, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org

These patches should be applied on top of Geoff's kexec/kdump patch[1],
v10, to fix some issues. I should have merged it before the submission
but I missed the timing. Sorry.

Please go ahead and review v10 since these patches don't change any
main logic of kexec/kdump. I will merge them in the next submission.

Patch 1 fixes a cpuidle issue reported by James[2].

Patch 2 allows kdump to start a crash kernel even with a kvm guest still
running. (I accidentally dropped this hack when rebasing my part.)

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/379268.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376460.html

AKASHI Takahiro (2):
  fixup! arm64: kdump: implement machine_crash_shutdown()
  fixup! arm64: kvm: allows kvm cpu hotplug

 arch/arm/kvm/arm.c                |   25 +++++++++++++++++++++----
 arch/arm64/kernel/machine_kexec.c |    2 +-
 2 files changed, 22 insertions(+), 5 deletions(-)

-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
