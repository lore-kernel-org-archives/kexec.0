Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA49EC54E49
	for <kexec@archiver.kernel.org>; Tue,  5 Mar 2024 01:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Vx2AzsktnrezZ8ANhk2RIOiMSFa7iGysOXgTY04h3v0=; b=bWSDMcFaOrmgLU
	RyARQduGwCFhpXe4Rp2Szs4YPxD2cQbOB/1Z31AIhNUWcQMqnG6NU714OqDDsF/NTTU7jTESEZ1dD
	RFoWZTbnqGOLGtSE/7ssS20w+Kq+/CDORcTVGscvPZLgysa0GO75F2xhcN3jgePcTvHq+aBza+28x
	qDUB6QJG7NVAjlw9RKY9QEgGkO5eOsZ0Fvtt/3A5IFDVAUqfGsg/uc0+WOVrJ7XMi+Clsf5auFktC
	WP3n5mYUhIbJUNHCzTRqRduIFnBIAXgJ/aIAGA/04bDCN7jxLyYA0Uw7eSuEtFNnP3SjmZEN8EhGb
	x8k0bPQhGLdX0PnkyZ/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhJfY-0000000BOWb-0TdK;
	Tue, 05 Mar 2024 01:32:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhJfN-0000000BOUv-3RKS
	for kexec@lists.infradead.org;
	Tue, 05 Mar 2024 01:32:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709602342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=i/7fD3ZNVp6TPhlanN5HBpulg6yBRQ6/2SajNxpxQMU=;
	b=MEhCAJMLNK4O/I5Qo4nB6/FkYlsfUlxolMHVwVYuehxwp7j4gY/YgghLjeMVWCXILHIbuj
	+zlZBT+EYQ/BMBcsVvvmUHaqjHDKjMjg1D0K46dPS9KvXuD59FD4BHoDfI85YuiSGRoxR9
	bDfHLIQHLEgrKOUINcBIVO9d9YicyLI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-jFOecq4CM7O7pIByyYL5TA-1; Mon, 04 Mar 2024 20:32:17 -0500
X-MC-Unique: jFOecq4CM7O7pIByyYL5TA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 319E5862DC0;
	Tue,  5 Mar 2024 01:32:17 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.116.39])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B233492C1B;
	Tue,  5 Mar 2024 01:32:11 +0000 (UTC)
Date: Tue, 5 Mar 2024 09:32:26 +0800
From: Dave Young <dyoung@redhat.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH] x86/kexec: do not update E820 kexec table for setup_data
Message-ID: <ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_173226_116748_918B66B8 
X-CRM114-Status: GOOD (  17.49  )
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

crashkernel reservation failed on a Thinkpad t440s laptop recently,
Actually the memblock reservation succeeded, but later insert_resource()
failed.

Test step:
kexec load ->
	kexec reboot -> 
		check the crashkernel memory
		dmesg|grep "crashkernel reserved"; saw reserved suceeeded:
		0x00000000d0000000 - 0x00000000da000000
		grep Crash /proc/iomem: got nothing 

The background story is like below:
Currently E820 code reserves setup_data regions for both the current kernel
and the kexec kernel, and it will also insert them into resources list.
Before the kexec kernel reboot nobody passes the old setup_data, kexec only
passes SETUP_EFI and SETUP_IMA if needed.  Thus the old setup data memory
are not used at all. But due to old kernel updated the kexec e820 table
as well so kexec kernel see them as E820_TYPE_RESERVED_KERN regions, later
the old setup_data regions will be inserted into resources list in kexec
kernel by e820__reserve_resources().

Note, due to no setup_data passed in for those old regions they are not
early reserved (by function early_reserve_memory), crashkernel memblock
reservation will just regard them as usable memory and it could reserve
reserve crashkernel region overlaps with the old setup_data regions.

Just like the bug I noticed here, kdump insert_resource failed because
e820__reserve_resources added the overlapped chunks in /proc/iomem already.

Finally, looking at the code, the old setup_data regions are not used
at all as no setup_data passed in by the kexec boot loader. Although
something like SETUP_PCI etc could be needed, kexec should pass
the info as setup_data so that kexec kernel can take care of them.
This should be taken care of in other separate patches if needed.

Thus drop the useless buggy code here.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/e820.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

Index: linux/arch/x86/kernel/e820.c
===================================================================
--- linux.orig/arch/x86/kernel/e820.c
+++ linux/arch/x86/kernel/e820.c
@@ -1015,16 +1015,6 @@ void __init e820__reserve_setup_data(voi
 		pa_next = data->next;
 
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-
-		/*
-		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
-		 * to be reserved.
-		 */
-		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
-			e820__range_update_kexec(pa_data,
-						 sizeof(*data) + data->len,
-						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-
 		if (data->type == SETUP_INDIRECT) {
 			len += data->len;
 			early_memunmap(data, sizeof(*data));
@@ -1036,12 +1026,9 @@ void __init e820__reserve_setup_data(voi
 
 			indirect = (struct setup_indirect *)data->data;
 
-			if (indirect->type != SETUP_INDIRECT) {
+			if (indirect->type != SETUP_INDIRECT)
 				e820__range_update(indirect->addr, indirect->len,
 						   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-				e820__range_update_kexec(indirect->addr, indirect->len,
-							 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-			}
 		}
 
 		pa_data = pa_next;
@@ -1049,7 +1036,6 @@ void __init e820__reserve_setup_data(voi
 	}
 
 	e820__update_table(e820_table);
-	e820__update_table(e820_table_kexec);
 
 	pr_info("extended physical RAM map:\n");
 	e820__print_table("reserve setup_data");


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
