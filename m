Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64FCC02182
	for <kexec@archiver.kernel.org>; Thu, 23 Jan 2025 06:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9GWnA6cQazWu1ukn6JyrCDn9phCCCsDqKbbThQSvZEM=; b=EHOSp6Q7ujXaxq3i7MGptuE/Vo
	bNFwB1dGfOkvHXTS4RSmYejai6Ki/Z7Jf4I71xY2EWFozhjox63egHu4bpPqgZorFZJGxb0WFm62x
	uEOiwVkX40Lk0iPqJ6FXQmEra0vdXRqBcDzgZsGIkfV910Q7wRf+nfNxKgpaBtapL/z5drhSCwWwN
	H0RS9AnyGWxqK0pQrCTYQos+AayJqLiBRqyq68wpOILmTcZ0mcQAHeMNNwnEmow4uC758+coVYEFz
	WoQOLb7UE3G03uA/I/YvjewNSlzFNG++mo/pwd9NlyRMDw+jNpBRqMc5fQDTvjZkPmbLzhETbtHme
	Q62Tk5jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taqr1-0000000BoMi-0v7e;
	Thu, 23 Jan 2025 06:38:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taqqx-0000000BoMC-1fsD
	for kexec@lists.infradead.org;
	Thu, 23 Jan 2025 06:38:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737614289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9GWnA6cQazWu1ukn6JyrCDn9phCCCsDqKbbThQSvZEM=;
	b=ZlZIKx5O8L+LzjLvAXzwETvy+zydgDybTP5qut/ePMVc4MGCbSOdlEepTb848Q6qkzI5vS
	PO0YwBb8Hbgzfohna9VDE2h9P3DSFvdtx5G0mHLE+T2r7bHzHhV3K2LHce72a/fhkDQM0F
	RSYW32uEL0xHJ0cZmxOrZ+v0+6j8PWY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-4SHC3acIOBiWlyhUCODqXg-1; Thu,
 23 Jan 2025 01:36:32 -0500
X-MC-Unique: 4SHC3acIOBiWlyhUCODqXg-1
X-Mimecast-MFC-AGG-ID: 4SHC3acIOBiWlyhUCODqXg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E49F195396F;
	Thu, 23 Jan 2025 06:36:18 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.112.125])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2F89195608A;
	Thu, 23 Jan 2025 06:36:13 +0000 (UTC)
Date: Thu, 23 Jan 2025 14:36:27 +0800
From: Dave Young <dyoung@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	Breno Leitao <leitao@debian.org>, kexec@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH] x86/efi: skip memattr table on kexec boot
Message-ID: <Z5Hja30Wb94uGQ3L@darkstar.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250122_223811_563109_480452A7 
X-CRM114-Status: UNSURE (   7.54  )
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

efi_memattr_init() added a sanity check to avoid firmware caused corruption.
The check is based on efi memmap entry numbers, but kexec only takes the
runtime related memmap entries thus this caused many false warnings, see
below thread for details:

https://lore.kernel.org/all/20250108215957.3437660-2-usamaarif642@gmail.com/

Ard suggests to skip the efi memattr table in kexec, this makes sense because
those memattr fixups are not critical.

Reported-by: Breno Leitao <leitao@debian.org>
Reported-and-tested-by: Usama Arif <usamaarif642@gmail.com>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Dave Young <dyoung@redhat.com>

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 846bf49f2508..553f330198f2 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -561,6 +561,11 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
 
 		if (!efi_guidcmp(guid, SMBIOS_TABLE_GUID))
 			((efi_config_table_64_t *)p)->table = data->smbios;
+
+		/* Do not bother to play with mem attr table across kexec */
+		if (!efi_guidcmp(guid, EFI_MEMORY_ATTRIBUTES_TABLE_GUID))
+			((efi_config_table_64_t *)p)->table = EFI_INVALID_TABLE_ADDR;
+
 		p += sz;
 	}
 	early_memunmap(tablep, nr_tables * sz);


