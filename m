Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED4FC5B543
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1BA6YgwmMRrEoQFrecCBFpMi5qidnNLqj+uCAoupSQ=; b=F9EGX0J5e5TfwNCZT8hbQdINVa
	1uv1cySAzZhwQE/ZyK6UIra/oLuzh8QFl70JtAqiy8RXEVnoxqFZB+3a3rfDNx4ijQu/YmMlbMULn
	9hQpEcIM5rDY52bvr+q0VMnAwcdbyCm2Dg6nKC2kmQwlndUvcnY/ZLBIYyCPZ6wj/TqZgyTQ89srt
	HXYUoqhqtr5ZqOSL+yjjUQSbmTwF6tiz3dcbjo+c9FWdugM+vriyY3kKoHtL8/LDrlLKZ9Brxyk3c
	wIE0gitpTTCoHxNN4tuaQHmrjC480Qu4nudvmAGDySgUV4rg/SCT0VvBk7f1XVlpz4seNA8PqLNLh
	ircYWRNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOwf3-00000006YFB-3MsH;
	Tue, 10 Jun 2025 10:56:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOvlx-00000006QlF-3k4r
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 10:00:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749549601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1BA6YgwmMRrEoQFrecCBFpMi5qidnNLqj+uCAoupSQ=;
	b=EX+9VVOs0YrqpPB/4PMCCLv/V3hTQtzPrhcN/O2tDEB9Xwie6sJypW5C+PKpccGHr2zyFo
	OcT09W4N+umtAoV7f3pghuF1M9+Lz5nD5WXluRtexddpqZiB64/yQUw3ltzp1M6FKtcKJX
	SK0PpR5mKPiiO3RYdOkccu81T6iGn5E=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-ZGrQ-rafMDau-BVZobCWfQ-1; Tue, 10 Jun 2025 05:58:21 -0400
X-MC-Unique: ZGrQ-rafMDau-BVZobCWfQ-1
X-Mimecast-MFC-AGG-ID: ZGrQ-rafMDau-BVZobCWfQ_1749549500
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234a102faa3so36191535ad.0
        for <kexec@lists.infradead.org>; Tue, 10 Jun 2025 02:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549500; x=1750154300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1BA6YgwmMRrEoQFrecCBFpMi5qidnNLqj+uCAoupSQ=;
        b=k4h+AbmMlB7ezcWLEZItcQRxCO/rCRhNjDezXlYXwzRuakgVwyiHYmSTRYgac1Dbh3
         8phzUjflGcC3KRa3UVvxoy5+I2fvnRtAQZuPQKsbLDN3EFo63KKUuWzVVq62qAAwvhDM
         tbbIM29GvlT9LQiCQe+RbXArYX++Wds5Supt4a/ea+wvnfRnrGSoXpcLl0KWpvi5/AXH
         bPWLaE7KtfFMgNkxb+9NvsdndUJNLqdzLEQRLAyCI5XhsuX7f+6NbYqBRVRCDX16RfMo
         M1g1+HL8iOMw0Y7qdxOcTccr00SOTxtq8UwAc4KNBL7fDvQ3K8NvT3HUNTb/scR8Ss9l
         O6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6UsV0puAqn6tfgoTJ4H//rue+Se6YA9iGS8+NkH6m3H6kH7s18Gs5DiYA3IkUg2dekJh2Qg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyMMaWF93zC17/oj0qPYK/8yuc9OY1cxhSaOBAGqHE1VBoas29k
	wknbia+0ZcacJa72Xiz3ADcYRPWw3vmnzSspG5hlycD1yTm9xy2238Gn3rbH4wq38a/oeW1HzTg
	u7QEIAEY3tuv9l1Znwch8mNRftBIOKgbDhv8I/z39ecYZdpjG8AVPW6T+9GVGCg==
X-Gm-Gg: ASbGncssuU1WQXx948BbJ072ptR0GuP514sv406K7MfPv0QHBoXmrK4GqaYsGrLN1K9
	2paWNRTT23TnYdh4e7L+VkpINfHT2EMbaIaPGgAmhdC0xiRZ+z+E3NGiCs24AqYoaQJ377xNurc
	Y4y9ssj94wdXZoMNyVg6IeLDo4OdK0IbalfYsrpbnsPPIp7u6bLIHonEI0ec0+bbE60sRAnMDt+
	wMhTU3P3Rl423JGq1Cdt0YGbwYRgKKicHAwSbf0ejA3OdGmCrjTorF1svPLG/CDnYhQBAG+L6Pp
	5Jyjz1L3i26zFdd9D7MCplcE5c2SERY=
X-Received: by 2002:a17:902:f690:b0:234:ed31:fc94 with SMTP id d9443c01a7336-23638367641mr28204075ad.26.1749549499916;
        Tue, 10 Jun 2025 02:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvgtmVp/FAQhrHtanxZ+9UqdZDN0TyDhBLTgpYLMROgD61u702QdzVVc1kKtIHFhYrc42rng==
X-Received: by 2002:a17:902:f690:b0:234:ed31:fc94 with SMTP id d9443c01a7336-23638367641mr28203845ad.26.1749549499605;
        Tue, 10 Jun 2025 02:58:19 -0700 (PDT)
Received: from localhost.localdomain ([118.148.112.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405f5fsm68189085ad.172.2025.06.10.02.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:58:19 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	devel@lists.crash-utility.osci.io,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH RFC][makedumpfile 07/10] Supporting main() as the entry of eppic script
Date: Tue, 10 Jun 2025 21:57:40 +1200
Message-ID: <20250610095743.18073-8-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250610095743.18073-1-ltao@redhat.com>
References: <20250610095743.18073-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z6xNFNMKD8niOQ9s4VCnoN93XCNu77AdBATTnyYSK9A_1749549500
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_030002_015647_2D0AEDD1 
X-CRM114-Status: GOOD (  12.05  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Previously only a function with usage or help functions is regarded as
the entry of eppic script. This constraint makes no sense because main()
is widely accepted, and people can easily get confused when writing eppic
script and blocked by the constraint. This patch will support main() as
an entry.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 extension_eppic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/extension_eppic.c b/extension_eppic.c
index 8aa9ed2..c4a13b9 100644
--- a/extension_eppic.c
+++ b/extension_eppic.c
@@ -49,6 +49,8 @@ static int apigetctype(int, char *, type_t *);
  * entry point and user will not have any option to execute the usage
  * or help functions. However they are required to identify the entry
  * points in the eppic macro.
+ *
+ * "main" can also work as the entry point of eppic macro.
  */
 void
 reg_callback(char *name, int load)
@@ -59,6 +61,11 @@ reg_callback(char *name, int load)
 	if (!load)
 		return;
 
+	if (!strcmp(name, "main")) {
+		eppic_cmd(name, NULL, 0);
+		return;
+	}
+
 	snprintf(fname, sizeof(fname), "%s_help", name);
 	if (eppic_chkfname(fname, 0)) {
 		snprintf(fname, sizeof(fname), "%s_usage", name);
-- 
2.47.0


