Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86146CA0EFB
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 23:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eYKRiFlOu8EF9M+TMQv/SvRIppyvVm96jRE8hmTT5eQ=; b=aJyn4+gMKoJfjgLypKYTrLHgEY
	715J0oKZtjCsanttp+m+71yY0MzXta45Ih74axb93gx3d0dW90a+uisGmk6f/IS+flSePCjvYSZYZ
	JkLq2mS+LOvr/HP+pfmnv7ZztR0XPaw7lsElp2P7y82t/icOynUUB3L102RQd72eT4LePNP3KQ/IA
	zmZ7CeBRyeaq5qE7BAohCNOVNTLQsDSgpqA35tvysJvY1YeuH94Q0COtXgi5ztQZYj/APVXjbirSd
	rPZ1XdlYwNj/Jj5VRJOq/X5gqN1avEvQ8rQ2YXcCS71nJ2vr8nwClEP9LkozxoC7/LO6IeRwA+NFc
	q5s2+6wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoVK7-0000000Bo83-1sqX;
	Tue, 19 Aug 2025 23:00:59 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoTv2-0000000Bdp4-1lrA
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 21:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755639036; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ccj1jZ2PAQPAioUMpppEmhYVNIDX5ctFwd59hYS2ldS/YodtrjI8aoWj8hUcJSQyTAMG8jHwET5MC0sRN+ZOifKG/ztzYxSqgS0Op6rgrxB43EGuOqtOH2M1izX5RY47M1JTFSafwmPrQKaou9r6f7Bls9QV+3Fs/jv4BcqUt7s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755639036; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eYKRiFlOu8EF9M+TMQv/SvRIppyvVm96jRE8hmTT5eQ=; 
	b=IKh689/qsXIyXpHMPjR4tAneor9GtT9iZf6OBfTfeC4szPQC2dctY09+xaUQt07pPqT+vx5EP1jFo7DKv3Xt8ljEIrtlI65+Nvl0e6NSWo7JY+Am9htlQGjnBJNdUKOU7u5m1NaqbrFf1k7WdfqiZW7u1dduNmPPkI3OT9yXuL4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755639036;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=eYKRiFlOu8EF9M+TMQv/SvRIppyvVm96jRE8hmTT5eQ=;
	b=ZhdPFfwWWM6U6GtRXcIzhYmpp4hONNMlsXPGBJNMK/oAxiiPibujzTXE01Ec22aA
	DZUFV2jr26r3stePYpI1d3LOTpI92oY1E+HH0pz3mDFnA9BLUOKkJq6LN4qb0C8i8wA
	/BqA5nG0g74XDs0xhFqcV4LBlFdC2AONUgD+9f+0=
Received: by mx.zohomail.com with SMTPS id 1755639034718423.9148109588093;
	Tue, 19 Aug 2025 14:30:34 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	kexec@lists.infradead.org,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v4 3/6] kexec/arch/i386/x86-linux-setup.c: replace %d with %u
Date: Tue, 19 Aug 2025 21:30:11 +0000
Message-ID: <20250819213014.908757-4-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250819213014.908757-1-safinaskar@zohomail.com>
References: <20250819213014.908757-1-safinaskar@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227187ff1e67c0c4abd035f1ebd0000ed4428c0ff5b6c6d0da0c771c160c30866e7fadf3bb76035f3:zu080112275f2f49a706d83885fa5e50750000f264d21b645ec18169e1b19c3d3a9dde684b2c27a08697ebb5:rf0801122c2b9fb0615467a0ad212d20910000a523d8de4e00da3b2d6e4eb2b9303fe62166199978af249c5a6366e04780:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_143100_491077_B065F025 
X-CRM114-Status: UNSURE (   8.36  )
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

...because e820[i].type is unsigned.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 kexec/arch/i386/x86-linux-setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index c716e1b..94d9dd2 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -761,7 +761,7 @@ static void add_e820_map_from_mr(struct x86_linux_param_header *real_mode,
 				e820[i].type = E820_RESERVED;
 				break;
 		}
-		dbgprintf("%016" PRIx64 "-%016" PRIx64 " (%d)\n",
+		dbgprintf("%016" PRIx64 "-%016" PRIx64 " (%u)\n",
 				e820[i].addr,
 				e820[i].addr + e820[i].size - 1,
 				e820[i].type);
-- 
2.47.2


