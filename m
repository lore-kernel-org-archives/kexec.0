Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B662E7716E
	for <kexec@archiver.kernel.org>; Fri,  6 Dec 2024 02:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ttl1CwtbP4SFjQRadlSY7toSUolnYHuGawMYMo12aNo=; b=Wkx/invRJk430DuuOI0f/yW2bp
	08Vpcd1WKjq76bXbxYq+6SXpY24j+dh3Km8K3Gq1gw32HhHWFRB7YtUVIep4OCRnOshXQmHAj4+JG
	QXgPfchhoGd082UGcFK6Odr7VPCJ1C9xdkbajbc2B7efu/boGt6G6cfwgS7egfhj2++LLYdF/ftMC
	tmfVaTidiDpUwPskwobG/23070dZsHdwTK4eDCaCII9bZvXWt/cEtubbhq8lzdQl/WuggL+PaqiTj
	vhorxL+sgrQEf2KDub8CgKp74Rp2rc5oUijRtIjheO2SsGmFXoNMZXdSBv2TU+ulnk6gzucl63V0v
	M8lbGwng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNne-00000000IMC-3I7e;
	Fri, 06 Dec 2024 02:10:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJNnc-00000000IKl-0p2g
	for kexec@lists.infradead.org;
	Fri, 06 Dec 2024 02:10:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733451029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ttl1CwtbP4SFjQRadlSY7toSUolnYHuGawMYMo12aNo=;
	b=Gv93gwp8txdd6I+TatxbtkxGrOdiEWXyOnJih+vx7TdP5bzD/rW9bLgj86xpMz1E41ZQYE
	dTyBQbSupzbZ1glqxL2yqNIsfgGhMULKhRklx7DeLqr2Uz/+3/bEgkKzqwg+VnQJ/6DW2B
	TD9sWmJQTceDfgHSjoTqSUHTJo3EaKw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-0kv5Of60N5GYWstlNxxtVQ-1; Thu,
 05 Dec 2024 21:10:25 -0500
X-MC-Unique: 0kv5Of60N5GYWstlNxxtVQ-1
X-Mimecast-MFC-AGG-ID: 0kv5Of60N5GYWstlNxxtVQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C0261955F43;
	Fri,  6 Dec 2024 02:10:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.101])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F23E31955F3F;
	Fri,  6 Dec 2024 02:10:18 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org,
	linux-efi@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Will Deacon <will@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 0/2] Kexec: Sign Image before packing into EFI STUB
Date: Fri,  6 Dec 2024 10:09:55 +0800
Message-ID: <20241206021000.8953-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_181032_316981_35B0BC53 
X-CRM114-Status: UNSURE (   7.82  )
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

At present, the kexec_file_load of either zboot or UKI kernel relies on
the user space to parse and extract the Image, and then pass the Image
through that syscall. During this process, the outmost signature on
zboot or UKI kernel is stripped and discarded.

On the other hand, a secure boot platform enforces the signature
verfiication on the kernel image passed through the kexec_file_load
syscall. To cater to this requirement, this patch applies signature on
the PE format 'Image' before padding.

The key used to sign is the same as module sign key, and the signing
tool is sbsign.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>   
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
To: kexec@lists.infradead.org
To: linux-efi@vger.kernel.org


Pingfan Liu (2):
  Makefile.zboot: Sign Image before packing into EFI-STUB shell
  kexec: Introduce KEXEC_SIGN_IMAGE config option

 drivers/firmware/efi/libstub/Makefile.zboot | 13 +++++++++++++
 kernel/Kconfig.kexec                        |  9 +++++++++
 2 files changed, 22 insertions(+)

-- 
2.41.0


