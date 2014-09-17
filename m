Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.gmx.net ([212.227.17.22])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XUL1Q-0005fI-Nb
 for kexec@lists.infradead.org; Wed, 17 Sep 2014 19:36:13 +0000
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: kexec.h:61: userspace cannot reference function or variable defined
 in the kernel
Date: Wed, 17 Sep 2014 21:35:23 +0200
Message-Id: <1410982523-8227-1-git-send-email-xypron.glpk@gmx.de>
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
To: Eric Biederman <ebiederm@xmission.com>
Cc: linux-api@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>

make headers_check
on mips cavium octeon
for v3.17-rc5
results in
kexec.h:61: userspace cannot reference function or variable defined in the
 kernel

Best regards

Heinrich Schuchardt


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
