Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA3DCF6C12
	for <kexec@archiver.kernel.org>; Wed,  7 Jan 2026 09:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w7aIEirXSlFElRo5Y92xYAouNeJKNZztucm0IeXzII0=; b=qBSTaQO6oSKCPp1wKtfE1kjcbR
	eEUPZoNrJLu7d4oph+nKYLWhnaaPwuOs4RTk2qfCbPFjA/i1s8jVWktlnBlvBpzlD1Xvt1t+UOa2T
	uq9r8I01LUL4wqfZVugtWdYIHGGk6GmWXksAkzNfRBS5ovChVYf3Cn6dMuJLlJNs3csrjXDciK0bK
	IQxS3sAHgZD7nixrldg/JrWvc9MXAkKNXsp6SY8REkJOjL9Lk7OpUHkq9eyPsElQN9UZf8MoX0wP+
	gfaSfswP/+vhs4F49gXBsIiccR370xC7WHzlsxzaKjl+iNeaWA4gLqo+XCQSpqrwt8dH265McFrt5
	TGBfDUug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdPTX-0000000ETmz-3JjO;
	Wed, 07 Jan 2026 09:05:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdPTW-0000000ETmW-1tg9
	for kexec@bombadil.infradead.org;
	Wed, 07 Jan 2026 09:05:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=w7aIEirXSlFElRo5Y92xYAouNeJKNZztucm0IeXzII0=; b=jyUsRQXS3vsavtRcRIuEWvJgKq
	DZyag/rcgYY2ZMnCEfCDD9EmX0SqgpxVO6v0o/BP9vbGWo0ZLELxXJ0p85436gESmFIa/1UFKqsTX
	ZDbtPEjcJGVyEcf5TJTylFxy5ES63sjHUdZUypH0jkTRxm+c+QVJhf3tUejHhtAlbS5YvJnMtqQ6u
	bHrCYJG15UPaA0KRFxzUMmUkdDdB4SdGEkqgLvEWkMOiiXzzCMkhCjwTYKc2JaD8duAQGmTJQJCI0
	uKoAtS1wL3rcxjDvx2zZjDIbpRXUlxf11NRH9ZBp69amoUUo8AIWJWinl3va0aP9GUiGiT8AC7y4y
	taq0U38w==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdPTT-0000000B1gr-2Dux
	for kexec@lists.infradead.org;
	Wed, 07 Jan 2026 09:05:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767776692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w7aIEirXSlFElRo5Y92xYAouNeJKNZztucm0IeXzII0=;
	b=TZi9gOcNC3yfVWFVi5QXP8Xds8oF9U8Mvh9EoH5bKkEI+clfeZI0stTCbJ1DMowCX/UAb0
	qUWcSpfLwyWWOKyczX1KkIKslUx0R3+yu6n0xEy3sUrA9stjKMX16f2ZVE/flEvnZpCMVw
	8zScP4f9CUixPN9YaT3NqWp1eSLUjPA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767776699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w7aIEirXSlFElRo5Y92xYAouNeJKNZztucm0IeXzII0=;
	b=Xp9701kkHASJnGxIs0IIYGu19ni6hUBMhiIB7WrGxlZrxPbkZN5t4+PbO9983d4ISf4wR5
	zUJtFQX/90Q/2s/LWeNO0boX6fQe6fA/sNEysfZe2WOjIMaXkolELsTyazUKckThzFtsHL
	LzG+Z9N+vxqBZAyv9EaTgOPYXub/jqw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-8ir1aZJFOrWfF_3hlTP42g-1; Wed, 07 Jan 2026 04:04:50 -0500
