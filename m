Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E161DE7E361
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JpVYK1kYMsSmb0glYSul7QEcfCfzZZ/MPpQITA6+2SA=; b=FUrOOVvHDBDKscSS8XsoMHUVrt
	rdCfUokTIGHFZBd06CiT4sRFki55HEEGSa/n0rkW5fn+j1GoENqU1ZpSrV/Ez/swchWUH1a8gijlj
	tGKcKcJvP1uvcu4XsXWJuG6bBal+SYeTTPvlZrZYKSu/ocSZj31K3VfvyZiyhxmB9AuNC7jIosHnd
	l/yFw6cJ2vVL/00zjig1T20LPcWs10QAvia8S1BbNMSWInBu6TpEex4UzUaWRAX5Tsm8RRYlUhQuI
	dCU+rmAmomKraDPKLWhkRUTJl5WYndmH5AzE4WE5EKop6psyMcswDf/A6p+YZdlg5LTjqimPMoYdF
	0g3cEIVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8bLN-00000001rGw-0bAF;
	Fri, 03 Apr 2026 10:01:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8bLK-00000001rGY-18B4
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 10:01:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775210493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JpVYK1kYMsSmb0glYSul7QEcfCfzZZ/MPpQITA6+2SA=;
	b=XZ+AlJBtocAuIVptxjk53rk52LB4aNCJnQnQiZu062EiY0h+O576du/Gtftll3bMDsboqJ
	dA+dbKqQGe8REWyrqCjQkZjRBwxwu5l5blQzOOUqcS81rTF75T+Neh13laVXEdTtrh3yG8
	HWhZi1IpVyUubbZ5LIj3uYEJVoaC2wM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-JlPm4b6vOx-u6xlWgxJcQw-1; Fri, 03 Apr 2026 06:01:31 -0400
X-MC-Unique: JlPm4b6vOx-u6xlWgxJcQw-1
X-Mimecast-MFC-AGG-ID: JlPm4b6vOx-u6xlWgxJcQw_1775210491
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b0cf396c45so19500995ad.1
        for <kexec@lists.infradead.org>; Fri, 03 Apr 2026 03:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775210490; x=1775815290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpVYK1kYMsSmb0glYSul7QEcfCfzZZ/MPpQITA6+2SA=;
        b=ajOyEPf8SOHtOGzMZaDC+ik17/TF6I0vEfasLWndipdqFGJAJiMr1zpj5Y2DqDE8KU
         9S033OEfmKaYfwQNzUYW3lsSGPJR9OLwwQLGNCWv75qJiVdWjwWIJyyDiHXr0Cwd7Utx
         Wjf3z6Mhw75MvHQ/+9e97zTf4WjrbSiHwykG5SRI0mCUIFh7F8tu2mKOScEZIBanx9wy
         z+od8o2NNNCrUt9zc58Qw9e2JKlX9GaQTvQMbRrSLc7zv2O3u6XL/M2r4puFS/UnJskx
         Tbz+ntUCNQW/RDTfYXus0OVtZr87qJQHAF5b7TP8wAxryp6flu4pirJLIKvG41Nej6TE
         KSdw==
X-Gm-Message-State: AOJu0YzdeR8U/dDMx6djfryJRU1CIMfXfaH0LjrofD2N9nXNsZOgPhNY
	WaL+aF+Nkcmz0xfIz/Da+W8njT0e3bZID5kAoOpFtOEID8ZRmWXLlk3zrxCZs5uEU9/xX9IJc9N
	o3zNxqhfG1xOLEFwI5i+tUkSCzA4Ve+qI/3KSpCCz726o8rthhefBGsmggV8iH4crBPQOWRD0of
	ceDplEDAe9dvCkmw1qjSNtdYC5rHNVYnNy9hBeEcEgsOo=
X-Gm-Gg: AeBDieu4hYuRI7Ec8UauMQBnK6Rs+3JRnw8g37Ws+2AwjsGgsSaIz4V3PIN308Qthyq
	5Mga6jyC2PpyXJ4qb5GZPT8zQ7E64yxvAUx204ty6PvUHWZPjeJHx0llRDjRoczw5tklgHh68+l
	HeMoT72+sWJA8MxXFDtqQlqetNnvdEvaBvt5Gb4LkLnMDrLidyecqklULtvl5k1IVVaIEBHgtfx
	wSuEzkw1ssCE/XCmo01W8te8R+NKOGAPFPSrzTBdDlzV7kmmLYqIsewtKhJMkNh5JeQDGq2swiF
	QULzG70zCwGA2yzaP+fFdurafsoTNlqde9OmDRVskkBRXjfvEO21jOg7Tt8GiwiVBdCLxk4f9lI
	RizMJBBkF1Hqy
X-Received: by 2002:a17:903:94e:b0:2b0:7026:24bf with SMTP id d9443c01a7336-2b28180530fmr27122925ad.14.1775210490274;
        Fri, 03 Apr 2026 03:01:30 -0700 (PDT)
X-Received: by 2002:a17:903:94e:b0:2b0:7026:24bf with SMTP id d9443c01a7336-2b28180530fmr27122265ad.14.1775210489564;
        Fri, 03 Apr 2026 03:01:29 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a1e9csm58846095ad.55.2026.04.03.03.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 03:01:29 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] crash_dump: Fix potential double free and UAF of keys_header
Date: Fri,  3 Apr 2026 18:01:25 +0800
Message-ID: <20260403100126.1468200-1-coxu@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9x_0s9pIL7EH2WsYZ_RGr-j05FaBAmIyrZMHPa--Svs_1775210491
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_030134_407046_4A3DA4FE 
X-CRM114-Status: GOOD (  12.49  )
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

If kexec_add_buffer fails, keys_header will be freed. And depending on
/sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
following two problems if the kexec_file_load syscall is called again,
  1. Double free of keys_header if reuse=false
  2. UAF of keys_header if reuse=true

Address these problems by setting keys_header to NULL after freeing
kbuf.buffer and re-building keys_header when necessary respectively.

Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
Cc: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 kernel/crash_dump_dm_crypt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index a20d4097744a..92eebef27156 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -417,7 +417,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 		return -ENOENT;
 	}
 
-	if (!is_dm_key_reused) {
+	if (!is_dm_key_reused || !keys_header) {
 		image->dm_crypt_keys_addr = 0;
 		r = build_keys_header();
 		if (r)
@@ -433,6 +433,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	r = kexec_add_buffer(&kbuf);
 	if (r) {
 		kvfree((void *)kbuf.buffer);
+		keys_header = NULL;
 		return r;
 	}
 	image->dm_crypt_keys_addr = kbuf.mem;

base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
-- 
2.53.0


