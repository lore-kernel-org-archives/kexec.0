Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4C2C61DB9
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 08:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fIiKWqsEvZY3nxwnWYCCnPlVmDAGc6W0S6TkgE1flFs=; b=n8CTh5Lb46TfWelyotU6/GKjzM
	i6Aj4Lw6xXWt+3ehZvoj7xZIfhaell+S49AZmsd6dWetquFEFczuyP+0Ux1+6LL4uKYQbotSDxMDS
	hpaCAJjSiaQ/9mGeSv7hlVhALcUzbDZZutVcAYGBmxqi24OHkD1/dlMYyN5Eapf5L5GRDNJycxueG
	cxMnw4yl3ccgDAe+0xJUgPhJXHphqbxdpb4xUWE7bexzNfAwf6jAot6Q2Lh7vEHrrMin1imgi8RJc
	GguSvAZi2BwIYSQVfsuBwVYINfqFDK3+/TMwtowA8D8PGIF8tkhPHBzBfVxEXSA0CK4XeKGhlhI+I
	KEC7ON2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsH8-00000005LdW-0UgV;
	Fri, 28 Aug 2026 08:49:26 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsH2-00000005LVF-0vg1
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 08:49:21 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-38e041ea211so871478a91.0
        for <kexec@lists.infradead.org>; Fri, 28 Aug 2026 01:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906959; x=1788511759; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fIiKWqsEvZY3nxwnWYCCnPlVmDAGc6W0S6TkgE1flFs=;
        b=FGiKiMA4wNbuenFOU4RiafUDCLXmathe8c2HiCpvFDsk4ksx3QZATevo2ZQHYOEyZS
         rDRUa0kRdyrs2lqLLm3krl5sZF/4kR3zwO9N1kPPcHdaLLXmj0xIpdlZulYDjnWxmN9r
         o4bZW6WdJiuprSU6nT4GLEK1ppzNOaSnfeWylF2U/Rb8hoNkuIvTnKsPT9JEZ4jNmVS7
         V9UDyYtg1t75K7myt/a7x45+6GVGRVCA7mVEBsU8l5DIEJXv5gWF1r9i4n7k4DyAMd6p
         OfRSuh6UdeNl0B0o/d6H1PfZI0W5nwJYCCfhOosWLrYe724eOJLJu5Vtt0z3QjYssv4o
         CrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906959; x=1788511759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fIiKWqsEvZY3nxwnWYCCnPlVmDAGc6W0S6TkgE1flFs=;
        b=AXo3VHZsUBpY1ourc6zBCi4BiNdiXVCIr03w8K8SkNvQcu/bdV8PTRcmC28RQ1/hPq
         usCjU87d2Qn+K6VLTYqLJFFSUwuXqStEd0+wCsVxN45I7X+HZ0HbZKpVol/QK8ZOZdL9
         zGd+mL59zfTp3w2aWWM2WcSnCtYxudkzTJo3n5mVH2rBW1UDmA5jXsURXzQMLhOOiPi+
         IpO5BczWZAeuLlyTGiDXEe5fVF8+hUh/kvkwQgi4h5SSRdbrEPvY9hMTOipL8uB6ziG6
         Vy08t834Skn3vD2HzeEtUf+39H2Ouqio0uIfqp2pFKCFCmZnkI7ohpQpaST9G/35X1Pn
         Wg9Q==
X-Gm-Message-State: AFuF++kFUqpri7FC5d7SNsGQG+qymmA+Q4B3OT021beKN+2oSGSMmWx2
	zhxeITej+vbM1Ho+7NQKqfD4KTHHVdis0vFIb/ke2HrzGFjmu3kfoe+XpcBZXsL1zLA=
X-Gm-Gg: AR+sD10IkDBs9AI7nK2aKLz4l/emuLtLGjnHEB/ugF/PNdcjyg/8i9lkrpRrSaJsIzY
	0dKGpHoWOjwIlloy05w1Gu3E1LUKjhdPtSvQtqCsjb4Za9BgYLPO/XlLA0w28bmu1w48jSoYs37
	+KyaPkehmM7slJwRlbJr2PZg8JFT/ZK9nneiPzx+wFKXnjqaMsr+vJ1N9HzDvbqeByXe5ZbfPoS
	Cd0K7WbT0BRzXStLYQmfsdbJK1O7waCc9+zVkeXZQlJ1OQg11L7xXYaUIaInOyTEdtSjDCAB50n
	aHFsSs4jNe67jgs/8CBgKJF8B33TninXKKPqvfUEmYDtiUAi2WZKSnr6GqQoapH21eKlJE7q0BP
	4WmOnlUDTqxOAGC+t6wEBLZrlQt9HXmnEHJEv8cR4HE/RqrBuIwmou7zncOpAUe6kU6biKyprxJ
	usfkXLVv9WUUgX8sFikM1e0aPNlPONJ5ryNNSSdGmYt/Fd0cAGHUrb/Dmq7Nvo
X-Received: by 2002:a17:90b:390e:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-396d0fe20a7mr10169834a91.16.1787906959279;
        Fri, 28 Aug 2026 01:49:19 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:a97:707e:a14f:cfbf:3e23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0de4d92sm3843670c88.13.2026.08.28.01.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:49:18 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 4/9] crash_dump: Free temporary dm-crypt keys_header buffer in kdump kernel
Date: Fri, 28 Aug 2026 16:48:50 +0800
Message-ID: <20260828084900.1496839-5-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828084900.1496839-1-coiby.xu@gmail.com>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_014920_259600_5F9B7648 
X-CRM114-Status: UNSURE (   8.99  )
X-CRM114-Notice: Please train this message.
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

Although we expect the system to reboot immediately after vmcore dumping
is finished, it's still good to free the temporary keys_header buffer.

Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 0b9e09c60745..91b7a5413b62 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -118,6 +118,7 @@ static int get_keys_from_kdump_reserved_memory(void)
 
 static int restore_dm_crypt_keys_to_thread_keyring(void)
 {
+	struct keys_header *keys_header __free(kfree_sensitive) = NULL;
 	struct dm_crypt_key *key;
 	size_t keys_header_size;
 	key_ref_t keyring_ref;
-- 
2.55.0


