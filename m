Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA93FC04FFE
	for <kexec@archiver.kernel.org>; Thu,  2 May 2024 21:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qkvKM2eCKMyiasuQZl/IQa6c61Y28QdA0OPvVcebwX4=; b=4TGQT+jk5SU4Br
	E/TbrVDvoymSWN9WuLcX6W7q7wFe6O9QECzIeYgppFsL83c7wlnHkJpBg4VCmWu8ukOdSyH3+5hJp
	NLHwNU6bSZSWbU+aKnsMBLcWH6A5CcZ//sEGzUjjaKap8Ei+TeSnawpmZguxmEcVe9wOaL0A2Hi6F
	QSKLneatUpXPAcD28Bc5I+41lusClctKupjeWt+5yQvBbo2cAtcJ0tN8GLGx9DROU9QHG5VnMc4YM
	01mVFVHiSsN2EKv0AUyd2y6uCHi6hO4LZfjJEtRjDJLMgqeBUnU95HoVRrqXMMplbzU1/1IefgWG6
	zgeLhCnkLFbc/mXtUF6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2dxF-0000000Dxoz-0KEs;
	Thu, 02 May 2024 21:27:01 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2dxB-0000000DxmZ-2GLx
	for kexec@lists.infradead.org;
	Thu, 02 May 2024 21:26:59 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-51f300b318cso1358084e87.3
        for <kexec@lists.infradead.org>; Thu, 02 May 2024 14:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685215; x=1715290015; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wU/XAKZMmUOs49TIIxrQWM7SSMi6Vt7hgebFMdmZZhA=;
        b=q1RnEG6fqAjFoYRPJ1o0dDiceDJVMOjoEUPxXxK9z7rPZ/uSoxqmhYRzpp6psOwF17
         jAbOPE+NGLjcgUVTMlsiqOQ+Zp0zcU8KNJ7XqZn+cAC8I/wq+GcnXQOLAsGDM6/5XBlQ
         nJlqgArnjl246se4BlX51Ips5kfOZBduiTuM3X4OjpUF8zfYM6u+nxb02jpApmMr7Woi
         4Y6+RV5QlSxY5q+n1XBcNwLiUoCDRuOua6kq5ATL6WiMYkpNqTZl+qtF5FZ4JU5aMQzB
         bPprAAwSW2/0SaQ/g4igsdnib1HrSYC4ZmWsba1HyElYOjpgbm9AGXFjDxtrk97xqIgs
         tBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685215; x=1715290015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wU/XAKZMmUOs49TIIxrQWM7SSMi6Vt7hgebFMdmZZhA=;
        b=ZS9aKX93psnvMNGnD6Cv5qizMnkM/kry/9ITA+1A692xOTlvC+tgMAEbd+mTXzXPwr
         P+rer8nG5lKGyLXA2K5KpG9yhysCvtPeYfhlk6B51Vi8kFsGB7xDMfunovAodhG9TkHl
         9cVhcGMewL44RRdd5OH8yorpvS/DuW1mea8HoCBhkXv39H2JmGtbUCJsSYpc4xCQ8oA2
         BlTazoCHYhQ4nRUJS8+oZbeLv09MZ9U7kJXq0dm9pBPWpgrHPGl8O6OKONgE+63mioMV
         2Xy9Vz3SAsrA7iG8Et6KYSHnE3H3Pgr7WrbABAsU/kZoaCWF9t+uCYpwbomOlnQvNQEB
         ggpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYu2VPXuEdi5T//x6NMCo9Lb58vZYSfZxbVqDdaedGrhumOBAmJCRfospyg4NJEXkXMg92HSbWroRSLVGcesJ7SY5nYKzkx15H
X-Gm-Message-State: AOJu0YyMhZzO/j5gjl1ARs+3EKlcsJH44pI4oQOdtgTyfdHSXOPYnv3n
	TbuQkL60kzGfxT51xWfWfg2eVs+XECTnqbEbfh36F3w9Ce0y76NtaLuO1M1xPWY=
X-Google-Smtp-Source: AGHT+IFdU+CNhHsbaoct4Qy+KcY+OUDNYVYuy7Zm5gtsIUrtGa9LNDfgRLHazZskYH9L85fevDVJpg==
X-Received: by 2002:a05:6512:3144:b0:51b:e42c:2ec4 with SMTP id s4-20020a056512314400b0051be42c2ec4mr584685lfi.24.1714685214745;
        Thu, 02 May 2024 14:26:54 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:26:54 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	kexec@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH 1/4] btrfs: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:28 +0200
Message-ID: <20240502212631.110175-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_142657_816408_7CEC8E65 
X-CRM114-Status: UNSURE (   9.03  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Remove duplicate included header file linux/blkdev.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/btrfs/fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 93f5c57ea4e3..5f7ad90fd682 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -9,7 +9,6 @@
 #include <linux/compiler.h>
 #include <linux/math.h>
 #include <linux/atomic.h>
-#include <linux/blkdev.h>
 #include <linux/percpu_counter.h>
 #include <linux/completion.h>
 #include <linux/lockdep.h>
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
