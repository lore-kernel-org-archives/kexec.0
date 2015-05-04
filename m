Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YpG1v-0005V6-Cz
 for kexec@lists.infradead.org; Mon, 04 May 2015 13:03:27 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH RFC 0/3] arm64: disable/enable d-cache support for
Date: Mon,  4 May 2015 18:32:48 +0530
Message-Id: <cover.1430742915.git.panand@redhat.com>
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
To: geoff@infradead.org
Cc: Pratyush Anand <panand@redhat.com>, takahiro.akashi@linaro.org, kexec@lists.infradead.org

These patches add support for enable/disable d cache support. It reduces
time for sha verification from more than 2 min to 3-4 sec on my
platform. 
There are some of the observation which I am unable to explain.
* It takes around 18 sec when I boot a kexec kernel and around 3-4 sec
* when I boot a crash kernel. In case of kexec kernel start of 1st
* segment is at 0000004000280000 and, end of last segment is at
* 00000040029c0000. In case of crash kernel start of 1st segment is at
* 00000041b9080000 and, end of last segment is at 00000041f9000000.

Pratyush Anand (3):
  arm64: Add enable/disable d-cache support for purgatory
  arm64: Pass RAM boundary to purgatory
  arm64: Enable/disable D-cache before/after sha verification

 kexec/arch/arm64/include/types.h       |  16 +++
 kexec/arch/arm64/kexec-arm64.c         |  16 ++-
 purgatory/arch/arm64/Makefile          |   1 +
 purgatory/arch/arm64/cache.S           | 222 +++++++++++++++++++++++++++++++++
 purgatory/arch/arm64/cache.h           |  42 +++++++
 purgatory/arch/arm64/entry.S           |  10 ++
 purgatory/arch/arm64/purgatory-arm64.c |  12 ++
 7 files changed, 318 insertions(+), 1 deletion(-)
 create mode 100644 kexec/arch/arm64/include/types.h
 create mode 100644 purgatory/arch/arm64/cache.S
 create mode 100644 purgatory/arch/arm64/cache.h

-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
