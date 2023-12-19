Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926E3C46CA2
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 07:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U6fgw8jw5KacyyeLxPE2+rYSpv0V38vGbt3ABU3kVBM=; b=i3Qp4VCLqRMPfz
	GHkdAArUe/NpQJvC20KuVWindOIkfID9yLJtR2membMSrx8IEB1FQvEgzuG7g08bDkpHeXc6SH531
	8XDU+rwbvmwm6gLmk+uPt0SHVxzD0vbizBqtOC5oP8tfUX5mQCmvdt0E6t+Z5v0xgYamiEQyS2CNf
	C+5Ve9oLkSef44Mb+hQzU502zN/bR3nqrhca6YoTdtaZcFixBC4c/mCDNSfUQloVPUFZLX1scPh6Y
	g25CuxIVeMsSA4fj5pGIFemSIz+qAqfbiuvAnzS64onVoP7FnYZFcbio47LHEpnpwURAIbUisCqrw
	pck7N9htDR2Swe64eJIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUXW-00D6Hv-3B;
	Tue, 19 Dec 2023 07:29:18 +0000
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUXV-00D6H1-0k
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 07:29:18 +0000
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-20306782371so2482769fac.1
        for <kexec@lists.infradead.org>; Mon, 18 Dec 2023 23:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702970955; x=1703575755; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVJnoRpc0nLQgXbaa396BAC/JfAbiv/gDW/cLPNXvHA=;
        b=MyoxoeZaDNsYMk5r+1DankB/4Q2/3JvZaapKhEotR2updvfiWB9dDf6lJqFaE6VVSQ
         A1ubI7TT2l+AdjDSODXWL0kkc+f0IFDj1n4YVQydg19FJn4Z4CqTizVtbFrolZEEKyOQ
         Aygs8mUMxCbXJuhsbLlt7QuYSD2tX/u019/Z9kjxP8qXLgmsE0by48FT2mX3osbbzwFb
         5kvS7TtC4Sz358ZARyVdczlrzt+aqW7++v+/y3Nxh/VgkTe3cQK/Z2MpVGoXAge8cMGU
         kqWgCRk9OisLIzRwHL4JnIaqH8RNuO9ijIzMmFzbUubkllO2IlQXWBKmToZ7EnQxrkIL
         46Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702970955; x=1703575755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVJnoRpc0nLQgXbaa396BAC/JfAbiv/gDW/cLPNXvHA=;
        b=fuagDFJbUG1mItaq1TfZqWdN4rpUHsX9E01WHNp0uLylVXNZpeX07VYo9XXFeL/dwW
         dzQi4O+aWPXp+BgM27EbsilW9k0HSQbSvlXlqWZwsZi5kXLItLdpK6/AlwQjtNwTpIUq
         IJtUjRpYPjh4tVxRuXT3qDTBauIyg6wydvDaF8wqcDRKxffCmRoPTz9kagAak6MSdYSy
         hgqiK3DkGOo8Hp/YG6w0gzghFpCZFGxB2GLkrJQNE8w8INTfLe9m07ptsxf1PHDy1lQk
         6gMr4bu8fWlu72BMx++KrZRpp0rJBSAiVlUq1VSTxdCucoK4h9Z7haBGcxW7a4wYSyR2
         B6+w==
X-Gm-Message-State: AOJu0YxaZ7s24w+1KZWhvLlCRofXCR7byoknG/nEF9Jq4DITguu1EqH9
	JJCGYU/Uaf/551BsDEf/BJw=
X-Google-Smtp-Source: AGHT+IHHdMs06uEO4+q/2bAZlRhxq6UUVNPFy9zVB4+gT6OvgQtBr2ly3NWW2ZDs89vzBi69wIq06w==
X-Received: by 2002:a05:6870:ac1e:b0:203:b0e1:eb7b with SMTP id kw30-20020a056870ac1e00b00203b0e1eb7bmr4201311oab.29.1702970955215;
        Mon, 18 Dec 2023 23:29:15 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id a9-20020a654189000000b005c683937cc5sm16388600pgq.44.2023.12.18.23.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 23:29:15 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: akpm@linux-foundation.org
Cc: bhe@redhat.com,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: [PATCH] x86/kexec: use pr_err() instead of kexec_dprintk() when an error occurs
Date: Tue, 19 Dec 2023 15:29:01 +0800
Message-ID: <20231219072902.90104-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218102436.4378f51a36525ce770f6cd30@linux-foundation.org>
References: <20231218102436.4378f51a36525ce770f6cd30@linux-foundation.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_232917_270007_B5C9C243 
X-CRM114-Status: GOOD (  11.27  )
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

When an error is detected, use pr_err() instead of kexec_dprintk() to
output log message.

In addition, remove the unnecessary return from set_page_address().

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 2 +-
 mm/highmem.c                      | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index e9ae0eac6bf9..4a77d5dd4bce 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -429,7 +429,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	 * command line. Make sure it does not overflow
 	 */
 	if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
-		kexec_dprintk("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
+		pr_err("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/mm/highmem.c b/mm/highmem.c
index e19269093a93..bd48ba445dd4 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -799,8 +799,6 @@ void set_page_address(struct page *page, void *virtual)
 		}
 		spin_unlock_irqrestore(&pas->lock, flags);
 	}
-
-	return;
 }
 
 void __init page_address_init(void)
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
