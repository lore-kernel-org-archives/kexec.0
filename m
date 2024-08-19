Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A894C54722
	for <kexec@archiver.kernel.org>; Mon, 19 Aug 2024 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tHaPLmupjlk74PfpfXdUk0dQlGMfNy034ok54hMHhxk=; b=nDSgSKFgPLs28d
	MRGDZ7HRACfAD/TcInLKyx6z05jlXWVEJLqvkwcDXFO+GxJQXaHGWbMiemApK5cA62q7EX0R6VnZu
	hX4EdUDFbNrxF5i2dZmLTeQ3LnpW6Z4jkjTUySvjnDgL5p0yUrg58AcqUGPzvb2DbjjaXoSuAFkHZ
	swkXg0s3eNGaV3kpWInVvBHyEAe83WF6fu4YKgQDmzLnd2duv/YwZnw9SrjhrvYDQEbRiSo9LaPJX
	jEH49CjuFoJqwbSEk1U8Gw097mqYMQXJR3f4See8bDg8WyVVzRCJnWrtQakDgz06uK1PDPYQE1ckP
	HKExYCsisiAhTEq0nFdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg3mw-00000001pwg-3duQ;
	Mon, 19 Aug 2024 14:55:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg3mt-00000001pvM-0zuH
	for kexec@lists.infradead.org;
	Mon, 19 Aug 2024 14:55:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724079314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QLgjZO4Zyjz7laVnuZPF54UYEyobsvNSUm+pwm24uBE=;
	b=Bds6FaudGw+pHWVwnQT2HwBF2RLR0IIIpICiu9vwJj59wwHTM9PUlZiIchcz344KKiurGM
	AJKmtajVL+M5lmvniC12jJOu2ZNeZukcn/7ZRehtZElG6xqYq76xxEYV+9q4Ptby7gBYPG
	HAbSKMSnfCb4X7AP8SCtvhNSPJmdw8I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-Brd712sEOlOpIfxBr1n9_w-1; Mon,
 19 Aug 2024 10:55:10 -0400
X-MC-Unique: Brd712sEOlOpIfxBr1n9_w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CCB91956095;
	Mon, 19 Aug 2024 14:55:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75D3819560A3;
	Mon, 19 Aug 2024 14:54:59 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-efi@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFCv2 2/9] efi/libstub: Complete efi_simple_text_output_protocol
Date: Mon, 19 Aug 2024 22:53:35 +0800
Message-ID: <20240819145417.23367-3-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-1-piliu@redhat.com>
References: <20240819145417.23367-1-piliu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_075515_369892_4A8DE766 
X-CRM114-Status: UNSURE (   7.80  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Some uefi applications e.g systemd-stub uses more members in
efi_simple_text_output_protocol, hence extending its members as UEFI
specification.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
To: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/libstub/efistub.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 27abb4ce02917..a075d327a11ba 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -506,6 +506,13 @@ union efi_simple_text_output_protocol {
 		efi_status_t (__efiapi *output_string)(efi_simple_text_output_protocol_t *,
 						       efi_char16_t *);
 		void *test_string;
+		void *query_mode;
+		void *set_mode;
+		void *set_attribute;
+		void *clean_screen;
+		void *set_cursor_pos;
+		void *enable_cursor;
+		void *mode;
 	};
 	struct {
 		u32 reset;
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
