Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A421C6FD1F
	for <kexec@archiver.kernel.org>; Wed, 22 Mar 2023 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6IKMrqrqyjpuDzln9lB+W7wHWuLQfsfPzZFhMUoGXZY=; b=Igq2uoXKrQ4L/6
	iD2U3C2KSF9B9X/d0vQQ3MWYV8Go1eGh9JYYO+7QxzpjEF3dqfGhupNlpCItVkNDu22IdbN47+IY8
	kXXzQrQDSC9Mh8A/4mg84jFaFkh5RiKmweQ6i/v/jvT+9WbZA20WFtGjM/hMui6ikqhXYbabC33HM
	Za+EBIx52B04edIrIwjW/kPmSap9ww0vjr0f9T0p2NLWyQC/2KvwzKhDopNIcOt9f6NhguLphGp+9
	+iYRPwHIU1RusPAZwxVRKGCes04SErxrwMi1tR9ixclglN/MaMFxY6le8YuttTcIpVqAyW8vghEaM
	WerCFTLUEPL79LNlDW4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peztv-00GOuq-2I;
	Wed, 22 Mar 2023 14:57:19 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pezts-00GOtT-1W
	for kexec@lists.infradead.org;
	Wed, 22 Mar 2023 14:57:18 +0000
Received: by mail-ed1-x535.google.com with SMTP id ek18so74143143edb.6
        for <kexec@lists.infradead.org>; Wed, 22 Mar 2023 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679497032;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGYOqDadhmsseDC0wX50qpITbuUEp1N4J0vaATobCLA=;
        b=G/l1XPwfAmpfc0zYBfc2PYxi5tOYq6n46qHEAus+GTjiRtmsEdqv+dK/6PcCUBJDLJ
         hbip3YmDaE6mXLNsGjTYq8q0g4yXh6gfNTKraQqo92KDvpsNQ4kFc6ZqLH8ExhcBRiCZ
         dYdho9HU6l7AMN+yE/wqmxMkeT6ZH0nDPozDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679497032;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGYOqDadhmsseDC0wX50qpITbuUEp1N4J0vaATobCLA=;
        b=EW5dhXVjG71WmdnWM9eA+Xe1xYisWU0g4J4PSRA3dr2unFyKDA9Y2U7AhP4PGkytmI
         1SWqsSQ2aCpheFcSDa5uJLsTa1+EgAWW0AF0a+sSM4WxGuBILTJ/Bgffa2TBxz8NbA4W
         iT1jIXyel0aGizQbNeW2MZVW2p12ODlld18qQKvkvtuUFQZWFeO2Huhl+SsqF1HbYv2E
         jaAw5VdpZG91GdmhcR+sUz5rqmUaGMcnKblrj3L/Y1VlfwHX8LfceyDv7u5rjqwLF4vh
         cSESk3rd4Wq7OdncbZxclznGqhAY7TN0wUxebot8LYDJWzOv2lzFNbonssCaMc+/LZFY
         rCsQ==
X-Gm-Message-State: AO0yUKXHqJrUSfN0nvl4wC9KlNF8f4/DOA/2HHBRemYVvSFY9UMHlb+E
	0DrB8VXdl1du01Q99tnRATtMYA==
X-Google-Smtp-Source: AK7set+PXmlCPVawaFWyPYo9kOHc3dNlpQMXGtbT4rULP0P5Nfil6epT/P9Ft0E42xmHrAYBEhv8Dw==
X-Received: by 2002:a05:6402:44f:b0:500:4062:99f7 with SMTP id p15-20020a056402044f00b00500406299f7mr7464988edw.32.1679497032667;
        Wed, 22 Mar 2023 07:57:12 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:5f6a:82a1:e22a:94f1])
        by smtp.gmail.com with ESMTPSA id q30-20020a50aa9e000000b004fadc041e13sm7886755edc.42.2023.03.22.07.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:57:12 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 Mar 2023 15:57:03 +0100
Subject: [PATCH v2] kexec: Support purgatories with .text.hot sections
MIME-Version: 1.0
Message-Id: <20230321-kexec_clang16-v2-0-d10e5d517869@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Philipp Rudo <prudo@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Baoquan He <bhe@redhat.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2892; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=fnrLcVQ1AvJdACOA7Q5fvzBkJ12XpQAOmvFAOWWoit0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkGxdB8KVcnWWA0yHB3Vo3OsDbKZYjZaWTwqtOoMlg
 u9oJd/qJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBsXQQAKCRDRN9E+zzrEiIBjD/
 9s92XhCh2L80pc0Mj6fm7p1vIC6K/nmBsfzkvlM1sLeSbHf6NuQdLPHn0QZS83rBYVMX/V2WZSm4dx
 C/ApyOM7ltyd5Ltr8memqr6SrP7mSl+1U9Yw5ZaSQqAY6NZGoZ/6aDFTCbaDbTAScnRgtDXz6hHLJ2
 GE5x2lu5RTyU5a5NekCilvoypGfFwHaLINDfSArgI9q+oP2f4bhd4BBNLfzBpv857Mo2gqjKhm+9xt
 E2Y0zYMbjGFclSXk0w7dsTd3AMQQ6tEMmhvdxLDjnpVE02PJpV9VZ/ElQmINt+YECOgrfZM9ayN/8H
 XVx+zquSCdZ1pp1CitBwxUnswJePK6x5ik2f1iGh5A5TPsB6fobSOt+iSroM5vV/OEtKGzXaeuQA2D
 MlSb3O47DiFgmMKyQyYZoGQvIKTKm0//y0qrirUsRi4BGEsaBmD65AdqopChGDQ7KSmpw8nJG99ozV
 Js1gHNTg+Ne/fJXZ+qoW8jENnFTrS6j2nw2EY7B1H4Zzntgi6ouQszaroQgUqvsaEBHsqaR/ZS2cKF
 Q68UkswH88KBtsodAJJFm9VGDkptYxpfCfJbvegERNNjUjHrq7xaqqdbLomI4cw4z7lhrwwu4q7LwT
 VoxGrrwqZFaBbys112SnZ6veat7mpQwzQEq5MH0anO3PjCV4S9huvjImJs0g==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_075716_530472_213E5EE1 
X-CRM114-Status: GOOD (  16.20  )
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
kexec: Fix kexec_file_load for llvm16

When upreving llvm I realised that kexec stopped working on my test
platform. This patch fixes it.

To: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
Changes in v2:
- Fix if condition. Thanks Steven!.
- Update Philipp email. Thanks Baoquan.
- Link to v1: https://lore.kernel.org/r/20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org
---
 kernel/kexec_file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..975f2e969a45 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -901,10 +901,21 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 		}
 
 		offset = ALIGN(offset, align);
+
+		/*
+		 * Check if the segment contains the entry point, if so,
+		 * calculate the value of image->start based on it.
+		 * If the compiler has produced more than one .text sections
+		 * (Eg: .text.hot), they are generally after the main .text
+		 * section, and they shall not be used to calculate
+		 * image->start. So do not re-calculate image->start if it
+		 * is not set to the initial value.
+		 */
 		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
 		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
 		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
-					 + sechdrs[i].sh_size)) {
+					 + sechdrs[i].sh_size) &&
+		    kbuf->image->start == pi->ehdr->e_shnum) {
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
