Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73497C47DD9
	for <kexec@archiver.kernel.org>; Fri, 22 Mar 2024 05:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=khayg9r9JSmRUjTavhYe2UL3jl28ZkC+TxHIPDSZS54=; b=I03lZm9Ho4MQV/
	mfCOdyHNLRn5zPVtz6L0P6yCEKJAb+1Bw/cERcZc0sxcocsAJfuv//oHjCmCvJiS/1YdgyughSJDk
	fQjKks72dwkb9p3YZHzYzAAoJf/C40QsPhOoaib8fvJm5eSUudKfnGDy+yX5G9UyndGucghXDIt4O
	s/lE19HBGLBFrcExpWK/A1Q8d+awdICbmlP0Bjy570MENY+ZpMC+/iOp5zDTs5+YogtWcLM/3YjZp
	vnRKyI9hgQoHw8PSYBHNyR3UXG5LrqcHWWhd5n9phnqOdKuG8TKtbVyBJTSLcwCqbP8mAGIzDvixL
	Zv9YlC+UAvhM/NQ+8jZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnXFI-00000005oBU-1a5G;
	Fri, 22 Mar 2024 05:15:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnXFF-00000005oAp-2BiW
	for kexec@lists.infradead.org;
	Fri, 22 Mar 2024 05:15:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711084504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XN7aKzLGzOynIr0BudMXIoLSM7riB5hVf4BhIx/IKms=;
	b=LVlDQfy+I78OtVbp9aVkSZmEDuBn6Oh8X86jN+eleVmQVNS48Z+yIiQy2xNIsK5nEolJxz
	wA8VdCfT6TMRFMAABRXDSTALvn6uv2VAOqvmjlNe5BPaqBP599GjzpyyqRRGxn+Xe49k8G
	TXRrv3aKa/at7PGfadAvK1WEAHmp0ik=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-s20SBmZqMCmRz5AOcn013Q-1; Fri,
 22 Mar 2024 01:14:59 -0400
X-MC-Unique: s20SBmZqMCmRz5AOcn013Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16080380662A;
	Fri, 22 Mar 2024 05:14:59 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (unknown [10.72.116.73])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 714921C060A4;
	Fri, 22 Mar 2024 05:14:53 +0000 (UTC)
Date: Fri, 22 Mar 2024 13:15:08 +0800
From: Dave Young <dyoung@redhat.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	"Huang, Kai" <kai.huang@intel.com>, Jiri Bohac <jbohac@suse.cz>
Subject: [PATCH V3] x86/kexec: do not update E820 kexec table for setup_data
Message-ID: <Zf0T3HCG-790K-pZ@darkstar.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_221509_663602_FDF00EA2 
X-CRM114-Status: GOOD (  17.26  )
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

crashkernel reservation failed on a Thinkpad t440s laptop recently. 
Actually the memblock reservation succeeded, but later insert_resource()
failed.

Test steps:
kexec load -> /* make sure add crashkernel param eg. crashkernel=160M */
    kexec reboot -> 
        dmesg|grep "crashkernel reserved";
            crashkernel memory range like below reserved successfully:
            0x00000000d0000000 - 0x00000000da000000
        But no such "Crash kernel" region in /proc/iomem

The background story is like below:

Currently E820 code reserves setup_data regions for both the current
kernel and the kexec kernel, and it inserts them into the resources list.
Before the kexec kernel reboots nobody passes the old setup_data, and
kexec only passes fresh SETUP_EFI/SETUP_IMA/SETUP_RNG_SEED if needed.
Thus the old setup data memory is not used at all.

Due to old kernel updates the kexec e820 table as well so kexec kernel
sees them as E820_TYPE_RESERVED_KERN regions, and later the old setup_data
regions are inserted into resources list in the kexec kernel by
e820__reserve_resources().

Note, due to no setup_data is passed in for those old regions they are not
early reserved (by function early_reserve_memory), and the crashkernel
memblock reservation will just treat them as usable memory and it could
reserve the crashkernel region which overlaps with the old setup_data
regions. And just like the bug I noticed here, kdump insert_resource
failed because e820__reserve_resources has added the overlapped chunks
in /proc/iomem already.

Finally, looking at the code, the old setup_data regions are not used
at all as no setup_data is passed in by the kexec boot loader. Although
something like SETUP_PCI etc could be needed, kexec should pass
the info as new setup_data so that kexec kernel can take care of them.
This should be taken care of in other separate patches if needed.

Thus drop the useless buggy code here.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
V3: Rebase to latest mainline [Jiri Bohac]
V2: changelog grammar fixes [suggestions from Huang Kai]
 arch/x86/kernel/e820.c |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

Index: linux/arch/x86/kernel/e820.c
===================================================================
--- linux.orig/arch/x86/kernel/e820.c
+++ linux/arch/x86/kernel/e820.c
@@ -1016,17 +1016,6 @@ void __init e820__reserve_setup_data(voi
 
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
-		/*
-		 * SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED are supplied by
-		 * kexec and do not need to be reserved.
-		 */
-		if (data->type != SETUP_EFI &&
-		    data->type != SETUP_IMA &&
-		    data->type != SETUP_RNG_SEED)
-			e820__range_update_kexec(pa_data,
-						 sizeof(*data) + data->len,
-						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-
 		if (data->type == SETUP_INDIRECT) {
 			len += data->len;
 			early_memunmap(data, sizeof(*data));
@@ -1038,12 +1027,9 @@ void __init e820__reserve_setup_data(voi
 
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
@@ -1051,7 +1037,6 @@ void __init e820__reserve_setup_data(voi
 	}
 
 	e820__update_table(e820_table);
-	e820__update_table(e820_table_kexec);
 
 	pr_info("extended physical RAM map:\n");
 	e820__print_table("reserve setup_data");


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
