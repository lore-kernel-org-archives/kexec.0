Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E48C43217
	for <kexec@archiver.kernel.org>; Sun, 20 Nov 2022 23:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S3NELRrN0IGSA20vRFM3DJlhBTTA13IW+0PluFVlxvY=; b=2aaHenYMoEdQz3
	07/xgOiBZS/sroDnQ6YtVz/Bq00tnVkWCYEhT48ZBYA8vFg6Kl5xLwMDreRPXZpr20IFuvuHPZjCW
	jH3UYzsZy74zojnJRwojpkuKf7JQc6KA5gB/8mZyahg+aEAXU5B+beybsB7Z+JAGobyq5PQjE5NBP
	jbv04t8prW17PJbSVBHhjCFIaXnD9Zbfrl57Llh7sjwGQABEmcVjCKpXPJ2JKtVOBxeMmGgy9Hovz
	USPSm74XnQaGbAq4zeP5Lx0vlM+npfx0Hjb9QvnqXz/LdITGJqbqse4zAljHHZ/x1K1FqwwGMjccq
	0Ma5pWHz4bI0nzBun8Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owtgp-007aFN-J0; Sun, 20 Nov 2022 23:25:31 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owtgl-007aCr-He
	for kexec@lists.infradead.org; Sun, 20 Nov 2022 23:25:29 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AKIWOxS001495;
	Sun, 20 Nov 2022 23:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=O6dqXTns8cG15zu1RgAWEa+DTa2avc/SfDmbcu1+qrA=;
 b=NnTRpnhlMKExbDDt+2DmMSoxk76q9zJJKCERQGHa6/V+4e5hxzuD++ui41lCZ99nl/Fe
 1wH2/G0PpCt8HCHSLeKoXajXu/e24RppOkzFhQv0Qx7KmTKvTMJmVSP1/yn8StI7EVLi
 8tswPkmPrMiId+JPHqUJ/A/YjLEo49Z0o34Zwdn4p8XK43gxJwEonk/xyxxHHb+zBSDV
 tT0Bl0ej/6c/K4fUIC9WHH2oLUw6twKI+WcP6A7E37J2fvHNMrHwfvCZZjPBvwsNxhca
 NuBd/dxx3pGcAGnGo3t76IRUGoRlDU9Wst8Toe0feNdByqpopkGOCzejYgqMMlIq2HeW yw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky8khj6hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Nov 2022 23:25:25 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AKNPMPF022291;
	Sun, 20 Nov 2022 23:25:24 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ky8khj6hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Nov 2022 23:25:24 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AKNLGGp007776;
	Sun, 20 Nov 2022 23:25:22 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma02fra.de.ibm.com with ESMTP id 3kxps8sbe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Nov 2022 23:25:21 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AKNPJ1k29491918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Nov 2022 23:25:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AED0AE051;
	Sun, 20 Nov 2022 23:25:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64C8BAE04D;
	Sun, 20 Nov 2022 23:25:17 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.9.248])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Sun, 20 Nov 2022 23:25:17 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v5 3/6] crash: add phdr for possible CPUs in elfcorehdr
Date: Mon, 21 Nov 2022 04:55:05 +0530
Message-Id: <20221120232508.327554-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221120232508.327554-1-sourabhjain@linux.ibm.com>
References: <20221120232508.327554-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fpwGs08pRRQdf-GskU8y36akY3H_BAxZ
X-Proofpoint-ORIG-GUID: PCI_M2EUuHepL9A2uMx0JC-HUJh8dhQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211200194
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_152527_605524_62F5EE24 
X-CRM114-Status: GOOD (  17.95  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: eric.devolder@oracle.com, kexec@lists.infradead.org, bhe@redhat.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On architectures like PowerPC the crash notes are available for all
possible CPUs. So let's populate the elfcorehdr for all possible
CPUs having crash notes to avoid updating elfcorehdr during in-kernel
crash update on CPU hotplug events.

The similar technique was used in kexec-tool for kexec_load case.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kernel/crash_core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index bca1b198d9e55..f6cccdcadc9f3 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -364,16 +364,19 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
 	ehdr->e_phentsize = sizeof(Elf64_Phdr);
 
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
+	/* Prepare one phdr of type PT_NOTE for possible CPU with crash note. */
+	for_each_possible_cpu(cpu) {
 		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
 			/* Skip the soon-to-be offlined cpu */
 			if (image->hotplug_event && (cpu == image->offlinecpu))
 				continue;
 		}
 
-		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		if (!notes_addr)
+			continue;
+
+		phdr->p_type = PT_NOTE;
 		phdr->p_offset = phdr->p_paddr = notes_addr;
 		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
 		(ehdr->e_phnum)++;
-- 
2.38.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
