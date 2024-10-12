Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E767CF257E
	for <kexec@archiver.kernel.org>; Sat, 12 Oct 2024 20:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Subject:To:
	Message-ID:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZW7Uv4FapoDMpNwn9wen8qh62yxLUwYc7FeZ+RUe7mY=; b=4PPlRzeQCZSTbW
	0ALRSRc2RcROWf2r12lCKucAUjNDAQziKBFNyk8/FpSsW9psUbsxOfl8dWS6XT54Fjwfk3SAXUE4A
	qeVpbhRgWGPLgvDhIZf91P2SkYAGALTmysVer4IZKB3R9b43tSUqi4lF/yzHSWf//nq+ZiwXaiVru
	CgjW76uDpoi4cVSg3D+BkP3KK3nq3Jb36eFXBHon1K94ZNNZ3O/SCS1JVi/iQGf3UuQEGlqU4o9uf
	f3CTXU41iC5EwiYRriMDMwhd4fa6+mNKX7KxwNRI7Fk4jOXPFU8yV2EMsQVK1lvUN028LLK2mWIWP
	Uxaa4Ik8qMeCudtjHLSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szj7I-00000001qC4-3eSr;
	Sat, 12 Oct 2024 20:53:36 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szj7E-00000001qBe-3vAe
	for kexec@lists.infradead.org;
	Sat, 12 Oct 2024 20:53:34 +0000
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-20ca96a155cso13586125ad.2
        for <kexec@lists.infradead.org>; Sat, 12 Oct 2024 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728766411; x=1729371211; darn=lists.infradead.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=EW184XunRkSd7S6FwojHcWT5Ec+eilMpYHr8JDtA3jTfeNulsi7noOdkgTV/bvvhoP
         pWAHK0nOa97yerUMfQvYiH8f9axpYXyfI8k3jIuZFSYl5mdfnoJ/6Y6EnVTBSFzxDVQP
         fdFXEo1zt6ouET97ZgHQPT5PHFwmnCI/xSh0Lh+9jNEZdlIEEcTwI8rft/reOTOrzMZC
         IgyLkBGk2tc4NB8D+Y+KMWjMZBnFrR5nLjk70CKlltZeNsNdjS6auUAMXisX7xMoldo/
         g5V0jcBvii1Adk+ZJvMCWe7t1YTGrCcGU2IJZOVlTqsREEAm3e354TXUYMl2FcWZqsGz
         i0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728766411; x=1729371211;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=VzfCzqZa8PcTjIsJ3Dro99m1Q1pB+FBqrCKOWwJKcNc93JLn5PPgHtzCdIsoWHXMEY
         PJuJgD5nlDhk4tSTrJg2c2AYznJE7aJFI20FDjeaBXFwS33/S1ihSHmGGeiZHc5aFs+q
         fwLIYoCyaFsNR4JP4Km4XOt7EWK8z4QcaFWJj1fw3Fk51ksvxq0tmuvXkcJVwvMmYb0K
         6yTphN2D86Ora8dLQlO4jrfxSw4aIZkG9/5rqzUYHiNxFjRAp87MeSFhIBWjCdeRlBSs
         umkRm+PJEsGJd3UAiB1pQJY4qahydiSg9R/3BxVNBVAnPpMWqEibdI7sEtDtFX1eX57O
         qVyQ==
X-Gm-Message-State: AOJu0YyOA68NZFiBCh5IXPz9vIqJGg7mkf8zb/rjMGSG61Yoah8e5r/3
	F31fJF4mFd/VjvT1q5uO/3XDJ76th8z1zR/ody6AL4HKkf9ISNPXDPZnasYU
X-Google-Smtp-Source: AGHT+IH6yy8H9gQxvIfr8XkH6+4k7wOReVAMxvRZMJfWt78HSrXAOQ//xCozZCf4RanJ0l42OCaF5Q==
X-Received: by 2002:a17:902:e845:b0:20b:449c:8978 with SMTP id d9443c01a7336-20ca147a5b6mr90455525ad.31.1728766410532;
        Sat, 12 Oct 2024 13:53:30 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc12714sm41228495ad.103.2024.10.12.13.53.29
        for <kexec@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Oct 2024 13:53:30 -0700 (PDT)
From: Josey Swihart <ksikhosana50@gmail.com>
X-Google-Original-From: Josey Swihart <joswihart@outlook.com>
Message-ID: <4a16e2a72367b553972996cef6470d6e9a00bbe51ba99c2838714bf05a1fc506@mx.google.com>
To: kexec@lists.infradead.org
Subject: Yamaha Piano 10/12
Date: Sat, 12 Oct 2024 16:53:28 -0400
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241012_135332_977061_6A025733 
X-CRM114-Status: UNSURE (   2.62  )
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
Reply-To: joswihart@outlook.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello,

I?m offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please don?t hesitate to contact me.

Warm regards,
Josey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
