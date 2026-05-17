Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C2ACD4F51
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 19:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BlG8LpAFp+hKa95DX8x1G7ey+RY4RgJIzHYj7htm+bo=; b=Vdnl0mdoWWSIO+2YPqVKxEyexB
	KE1mVb1oV+BozkjESsi6LvmhMuWoNcSZr3F+L2f2OUgK9kD/unqHItutcmJiQubvSw4QwEGCSZ6GZ
	e+OcFAgBs/+Ouy2WydGuHCrHUiJgL4SAj/RSlRhUlswqyYC3TsQsTtucJ0aG14Fxtzn0doju4xr33
	J/W6fy7GbDL6EC9cd3jZhfuKRRPscOgUAVw55zT+0qMZS/LoRErYaez4kYqZAri9c3B4aAgpGqQ0W
	6LesRKR1RYjpvzAGJ0pNi7FbYi9KxFWZGeSnHbs5ZBHF8foMobZRacr2j/u7fF6YDWrJ3LZjv8ihg
	ydcC4EJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOh8i-0000000DKVb-14bU;
	Sun, 17 May 2026 19:27:04 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOh8g-0000000DKTo-3M29
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 19:27:03 +0000
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-90d1f03238bso263968985a.1
        for <kexec@lists.infradead.org>; Sun, 17 May 2026 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779046022; x=1779650822; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlG8LpAFp+hKa95DX8x1G7ey+RY4RgJIzHYj7htm+bo=;
        b=ZyfP4nVQmNIUonXj2ocAdBZ6KiifDhlylFlcpAcu7M0qp9wFjwN+y2ubjuMwyTwofg
         a+QxmY7SOIgOP4aLmr4OJuXTaRk2kbeEXz0h61CuGbpJbXROmEww9tBmj5zFKSxJsfkL
         rluTPau5Hq0pldR6OcqWMQmQZVTifNXhWns8VRO7MWrZOz1Hp6WNEkQgNPTvb4jeMJ8b
         fnR0wrCBFVVZ/Ctd01gg6WujlFvI7c11ycsWS24VpZxxijhDUgQea32aH9kvJuw5hIPh
         eu/tZVNlChGPqZKrhshWkdgU7Vvt8Qyndui02NiT3j+iTKPIO3VannNWLqb/0XjeCmpb
         pgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779046022; x=1779650822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BlG8LpAFp+hKa95DX8x1G7ey+RY4RgJIzHYj7htm+bo=;
        b=RwvnwyTW/fYwVIsyj+t+Je8THX8mHf6fgBc9Iq7Jm0iS9R1AwUlqQ3T++wR5AmUmhx
         NcQYvQqKH9jodBxU/5zC7ampyo1DIBp0oF49f7uXExGZTiHfTm5ik4eo89RwXgMoaaAV
         W78YuVc4J1HVOqlfDk3Ku1Y568VJeIbzbgCNF1viiTYCl/rh7Z2EXWqvLiKSagGTaiQq
         y4GeEFngB7ApFq9XJqBOXByHmFStSjIlMgpViLDYGk3zp9fz3t9wvBUpSLXsQeOPWsPK
         kIaPJ/G23wFrB2HVMoyecCbrwpnNehT7jQGzjH0xMjPY0o+Sb9RSXdL6QBpPTvT04fe7
         JXgw==
X-Forwarded-Encrypted: i=1; AFNElJ8x648AIFGNIQe/Cf/Lf4Y1A/Lk23QpCWh/eZJirFKGW6t2WIu8NdL8vpZANiKqUiu30xzNSA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzK1hZ2p+jzhaozYqeoBoX0TI2/fxz4Ucx68YlFTayQin/FgWXa
	x9sq7ZUSw1igENsLk3w830Wr9Yo3m9J3Y2SdCrwgTmgBChRD14HTdvubcOX5iaHf36g=
X-Gm-Gg: Acq92OFph5BneoXU5CXeyLFQx5rqWkwO7kXemA/soV1en8hYMcot84nkzW5gA9AE8FI
	PpnEHdg6s+J6GKExNHAg+blj3RYYlTkLqlyZ1MY/7xcCCrdJ/EsyQ2+nQeEUZHZWWJaobxpVR87
	DSCWU2JaetwCQQ6tpOPwxwYsTSx8ngkHUY9c7ZHmjZBOwnwp7x8tOlzHOPMuhJS4HOz+Gj7UPRB
	jUD0xobf/AEDAxygMGuZc/l4xxuBNe4V2iC/PP8ZbW4tCiY/OKkWijpY+kBvrkq+LG00YVlmJd2
	14GP5kUC/i8bEQw2sAPQBkYJVsoFOKK4lrL6jd8NvNbv/EtL7lG+EEHmN133lWq8Z14Tfp97XaH
	0LJg3EgqEUV2znCkWGCbRQ1+Jyra2MsLYRQp9bh9GXRqZ0xfq5U6k0V4uy1mU4tl1flNa7plnuK
	nEJ4LsuVmLvRFEVuirsjwYX8HgaS3hjMKTC/SfsFfWZiGp5gW7jII=
X-Received: by 2002:ac8:5e4e:0:b0:50f:ba60:2dd4 with SMTP id d75a77b69052e-516419629f0mr204707541cf.40.1779046021672;
        Sun, 17 May 2026 12:27:01 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456d5c4dsm108828621cf.12.2026.05.17.12.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 12:27:01 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	liaoyuanhong@vivo.com,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v4 5/5] liveupdate: Remove unused ser field from struct luo_session
Date: Sun, 17 May 2026 19:26:50 +0000
Message-ID: <20260517192650.1019314-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
References: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_122702_837827_A2356798 
X-CRM114-Status: GOOD (  10.63  )
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


