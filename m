Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F72AC74A5B
	for <kexec@archiver.kernel.org>; Tue, 21 Mar 2023 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dpZDdX8rIFabDNmXSmQ/dmZ+xQEZpW5IpiHXY7qSShA=; b=ONNrjV73C4sCd3
	yWA/WR3IMUOVMaKJegbPKN+KD6yhtg5g6VXF/kF+fkED2yDW9v4KoGHhwcMh1QcDX1b7C3Pmie/1S
	t15kmYbkDV6xyXKSCbS7hSQ3hASwrsB+8bMGCrEE3Gp3cahc8sBW3uuixL9sgZuWRUJiZfYEOdDj0
	lDpkhbKnzSQQF6fhSbLKyTs16vb62FKKUlLyLLYlD8JAzg0FFqT5Xc1kksKsdRs6esNdkEIWF89Ks
	CxbuaH7Dj+Yg3CIsJJNOjjmBs6B2OJTpeNDnPo7Plo4AHmO6qvL6U1RZYNPysLSLUEelzFece+2aD
	yk2yuiAAa+XQQCZSjffg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peaUl-00CFEv-1O;
	Tue, 21 Mar 2023 11:49:39 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peaUg-00CFCu-1m
	for kexec@lists.infradead.org;
	Tue, 21 Mar 2023 11:49:36 +0000
Received: by mail-ed1-x52e.google.com with SMTP id ek18so58513629edb.6
        for <kexec@lists.infradead.org>; Tue, 21 Mar 2023 04:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679399370;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wfc/MKwL6R69K5wz8AOeHXnxOrck8uBBMJXOwwRZiMA=;
        b=hqeF1dzvKFnVOu3pPvTcvVWaYPURtGrMkJs+VoOA7NeCEwSjuKUV4S9Jgi41+DRCVT
         nDgoCi9okHijFcq+EEepOhHzvQxsO7NU/XnDFGwfu0Wj1Fs7dwZ2x6mIZfve0hZWYCw4
         bhO2WkmO1otQ9wjov9G0w3pX3Sa/qRbQ7FEnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679399370;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfc/MKwL6R69K5wz8AOeHXnxOrck8uBBMJXOwwRZiMA=;
        b=kC/9uG5nCmCyZIVE1cbTHN+jZnN9cqpU9fdaRvThFkwh1DqlPDTR4lWtuaFQmYGWSZ
         0tArsSdSfXj3fQ1y7leAOlhaMYtVViZPZ9zMGf8/tjcFSusSFi4NzEmUo0x6VUa+34l3
         ni2iQojwTDTkXBNaiGRurHoTLliOZKEHh6aTo3USADPgDcPdj+on9SCGR56LPq5yj3e3
         n17t+7kxcDijUXMXT+kEu8nQcGEWGwy4NtzIBy4quIEEamqMCSoYtxwy2njvacQUBmvh
         y8n6F8wVkzmlHEa3FiLWyY8ZVXGQf3dECyLLbLfQ5NZPaR8wvmErqhMuxT9L7lqoOr/f
         QGpw==
X-Gm-Message-State: AO0yUKWKqyqB7FBjyeWvN0H1yNTFyeVMAuQ8mp/juWj7y+YgD6BSUiSK
	3B19ldH2Jn//VeAzNk+PlVUHzg==
X-Google-Smtp-Source: AK7set8u3SsBgOKZqdfTvYLQwQbmLrg1oqykUrZtwCjyDwbRSr6v7ivv37R8vy3Jy+L4xYW1jqPiOg==
X-Received: by 2002:a17:906:f8c2:b0:930:3916:df17 with SMTP id lh2-20020a170906f8c200b009303916df17mr2808888ejb.0.1679399370203;
        Tue, 21 Mar 2023 04:49:30 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:1066:a3f0:9dfa:4604])
        by smtp.gmail.com with ESMTPSA id gv27-20020a1709072bdb00b008b9b4ab6ad1sm5682835ejc.102.2023.03.21.04.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 04:49:29 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 21 Mar 2023 12:49:08 +0100
