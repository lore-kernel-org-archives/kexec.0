Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70F3C61DD5
	for <kexec@archiver.kernel.org>; Fri, 28 Aug 2026 08:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lm7BcEa8+Jgt9xkhmMJfF26Iq1SFFXivMsEEThtEiJo=; b=L8fjDR22T7ZlTm4hSvf6kwLuMQ
	Oi9KUrhLkY29ztWxax/xmo5d4KR6vPbj6mzHSkwrmgwSVwJt/XNclLV7sQgirZTPMvTcVefAl2NK3
	Rt9aPenazROxfDC/3Rmvo0Ktudd3+3N2FVtahhvdKEiRb8QJ/vBbqrTKjd8QTACql/kVOd2v+Yqp9
	b68pIOXClbQsCWJPrStJtUn5Kh9+hOMidCWigmFjDYOlmRbt/CW/IFOGgf1mlZlE7pnU37RtSrnn3
	AxCdWt+8Frlkx8JniKEkb9fWgu//ppKo2NdgRcsTN+ruskDhKVjVg+PscZ8D58ramfv74PA12UEYo
	ERihHE3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsHS-00000005M6N-28YR;
	Fri, 28 Aug 2026 08:49:46 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzsHM-00000005LxU-1jyj
	for kexec@lists.infradead.org;
	Fri, 28 Aug 2026 08:49:44 +0000
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so566656a12.0
        for <kexec@lists.infradead.org>; Fri, 28 Aug 2026 01:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906979; x=1788511779; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lm7BcEa8+Jgt9xkhmMJfF26Iq1SFFXivMsEEThtEiJo=;
        b=UKsQfgVEMCSrAGARhHy7mRAMHvpKlI+Q7Ae8W3zicsugT3l7EUDVDpx+EEBMWCrtIP
         Vk2LIL/9NjDpZIGaLfEUoSxgTNKFaTFbi+qSBL21iOdRHCxWYXTzZCX/t3iQNE1bp0SP
         KFIdZyMhH57TKoZ5c3t6vUlwgFmFvNQfrnIoZFPedM0oDGCezNJ3I23rOjdh6yPsSasU
         4xo8kdaknKyq7700MsZM+ljO/RonI5uMt8MindBMs6gVfRR+u/ZG8H42ljUbmKpaZmYz
         dPW3H2qmiohq1rcNzAypEJsBPkfRADaDmQF0KuemXWfiWjtpUVxaaDSFJXHImSKWvOW5
         Ow6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906979; x=1788511779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lm7BcEa8+Jgt9xkhmMJfF26Iq1SFFXivMsEEThtEiJo=;
        b=jUISfOby/aonztwUJ8sG2GTXYZYlE5kscjjwHpR1JaXXByb/iIMf5jHC0lFo4MBQ1a
         3O3ga6bn/NvcJBDoqhm3sj1PzDSbst19htM97uKyW/iYzOwmZfAxheJ/CcogSHo9xjCJ
         XrQI8GsCl5kA103NJ+1oLqlV6aRUqqow+2A9Qa6Uf/oNYJ0tdXv1L9UjPfElrVttScDK
         IvbbFlGaxqpDqQJllZVDO9oEQDAKmY6ISEe7DXk7PkmA1n6mIDl+BJRgxXg4JiLSBS7W
         XOSfDCrSmqo1XT/VLf8/NEbYDZHG0v2mcNhB0iZ0rZcYpjfRuhPd04FCX1YAzmoGio6T
         JIwQ==
X-Gm-Message-State: AFuF++lNP8e+O+W/ZtUH+3LaMUXR+1tMK26+y83hmh9LdaUQMieb18IP
	TcqzZVAupV5Tzj8/WriA3HWwqcUSyqHKrZByrhZnwWDBuyTe8XoKyg56faIo3uKwKJdRzg==
X-Gm-Gg: AR+sD127YKj42ynAUV1MXC3xziHcN6qD3Bs1snH8QBePsDMdtKyd8/oJ1b4w6Wb0S6k
	zyuLMiPImykNHzfIrdNlA1l9Y3reiQDIWIh1H2qzf7FoBoYcO1EynNhz9aR/HlJIPhbxB355TVZ
	UuquAAreP5Tg1DeiDb8Gxaq1+voJ2EpetlZOV8qix7ynz2QTzSROM4uvBSmdRLCI8y0/bBwU/uV
	1lH2U91LBqTD74GBthCd33ejdUSxp5P7QHiv9olfJtIIHrjrpwAQ+TnLIP9pjCtyP9JKVm8xT1p
	o+EpXgu495Kvrgi29W4qpXV82BcVGp8o6CpAexNCRUpr6/N8qHqRUiyqkfYedJ5iP95n5RNWr3L
	6+JGUpeAOZMgKJs5JyOVS/WYBa7FpCK0XfevL1DoOVbalQ6OlIB1J0fQJybQgH3e0xxF/VSPsNf
	ephsaklsje/0l8Thd39aUR6cg8a2pzo0B+WVnknzZz7iUpUzMN2xPeYhgMLi+m57EeMOqIAQ==
X-Received: by 2002:a05:6a20:db0a:b0:3cd:9f0b:f788 with SMTP id adf61e73a8af0-3d267b656d6mr11291974637.12.1787906979500;
        Fri, 28 Aug 2026 01:49:39 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:a97:707e:a14f:cfbf:3e23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328713b0451sm3801546eec.16.2026.08.28.01.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:49:38 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 9/9] Documentation: kdump: Add arm64 and ppc64le to encrypted dump target support list
Date: Fri, 28 Aug 2026 16:48:55 +0800
Message-ID: <20260828084900.1496839-10-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828084900.1496839-1-coiby.xu@gmail.com>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260828_014940_454380_5BB0AF8D 
X-CRM114-Status: GOOD (  11.10  )
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

The encrypted dump target support is now extended to arm64 and ppc64le.

Fixes: e3a84be1ec2f ("arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel")
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 Documentation/admin-guide/kdump/kdump.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 0bf2eb100a05..36ad6125c670 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -572,8 +572,8 @@ Write the dump file to encrypted disk volume
 ============================================
 
 CONFIG_CRASH_DM_CRYPT can be enabled to support saving the dump file to an
-encrypted disk volume (only x86_64 supported for now). User space can interact
-with /sys/kernel/config/crash_dm_crypt_keys for setup,
+encrypted disk volume (only x86_64, arm64, ppc64le supported for now). User
+space can interact with /sys/kernel/config/crash_dm_crypt_keys for setup,
 
 1. Tell the first kernel what logon keys are needed to unlock the disk volumes,
     # Add key #1
-- 
2.55.0


