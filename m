Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99308CD4F25
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 00:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BlG8LpAFp+hKa95DX8x1G7ey+RY4RgJIzHYj7htm+bo=; b=o6yM0TDcGkZ2eyjdYFuwsSwHTM
	yMQmFkt01tKEIlJq1XLtYIiWOz0puu5KveM2vcuZS+4f6llqmtsbLfvQsX2wWJd/EmuXypwjA3Z8Y
	xvcPFby6XN5Ajn0gr2kmTygCHjROeEl76aMTtdhF2NhcYobVxf/NzL+pMFuZtMxZ9gJirvA7QBIuB
	w15ouC9ZNp4cReFHARy2S9KcJ3fKRsl2OLhHghnByrVeRkkLdqixeUD9dAJ9Cdy/I3TNp6BQ2btj+
	g4jyM7RI4NrrxKb21o/5YyqeNlkoNX9AIwBaYJpQLogyL9KqNhawPhYhOGEOk6h/uGfH78KssvfVs
	0lSKzZ9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgYZ-00000006vrV-3CdD;
	Fri, 15 May 2026 00:37:35 +0000
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNgYX-00000006voe-1VsG
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 00:37:34 +0000
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-8b821f39a12so68775546d6.2
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 17:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778805452; x=1779410252; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlG8LpAFp+hKa95DX8x1G7ey+RY4RgJIzHYj7htm+bo=;
        b=QdSK0qpR8GLmqjq/OiA8q14WHTVI2rdNiAFyupOK/+KxHfHBqsBL5km2CA4R0ur8OB
         ufTBOSf5XX+XzrAC5S7InOGKP/0CLc5/u5hr9riosLZkMEbujShhfyFZvXwVIKaBp+AJ
         2nXPyl/Ldsb1VEsJTwpgCFocbbkcgWO8tDsXhYXX8n9yu9AawwO3RTTqw17YzRrVaE+e
         XGsI79/wC/K4hFyo1AM0EwSLeBTGElHIyYpx2uaKy8ybl7ncLGgBBaD7A7KYqLPId+gq
         9zulussjdX+x6+n4dTtC931jqFdhnGnlBq+T8EbL4sajOsaSvtN9izU0foIhBHDBfPH1
         EE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778805452; x=1779410252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BlG8LpAFp+hKa95DX8x1G7ey+RY4RgJIzHYj7htm+bo=;
        b=m8eSzpYHRGIatkn1oPc9yakfIckK08edaETP/+DJWdP44iOa/SPkEegdCHYulRhkpM
         VEmYTF5DAbRYaC6wxhvKX+qYgrj5q5WDaRHrW146emnPRH9/EbzjkGYR6TdpMIpuB+co
         E3fcA4RuaW6mih/2EG/HAk26fqB1xbtDjnesHE6ukejk8mm0bX9b8IyLq+pi/uTmOqGj
         tyt3HgyzCs88QdjFeJQ7BWAeld/+AhnqCFLmWmeq2X7yRs9pGg0ov5YDVRn23HmCWmFw
         eP4jUTIsm7NSYVjmdBNBRotbMzd3QCpzXGl+tBC88JG/WNeHqcnr4d5pAU6TDd5LkhUl
         fWCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LpZr3lJ9CFbYUxVUO7u9f5lgDPomPEVyEBA8m7MloQOSPJmnXy9LxMXSSVN514xPiss4abA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzlcJaLO/MvzsO9fFFzVlqPgLUvhbxyVOiBLEoJMsOwEY2u7WLL
	27JL1o0s3rp7Y3iqZhZEGWsYB48uVhSjcetid2dG97DHdcPvLVX4xB4zypvwkFL+2mY=
X-Gm-Gg: Acq92OH9ep8pTC2h0VL4YZ1rh/GRmOBqoJY47Up2s6pJur6UvWmtVVnNWz0UmMx3yuA
	FU0LC26Lnd6DDEH7vO1KWk983oyxfaVVWem9odSIFU7IB7D9A494bESlKJrTZ7ZyT2r8jYLhYDy
	HcOKA2wzItO34QSuffgkbikJMz9jiQ6f3FG3PdkhafFQ2yw7s9QqOeqyjXV7NWmfpVHnpwOMo+b
	D4LMFmMGyfsVffEWQq+hkjSYmxCopNeJ9deSVgC9se+Nvo4q/ZVLy6OPEDcM/GKZ3M5wc2D1Yw5
	4A/eczio/iDDB5ZRKODJVyuad+S17bGVmeaJzFX2v/dQGrIBVBmp5rHz2IPHBgQPERHTLabZbv1
	sFe6OXy+rru/YbqrauRYY/wcPsMxqpvbQhXz5n0bZZgvCDvITt/5FWjK7aDHvub7oy78o7+uGT0
	1QHSWhTV1qR85cA8YLDSQvGM5AYYV3uKVY4HKHGO/VNRNcZ2J5Bvw=
X-Received: by 2002:a05:6214:5a05:b0:899:f24d:1245 with SMTP id 6a1803df08f44-8ca0f6bda7dmr38872236d6.43.1778805452230;
        Thu, 14 May 2026 17:37:32 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c16366csm36918236d6.40.2026.05.14.17.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 17:37:31 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: kees@kernel.org,
	rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v3 5/5] liveupdate: Remove unused ser field from struct luo_session
Date: Fri, 15 May 2026 00:37:22 +0000
Message-ID: <20260515003722.938123-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515003722.938123-1-pasha.tatashin@soleen.com>
References: <20260515003722.938123-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_173733_409511_FF995238 
X-CRM114-Status: GOOD (  10.86  )
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

The ser field in struct luo_session was intended to point to the
serialized data for a session, but it was never actually utilized in the
implementation. All serialization and deserialization logic consistently
uses the pointers maintained in struct luo_session_header.

Remove the dead field to clean up the structure.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 875844d7a41d..dd53d4a7277e 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -59,7 +59,6 @@ struct luo_file_set {
  * struct luo_session - Represents an active or incoming Live Update session.
  * @name:       A unique name for this session, used for identification and
  *              retrieval.
- * @ser:        Pointer to the serialized data for this session.
  * @list:       A list_head member used to link this session into a global list
  *              of either outgoing (to be preserved) or incoming (restored from
  *              previous kernel) sessions.
@@ -70,7 +69,6 @@ struct luo_file_set {
  */
 struct luo_session {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
-	struct luo_session_ser *ser;
 	struct list_head list;
 	bool retrieved;
 	struct luo_file_set file_set;
-- 
2.53.0


