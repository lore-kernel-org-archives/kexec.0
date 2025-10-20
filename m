Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1228ACCD1A2
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 22:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1BA6YgwmMRrEoQFrecCBFpMi5qidnNLqj+uCAoupSQ=; b=Ed1R4yM+98Y6SdX0SELVrdILWM
	svsUkcl1sgeChMs5doPXoxNR+PsBfTNgssg/mWKZ/mZKZxgR6wXR7Ewy10ndG+gkpU+PoxCTqHum3
	MyJYgxI7/KYRfx95Ylf9GE/urXac3J0winkt2+fPoCc1JqsCTYRnHy5ZQBam9AdQdCJu7PknVGeXw
	zPaUXjneKVonDTcpUflI8xmB+ODangIWaSFCXhtewH6RIMSXVCkBw521lMrL/ojdcdk917bcUNja+
	2kSj0Cj7OIB1T8nbbDBi5d+fVFz5PVPbhMxOXwY6I0qew65odnRxRCHnaHsD1qH0fkXnAM4DEOhpl
	DQq2/kWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyIr-0000000FAsi-1e1e;
	Mon, 20 Oct 2025 22:24:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyIo-0000000FArB-30HA
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 22:24:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1BA6YgwmMRrEoQFrecCBFpMi5qidnNLqj+uCAoupSQ=;
	b=AtqUGZ3viQ5HzvLGr8oV/WrADIEvW/TsRKo/nPsnF3vDgIZxWDO5x7Sai2VoY6a9ZclBNW
	H2CI2RX+nmZ51CA4ks2QbC9NFHOUj0ZDtLVtfAJSTcXhSjTCyNmEZlxiM+hgbtBKGO331q
	TUFYWgYQ3VhwMOh2cebn0c1jJf5bUY0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-7T9ZaEMwOmadMH_PXhh0xQ-1; Mon, 20 Oct 2025 18:24:27 -0400
X-MC-Unique: 7T9ZaEMwOmadMH_PXhh0xQ-1
X-Mimecast-MFC-AGG-ID: 7T9ZaEMwOmadMH_PXhh0xQ_1760999067
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7a144677fd9so9383558b3a.3
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 15:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999066; x=1761603866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1BA6YgwmMRrEoQFrecCBFpMi5qidnNLqj+uCAoupSQ=;
        b=wIahxG/7qgGvKHEVALjqMfWmSaSwebkoJLs/FSZXrfDZGmo4h24+TwxmWGMrDjWiOq
         e6pVkflCubhEMwYNC0RUS1FxLZZOX/X2DhLUuab0811a6kzYqmYuk+DJM0/eR18H90iN
         b2hJKRmGwyIQB9xOS2/wzNzTywpvUNNLgH1J6xwm4sDpAoV7uwOy/9Yi9RfSRm+uCQKN
         wo0uCjlAAi60hoLFgsMawqK/TRTzg2+0XT2clDiWf+hFQvqeoGWkI9FcqtfLjNsudM9S
         aTnxYuHuhfuKmj84wdU3D8uLEsNc0/t5kW0JuFL5KKvrirJYIQmk5mIycaO9Sq/hNqrs
         kWqg==
X-Forwarded-Encrypted: i=1; AJvYcCWbE1MRr0l69M3KtYZSfBqa2+jn70elhwHi++i8n1tC9ihS80aQjxC4V1pIUxfaB7NOcKU5rw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzwferbhDOOpMRb3NXp5luWoo3TXYbnlfvtR1jwAKMG4gBSDVgt
	4V8CEm4pjrYfDx8mFf/8EkVGgxyrtgnqsU/pojnK5fRmDTugvso+YKNK0cnqPkt2oPFrYVOVCwa
	S2WKAFKrm0hA+1MobejrKZMSNiMU5bWGcY+DC20BLpEqJC0Wy2aRg8OAPyILylJbGpkT9ew==
X-Gm-Gg: ASbGncuYjmcbgj4tFP3/R8VyGiLn6JAf2t5ODcN+BdDYaqOGW23XAooFaJ0pJf7xlRn
	AK7wdhk+F17Gf42CW8UWEUaxb6Hpl4wjq7/CwGml/P4nGvnph/zxEYQKIiYkmiiU5eNxDodpaOZ
	5+jr4aF7VH9c5PxIaS78cVEnDW1ldB/JEZ1upXHsBrBjwZXN/82SVqZ7wYBDHjJHp0cB+75JeS8
	z9B6gLski6rKP1/wqD4C10SV2PhliFdL43iY4IuR4/eeZWcu/hxRgZS6OqRETRljR6aQ7gWyV6C
	JzHvjtOEhK8H1xZiUN0rLNk5EjUx0VU2TV3ssYNemmZPTsqEw+S5c2ogir8yIVSJfnBpOHnfAjD
	ZXo6I7LRzOdILc+d+cOJAkDFSDeVe1xBmqeHKcIhG08s=
X-Received: by 2002:a05:6a00:a90:b0:77f:49da:166f with SMTP id d2e1a72fcca58-7a220d41109mr16446235b3a.25.1760999066639;
        Mon, 20 Oct 2025 15:24:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjHrsBSC0HTbki/6DRe3SLb2e+PH5i70x8tQssN2dNNWVCkKhijGivYLWPXxbH2U1SCUnx4w==
X-Received: by 2002:a05:6a00:a90:b0:77f:49da:166f with SMTP id d2e1a72fcca58-7a220d41109mr16446219b3a.25.1760999066264;
        Mon, 20 Oct 2025 15:24:26 -0700 (PDT)
Received: from localhost.localdomain (115-189-93-209.mobile.spark.co.nz. [115.189.93.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e265sm9229263b3a.52.2025.10.20.15.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:24:25 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile 02/14] Supporting main() as the entry of eppic script
Date: Tue, 21 Oct 2025 11:23:58 +1300
Message-ID: <20251020222410.8235-3-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251020222410.8235-1-ltao@redhat.com>
References: <20251020222410.8235-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: awobMhC0pXagGBgD01yIFMbcyhABT9sRzhwc6MWCWuY_1760999067
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_152431_254772_75DD0D75 
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


