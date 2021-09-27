Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Coiby Xu <coiby.xu@gmail.com>
Subject: [PATCH 0/2] use more system keyrings to verify kdump kernel image
 signature
Date: Mon, 27 Sep 2021 08:50:02 +0800
Message-Id: <20210927005004.36367-1-coiby.xu@gmail.com>
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
To: kexec@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org

This patch set allows arm64 to use more system keyrings to verify kdump 
kernel image signature by making the existing code in x64 public.


Coiby Xu (2):
  kexec, KEYS: make the code in bzImage64_verify_sig public
  arm64: kexec_file: use more system keyrings to verify kernel image
    signature

 arch/arm64/kernel/kexec_image.c   |  4 +---
 arch/x86/kernel/kexec-bzimage64.c | 13 +------------
 include/linux/kexec.h             |  3 +++
 kernel/kexec_file.c               | 15 +++++++++++++++
 4 files changed, 20 insertions(+), 15 deletions(-)

-- 
2.33.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
