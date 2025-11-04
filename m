Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED082CCFA04
	for <kexec@archiver.kernel.org>; Tue,  4 Nov 2025 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vEZHRadoqRgO4IgyXPFxluBKZrkdYFiHDtDy5XP6kDo=; b=qTYGCWif8BhTIqu8ZAXhsAcX7M
	elBhCXNv0dI9ArGXfSzOfmqw587gyG9sxu6Iiy2Qae7vPoagziZFPm42X9i8UzHmxKQJVHMkN+xSn
	JMUyrC6QUBpuJHnaDCSTQ0vOuDUkIrLrXkBlcO3345kaVr3sI9PO87EdRGOXGpdz3SQK3EHZ2mtCp
	mUE0pnroJnwBZWIz/zz4KvEeUQ6s5qJ3irG5FBjg5RubhKoGuAiW7+nfkscxBT1nB1XqAHjWR7LA6
	xt58xhgQWizGCQ3Q+J1wcemDz5stgk0db44d2BF0CKpa5UVBewWNfvOZqPSNVnUcWEcBzplMLebWu
	L7/N0pFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGI5o-0000000Bz8e-1JDR;
	Tue, 04 Nov 2025 14:33:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGI5n-0000000Bz8M-0dje
	for kexec@bombadil.infradead.org;
	Tue, 04 Nov 2025 14:33:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=vEZHRadoqRgO4IgyXPFxluBKZrkdYFiHDtDy5XP6kDo=; b=QI1ClZ2Uk+RNDjGocx8+xiBrH8
	ORbSSAk99RM1FwSFTf/4fAib+j27VW308/+KTG4vQJy4CjGorBFcxNVu4DoBBHeOS5VX61d+8cPmC
	1Zcr1z8hBMwIcDctf1D2c87Xmx6gHPEEshmKkkU8nhiTvlj80tbB4s68BVsi02DmMMXTCBFveD8Vi
	rxK/DsVQKr1eY36fwbhgud2RNf0daJdLwdAtDUFefzpG3E5xszCo4y53ge3e9yIIsqV9TwZbibCYZ
	7OB/Yh00/CCS8d+KO4aKBUrx2DcIsu61g6jC/GcJCmTxu3+UYdYhOlbKlhet737raxFApNiRGmog6
	XCy16wgg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGHE2-00000000CBW-31Eh
	for kexec@lists.infradead.org;
	Tue, 04 Nov 2025 13:37:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762266767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vEZHRadoqRgO4IgyXPFxluBKZrkdYFiHDtDy5XP6kDo=;
	b=a3AnXu1/FkKb++LmTiMut1MTYe/lFdLa0FkRKycIF1h0q40CAk8UntS8Vg4lAAbGUWq2do
	FKiBKIVWYmpfHLpqAsGbs631Qtj4Uc6dq2w3csYGtWnLisY1onhoSGtHQIOb4MWuhdxUA/
	9QOLIE8g9Gx71Oy9EFx3JHeZTRhpKJU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762266776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vEZHRadoqRgO4IgyXPFxluBKZrkdYFiHDtDy5XP6kDo=;
	b=KdkaYSTLf8mZQ3vVGs2wRMjVBqau/b0YtIj42kNqlWbKE8XFcemCD+pSh7lPj9fZhquXuX
	cGDeWbMU3t/TsOHZPZ92s0s+lobpAQVF407SGdwUCECAXNNXseCFzDPWkpcQk6mM073cwn
	qznKGbEqITt2XIkMiVspmhxodaZM4nY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-cDpk9zPXOkivnYNM_62CFA-1; Tue, 04 Nov 2025 09:32:45 -0500
X-MC-Unique: cDpk9zPXOkivnYNM_62CFA-1
X-Mimecast-MFC-AGG-ID: cDpk9zPXOkivnYNM_62CFA_1762266764
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4771e696e76so56793155e9.0
        for <kexec@lists.infradead.org>; Tue, 04 Nov 2025 06:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762266763; x=1762871563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEZHRadoqRgO4IgyXPFxluBKZrkdYFiHDtDy5XP6kDo=;
        b=uy9Ykqly3eoRwsDDAW8nfPKvsnoRpNR5GNTDTneY/swVQLsv62YqFMLzXSjhdTaBpM
         8xd/VmrfZ+EF/xkNjNATQFExGkD4e49iCcBdWzvPJEAkYe+Go8BS4+lST5AeGsH/64Ku
         Uu3rSmntNqs2u19lXw+BBBlfKZuABi64G1k6XEEJpLIdvzhCPG5I0veqm9X5JtCJXRmc
         jgoQZnCb/x4VAGA4rkDnOtfOuSLxFhRbkTnrczCPTGw7XzTsykWbNsBjgq65FeRmOrmB
         ZVC0YK4mTMi4UZ/aP0Qc2I9dI87AsgkWhgpAO3FgjuV6UqDcutq0Z535Mefb/qi5DE0s
         Gbjg==
