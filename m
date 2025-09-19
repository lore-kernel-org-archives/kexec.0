Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C061FCAC592
	for <kexec@archiver.kernel.org>; Fri, 19 Sep 2025 17:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EUmQ/B+AlAHjJtdaqVPlH5RvJwjcQ22iCojUlVm3nUE=; b=RSzJT8z8YcvJ8Kyd6XVrJ5YJfc
	NJ5aOK3+mw2aNKyQpmYG5wlzw65z7DBalzt6IyS4t17AZ1pMb6ZyjWBNl3DEnyw2j6XVW7cNHdwO7
	/32tOJOrpcD8F7oDjn+uHK1Jl3oe/w72FkGr6U9I2rAOhIbTNztA/bA3yxPsBM+rHYH/JpI4ECjlR
	SK9HM8TNUefMqBiwxwr6GfJZR05phYZwuCTJz/D67x9g/FLiYaoIWenYJ3+r0+CiJ2f9Gym7lnWuQ
	COnmFe8hmTeUqnLfEHbUXXqcdfJzoICi/5B7npmEtxiZu3GpX27WH3awOggjKAWA+jaa+0GqQWsoU
	IWkq+Yxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzeWS-00000003bv1-2Zsy;
	Fri, 19 Sep 2025 17:03:48 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzeWN-00000003bu6-3hjh
	for kexec@lists.infradead.org;
	Fri, 19 Sep 2025 17:03:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758301424; x=1789837424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=egBRak+pgEmI39GPWN74tSeQk2eoovRtS1aoXXmXZK8=;
  b=nwiYIl2pbfJa+leR8ebUBDma96Okxp9eZJlwqrgB7SU9e60GRunRycLQ
   bG2SNPxblHma6KiELLnKzazky69OlaB+NFtEw5VkXTxnHXX6exutuLFUl
   FMmYfoBZHGl7wsyyL94v5zANRmsTHeuSLdKwSmZKXdzIYFzYdhGkM8R67
   etO4fk4ed+y3pR8nyySmLAFQSg5nOYRoEhjhc5YwqHJQfZn94knxOnRKq
   4GTa6OEqx+tkjRU8djzXnC7bwu6+GV3bYoRGdKU7B0XK/z4xUrrZGCu0B
   SpW4Rq4lHfgYAi24nTp/8Tj7gE5ZuQLl8jqFlc1Lu1xZ6Lw1uQS3kaCYG
   A==;
X-CSE-ConnectionGUID: TBieiM2MQjiA245XxBWP4A==
X-CSE-MsgGUID: 7HrKeOTTSpOgZAc6dzjZAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="78257335"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="78257335"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:03:39 -0700
X-CSE-ConnectionGUID: a0BIc21qTYmOjQliRJAt+w==
X-CSE-MsgGUID: KzNJtFETTtmEk7YMJtF0Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="175444812"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa009.jf.intel.com with ESMTP; 19 Sep 2025 10:03:39 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: Shuah Khan <shuah@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Cc: Simon Horman <horms@kernel.org>,
	Dylan Yudaken <dyudaken@gmail.com>,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>,
	Ricardo Canuelo <ricardo.canuelo@collabora.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kexec@lists.infradead.org,
	Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v2] selftests/kexec: Ignore selftest binary
Date: Fri, 19 Sep 2025 10:01:39 -0700
Message-ID: <20250919170139.3452889-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_100343_935093_A930EB32 
X-CRM114-Status: GOOD (  10.90  )
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

From: Dylan Yudaken <dyudaken@gmail.com>

Add a .gitignore for the test case build object.

Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
The binary creates some noise. The patch to fix that seems to have
fallen through the cracks. Sending another revision with an expanded Cc
list.

v2:
 - Pick up the review tag

v1: https://lore.kernel.org/all/20250623232549.3263273-1-dyudaken@gmail.com/
---
 tools/testing/selftests/kexec/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/kexec/.gitignore

diff --git a/tools/testing/selftests/kexec/.gitignore b/tools/testing/selftests/kexec/.gitignore
new file mode 100644
index 000000000000..5f3d9e089ae8
--- /dev/null
+++ b/tools/testing/selftests/kexec/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+test_kexec_jump
-- 
2.43.0


