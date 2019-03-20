Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h6TUB-00054w-2G
 for kexec@lists.infradead.org; Wed, 20 Mar 2019 05:10:00 +0000
Received: by mail-pg1-f194.google.com with SMTP id b12so884816pgk.0
 for <kexec@lists.infradead.org>; Tue, 19 Mar 2019 22:09:54 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v3 3/3] Documentation/vmcoreinfo: Add documentation for
 'MAX_PHYSMEM_BITS'
Date: Wed, 20 Mar 2019 10:39:34 +0530
Message-Id: <1553058574-18606-4-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
References: <1553058574-18606-1-git-send-email-bhsharma@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Michael Ellerman <mpe@ellerman.id.au>, bhsharma@redhat.com, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com, Dave Anderson <anderson@redhat.com>, Ingo Molnar <mingo@kernel.org>, Paul Mackerras <paulus@samba.org>

Add documentation for 'MAX_PHYSMEM_BITS' variable being added to
vmcoreinfo.

'MAX_PHYSMEM_BITS' defines the maximum supported physical address
space memory.

Cc: Boris Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 Documentation/kdump/vmcoreinfo.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/kdump/vmcoreinfo.txt b/Documentation/kdump/vmcoreinfo.txt
index bb94a4bd597a..f5a11388dc49 100644
--- a/Documentation/kdump/vmcoreinfo.txt
+++ b/Documentation/kdump/vmcoreinfo.txt
@@ -95,6 +95,11 @@ It exists in the sparse memory mapping model, and it is also somewhat
 similar to the mem_map variable, both of them are used to translate an
 address.
 
+MAX_PHYSMEM_BITS
+----------------
+
+Defines the maximum supported physical address space memory.
+
 page
 ----
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
