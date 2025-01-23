Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8433C02182
	for <kexec@archiver.kernel.org>; Thu, 23 Jan 2025 09:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uo8Cx30dCXpTlveUxDtkpyhLzmGF8WktVGE/fkEV+uI=; b=dObIopAJGv0BMmmd5qGW6F+TXM
	PjhoMTrPDPmMNtQsBtwXFV5DOcpM5zaEvaeW64F23KBAYGEvCYS+RgrmiQmpgy1Vhx7pp/dlnfFjj
	Mv7AX3qfLcpgFC93NmtW9KgrfFPb7Of7elSgyzxPkBvZ/4p6oOYMzoSou0x+LQlRuIbf6U2lsH4QE
	KWP+xZLSsdl9P/6ROZl8zAugsa6XkYDCzKz07cRPYLA08FYzLL45PAp9r6XJLicEmSmq6sfkoaX3Z
	MwGrTBgsuJkdWhJpOU0VFli6Cnqk1FdzB4/CKG3Ko+W/Jt3ZjjkClvDipmC9RGtTSXk5YmarR56DP
	Q2ftjW/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tato5-0000000C7iC-0TnR;
	Thu, 23 Jan 2025 09:47:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tato2-0000000C7gI-07LX
	for kexec@lists.infradead.org;
	Thu, 23 Jan 2025 09:47:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737625640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uo8Cx30dCXpTlveUxDtkpyhLzmGF8WktVGE/fkEV+uI=;
	b=hTlERlP0GzP+Fi+zDTrIf8FmO8WdOUgtlvLKjqb1SluK/CbOxSos+XtLY1hMzEj+L0E0wG
	qEjB+XNM0G5JtHht2nciUaWLsUflzhr43iWr3Q1DWP1UGmbd1LFG+Hm5kbf1dJxFoZExj5
	ny2VokT7S28lxLSZhtKElesgaZuEcNo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-1AShxQ3WNx645fNCft0tTg-1; Thu, 23 Jan 2025 04:47:17 -0500
X-MC-Unique: 1AShxQ3WNx645fNCft0tTg-1
X-Mimecast-MFC-AGG-ID: 1AShxQ3WNx645fNCft0tTg
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2166a1a5cc4so14837965ad.3
        for <kexec@lists.infradead.org>; Thu, 23 Jan 2025 01:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737625635; x=1738230435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uo8Cx30dCXpTlveUxDtkpyhLzmGF8WktVGE/fkEV+uI=;
        b=JjMQqILCUq52U+cStr14dnZYBbHJlJV25igVSJUv/RQ3RioSSupMhg3mXg7PLvZEGN
         eq/MI8c7bhWoKqAxIxvbz/QfVhQxuKr969y/1Z8D+FEDB7L6KV79N03j45LBilh836nQ
         Sn+tczJGnLdx3IR2RJtiVcU7YHCd3piQLBh1ZZUmIder2VgsmEi4y9FQQessKl6Pi+Yt
         H7U89L3OzSQNteNQMFjtNhPJUG1XrR1VgwufEw6gmgHXmipM+915QSVSHmDMAEV8B5dQ
         cvTV9x6SroGNE33a9sYwUmfRQav/VOfjLgyIitiHOD9JwvHb/Ji5+YqGhE5nOngXF56O
         H1zA==
X-Gm-Message-State: AOJu0YwTot46yUGXOTmG5l6KFYELya0uxuUe0cid7d04r5ADCr443lGk
	EN3B2mINBQkdggteYsr33iJQiVI02yjBekOf/OHQOa2Ss5JIpKx+El29vEGCo0I1H5nzwWj/lj9
	iTGr+JI1nGke+Bg0phWlW97rxeX/yY6albCFTXBNljCI0ObDyClH6mDBkGrKb7Nq7YkMVH9Q9Ll
	paIeMrJnMtit3X9h4qjoMFRlYsb1Y1XK+ePA51OYw4zA==
X-Gm-Gg: ASbGncsg3/DD8oajT6s95zOm5qywCDjJBdOUN4ptjQCMdPTkH6TNcowMhO6uaLu/dGb
	495FRE7Az0viEIGtxt18PFK7vPYN1GkQoM/ZxgLlQl91v1W+/sW6ohG2pOaezhxypuMA25d1wlS
	LvmvH40RAjGBbX91DeCrk8Vj3oecx1yk0Mij7cwxODkioGYhJ1K0mxGQ5QYcz9oBCIsWeu6KFi6
	pH/tyhh0Nf/IODmf18X2OabbWH+KmppwVm3rX8nBNZyMGKWKY2ZOpHFIXE4DQ==
X-Received: by 2002:a05:6a21:329c:b0:1e1:a829:bfb6 with SMTP id adf61e73a8af0-1eb2144d339mr38365126637.3.1737625635308;
        Thu, 23 Jan 2025 01:47:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtUI2Y5Q2lmYLXXk5yM73Wgh2k93Y2CkVbw456gB2BcyX+aNcv84YNDoHyrzswWqNbgkvo0w==
X-Received: by 2002:a05:6a21:329c:b0:1e1:a829:bfb6 with SMTP id adf61e73a8af0-1eb2144d339mr38365095637.3.1737625634911;
        Thu, 23 Jan 2025 01:47:14 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bcc3234c4sm12183154a12.19.2025.01.23.01.47.13
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 01:47:14 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Subject: [PATCH] fix gcc-15 compiling error: too many arguments to function eppic_init
Date: Thu, 23 Jan 2025 17:47:10 +0800
Message-ID: <20250123094710.212511-1-coxu@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dU2tYVdbizcXaaXNDtN9EHkHJTbwdJOxcZ37oTPFU3I_1737625636
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_014722_138534_BF8D458B 
X-CRM114-Status: GOOD (  11.36  )
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

Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2340813

When building makekdumpfile against gcc-15, the following error is
shown,

    erase_info.c: In function ‘process_eppic_file’:
    erase_info.c:2226:13: error: too many arguments to function ‘eppic_init’; expected 0, have 1
     2226 |         if (eppic_init(&eppic_cb)) {
          |             ^~~~~~~~~~ ~~~~~~~~~
    make: *** [Makefile:109: erase_info.o] Error 1

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 erase_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/erase_info.c b/erase_info.c
index cbe1681..af6bfae 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -2192,7 +2192,7 @@ process_eppic_file(char *name_config)
 {
 	void *handle;
 	void (*eppic_load)(char *), (*eppic_unload)(char *);
-	int (*eppic_init)();
+	int (*eppic_init)(struct call_back *);
 
 	/*
 	 * Dynamically load the eppic_makedumpfile.so library.
-- 
2.48.1


