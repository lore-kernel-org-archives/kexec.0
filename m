Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x236.google.com ([2607:f8b0:400e:c03::236])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1beHq7-0006J8-NM
 for kexec@lists.infradead.org; Mon, 29 Aug 2016 08:22:44 +0000
Received: by mail-pa0-x236.google.com with SMTP id fi15so47383032pac.1
 for <kexec@lists.infradead.org>; Mon, 29 Aug 2016 01:22:22 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 0/2] arm64: support --mem-min and --mem-max parameters
Date: Mon, 29 Aug 2016 17:28:39 +0900
Message-Id: <20160829082841.3750-1-takahiro.akashi@linaro.org>
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
To: horms@verge.net.au, geoff@infradead.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org

Geoff's current patches of kexec support for arm64 [1] ignores command
line paramters, --mem-min and --mem-max and always load the kernel at
the address above "TEXT_OFFSET" bytes in the first memory regions.

My patches add the support of both parameters and, moreover, make
the differences between elf_arm64_load() and image_arm64_load() quite
small for better understandings.

Please think about merging my fixup patches.
	-> Geoff

[1] http://lists.infradead.org/pipermail/kexec/2016-August/016942.html

AKASHI Takahiro (2):
  fixup! arm64: Add arm64 kexec support
  fixup! arm64: Add support for binary image files

 kexec/arch/arm64/kexec-arm64.c       | 22 ++++++++--
 kexec/arch/arm64/kexec-arm64.h       |  1 +
 kexec/arch/arm64/kexec-elf-arm64.c   | 79 ++++++++++++++++++++----------------
 kexec/arch/arm64/kexec-image-arm64.c | 29 ++++++++++---
 4 files changed, 88 insertions(+), 43 deletions(-)

-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
