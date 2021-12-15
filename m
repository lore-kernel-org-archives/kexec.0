Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxYOh-0029mI-JT
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 17:49:00 +0000
From: Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCHv2 0/1] s390: handle R_390_PLT32DBL reloc entries in
 machine_apply_elf_rel()
Date: Wed, 15 Dec 2021 18:48:52 +0100
Message-Id: <20211215174853.7520-1-hca@linux.ibm.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: Philipp Rudo <prudo@redhat.com>, Tao Liu <ltao@redhat.com>, kexec@lists.infradead.org, Alexander Egorenkov <egorenar@linux.ibm.com>

Version 2 of Alexander Egorenkov's fix with a changed commit message
as pointed out by Philipp Rudo, and requested by Simon Horman.

Please apply.

Alexander Egorenkov (1):
  s390: handle R_390_PLT32DBL reloc entries in machine_apply_elf_rel()

 kexec/arch/s390/kexec-elf-rel-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
