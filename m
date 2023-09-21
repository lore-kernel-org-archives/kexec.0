Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C75E7106E
	for <kexec@archiver.kernel.org>; Thu, 21 Sep 2023 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YUdDml7fzEOwlYEM8tppP2h280Rug5KDsCC3ei4I3w8=; b=MgjFCpzQb9EeSv
	X+p1bvG23LTTWNTozKcaaKIiyAn0caA8b+LVSpLnPJCbMzzq8kTfkUX3/eZPeVWJZHDOY7AbyYxVb
	QpJHXVvXXZNQlZSrqeoZB2VDx684bd6lWmIGMhRku0DVNoA4wb2UWL3JuPdS4ui6mXsQ+1J/WTASm
	CCGz9CIAt0nclAktaHXSCdyES0Tkda4iNACRdmOlLQ57XJ+NbRED0dx1QGPb9iGzRT1zmI6xnmJRc
	41s03arEUgh1xmA++CO+gJMjZsab9keyM1zUOg6dPLVwLFCFJmtSh8KTv0prQ9KX+BNpfJ1lLZ8Vz
	Ib2/tZxDvsgFOUm+1vSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjJs0-0069Co-0b;
	Thu, 21 Sep 2023 13:37:28 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjJrx-0069C5-1S;
	Thu, 21 Sep 2023 13:37:26 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso741283b3a.0;
        Thu, 21 Sep 2023 06:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695303443; x=1695908243; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s3PFsk9RxawxfMXOtaSCxuM4N0nVN4fYpqcnCn3pjAc=;
        b=kyFoJ5m4XNVoo85KQxZyzAjChvokNcnfYE009pg3hEAA1trTM2Rpjqw6zJALNJM6oG
         ZwRuiuRK0UgOJKAxfygcfDQlgJQdCh4uqicoLnCijMkeJ3F5EIRJw1Ga1xkjtCKs3xy9
         W7dRVu1feuPtIVqOoXjb3eeN6H/I1uXFk3oOPZhuQL+qAzDnHQM7rTh5bMHj3xc6x6Ap
         DXdzcbu4bKyJwPsb3QWa5Kmh6VweBh14SF2PN5xeIrmT3qmiuK+J+ukF2KSAnGfuf2TB
         rPLe68Td37+kBkfs70pM/A0oe1XMquMPrdyn78jDy6FUy3yCGkmOwlcj+ORQ/keM13Sb
         nAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695303443; x=1695908243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3PFsk9RxawxfMXOtaSCxuM4N0nVN4fYpqcnCn3pjAc=;
        b=YROlorPsWWCu1HaM3I/FHpNMX3D8VhfWfgPVUWbvsQSaQtrinY7ao6pTLJHbW8Ifu2
         QsT5JWN3YCQeIWb4KPZaPenRn4KvqFd+c9J3vSoP6Mnt4d2tehdq4uJSNSvo0EX/z9hz
         f79OJ4XxFJi5DVk29pAA8lRwEmcAn/bZsibJJKwTU4zJktelvSa3ZYeMNkitUv05kJg6
         cIDHY237Te3GwN8xZMNBudoCIcPNJ6PZ3CEEQSjYwBPc/LQlYttAo5IN9UAuZuYwYUhZ
         8j8dAyu/fg8dfO7MXMsymauMmU6X4L/pkaaSmsF2O2Wvz4l8PkgOsfHQaC/kDUeen/SR
         ChjQ==
X-Gm-Message-State: AOJu0Yyi2DNxnvV+q3PnLc3uM6dIUTAN+TqNWjhvnn83GbdAdiW25vu5
	UCJvMGw6Cn6Bqzc/aWD8m3Zo+uabbOtz
X-Google-Smtp-Source: AGHT+IHqBOWg1F4PKaT/rGEtmyVHAKj64PV6vA12DXK8x2GnhLUghr0fvSUmo/QuxpPBpHJLSaljVg==
X-Received: by 2002:a05:6a20:3d91:b0:14c:a53c:498c with SMTP id s17-20020a056a203d9100b0014ca53c498cmr6514454pzi.10.1695303443117;
        Thu, 21 Sep 2023 06:37:23 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78158000000b00690188b124esm1389785pfn.174.2023.09.21.06.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 06:37:22 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	kexec@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"Jan Hendrik Farr" <kernel@jfarr.cc>,
	"Baoquan He" <bhe@redhat.com>,
	"Dave Young" <dyoung@redhat.com>,
	"Philipp Rudo" <prudo@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 0/2] Sign the Image which is zboot's payload
Date: Thu, 21 Sep 2023 21:37:01 +0800
Message-Id: <20230921133703.39042-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_063725_496378_BA5D75F7 
X-CRM114-Status: GOOD (  10.30  )
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

From: Pingfan Liu <piliu@redhat.com>

I hesitate to post this series, since Ard has recommended using an
emulated UEFI boot service to resolve the UKI kexec load problem [1].
since on aarch64, vmlinuz.efi has faced the similar issue at present.
But anyway, I have a crude outline of it and am sending it out for
discussion.

For security boot, the vmlinuz.efi will be signed so UEFI boot loader
can check against it. But at present, there is no signature for kexec
file load, this series makes a signature on the zboot's payload -- Image
before it is compressed. As a result, the kexec-tools parses and
decompresses the Image.gz to get the Image, which has signature and can
be checked against during kexec file load

[1]: https://lore.kernel.org/lkml/20230918173607.421d2616@rotkaeppchen/T/#mc60aa591cb7616ceb39e1c98f352383f9ba6e985

Cc: "Ard Biesheuvel <ardb@kernel.org>"
Cc: "Jan Hendrik Farr" <kernel@jfarr.cc>
Cc: "Baoquan He" <bhe@redhat.com>
Cc: "Dave Young" <dyoung@redhat.com>
Cc: "Philipp Rudo" <prudo@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
To: linux-efi@vger.kernel.org
To: kexec@lists.infradead.org


Pingfan Liu (2):
  zboot: Signing the payload
  arm64: Enable signing on the kernel image loaded by kexec file load

 arch/arm64/Kconfig                          |  2 +
 drivers/firmware/efi/libstub/Makefile.zboot | 23 +++++++--
 kernel/Kconfig.kexec_sign                   | 54 +++++++++++++++++++++
 3 files changed, 76 insertions(+), 3 deletions(-)
 create mode 100644 kernel/Kconfig.kexec_sign

-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
