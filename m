Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cIs9J-0004J7-V6
 for kexec@lists.infradead.org; Mon, 19 Dec 2016 07:14:21 +0000
Received: by mail-qk0-f173.google.com with SMTP id n204so5505934qke.2
 for <kexec@lists.infradead.org>; Sun, 18 Dec 2016 23:13:56 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH V2 0/2] kexec-tools: arm64: Enable D-cache in purgatory
Date: Mon, 19 Dec 2016 12:43:45 +0530
Message-Id: <cover.1482129830.git.panand@redhat.com>
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
To: kexec@lists.infradead.org, geoff@infradead.org, james.morse@arm.com
Cc: mark.rutland@arm.com, Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
is around 13MB and initramfs is around 30MB. It takes more than 20 second
even when we have -O2 optimization enabled. However, if dcache is enabled
during purgatory execution then, it takes just a second in SHA
verification.

Therefore, these patches adds support for dcache enabling facility during
purgatory execution.

Although I have simplified the logic a bit now, however I understand that
there are reservations for introducing this complexity for gaining few
seconding of execution time during kexec or crash reboot.  But, I believe
if d-cache enabling code is stable enough then there should not be any
hindrances to accept it. So, please give it a try with your platform and
let me know if you see any issue or it does not work. I am still open to
improve it further if needed.

Changes since V1:
	- Moved page table creation logic from purgatory to kexec code.
	- Only 4K page table is supported, with 48 bit VA and 2M block size
	- if platform supports a 4K page size, then D-cache is always
	  enabled now.
 
Pratyush Anand (2):
  kexec: arm64: create identity page table to be used in purgatory
  arm64: enable d-cache support during purgatory sha verification

 kexec/arch/arm64/kexec-arm64.c         | 152 ++++++++++++++++++
 purgatory/arch/arm64/Makefile          |   1 +
 purgatory/arch/arm64/cache.S           | 281 +++++++++++++++++++++++++++++++++
 purgatory/arch/arm64/purgatory-arm64.c |   5 +
 4 files changed, 439 insertions(+)
 create mode 100644 purgatory/arch/arm64/cache.S

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
