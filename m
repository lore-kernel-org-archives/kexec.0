Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402F9C35274
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 02:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NOeC51j5VdbTD22eKwiw9AJpEs51LuONX/q6pObc2hM=; b=DEiRANixnvhCIa
	sSCTBjXNbEbKHCIuU+deyZuw0B4Kp2MEPkrmaorDCgsNt3N3eojw6I2xEn/jW0zgOUirKnl+OjAMD
	hAix5gFfDbqGPZ/cVd5npIr2lZRHswdVmob96gccGVLa5HkC327HWj1BGG8qh4YRpkDAmhpmR++g1
	0Z2TpkcvWNgiOVhc9RGgQUu+Cr+9RwXibIKAp9rlQb/yqX9x0z7A5cKKFhuSdUPvhGjhXMIPd3UHS
	Bctptk3z9HPxhB0fMHGZWTTTc+HP9x9iRdMSvLHfwRjXkuXSfUiM9dg+iEuoT8tu6RvZtteI3X+mJ
	aSdKF64xCue30FMMnZOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFQ4C-00Cc8G-2N;
	Tue, 19 Dec 2023 02:42:44 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFQ49-00Cc7x-1P
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 02:42:42 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28b7a0d1665so973343a91.1
        for <kexec@lists.infradead.org>; Mon, 18 Dec 2023 18:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702953760; x=1703558560; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrNdaUd1I0ntnBi2B5c/DW3suLxtz21RcLr/EmZ7jXE=;
        b=i+9jr4UGjye4I9w+8wSCT/iIk7xpmdf2EPQDqddM7G/99k6JLZEnuWv7jkAesl4ZtT
         +JoUOQJ29PxmL7S3uj/z3Uic8PG4E30MjJliHmeEBFWlwW9FrHH1Qwawa9Ah0cqv+zt1
         gJU07bd6Q7bcT8B2vlgIXbcZf8dqJQ25dMdjoxs8zLp8hQVdHn9YKJjGan/p1Uf51GH+
         Qb0VdffxVYGV+jRkH+Lki9nW6rm5dEGV8Ilc1v3SU4AigsXVsc9uhGvspojaJAUCOb2v
         sZ7KS/w58WFyvbiYR0xurT6aZt6I4/WbPdbTg2hikBJe5XcNntcDuO7U2fcLQ659o/f0
         vAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702953760; x=1703558560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrNdaUd1I0ntnBi2B5c/DW3suLxtz21RcLr/EmZ7jXE=;
        b=bsRBlr/qs8vbUlhLPEkIE5TIEygYBaLDHuJxkwpaBZDXV7ka9ARpQE0IfZJYFSbdF6
         zZYbMQnkU1KpB5Azew+A+k6NXENcUlTC/CoudiCPUrqE49nb5QdfbV/SJYBZsv4YGlfy
         9k/HgfKfOyFh71lZgVVN/WEOJMBM3g3iLMdDMKkpqioHSHStV4bCkYOTmENIm+c7MJUf
         nk5hbmB4YfHlPe4YVBMiQ686B2Cic6WU5dshSAOzoOHq6IoiS2MqX2QItnHpjBZBhEnf
         Gcxw0m5PYgMEA/24BejeHitRBIWQ14DOWdZA7S854l8hMHd0eq4wUrFT6yV+n+9eaXNl
         jf5w==
X-Gm-Message-State: AOJu0YxEVoGN51Hy93hjK3OCaN8r56zuJuaUycZfZdtyJ3JqMqWwPqXV
	vt7EGo98JDLzwmA7TPmlh9s=
X-Google-Smtp-Source: AGHT+IEMr7SMf8dJkuy6k8qi1J/96oz87KZnHCi3MepwxjvtKXznLGUn6U8+nRNkKfrz5fYw7BLjjQ==
X-Received: by 2002:a17:902:d548:b0:1d3:7d0b:a878 with SMTP id z8-20020a170902d54800b001d37d0ba878mr3984676plf.124.1702953759941;
        Mon, 18 Dec 2023 18:42:39 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b001d38cae83e9sm6468589plw.104.2023.12.18.18.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 18:42:39 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: fuqiang.wang@easystack.cn
Cc: bhe@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vgoyal@redhat.com
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Date: Tue, 19 Dec 2023 10:42:33 +0800
Message-ID: <20231219024234.34644-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2fc2ad7d-13be-4a9a-b984-67b1bf04c56b@easystack.cn>
References: <2fc2ad7d-13be-4a9a-b984-67b1bf04c56b@easystack.cn>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_184241_477128_FA3E0E80 
X-CRM114-Status: UNSURE (   7.04  )
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

Hi fuqiang,

Yesterday, I posted two patches that happen to address the bugs you an Baoquan
are currently discussing here, I wasn't aware that you both were also working
on fixing these issues.

Baoquan suggested I talk to you about it.

If you're interested, you can take a look at my patches and review them to see
if there are any issues. If everything is fine, and if you're willing, you can
also add a 'Reviewed-by' tag there.

Sincerely,
Yuntao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
