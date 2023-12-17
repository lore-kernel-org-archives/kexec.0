Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC12CC3DA6E
	for <kexec@archiver.kernel.org>; Sun, 17 Dec 2023 03:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cJ+42Snkp2ipdRpbA4lA9DJSF2I4ud8cPCzAncS02Ww=; b=I5IAzpHXgCf3i8
	9JX/cy+NuCJHstp9F7jDVh94r96NsJHaVQkPhj9/89Vit4hJD4x+9OaRM7+W4yPno2ok9f+IBLSTO
	nNtTN/53FOJaRJgY/c9JjvWZyipn5By/BoyTBeFqdhnUdrh4LmpJM3ky4P5KD6F1Ip/1sa//VGlm2
	fE1pcCL0UpvQ9b4ymJwAQJxT0ez0A3lGIku5rluFbWu0ZEtWyjLz+D4gzDFXmP2Jb1qXEPER+oMSg
	mlRqinxNilfJRkewTxP+mxkSMGeuXx2jI+8LjBYWSfolmPFitiXojnGjUhI1KMEOgysPafORc64S/
	V/GzzVborynrh1mBh9CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEhxH-0075CO-1E;
	Sun, 17 Dec 2023 03:36:39 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEhxE-0075Ai-2U
	for kexec@lists.infradead.org;
	Sun, 17 Dec 2023 03:36:38 +0000
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7b771176f80so168396639f.2
        for <kexec@lists.infradead.org>; Sat, 16 Dec 2023 19:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702784195; x=1703388995; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3V8gSp8bUEZWRGRAcmamI1zQxxCYsLgl6TFXIZtXR8g=;
        b=LZOPOql5+EC8HSR8uHm6a4g1I165e0u3EMpl3MnjQDNf/t9jXVNCrtk6gZNsYbcsvo
         o5+VtRQhe7/VJUe8OBwlF28pSSfp1MuDsiMCX5rwYaRuRq4fVUG0qzfSxMjmm8vka7s+
         tJY+S3wf5PcoX9WLLF/dYAIdJQPwmptvR1IEd7fAiMC8+PiCcOhr4E+B5gGV3x9TZ/Jm
         CzdvDC+2IlD9MDtzSBpUldmAoHkOHv3t0aLV87nJYuAmqfJyZnriG2kDHInCcmSKhf2d
         4R0LttaRaj/BCjkmAQwHjo/HQQ/rFNzX4xv5w/6LZEwwtSsL0s68DPN4kv9Cs3v7IFPk
         PzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702784195; x=1703388995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3V8gSp8bUEZWRGRAcmamI1zQxxCYsLgl6TFXIZtXR8g=;
        b=Iwne8D9kzaNMDfxDfrip0wj4dTEBAo/sV8ebK5Wt130x3I/LJvINBZtVleqAJhuhnZ
         xZrVppstnHc4tUCn6pawB/Vl1XwAdaIShrs1jhM0Hi71dcVI2jj+P2sQMwNnAyfAbcOw
         4asN8fn61zKkQ4u6cFYVkA0cIuYRdtEjI2hStJrK3IOJp89RGntPx/6+Z+P9yHkexG7M
         OfM6WOtid/YafpHmakx/iJxwxljjEUg7Tn2g9T7c4XSC/YWdtoRkaxxFdvhVs16MJqRI
         K0x/Alr1sTPjzVqVhheSv8jhzdf7nGmR6wMcp0FEijG4IIcJLjksasTTukV5jTxpMIvN
         SW1Q==
X-Gm-Message-State: AOJu0YzbVDVMItHlT3//+pnF0MZ9yR5L2Z/TI53lU0NaiHFySvgtK1ta
	/TPgSRrKxBDNlASte/RCiCY=
X-Google-Smtp-Source: AGHT+IF19Uou+JFEzXr0eitLYlv+ldY8dy1/12JKbWr/jE+2XcuM/gbK5TyaB6a5sCN/Nkm2axS0Jw==
X-Received: by 2002:a5d:8850:0:b0:7b4:28f8:526 with SMTP id t16-20020a5d8850000000b007b428f80526mr16927258ios.38.1702784195510;
        Sat, 16 Dec 2023 19:36:35 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id x26-20020a62fb1a000000b006ce48a0b7c6sm15768820pfm.109.2023.12.16.19.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 19:36:35 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v5 2/3] kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()
Date: Sun, 17 Dec 2023 11:35:27 +0800
Message-ID: <20231217033528.303333-3-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217033528.303333-1-ytcoode@gmail.com>
References: <20231217033528.303333-1-ytcoode@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231216_193636_814718_BF24E51B 
X-CRM114-Status: GOOD (  14.43  )
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

temp_end represents the address of the last available byte. Therefore, the
starting address of the memory segment with temp_end as its last available
byte and a size of `kbuf->memsz`, that is, the value of temp_start, should
be `temp_end - kbuf->memsz + 1` instead of `temp_end - kbuf->memsz`.

Additionally, use the ALIGN_DOWN macro instead of open-coding it directly
in locate_mem_hole_top_down() to improve code readability.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/kexec_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9a419cd22d4..336d085cbc47 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -426,11 +426,11 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_end = min(end, kbuf->buf_max);
-	temp_start = temp_end - kbuf->memsz;
+	temp_start = temp_end - kbuf->memsz + 1;
 
 	do {
 		/* align down start */
-		temp_start = temp_start & (~(kbuf->buf_align - 1));
+		temp_start = ALIGN_DOWN(temp_start, kbuf->buf_align);
 
 		if (temp_start < start || temp_start < kbuf->buf_min)
 			return 0;
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
