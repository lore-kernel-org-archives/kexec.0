Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muwSU-00Cc7J-3X
 for kexec@lists.infradead.org; Wed, 08 Dec 2021 12:54:08 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8CemFx023635
 for <kexec@lists.infradead.org>; Wed, 8 Dec 2021 12:54:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3ctuq29smv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 08 Dec 2021 12:54:02 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8CfT9h025270
 for <kexec@lists.infradead.org>; Wed, 8 Dec 2021 12:54:02 GMT
From: Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: [PATCH 1/1] s390: handle R_390_PLT32DBL reloc entries in
 machine_apply_elf_rel()
Date: Wed,  8 Dec 2021 13:53:55 +0100
Message-Id: <20211208125355.256391-1-egorenar@linux.ibm.com>
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
To: ltao@redhat.com, prudo@redhat.com
Cc: hca@linux.ibm.com, kexec@lists.infradead.org

Starting with gcc 11.3, the C compiler will generate PLT-relative function
calls even if they are local and do not require it. Later on during linking,
the linker will replace all PLT-relative calls to local functions with
PC-relative ones. Unfortunately, the purgatory code of kexec/kdump is
not being linked as a regular executable or shared library would have been,
and therefore, all PLT-relative addresses remain in the generated purgatory
object code unresolved. This leads to the situation where the purgatory
code is being executed during kdump with all PLT-relative addresses
unresolved. And this results in endless loops within the purgatory code.

Furthermore, the clang C compiler has always behaved like described above
and this commit should fix the purgatory code built with the latter.

Because the purgatory code is no regular executable or shared library,
contains only calls to local functions and has no PLT, all R_390_PLT32DBL
relocation entries can be resolved just like a R_390_PC32DBL one.

* https://refspecs.linuxfoundation.org/ELF/zSeries/lzsabi0_zSeries/x1633.html#AEN1699

Relocation entries of purgatory code generated with gcc 11.3
------------------------------------------------------------

$ readelf -r purgatory/purgatory.o

Relocation section '.rela.text' at offset 0x6e8 contains 27 entries:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
00000000000c  000300000013 R_390_PC32DBL     0000000000000000 .data + 2
00000000001a  001000000014 R_390_PLT32DBL    0000000000000000 sha256_starts + 2
000000000030  001100000014 R_390_PLT32DBL    0000000000000000 sha256_update + 2
000000000046  001200000014 R_390_PLT32DBL    0000000000000000 sha256_finish + 2
000000000050  000300000013 R_390_PC32DBL     0000000000000000 .data + 102
00000000005a  001300000014 R_390_PLT32DBL    0000000000000000 memcmp + 2
...
000000000118  001600000014 R_390_PLT32DBL    0000000000000000 setup_arch + 2
00000000011e  000300000013 R_390_PC32DBL     0000000000000000 .data + 2
00000000012c  000f00000014 R_390_PLT32DBL    0000000000000000 verify_sha256_digest + 2
000000000142  001700000014 R_390_PLT32DBL    0000000000000000
post_verification[...] + 2

Relocation entries of purgatory code generated with gcc 11.2
------------------------------------------------------------

$ readelf -r purgatory/purgatory.o

Relocation section '.rela.text' at offset 0x6e8 contains 27 entries:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
00000000000e  000300000013 R_390_PC32DBL     0000000000000000 .data + 2
00000000001c  001000000013 R_390_PC32DBL     0000000000000000 sha256_starts + 2
000000000036  001100000013 R_390_PC32DBL     0000000000000000 sha256_update + 2
000000000048  001200000013 R_390_PC32DBL     0000000000000000 sha256_finish + 2
000000000052  000300000013 R_390_PC32DBL     0000000000000000 .data + 102
00000000005c  001300000013 R_390_PC32DBL     0000000000000000 memcmp + 2
...
00000000011a  001600000013 R_390_PC32DBL     0000000000000000 setup_arch + 2
000000000120  000300000013 R_390_PC32DBL     0000000000000000 .data + 122
000000000130  000f00000013 R_390_PC32DBL     0000000000000000 verify_sha256_digest + 2
000000000146  001700000013 R_390_PC32DBL     0000000000000000 post_verification[...] + 2

Corresponding s390 kernel discussion:
* https://lore.kernel.org/linux-s390/20211208105801.188140-1-egorenar@linux.ibm.com/T/#u

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Reported-by: Tao Liu <ltao@redhat.com>
Suggested-by: Philipp Rudo <prudo@redhat.com>
---
 kexec/arch/s390/kexec-elf-rel-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/s390/kexec-elf-rel-s390.c b/kexec/arch/s390/kexec-elf-rel-s390.c
index a5e1b7345578..91ba86a9991d 100644
--- a/kexec/arch/s390/kexec-elf-rel-s390.c
+++ b/kexec/arch/s390/kexec-elf-rel-s390.c
@@ -56,6 +56,7 @@ void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
 	case R_390_PC16:	/* PC relative 16 bit.  */
 	case R_390_PC16DBL:	/* PC relative 16 bit shifted by 1.  */
 	case R_390_PC32DBL:	/* PC relative 32 bit shifted by 1.  */
+	case R_390_PLT32DBL:	/* 32 bit PC rel. PLT shifted by 1.  */
 	case R_390_PC32:	/* PC relative 32 bit.  */
 	case R_390_PC64:	/* PC relative 64 bit.	*/
 		val -= address;
@@ -63,7 +64,7 @@ void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
 			*(unsigned short *) loc = val;
 		else if (r_type == R_390_PC16DBL)
 			*(unsigned short *) loc = val >> 1;
-		else if (r_type == R_390_PC32DBL)
+		else if (r_type == R_390_PC32DBL || r_type == R_390_PLT32DBL)
 			*(unsigned int *) loc = val >> 1;
 		else if (r_type == R_390_PC32)
 			*(unsigned int *) loc = val;
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
