Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A59CD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vsy43cKdjjquhJVv3pJ2fPEZtWZ9VhRxjDQaQqinW+s=; b=FzjbYN2yqbqvt6sBE3SxZraIf9
	wQIStaC538ty35qFCbr70E3rBWO6SNUFvf9slK5qgkgp+AsZIdI1wKxegso7xlROO7lthQe0Y86+m
	Kxa3DoGwd2uf5AQFYcMYjq5p1XTunX5pUQS6FSXCFkRcGtkRK6/4fH8kFs1xd5GQtgOLk1UcW1Lom
	Z6VhXXLm15m7SjdHLN9m6Jy1oa87kxt9t9s85NzvFqiL5iOsjLYAlulPhE1gMsa+3YE9c5zDMnRL4
	kq6Ob4yDTGpCQhMVfcrq6TzYCKtGImH1IVDqUI3QgHmHC+TAxvB3ykxfNdYLJcYJk/QHYw5kCnUtD
	oXL0vD6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzrd-00000009TAl-22Qm;
	Fri, 15 May 2026 21:14:33 +0000
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzra-00000009T8P-2nl2
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:14:31 +0000
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso1354201eec.0
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879670; x=1779484470; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsy43cKdjjquhJVv3pJ2fPEZtWZ9VhRxjDQaQqinW+s=;
        b=LatJamDMoaGW8XToLLzEZzbKT6VG3PT9GXnS1K+tT4OhjFoRYny5CRqrJ5Djb1roNj
         GB7TrnfcYCPhACuTjBTlzwMuYLmH2mFI2J9SdpFJESERrduMKLVOnvYlUwhT/YSF4pa2
         UTl2Cj0uId2g7cT2pZ/3C/3FZytvTrlAkmRqAsDg89lge88MBn1uo5brRWLFm2Kwx6gr
         kc+9r1GqjPWxqyASgEYQbEYb1Zx6H8nlLr3R0f52HSibccInC4reiAMf+VyW1+u1TPvS
         mE4JB2ndHMCVNjoVUiby2/Wt1lIxZRAb8Dnc4SrLeEZ1nDrua/sszy7pzZWhqm/UkQIv
         dYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879670; x=1779484470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vsy43cKdjjquhJVv3pJ2fPEZtWZ9VhRxjDQaQqinW+s=;
        b=LiGIIcP5pXpGfeM64V2NY+JrikWtG51l+YqJ4C2TWjriwiqwR+lI/dAqIHpYwTeK9w
         bvRdKK4oGkRsAGGX6DmhJS/Pwu61K64B/9pJYHPJve3dD0he/29QqHGsrb/FlMU5iAtW
         abasiGClwrqjENIk4KTYvFe38A6l7PglAOu7hnT+SGOSVIRSGMzVfgDwU8ib6IWaqs9a
         WBg2w0m48ba4T3roAW/dNBFRD5IcxomKpPdzD7tChbkIN010UnVF5lRRHvGdFumsVu1O
         SQcFOAOlZz1VZUY/GklJC6T81qTCI8DfFoYV1Wknz/Gou4PtDq96S+GLyCntqjoOGP0G
         uGRw==
X-Forwarded-Encrypted: i=1; AFNElJ+sRqhQfScxao0HHTT4qog7Fik8vl6KjO3JiARFKNpY6Wbv6nNkwDPhXFdJE2vigHWG3aqh4Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YzFhLVu0biZfcIwxgJrkDLFasn8Fg1h8mei0zle7JbgvgLAWIPb
	/oX05YfJVlNxjgGebujVwD9I/U0Z28XxS9rb/6H+p/1sX0E8xKZYWQyB
X-Gm-Gg: Acq92OH3eXEBBiP0bSioYT+4Yhcq4bx3n26VqaAYRsp/x/coaFk2BGHpRu4NyGrA4lK
	Xp+pjuTXHkkuDJ0GTf/8+zYvsxVgsnGGS56bNn9JDlSRnk424VqVERJHMTwA4WL4lBMP+NXNiFy
	m4wYsWj4i6xYbW+KCGguacledFBCvNB0/7FpocREXdrhMjaTBamAX0p15NRRiEc/yvLuNbjfECo
	7AlGmLEN9XUqkXnXbci7angMu4Nr4iqHhFv66jwPVkejPFH/CvUXTsx/6ENq6FqZ70kILB5TVMe
	cnDdRhU2m/ocG3pYsaKKFVU58n6IezJu98RSR1v5NCA2m5Fyz8Ok25bUuSNQUS2xONGP9nm2Gk+
	gIqeHxUlC7b65+kwPOngTBOQfivBpRH36yZrW5wJxg71h1Jf333uKhV9klVMztG6fMaxv58ECgu
	msamkFSDt8uoQICieh8NmgBZdFUZca5hs=
X-Received: by 2002:a05:7300:e6c4:b0:2ff:c84d:44d2 with SMTP id 5a478bee46e88-3039815cae2mr2917959eec.12.1778879669685;
        Fri, 15 May 2026 14:14:29 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b3cb2sm10323215eec.30.2026.05.15.14.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:29 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 06/38] tpm: Remove main TPM header from TPM event log header
Date: Fri, 15 May 2026 14:13:38 -0700
Message-ID: <20260515211410.31440-7-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141430_752888_C8DEEE9D 
X-CRM114-Status: UNSURE (   9.42  )
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

From: Alec Brown <alec.r.brown@oracle.com>

Allow the TPM event log functionality to be used without including
the main TPM driver definitions.

Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 include/linux/tpm_eventlog.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 891368e82558..367b70ecc4b1 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -3,7 +3,9 @@
 #ifndef __LINUX_TPM_EVENTLOG_H__
 #define __LINUX_TPM_EVENTLOG_H__
 
-#include <linux/tpm.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <linux/tpm_command.h>
 
 #define TCG_EVENT_NAME_LEN_MAX	255
 #define MAX_TEXT_EVENT		1000	/* Max event string length */
-- 
2.47.3


