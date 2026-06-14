Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E778CD98C5
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t/HBHoVpPWPsjYGNIDUxBanZVmGWwZw2N5BsDYoGrN0=; b=G12YWX97AYdvZ5bM7ag2hDEqjo
	ju2R+T+PXHA5EfQXL7EPU3gi0RpHov+5kRXDxqIcqFN4Jlv+lm3GW2nfdXYqpROqyxS/MLo7K9XKa
	ynVVLaMBu9vI7zkOXADOllbXIpHm9fCjaZXINpAYOTewCBPbtY3oOZnWE8jixGdn2pxRzBsS1tYDk
	v2vk7pT49SbbOOeBlzRYkPMxHpzxCbNiARyrXUOMqAd7BCvALkrHyqskyBXmsXV7C7pCebWZsPb5N
	Z9RCJ8VWrMWex0FkoOcU1TdOp3KnwwJ2hD9Er5auL3KTW8EQwrrPqEVsBh6x1XpzmjleDfdR+31vt
	DTl445Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkDf-0000000CzAJ-2bqb;
	Sun, 14 Jun 2026 12:45:43 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkDd-0000000Cz9q-2mw5
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 12:45:43 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-8ccf181a52bso27132656d6.3
        for <kexec@lists.infradead.org>; Sun, 14 Jun 2026 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781441139; x=1782045939; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/HBHoVpPWPsjYGNIDUxBanZVmGWwZw2N5BsDYoGrN0=;
        b=QPpGSfSa6Vqv7fyCCEceqOZ2laSx8YfQ6tM5AGgBwBMicvFqHcRpfrhBIztZjdu3At
         lsn3NktA2srOOOufUJ1BvPJEj8s7b4ClWJoxZyj76Pe8Ed9E1LNSMg8c3GFrLSKxgafv
         pAVo8GN92yRKA4rj2RdSH+VgD8fyrjgRWzSmZRUTNuTfU24mAABjUBOa6OJP9ctTmin7
         vN6HtsCUuVwmUH+tZ0eycbj+MlLNXxMq8Vsz7PsMD32bzlBYMGZ1KSfDVliC/i9oy2jf
         EuWcvFO6BYetM4CBsNCPThiJM6TRC4X2x7kzttQCMjZNv9wm9D50Pq3/4IPCsL4jvLei
         2kOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781441139; x=1782045939;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/HBHoVpPWPsjYGNIDUxBanZVmGWwZw2N5BsDYoGrN0=;
        b=BZUXWftdbNqUEWVfnOiaydIiSdsDqOD7XO61zl1KbE3c2yWA9hj6wVdZ6BNsuwVKCC
         A+xESKDroAGpeUcCNIHc5dJ/lfWJD4oSEJglyuZjRRZlTxT4vx6zzYqh90eSxa1YKOdy
         g8+DvwDtKn44f1hcQz1yQkE8Ivpvl9WpRwNBJFvFhaTOaOnvKZsuE8YskDbL+8+1dv21
         e9BiD0bn/fhY69xmF3iX9E/rFh6phMJ0z/j7EoW29F/Ex1jYfljnBZD+7OU4qDNRL5qx
         AGjHaV3qmNz3L3OIT5LY+9LFzAkqX7c+b2M5YI6zUYFC7i4Iu9VeRslYT0McYq4ZJzt+
         KSxg==
X-Forwarded-Encrypted: i=1; AFNElJ+RIxA4UXi6xrVRY9LBa5/AR+eUBh7YsP+LGlS3CcZo1H/TH5qHkY1/3Nfheuy+ArBGlhBrkg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+z+eVYjf4csch9+VsnJAmFOSbLsjc46JctlPs7r2iKY4XHOxl
	aeGv9ESh5kgUJbS7unAbSt4nbITYYQESIueJz+kD9sOcow5FRx/yDgSPMBxcdsebK8w=