X-MC-Unique: 8ir1aZJFOrWfF_3hlTP42g-1
X-Mimecast-MFC-AGG-ID: 8ir1aZJFOrWfF_3hlTP42g_1767776689
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47a83800743so2778205e9.0
        for <kexec@lists.infradead.org>; Wed, 07 Jan 2026 01:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767776689; x=1768381489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7aIEirXSlFElRo5Y92xYAouNeJKNZztucm0IeXzII0=;
        b=wabonvy9fmZVA1boRAiSss3fpLgkiscvOlLcGCkWPiNM6elU5g3pTtZvBeO5gogczu
         Ae2wSPX4EDhbUTtt4l/k0FAMI1S0bEwfa5I5jXa+R9J68+PMeOKGZE4aGb4VUVcZlKYq
         znBTb0foWmi9w9gB2+llKLrkvbvxwn9xD+A6xQyX0oXGL2DJUF0UqudJHZh9m5Fs6N9b
         QCkrtEcsltQmOnpL4hJ8smAH617A6Hy620jSZNYahj6sQAg4b1IJahFc6LkKEEnNBNY8
         50BSZv3QFmCQXHQsJU9gn5ADfuR7B1s4URUpjA23nxgzg3Tmds2D5+7sFslbCl2/O1CG
         Ds4w==
X-Forwarded-Encrypted: i=1; AJvYcCWOXEp0ZWLjX82MIoF7oSqba+SeBztHuzAUV6z54lp5zzTwbREpltgyHHFVlpFZHGDeM/VNRw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+5aRxJRvfoIdGCo39oQ49HplWzLQOxI0IczJZzTcglcxdPL2X
	qEwwYQFUwBM2oR/mBKDBfM6esefLMHdDdzOnuydg1hdxck8ECJJstyn4j26s2W/a+Qll3RjX0s3
	O90lRvk8cP9fqTa3umVSEKQCxbn5nCTo/UAP1R9Vynytuat8vU3ZgNWVHYaNdyw==
X-Gm-Gg: AY/fxX4XqBXptKqoQObuUHs4z5MVv+HtZPKOjifNcyKiWGwjqmuIfgQANbvOFnUWpyM
	NcoykdGp5v7ZmbKGJ9uo89WWTDNfz7aMrG4/i16GBd6eLvFTVt+ZCh0vdMid5cmiUAltG5t/uZa
	I7po7SgAQYVYOkt124Mw7IL5cIa8g747PSBVy+xhyLTko8ZkKNZhwIl9krUaw59HbrzDbI4LPEq
	settKgQC5IHy1QHc8hzP0pH2KeHvjG00g0Yjvsc14rkFeQW9dnyfOjBe8r2IguPR6O+qZf+yV38
	6VAwiKiXmlKP+ExEmtMFSSmUy0qqSaUF3DmmooaEs/dP0TuKjeRd6Uf3PDysqOqFtaZulj+xL57
	MMmPRYavvko7QtkO1cs820ODfVTUGHY9Xw2KnJ7raGT7nDjGXtgElTSy4pFk=
X-Received: by 2002:a05:600c:4685:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-47d848787d4mr19066375e9.16.1767776689292;
        Wed, 07 Jan 2026 01:04:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBxZvbctLk8Kb75sAgCNKupX5//pUrqHmf5E4ojGAgMRxBeSVD8oZNwP8f79+dr08mpm67VA==
X-Received: by 2002:a05:600c:4685:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-47d848787d4mr19066075e9.16.1767776688814;
        Wed, 07 Jan 2026 01:04:48 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f69dsm88569055e9.1.2026.01.07.01.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:04:48 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Mike Rapoport <rppt@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION
Date: Wed,  7 Jan 2026 10:04:38 +0100
Message-ID: <20260107090438.22901-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 28kC7y-z9rdBfhYwbiVYY1v6sRaN48p2f6QtZ_oQQL0_1767776689
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_090503_726795_78F2D411 
X-CRM114-Status: GOOD (  13.45  )
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

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit e8d87911a204 ("kho/abi: add memblock ABI header") removes the files
in Documentation/core-api/kho/bindings/memblock/ and adds the corresponding
content in include/linux/kho/abi/memblock.h, but misses to adjust the file
entry in the MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION section of the
MAINTAINERS file.

Adjust the file entry in accordance with the changes of the commit above.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b28650893f2b..1ec85c68dd4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16454,7 +16454,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git for-next
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git fixes
 F:	Documentation/core-api/boot-time-mm.rst
-F:	Documentation/core-api/kho/bindings/memblock/*
+F:	include/linux/kho/abi/memblock.h
 F:	include/linux/memblock.h
 F:	mm/bootmem_info.c
 F:	mm/memblock.c
-- 
2.52.0