X-Forwarded-Encrypted: i=1; AJvYcCWT44X3uCTPo79zhFUM0aCGlcvpNgy5mq/oIACFTb/MWiu+NTSR0i0UlOWWFfJDihln2lgbig==@lists.infradead.org
X-Gm-Message-State: AOJu0YwpLbutP3V92ExWzTPj0+k3pEhz1+tvW6G2ejJ+gbBDnSutRwVe
	9i0dJfB+W84jVL0lq1yBTXkpqmJUap3u1pHi8MEeRsslFVWE2rweSNFYhxIMoTo+ooHs00b2G6z
	0IgfXNTTgzWEgKrAxgJTeTDMfwAd+hC3TpraNwC4091uvIXwJZWohli+AkUg+hA==
X-Gm-Gg: ASbGncun2N6LyOmWBnBIBd81plBZAXcbHp+OlIOuoN52EvDumJVeirGTlebrvXXYWf9
	zhQtyG1J2L0m2+tLgN5lWSfcDkKTg9b5gqHmjK4tyjQ4SV3JmOlOos8e0bcabKxWN23RQDc4/9b
	TybIA0Rd4kATC1DoGjOLnNcVVdSYmt7jras5Bd6FuMdbcmjF1K47DBU++LnChGC4+b+N4nhoB4h
	px1fyvJH8yWEWAJ3IDH24vd/0eNYns5p1gfJmGHHolcz5Y/OyZVaUn0F2ENd1pxfPf9iWBs/cpm
	bwrrT7JpMl/lISCu2xcV3mgk3QpYRVACC8C/vz4dtLwc4Hd058Ja/AFVDsQQgsuwEoLb86l/Lki
	nG/kHkrWpKNlOZ3coIzbq6Jryx4kF6V7pM48VVOyWCG+ckRnX
X-Received: by 2002:a05:600c:820e:b0:475:e007:baf2 with SMTP id 5b1f17b1804b1-477308b6d72mr149701305e9.41.1762266763634;
        Tue, 04 Nov 2025 06:32:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuFO1RurfhxQ8KoSwXSsJCryYZmg5ZaBALPYzQvFuAwcNRk3r60dzVnYtxJMdeRZ/p/LV9eA==
X-Received: by 2002:a05:600c:820e:b0:475:e007:baf2 with SMTP id 5b1f17b1804b1-477308b6d72mr149700945e9.41.1762266763179;
        Tue, 04 Nov 2025 06:32:43 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558d8a1bsm18898635e9.7.2025.11.04.06.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:32:42 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: extend file entry in KHO to include subdirectories
Date: Tue,  4 Nov 2025 15:32:38 +0100
Message-ID: <20251104143238.119803-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cuEUWRR3gi-dEsd-2yXaqOl-pdEEOVNoZ3R2xA7ssyM_1762266764
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_133730_914949_285DD018 
X-CRM114-Status: GOOD (  16.48  )
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

Commit 3498209ff64e ("Documentation: add documentation for KHO") adds the
file entry for 'Documentation/core-api/kho/*'. The asterisk in the end
means that all files in kho are included, but not files in its
subdirectories below.
Hence, the files under Documentation/core-api/kho/bindings/ are not
considered part of KHO, and get_maintainers.pl does not necessarily add the
KHO maintainers to the recipients of patches to those files. Probably, this
is not intended, though, and it was simply an oversight of the detailed
semantics of such file entries.

Make the file entry to include the subdirectories of
Documentation/core-api/kho/.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06ff926c5331..499b52d7793f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13836,7 +13836,7 @@ L:	kexec@lists.infradead.org
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/admin-guide/mm/kho.rst
-F:	Documentation/core-api/kho/*
+F:	Documentation/core-api/kho/
 F:	include/linux/kexec_handover.h
 F:	kernel/kexec_handover.c
 F:	tools/testing/selftests/kho/
-- 
2.51.1


