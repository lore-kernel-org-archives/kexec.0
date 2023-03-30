Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2621C77B60
	for <kexec@archiver.kernel.org>; Thu, 30 Mar 2023 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Message-Id
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Su7Z5VUjHiEGS3vEn7wNn+oPc2pwG6b8HO6FBkwjyfE=; b=zkJhAh6gEq3CKM
	mlS2bQJbAQ322oPh2ZkLBOsCtWzm8KmxLRWZk3eWDX/9BIQapgDCrIFg+bH8Kx8i9bzyVZPMQF1iD
	EZ+9TTOqeG8YshK3LxPXiua+snT6uTTeTpbYpdtx0kcJEu9q1X7oAOII6IsIr07u2EjfqBnRdQJV9
	8DEZzxXVBqNG9XCjPf/oB4kaC7DM8bjLKhPx4Dq8dKi6UwuGnJJGdS3bc5CHwQ8rxHKx+6bJpGT29
	7YnpB1X+8vWpKVT1/MpuFt1oZqi8794s7izE2ykuYpNUqwdq/K8smSBps0p7rhTpQGMUXfH21D7k6
	ovWFeNohGoRHKpDCYimg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phoqN-003KEO-39;
	Thu, 30 Mar 2023 09:45:19 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phoqL-003KBt-0I
	for kexec@lists.infradead.org;
	Thu, 30 Mar 2023 09:45:18 +0000
Received: by mail-ed1-x530.google.com with SMTP id b20so74126253edd.1
        for <kexec@lists.infradead.org>; Thu, 30 Mar 2023 02:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680169514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0ZT4tLV4pwIFoJoCyH/LTIscOWlu6sttcJkFj6RAJg=;
        b=MKhXbw6KldDmbyijGdW2H7JuSKi026ZosGMSIpAUYa7SUhoSNajx2CAwoSK78pgnXv
         9F1Q9tXqHnihud+Axk0aABNgz4iHDjH0mabEzb78y0ER0Y9LmD+SwmoeJePo8qY4ZTp+
         nu/4byyaZZi3pZZV96rCwuaexyXd2rOqeDjNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680169514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0ZT4tLV4pwIFoJoCyH/LTIscOWlu6sttcJkFj6RAJg=;
        b=PFRlBV19d31XhCXjItQVIp7QnPYKc25BhskMrl9nqx8BDO8la/CrSAnXWzs3Og4ZA/
         virI7RWWQzI1sCtazRVX0DhvmKIn5cp69VycNv9/XuwoHLlht3cEiph+3fOWZV8UQYTr
         5AsAKhPj/0nr7en28mEE5D2ZQmiR7DP2l2QkalJDmLud4zmzh6qzKHy8frr26dB+IGko
         YGzDN10lqjQ90JnQ5MzJ9yiMIBFs/ad/yFc4+f51UEl9eQ44GWSbIU056h5gpc8q+BMY
         Wmh8SmRBCeePVazieeIlFfTwJmHr4XM2ZFtv+accES2q/k15W5D8tYKH6G51cHtJi0Fx
         hCSg==
X-Gm-Message-State: AAQBX9cv7dfV8ozJNzlNBKqxG1Ll2Psx19IB0kWnvPn9gAagCtEGHJIv
	Ui71bcaPWsyWE3uy5O94/Ff5wl/+4y2uGoPaWNs3/w==
X-Google-Smtp-Source: AKy350Y3MhdwISO0SGhTHGP0tjb+EgKW1gK7KqgVklHI9iPI6buZ2tIhiSHfYod7GWEdeKrys5UvhA==
X-Received: by 2002:a17:906:144a:b0:944:394:93f7 with SMTP id q10-20020a170906144a00b00944039493f7mr16259171ejc.61.1680169514692;
        Thu, 30 Mar 2023 02:45:14 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:1396:ff5d:6e2a:df6d])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b0092b606cb803sm17683616ejp.140.2023.03.30.02.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 02:45:14 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 30 Mar 2023 11:44:47 +0200
Subject: [PATCH v5 1/2] kexec: Support purgatories with .text.hot sections
MIME-Version: 1.0
Message-Id: <20230321-kexec_clang16-v5-1-5563bf7c4173@chromium.org>
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
In-Reply-To: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>, 
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Ross Zwisler <zwisler@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Simon Horman <horms@kernel.org>, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2485; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=l/5U4QEZ8HewezM0SKo7DhSrv7EPFo5/mMqWDXwDLoo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkJVofL0ZHdw3ddeiqI0n8LoN5gHxlFKFxXyM1S
 urlJaHanIOJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZCVaHwAKCRDRN9E+zzrE
 iBg1D/91C6RHT9QE0cVG0e+v65DsVYnvrTBce1q5oPhLB+VmdQz1sThWgK+n/xYoYX9kPacvf/z
 6IDhkaLhHIQUVpdlui544DRnz6ShOt/8I3rM8gWQ4rD8jSJ52Qgc6Jd4CZu9gphgilDDor3kf+U
 gELhcxQkcHt+WlPPSiUYJ1cQw2LJWGMJiK1Pdosh6xEMM/lIz3zvuRTZz1ww/UhJ6CRQ5R9wyi8
 6N8DggUWF8LDooOKLv1tDJptKXtOiyTqCrjjFUQ8oqK3DEcSsy3lvHTg42bJFqLanTknUJrsCU0
 f5OLuScX7v2fZKP6t/RzVbNJbNoMBc1BWVYsoqieeMxwHnEBeCzL/nhDjCgsawICPSJbkkbNH4A
 PIBr5S7JcxPJ+AAK1wDC7gSiv80UNRE093oL2GFWo6D4osNDiqWDAPGtEv25dLIqMpQ6YbbkCYa
 iM5Opq0IJXCKm+Zd8jJQO8/PwXnR5TgHsf4OeYYUAm45oEyBEr5F9XYgR9mvDLbGKMCY1wmRN8t
 2RB1yHeR6VtZpkUdsFQfEfqD8w5jjh/qGLn77FIjPqh49Y64YZH0pdqscm1wpaHQYpJLFphTt/E
 PMV5yLjcLpgHIPop1pIp8gYl4cnmsm8T2+dAUcp1Jfj9CPUk6EenylzOoGoT+nk4Rq/fIP3CYL8
 dgSeZj8HENys/Ww==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_024517_134321_8A6C45EA 
X-CRM114-Status: GOOD (  15.38  )
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

Because of this, the system crashes immediately after:

kexec_core: Starting new kernel

Cc: stable@vger.kernel.org
Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
Reviewed-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 kernel/kexec_file.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f1a0e4e3fb5c..c7a0e51a6d87 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -901,10 +901,22 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 		}
 
 		offset = ALIGN(offset, align);
+
+		/*
+		 * Check if the segment contains the entry point, if so,
+		 * calculate the value of image->start based on it.
+		 * If the compiler has produced more than one .text section
+		 * (Eg: .text.hot), they are generally after the main .text
+		 * section, and they shall not be used to calculate
+		 * image->start. So do not re-calculate image->start if it
+		 * is not set to the initial value, and warn the user so they
+		 * have a chance to fix their purgatory's linker script.
+		 */
 		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
 		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
 		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
-					 + sechdrs[i].sh_size)) {
+					 + sechdrs[i].sh_size) &&
+		    !WARN_ON(kbuf->image->start != pi->ehdr->e_entry)) {
 			kbuf->image->start -= sechdrs[i].sh_addr;
 			kbuf->image->start += kbuf->mem + offset;
 		}

-- 
2.40.0.348.gf938b09366-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
