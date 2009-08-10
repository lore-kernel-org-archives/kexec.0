Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MaVeH-00086m-Bu
	for kexec@lists.infradead.org; Mon, 10 Aug 2009 14:14:57 +0000
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id n7AECXNr012789
	for <kexec@lists.infradead.org>; Tue, 11 Aug 2009 00:12:33 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7AEEoDS287034
	for <kexec@lists.infradead.org>; Tue, 11 Aug 2009 00:14:50 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7AEEnGL025344
	for <kexec@lists.infradead.org>; Tue, 11 Aug 2009 00:14:49 +1000
Date: Mon, 10 Aug 2009 19:44:42 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: [PATCH 2/2] Support R_PPC64_REL32 relocation type
Message-ID: <20090810141442.GE3110@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Reply-To: mohan@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au, kexec@lists.infradead.org
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org, nhorman@redhat.com, miltonm@bga.com

[PATCH 2/2] Support R_PPC64_REL32 relocation type

gcc-4.4 compiler creates R_PPC64_REL32 relocation type in the ppc64
purgatory code. Add support to handle R_PPC64_REL32 relocation type.

Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
---
 kexec/arch/ppc64/kexec-elf-rel-ppc64.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
index 80543af..97aa34c 100644
--- a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
@@ -62,6 +62,10 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
 		*(uint64_t *)location = value;
 		break;
 
+	case R_PPC64_REL32:
+		*(uint32_t *)location = value - (uint32_t)location;
+		break;
+
 	case R_PPC64_TOC:
 		*(uint64_t *)location = my_r2(ehdr);
 		break;
-- 
1.6.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
