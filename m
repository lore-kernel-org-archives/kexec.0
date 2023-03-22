Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD93CC6FD1F
	for <kexec@archiver.kernel.org>; Wed, 22 Mar 2023 19:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=C9tbvI9OT4IMn9cnMnhFobGROBm5uVzB1eWYAVHXKxc=; b=0Qcse3m8aPbUO6
	9gs3Pp/2T6e7rUHRzdpGvlSeTejtWirw5gYKVIDrpRRq6ykAMZvp3PlAYk/cq+GEAHg2VvfQ8tb5G
	Ze1/3e4OMUeNO4wgTldfQr+mu76vsva9kzD8/VYQDxxQRVEIMCsy/3mjPB/WZr+i1jRC+UeRDbzlt
	mMTGF/zD8D5LseSb6hVMg35GOlq1r1xZOq0ycwgYXEKj2zMkN/WMTDqKWetJgjTgcebo4LbLjeB0S
	0TpmC+6g3Jf2M3QhJBMWvU6i0ZmesWtTrzB7xBqVPeZrnVR/WJiBAGToec9rrSccJ1w9udjN0dfDr
	NSc/I0oh/VFO3/n0vOvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pf3q9-00H7ie-30;
	Wed, 22 Mar 2023 19:09:41 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pf3q6-00H7hK-21
	for kexec@lists.infradead.org;
	Wed, 22 Mar 2023 19:09:40 +0000
Received: by mail-ed1-x534.google.com with SMTP id cy23so77053135edb.12
        for <kexec@lists.infradead.org>; Wed, 22 Mar 2023 12:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679512173;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ySahdxE1L4cd6ksj325R5E2NVmNvOBKF2RFZh+Bg40=;
        b=UPWEMq3NxXxzE8Wiu8abtvsUinCwPFZ8H9FO2g/NFY4fziUMumJC6irIJ6dv69ZpTQ
         n21XNFACcI9NsGiNHUOVoAwAE2Fee/eo+JtPd9gQfHg4dOwJC75vcH4W7wbd8iWEA9qK
         XqW4gf0zm/PELPGeYyejrX2CHeGxrVAhvfSjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679512173;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ySahdxE1L4cd6ksj325R5E2NVmNvOBKF2RFZh+Bg40=;
        b=zMQC9fa5kzK8nvS3k9dXvH+0q1TuYQiTVHPGgwWljXE9Ku5QPQ7lSeFn7SE0ZVkLbt
         LumN6TNbDIuPr6CZHdnKZf6ZSEiH9+zXIpK8q5u297eAQCVF/dAgnNTA5re48ACLWWCZ
         uqOBK0R/rQZqDqYNY32AXWpyhKZ7kVVwGlbn+X280lQFvod8jkpQYs/soiJ9zrqA74pv
         y+lI6ncFvM7Qd1TsmfbSvzd6qwMdPGr0HMxZ9nRN9Dt1SQrCtp3r9bGmSY5eVNm5nknR
         18ZmQg+HG9o5RDMykE+kTkwxOK1xLBzI+uUCzsyIp4qVelV1s6Ls0AUj98e5KAKkGTDz
         8SfQ==
X-Gm-Message-State: AO0yUKWVL8OBALsxkB7U8F4/t3e6dh5JYTzNe65MIzgW5o0h10rXDxV0
	Rr4LpdQfVP88ilVduev+zJs8ng==
X-Google-Smtp-Source: AK7set9bWzvTBQfp8o8NZCDk6+QW+Q+iaLsHjRinXNgkwF5mMn25Kdc/k/pwNG7wlQ43npIAUmacDw==
X-Received: by 2002:a17:906:7e55:b0:932:cfbc:7613 with SMTP id z21-20020a1709067e5500b00932cfbc7613mr7814672ejr.24.1679512173566;
        Wed, 22 Mar 2023 12:09:33 -0700 (PDT)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id k24-20020a50ce58000000b004fc9e462743sm8129130edj.91.2023.03.22.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:09:33 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 Mar 2023 20:09:21 +0100
Subject: [PATCH v3] kexec: Support purgatories with .text.hot sections
MIME-Version: 1.0
Message-Id: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Philipp Rudo <prudo@redhat.com>,
 kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3040; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=zeD7U+0v4JMLtkU5q8C0r0fzM4KdEhcMV9PmfyzIKU0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkG1JkKRERoHv42QrNtVkqYPkq552VERdk/QnsxyEi
 q0BT2CmJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBtSZAAKCRDRN9E+zzrEiN88D/
 4us5k4JkfH+locFVVMElk6flGVX8JQm9dVqN442H5ATser3crdr0Ar8pPlcgcJVHtwby3G+qLJksSm
 loLsjZoLDrQgTJDJIQJDWmrj1fLTE3IranBC1bgZ4FyFir/I4yhSpiDIONnctM8nNAFZ24rLYABGmv
 2VqJU7zbiPbg765ixmxCilQptemctcAL2K4wb1nEPVZhiRWCCRVe6GbYOnOOZzY/PmG0MrdQp/aAhj
 nghVQ51CpAUd+TvUgbFOBhBfNwVsX6+ujowsxQNl9oXGdkjdbiu4/uV5oWvFfx3VJjsebs1uOFn54Y
 M/PhxTrEBH3+pKBmtWc2n1pPzcIPU5cLt9j41IJSk39sCdZ7oM9G24801egJoqBL/el62Oaa9wqFCW
 BRwp09+2qsTGQIJvdGHKuHEOsbjgm0WfUtuxM2kpazmAAx4xXOMImQkGvbpPrdD8zRqNz1JEPs+Kcp
 kfcmq1tbJhIayWISo6eKAd74xIl2RrGobQo7zGPbcNqFL9QvaJU4mMTv4q4l50xxPyiqAnDYKfXT/p
 494vBT80CbrGQqWqWiKjf+sDRSd8Df+KY0qkXOf3mh9ycDvfnSZPEOuKa5rO6jSglNHRVY8Qr0WdHl
 79mYgpPR8TRXNH6RHduqRtZaSBJ5syOlt/y6SVivwFK2YWchFDGjZrxBMxMQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_120938_685266_1B5DD588 
X-CRM114-Status: GOOD (  16.28  )
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
Changes in v3:
- Fix initial value. Thanks Ross!
- Link to v2: https://lore.kernel.org/r/20230321-kexec_clang16-v2-0-d10e5d517869@chromium.org

Changes in v2:
- Fix if condition. Thanks Steven!.
- Update Philipp email. Thanks Baoquan.
- Link to v1: https://lore.kernel.org/r/20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org
---
 kernel/kexec_file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..25a37d8f113a 100644
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
+		    kbuf->image->start == pi->ehdr->e_entry) {
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