Subject: [PATCH] kexec: Support purgatories with .text.hot sections
MIME-Version: 1.0
Message-Id: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>,
 Ricardo Ribalda <ribalda@chromium.org>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3075; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=L5iy/RBbUSnp18lqg34HLuwN0ZubleWR8YgXa0JvyoY=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkGZnBY8DH4DLVJKyCFvKrPsDgIulVhZBdn63lYLCA
 ZGHPU66JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBmZwQAKCRDRN9E+zzrEiH89D/
 0SBPLgBlsByQkpnKEHmdb/+FGZhQdP8pzvqICJzE5FSm5AbLQkkBGsbsn/OCJbxZgz48M/nyXISz3P
 eqo5os9lgQJrZR0402pKlYMaY6WxbToVesC2SjKKFC15bESzf60lL8KNnIxhwsFDwiCRv1sgCn2jgl
 HOsT2/RIIOAQ6fdKoWAzZ0m/UOt9gPfjQqh9jce4oW2tYQ/gKHvJohcczJIxQn8d14eYGZWbQOdxjO
 pWTSz9JlQssUwykW3m30ZAFZ3eDmFpUldV1fIDfDE9ADDymeAzIXKF7mjbzqhWEJW6S8/g26MQCq1n
 Xx+4+n1m84Pj9iSIoBRDQ5tNGJSpvCXJ3Xdp3WrSaun9eSFKOuv2skMZP8tDvh5D+/yNzcYLMPgHD9
 yYV9j6R3tGc2oV3CWBrkmzzU4ZtzZLJFJpP60Rck+Vl/FPQ/qmd67OD4qzOnlNrSSuo3c9LxAu5Jcy
 hlSyzOkrtRhfsAfU4hjQDEl2IxXvvcz87J6R+BKUjPBf5xAor3aIiYDGrplVGgtVddCOZOJQpAiPQc
 MajN346hQO3biY2LLKWtL7nVDwV9iOaMpe0grfmV7vL+o5kLxqyHsMHQyzz4bb97FyDoKYalaHiyao
 gNd6rdc0NCUTUV2g5xsUXHYK/axh475DE/LsZNhecsEeGSUaL6C4di6XPw7g==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_044934_623978_84104F14 
X-CRM114-Status: GOOD (  10.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Clang16 links the purgatory text in two sections:

  [ 1] .text             PROGBITS         0000000000000000  00000040
       00000000000011a1  0000000000000000  AX       0     0     16
  [ 2] .rela.text        RELA             0000000000000000  00003498
       0000000000000648  0000000000000018   I      24     1     8
  ...
  [17] .text.hot.        PROGBITS         0000000000000000  00003220
       000000000000020b  0000000000000000  AX       0     0     1
  [18] .rela.text.hot.   RELA             0000000000000000  00004428
       0000000000000078  0000000000000018   I      24    17     8

And both of them have their range [sh_addr ... sh_addr+sh_size] on the
area pointed by `e_entry`.

This causes that image->start is calculated twice, once for .text and
another time for .text.hot. The second calculation leaves image->start
in a random location.

Because of this, the system crashes inmediatly after:

kexec_core: Starting new kernel

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
kexec: Support purgatories with .text.hot sections

Clang16 links the purgatory text in two sections:

  [ 1] .text             PROGBITS         0000000000000000  00000040
       00000000000011a1  0000000000000000  AX       0     0     16
  [ 2] .rela.text        RELA             0000000000000000  00003498
       0000000000000648  0000000000000018   I      24     1     8
  ...
  [17] .text.hot.        PROGBITS         0000000000000000  00003220
       000000000000020b  0000000000000000  AX       0     0     1
  [18] .rela.text.hot.   RELA             0000000000000000  00004428
       0000000000000078  0000000000000018   I      24    17     8

And both of them have their range [sh_addr ... sh_addr+sh_size] on the
area pointed by `e_entry`.

This causes that image->start is calculated twice, once for .text and
another time for .text.hot. The second calculation leaves image->start
in a random location.

Because of this, the system crashes inmediatly after:

kexec_core: Starting new kernel

To: Eric Biederman <ebiederm@xmission.com>
Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 kernel/kexec_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..b1a25d97d5e2 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -904,7 +904,8 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
 		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
 		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
-					 + sechdrs[i].sh_size)) {
+					 + sechdrs[i].sh_size) &&
+		    kbuf->image->start != pi->ehdr->e_shnum) {
 			kbuf->image->start -= sechdrs[i].sh_addr;
 			kbuf->image->start += kbuf->mem + offset;
 		}

---
base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
change-id: 20230321-kexec_clang16-4510c23d129c

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
