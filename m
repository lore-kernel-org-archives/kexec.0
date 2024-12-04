Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449FDE7717C
	for <kexec@archiver.kernel.org>; Wed,  4 Dec 2024 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WYRTkbcHet+ClCO8Q7Li/qxr/6/P0nWlLIIrfww7Knk=; b=ShWpr1kQyNYy8EhrWwypO767S9
	SLoufX0LnIyJ5TizvHOWVVC/m0Aqkk1dwhUwe3EFnIhxdVEtJpK9YXGEsQoBdJrsSE+Ypp5axnmq0
	tR8XUx+DuBA0VgRnlI9dJv040aKQPcWLL1F16cFcxFXqG9ZQgxGUstTIVaHnevZ6OF8WcR1RldDwy
	IYQ9HTUvyotCi1lBpAKCBT8O9VzU6711HN/9IJ9LGYx3HRXAG2tO4LKr+ZvOuC1F2AXBs9ItJTERf
	hrrVWbLfDIuidQoCtm5esF8q/ERy/jd7QZXvowHQkBpM/ip1+eacdSPPC4k3k6kgOf3GjD3++QTY0
	fdRbZ0kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIoxg-0000000CbVK-2gh5;
	Wed, 04 Dec 2024 12:58:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIouF-0000000Ca6W-1wN7
	for kexec@lists.infradead.org;
	Wed, 04 Dec 2024 12:55:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYRTkbcHet+ClCO8Q7Li/qxr/6/P0nWlLIIrfww7Knk=;
	b=gdSp76W2fMZxWBw7IyXVva167tl5xVwilwJeCdz3Xpm3xFoa4T9RUV1ZjkKRye6UW5Oirs
	XqN09QK0AiM+jmrF7IUcewXOil4TcYu5AlHcHq6WHGiUCHWdxERJITBQzyLSDjuVc1AP3j
	Fj1duaBuMWbTU+ZDLsuqN4+jLpS8fB0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-W2ou83h4MdSmoFWAWDxkHw-1; Wed, 04 Dec 2024 07:55:01 -0500
X-MC-Unique: W2ou83h4MdSmoFWAWDxkHw-1
X-Mimecast-MFC-AGG-ID: W2ou83h4MdSmoFWAWDxkHw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434c214c05aso29037725e9.0
        for <kexec@lists.infradead.org>; Wed, 04 Dec 2024 04:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316900; x=1733921700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYRTkbcHet+ClCO8Q7Li/qxr/6/P0nWlLIIrfww7Knk=;
        b=RyNyfAMMqhN6ey/Ngl02F/abC8bPfmB86Rq3MOWuwRdJqChGbHNUv2bxcvkXvUZ29Y
         rUc2NIbIw2uc6vELwSfP/cx3L3onLqJhv8VZdsEqra2MUenVmK7UZRRXaAMzbvw746rz
         Cgoix/BAmKwe3i4YJUtIZbIxRB5HyN4ykSkqm391CBFRtrv3F760pemC4Ph9pAtPfyf5
         QE7sjYArjz6OwA6cdv304NvMveAG5lisqZl969EPMmh0fCk/Mu2/3LBn0djpIOB/oHOm
         6G9a8ji4Qjstl+EXLdgUPU7VefB3PqkhLIybLCHaicXx6Xl1daJ4K7R6XjV055VLwm22
         rmLA==
X-Forwarded-Encrypted: i=1; AJvYcCVgzDuBQMSSOYgMOC8jKkslCu2aQKAsU1MLjftzIaIjabfglBQd3/AhoMqZu9faz7zApH6NfQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyj3HHH117cQJ5wsjzcZMzD6U0fclix++0Cotm9EyuTgm70DJMP
	FxeqZyGlKJdB7P2iGPalVBReo5pDknIpAE2mnPNxc9uhXc+6lM49lf9HJ+UEETsuXsrD72jft+w
	EtfKag6U5huZsBUXKDt5eKfaIqkEcOVkdHPb3HJwXg8nmN2Na3CF6TdKMjA==
X-Gm-Gg: ASbGncveNFfr9wP6mjGgx5J0p7wqHzTLbND3zJerTk1uZ2y8hy3AyiIMX8a/8xc+9RQ
	QobYsUsO2EXw2wOyV2WCix1oD9uhjA98/B6N3q8tFVF9LkIgOn3V7l2D242A0HBDmEQtfCZPhZ6
	XzTu9+RomHhU+llo7GfUcfBQWym6bR/WKiURiLcCy+gZ0J8yHl1JkLQurx+uY9WsD9E5q1fFxV5
	OPu/ovwkrQKjPIu/QPnUjQ37R/5KYa4i5TCZrek5fECs6NJU0mUDbNhGgBwHNkhV/C4CitZ3DmC
	H2gjMGkktmr547OYyPMWtJyaTTPPoNPddRw=
X-Received: by 2002:a5d:6c62:0:b0:385:f677:85af with SMTP id ffacd0b85a97d-385fd53ee5fmr5431754f8f.47.1733316900232;
        Wed, 04 Dec 2024 04:55:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkIZLfFS9dd4mzise8YhuqVkFTd47qC7aw9US3336mGUo5e0+UH/rIIT1Petk2to7fPbudFQ==
X-Received: by 2002:a5d:6c62:0:b0:385:f677:85af with SMTP id ffacd0b85a97d-385fd53ee5fmr5431725f8f.47.1733316899810;
        Wed, 04 Dec 2024 04:54:59 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385ccd2e1bdsm18785865f8f.9.2024.12.04.04.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:54:58 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 04/12] fs/proc/vmcore: prefix all pr_* with "vmcore:"
Date: Wed,  4 Dec 2024 13:54:35 +0100
Message-ID: <20241204125444.1734652-5-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: du0Pnqd1hy7zPaSwmjih6yS419FyMEdJDAwj9bxoZhM_1733316900
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_045503_568981_98B4190A 
X-CRM114-Status: GOOD (  12.07  )
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

Let's use "vmcore: " as a prefix, converting the single "Kdump:
vmcore not initialized" one to effectively be "vmcore: not initialized".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 16faabe5ea30..13dfc128d07e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -8,6 +8,8 @@
  *
  */
 
+#define pr_fmt(fmt) "vmcore: " fmt
+
 #include <linux/mm.h>
 #include <linux/kcore.h>
 #include <linux/user.h>
@@ -1580,7 +1582,7 @@ static int __init vmcore_init(void)
 	rc = parse_crash_elf_headers();
 	if (rc) {
 		elfcorehdr_free(elfcorehdr_addr);
-		pr_warn("Kdump: vmcore not initialized\n");
+		pr_warn("not initialized\n");
 		return rc;
 	}
 	elfcorehdr_free(elfcorehdr_addr);
-- 
2.47.1


