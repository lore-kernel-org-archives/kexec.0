Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2155CC4332F
	for <kexec@archiver.kernel.org>; Mon, 14 Nov 2022 13:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:Date:From:MIME-Version
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5j/XHxhz2jUGdHHV4mwAMkWq7AmYa4x54dwc74sOV6c=; b=MOrWnB8BOgZFyA
	TK6cvqaXOVHIWfdGJHwdoyFV4h5aMBKMOuYF8Spc/C2sZfo+O3L3oEjbBrpKM3SCV7kCqC2pYdWOA
	ba8uLqDoyLdlYbCaM4smJ+PN7iFcyauuF7LlDbYOMTNN4PeDxXl3V7m53OAKRd9mXVKAthTJJZQ8V
	LV4g+laJB9D8QzyRpcBTVYQiensqc3Zy1sszq+Vl9WAmHiLqDGtQhe8ZctlAg6L7s6Kbzn3myOWSd
	1jqrnX2nQfnOF8dGVyV35d7D0WS3lqSXMxzEy30PRFqFw/84qQpWD4j6YHenThnkY+FSQrXbOydCv
	mD7J474d/7wHxUIkQLyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouZZC-001FEK-30; Mon, 14 Nov 2022 13:32:02 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouZMi-0019VD-IT
	for kexec@lists.infradead.org; Mon, 14 Nov 2022 13:19:10 +0000
Received: by mail-ej1-x636.google.com with SMTP id t25so28189607ejb.8
        for <kexec@lists.infradead.org>; Mon, 14 Nov 2022 05:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=wptfyIK6cGXWafJRIE0+wKYEiUfT/C8Cp/88f6SDnJI=;
        b=KN2CymL7WFkKiYXpoBmRpQWQXiDY44c7m6Y6yAFKT1NlHPmEkO6jZ5Yupm7GugU/Wo
         ThOL9DjjqdaifsHu4IQ8e+xX70/vP0uafrmaoWSB2xHm25+2eT0nAg+QDEDjmqkf3sJe
         JkJuIjrYCBcLhpIvAHy+6j27qnBKw3LG+ys7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wptfyIK6cGXWafJRIE0+wKYEiUfT/C8Cp/88f6SDnJI=;
        b=DVLtq8OzqcYoaLcB8ZGtmFWyNFj2gJQM8l1e0iw1zdkIUJFhkji+UHxo1UPS0t+7Ud
         9t/DBXdBDWExLYV1/EYX8VkKleFrHCps8GVoM+PQ8Ls0EC+tgcyLqNgLa4hzmbHQxsAW
         AAyxF5tTZp+DPb77/zOliDusj8ZF+U495/uw/wJvdiyFN/iTlQo5VTjb2za93D0jfiW1
         qLRkkP2G5r9GKMFrELvOZKGywEQ/9BpZJ+M1wZSfH3caoWAZuxpS8TCr2eC/tZPk6lIH
         JFCxzPLH4xi7NHiJiiC2WxkD0yxTME3Flj9HIof4Hta9m8BgJPgb1Qq5rA5MPWnK2OKu
         SCbg==
X-Gm-Message-State: ANoB5plrbOWSQO1DZJu4FKG5wW2CP/UehpbDuIUxe30HdzcHyYKZMcjH
	f4Qs90Nunhb+40q3B5MMR2qCEg==
X-Google-Smtp-Source: AA0mqf5XAHfO6upM08Nlwr28NvlYYCOvH4cs7UB4GYrPptHd4Wu7+zqYlEwJB7EXRhdzfIqrEule5A==
X-Received: by 2002:a17:906:edb7:b0:78d:b712:fe99 with SMTP id sa23-20020a170906edb700b0078db712fe99mr10318362ejb.462.1668431945090;
        Mon, 14 Nov 2022 05:19:05 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c205:5c4e:7456:c8cc])
        by smtp.gmail.com with ESMTPSA id g13-20020a50ec0d000000b0045b3853c4b7sm4802061edr.51.2022.11.14.05.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 05:19:04 -0800 (PST)
Subject: [PATCH v1 0/2] kexec: Add new toogle to disable kexec_reboot
MIME-Version: 1.0
X-b4-tracking: H4sIAC1AcmMC/w3LQQqEMAwF0KtI1hMwVVDnNm39arB0oNFBEO9ul2/xbjIUhdG3uangr6a/XCGfhu
 Lm8wrWuZpc65yI9Dyr+ZDAOy5ELjAcLFMYIDJ03bhQncEbOBSf41ZvPlN6nhcDB99zagAAAA==
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 14 Nov 2022 14:18:37 +0100
Message-Id: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org, "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=JfIkpVZ3TPV8FpLGteqEp65kTEUP1lPgQkWDBE88DK8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjckA4FzdwiaV6YR2rAuNRu5qRVsvHdkr8TBqmbGPm
 CtXfY96JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY3JAOAAKCRDRN9E+zzrEiG2XD/
 9E6yRRi3EQWhNK8uXRmHb1MCO0lvuapyhVEgfn84IwmzoXZD0pthUawboSbdfqV2aCv95D7xDPGaom
 Tkf8PBHwsFpeOBEWQ/jYmYr4+LqnKjvY3DJsWQPJTXM7VQ9EdTGBL5ZBfqHMmeGVvrUQB2dSWgqYcF
 T3kFrEMBraghVcFnOA3223Ba2sSuonthRcaotPb+xSYYUMn/rkJXpdplql6892hC+w9L1sFDARUx7C
 tvhRMa/vmLgAgd1tGn2TU7gPPutTUG7Jx0TAN04IZ97QZdyE7h7vKyskbiu0cmnhILdGFpomAVfnpW
 xGV4XIGWqmIwc8x3v9jMckXWb23Av3Wfu3CWoPPXPKpajj9Vdz1C4kCQb7gTq2RQK0iRgIv1F1jUZ4
 5M8T38wr+Wv5+YbShJzRhR53LUtmNRBLjDlZ6x7FpUpTth5w3vyn4s/kzukKpAepAWp96lfjhoZ/hV
 8By8SfhB73wVspAP3X4fKz7Dn5Ghpgo6V0ww1ERk4z4Wp4Xzh1W0q3FF1jfIEIyMokns/CxFNKSD+b
 Fuz/sLCrcNriPFsUkaXZX5n2KLveB+bOEoO0sBHzL+UhDyPkVYF3kKKZQw/O/TjeF6ybBcFuq1jiuI
 ovH518DkpySdiiVfyHPxGcCI72WSIEGqwvrjoE0cFpEAPFpQtq3RQTTNU+DA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_051908_680188_F40DD971 
X-CRM114-Status: UNSURE (   9.57  )
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

Kexec lets the system administratior replace the current kernel with a
different one. 

Add a new toggle to limit that replacement to system crashes only.

To: Jonathan Corbet <corbet@lwn.net>
To: Eric Biederman <ebiederm@xmission.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ross Zwisler <zwisler@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Ricardo Ribalda (2):
      Documentation: sysctl: Correct kexec_load_disabled
      kexec: Introduce kexec_reboot_disabled

 Documentation/admin-guide/sysctl/kernel.rst | 18 +++++++++++++++---
 include/linux/kexec.h                       |  1 +
 kernel/kexec.c                              |  4 ++++
 kernel/kexec_core.c                         | 13 ++++++++++++-
 kernel/kexec_file.c                         |  5 +++++
 5 files changed, 37 insertions(+), 4 deletions(-)
---
base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
change-id: 20221114-disable-kexec-reset-19b7e117338f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
