Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1evFJ9-0001Fh-1y
 for kexec@lists.infradead.org; Mon, 12 Mar 2018 04:43:39 +0000
Received: by mail-pl0-x243.google.com with SMTP id v9-v6so8686226plp.12
 for <kexec@lists.infradead.org>; Sun, 11 Mar 2018 21:43:21 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCHv4 0/3] enable nr_cpus for powerpc
Date: Mon, 12 Mar 2018 12:43:07 +0800
Message-Id: <1520829790-14029-1-git-send-email-kernelfans@gmail.com>
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
To: linuxppc-dev@lists.ozlabs.org
Cc: cascardo@canonical.com, gpiccoli@linux.vnet.ibm.com, kexec@lists.infradead.org, paulus@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org

This topic has a very long history. It comes from Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
For v3: https://patchwork.ozlabs.org/patch/834860/
In this series, I separate and change the mapping between cpu logical id and hwid.
I hope we can acquire it for "kexec -p"

Mahesh Salgaonkar (1):
  ppc64 boot: Wait for boot cpu to show up if nr_cpus limit is about to
    hit.

Pingfan Liu (2):
  powerpc, cpu: partially unbind the mapping between cpu logical id and 
       its seq in dt
  powerpc, cpu: handling the special case when boot_cpuid greater than
    nr_cpus

 arch/powerpc/include/asm/paca.h    |  3 +++
 arch/powerpc/include/asm/smp.h     |  1 +
 arch/powerpc/kernel/paca.c         | 19 ++++++++++++++-----
 arch/powerpc/kernel/prom.c         | 25 ++++++++++++++-----------
 arch/powerpc/kernel/setup-common.c | 35 +++++++++++++++++++++++++++++++++--
 5 files changed, 65 insertions(+), 18 deletions(-)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