X-Gm-Gg: Acq92OHJ9HApbwNzDm9PR4n0EwHwd6SrXZF1La7L23uUXdfOlC46uVMTlEXh+ceX1ZH
	K61xIGeCIt04MZbg5W09X8JtlArm1RqyMaI62m1I/OjLJkKsrVXpJViMWxlbh8tunUSLnCm1qf8
	brhv+zep/2wpANiaYCvY5yugsWQ9mWk0zMjnUmwUePWn1bhTyOUV7n5ilxhJ4l/mlXOZFGn0QBI
	7XPi8RHOmvscaXu0OhfAbvMAlWPc6y5H4ZgEUvpWFHCYKaQ0vbDySOM+4pb/qAX9atOoRapA/AV
	RTLESq87ry4ZQ4IkhvM/uf0BU7SL+ffvRsRXdcu6k/ivCUTrBqik9XZzT3xY2DU83I5OvCmidFm
	1gTYz10Fk82O4em8rItk/DX9dTfh7azFCqEsrAEFRvkRR1U+UTfyCp7NPLRHr/GqakTVwVL5a8x
	Skv51eOxNMd53A3XkoBgq+0gmuGkdK6sxRwjBDsbON8T//nN0nztyTcO9pSMfRUzrD8S9bVdg=
X-Received: by 2002:a05:6214:23c8:b0:8cc:f135:52ab with SMTP id 6a1803df08f44-8d32f695300mr175932556d6.39.1781441139508;
        Sun, 14 Jun 2026 05:45:39 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d3045783b9sm77600166d6.24.2026.06.14.05.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 05:45:39 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/2] selftests/liveupdate: Move luo_test_utils.*
 into a reusable library
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org, 
 tarunsahu@google.com, skhawaja@google.com, shuah@kernel.org, 
 dmatlack@google.com, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-kselftest@vger.kernel.org
In-Reply-To: <20260612214512.464146-3-vipinsh@google.com>
References: <20260612214512.464146-1-vipinsh@google.com>
 <20260612214512.464146-3-vipinsh@google.com>
Date: Sun, 14 Jun 2026 12:45:35 +0000
Message-Id: <178144113518.1257322.4443569681996758075.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=505;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=yMmkTx/uXoXsBnrgn56mvQD1S12q6dE9Jk6UX6Clw2k=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqLqJyLv1Y8RHG3lTIXeMb1ViNrbot1jVkHVENL
 VoWuHOWiSOJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCai6icgAKCRC7dyhM23N6
 3nz7EACOXaEbbe8vnns23e9vjsayU9RkAd6COiWy0fS1zENcHbpbP8579VwlAlYQ9ZKFjFZ8/z/
 m7VU/8iXA+4aU87PDqYtZAJbH2UNC5yXEjRiY6v00hsli423yYc8DXEKIQkfSchRiXXJpoH1N1a
 Zbe5y37wIjdl5LX0HcNey23/5kICwhuQOKi83qpNxhpJuTOpR/78UUv4q/we8yVH8EfPr6m6GLD
 /eyo4Ykzk2gOKMn3r/fDrRgnj+RQe5Gbus61zVz1xxXTQF57LMjwHibyjFXxmHl/8g77S+OS+1v
 EJPwFoFjGkf1RjaP9LpiMTke6NizN/ZOl6OxRsrOBJnocGv2ZIfdAhNQNi93fczfTrS/npGNTIq
 VO6xXlQpY1IxkyEXb8vGW9+6d2kMIiu21kmcO1jmzbyyp7ryHHMetOc/5QYdQWfUH2Za4Jzfa16
 i72ah/OJB5z3JS2oDUnmctk69vao04vWDdE7x+qD3vzp0z2CA4MsUHZ79HdUWE9Kx0eNF7TC961
 Omy976+bY/2F7UX5t+MmbS6onFJST/KfC5ffbpkt1wlil0wvaelNu1p3u+WRwsaFq9q7G5zZo2L
 h/He+qe6Hytci8fvfMnAjaT7hhLnGE+FadArZgsjoJn88u6MyhqIEu1o2LTSaezvIraUrKUqgu4
 u/jBWqYrHjN6Bfg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_054541_724545_B72C274A 
X-CRM114-Status: UNSURE (   5.97  )
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

On Fri, 12 Jun 2026 14:45:12 -0700, Vipin Sharma <vipinsh@google.com> wrote:
> Move luo_test_utils.[ch] into a lib/ directory and make libliveupdate
> library. Pull the rules to build them out into a separate
> libliveupdate.mk script. This will enable these utilities to be
> also built by and used within other selftests (such as VFIO).
> 
> No functional change intended.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

