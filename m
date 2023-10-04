Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9573DE936EB
	for <kexec@archiver.kernel.org>; Wed,  4 Oct 2023 22:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6Qv/S/2Klcc97VK7hq8B178xEHlj6yJMlA+R1WLKZwg=; b=LFFiBgKK9xzK3s
	R2sORs0UXGUW2GGVdMzUsNseumOtxW5yD+PO1Ggad03oMDuEfOXNX5oZdZKD7Ph96eE7c35WwTn05
	dwsiUAcYTF9wPGRU9kesc6U8ssxiopmjYV2q7Kv1EmZGxl09VN4/IuXbzolGFfWxqryS1xGozpDKY
	fCdeH9y6NBu63TbWnQv2Xxtjz0BcTUohmbBUEq9hewTXyHs+Fwycnt+RZIuP76qo5U4qhZM1lkLNJ
	gh+9Te9Os/u5fWNDJn8Rc3N38Wm6gcziLhdZnFlsTuOVns342fgmbglfik8AMe/089KfG3uiVU3f0
	GNm+TvNaHWmKVUSuJ9ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoAH1-0010IU-2X;
	Wed, 04 Oct 2023 22:23:19 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoAGz-0010HQ-2Y
	for kexec@lists.infradead.org;
	Wed, 04 Oct 2023 22:23:19 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7781420B74C2;
	Wed,  4 Oct 2023 15:23:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7781420B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696458196;
	bh=ycFAv0PCBQmDgiC3b/2+OMlEJBzxcUfQc48aiL7bf3M=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=QbSVwGL5m1YV4ZHlI7tRceJRWnWKXfuvjkrkM6T3QHhhstHPuzxjz07qTLxANFrZk
	 Et3OvrVSC5lRKgTv2fB8uTv8CcmDbYXQ6OSnLKsopKQZg69XmRcsJ0SIvj/Rpo1/lr
	 pygBF8mQ5e3QBv3q3CjyepJosWZjhUMMCLIGYcbk=
Subject: [RFC PATCH v3 1/3] x86/boot/e820: Expose kexec range update,
 remove and table update functions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com,
 bhe@redhat.com, dave.hansen@intel.com, kirill.shutemov@intel.com
Date: Wed, 04 Oct 2023 15:23:15 -0700
Message-ID: <169645819587.11424.5389114333710932782.stgit@skinsburskii.>
In-Reply-To: <169645773092.11424.7258549771090599226.stgit@skinsburskii.>
References: <169645773092.11424.7258549771090599226.stgit@skinsburskii.>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_152317_947213_DF8A0495 
X-CRM114-Status: GOOD (  11.44  )
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

This functions are to be used to reserve memory regions in kexec kernel by
other kernel subsystems.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 arch/x86/include/asm/e820/api.h |    4 ++++
 arch/x86/kernel/e820.c          |   21 +++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index e8f58ddd06d9..24bb8da928bb 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -22,6 +22,10 @@ extern void e820__print_table(char *who);
 extern int  e820__update_table(struct e820_table *table);
 extern void e820__update_table_print(void);
 
+extern u64  e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
+extern u64  e820__range_remove_kexec(u64 start, u64 size, enum e820_type old_type, bool check_type);
+extern void e820__update_table_kexec(void);
+
 extern unsigned long e820__end_of_ram_pfn(void);
 extern unsigned long e820__end_of_low_ram_pfn(void);
 
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index fb8cf953380d..f339815029f7 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -532,13 +532,12 @@ u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type, enum
 	return __e820__range_update(e820_table, start, size, old_type, new_type);
 }
 
-static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)
+u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)
 {
 	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
 }
 
-/* Remove a range of memory from the E820 table: */
-u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
+u64 __init __e820__range_remove(struct e820_table *table, u64 start, u64 size, enum e820_type old_type, bool check_type)
 {
 	int i;
 	u64 end;
@@ -553,8 +552,8 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool
 		e820_print_type(old_type);
 	pr_cont("\n");
 
-	for (i = 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry = &e820_table->entries[i];
+	for (i = 0; i < table->nr_entries; i++) {
+		struct e820_entry *entry = &table->entries[i];
 		u64 final_start, final_end;
 		u64 entry_end;
 
@@ -599,6 +598,16 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool
 	return real_removed_size;
 }
 
+u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
+{
+	return __e820__range_remove(e820_table, start, size, old_type, check_type);
+}
+
+u64 __init e820__range_remove_kexec(u64 start, u64 size, enum e820_type old_type, bool check_type)
+{
+	return __e820__range_remove(e820_table_kexec, start, size, old_type, check_type);
+}
+
 void __init e820__update_table_print(void)
 {
 	if (e820__update_table(e820_table))
@@ -608,7 +617,7 @@ void __init e820__update_table_print(void)
 	e820__print_table("modified");
 }
 
-static void __init e820__update_table_kexec(void)
+void __init e820__update_table_kexec(void)
 {
 	e820__update_table(e820_table_kexec);
 }



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
