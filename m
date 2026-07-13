Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E774CC44501
	for <kexec@archiver.kernel.org>; Mon, 13 Jul 2026 21:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5k6F2tNoLGYGAlUHWdIU4sT4ZSqv0jTiqRc+bkYGypk=; b=CLwIgFX28Kydh5Vfeb7BtFhiKY
	R3B4Pc6RQ7b4cHDL2WmTCQPD7TlR1CXSVMcFszQ9yaefPsiK/RCt8eP9po/rxjyocW2DM9ty8CQvX
	s6gS5asSwAoFQuV7fAc4RSmQ5AEJCg/ye75fPbR3m6Rqn6UGUPnqeFwpYBMiNe0iAmSH0SgbzuY4G
	OY/+cGBX6EFo65NHlBpBhyORgbYpb1RqaOJH+2GcWCKCjuq1eywp+VhRzVewV064yvUOqbjfw9YeS
	ksuoafbURnNuTra9OtIWhTP3VkJyS/1gK0RQslGrLvZ9OzF8nMv8w0Rn6Au0oGK900fr7HchEtuzO
	hBTqSPWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjOAo-0000000ARPd-2otp;
	Mon, 13 Jul 2026 21:26:46 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjOAm-0000000AROw-1tyW
	for kexec@lists.infradead.org;
	Mon, 13 Jul 2026 21:26:45 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2cacef7d299so43925ad.1
        for <kexec@lists.infradead.org>; Mon, 13 Jul 2026 14:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783978003; x=1784582803; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5k6F2tNoLGYGAlUHWdIU4sT4ZSqv0jTiqRc+bkYGypk=;
        b=qDrf33j8Ddv8vL8pUwVqh79cWllDjqCy8KFy0vd2VTBmVfI5c3X7YbGhDHFBseUdda
         iGazTojOYf6D62Bv/lCx9pzVt0b2XKkhhOLjF17e0RKB329hjAhUjOrmX2crMkZW6cro
         mr/0ZxAFBUJD+7FftPUU0XykoMMTzWwyFcNf04tD5hpq2wFoQmL26KVxuI9Byy9xxC+l
         GFmDrEw/sNazQ0ExD0uWw5nZwpM0WMO/n/xnhDF5e1/nngK1z+sFkgzSqqO8lkdXp0TH
         oT6mrIvW2K2uiuTx+G/VZuzB1z8uO762g2Ebl1w/v1Mujc+buosJ68cM6JSGsXWuEX+1
         qGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783978003; x=1784582803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5k6F2tNoLGYGAlUHWdIU4sT4ZSqv0jTiqRc+bkYGypk=;
        b=mqn7qI2EAbpWqTJTwhY4jSTG+EN1geD58yA66V/3JZB3ym4RizBM55JKevkTuxxhh0
         tc/ApvbOW8xKqWW2XZF79pr2P1yVZPf12Y37Tr/IN6Sinx7Bi8Q2j0DbLDtlpDCROnRV
         Edx5U0yq88YURMUFL6AABbi1akYY1wnT9qgERRPLtnbqZRIQ2ts/vTaEmn/5MekJvrqN
         qniIBL//Mb2Cl1JhZGeT7IrCV1SWYzFyO1SJgyLgjZHfeHtmg9qUPSMe95xO5xgFxJJb
         Z3itiw5FiGPS3+eYqvbZr0lspCGyQguw5QLbzkUVcTKhChevKmcs3pSA5UbU75GyA9RH
         ejuQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyEpgaF8jgr7Rl+KRKDUU70NYizKTqkeXWh2HZND29Pp0MXNIMn8qK5yBS2HxRj5KWwtSZGA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxHrCFSiWhVw2SAA1olcmJXZCGgRRM07lvhfvsbR8bPKOaG4k8D
	/iyhesJZatylCeuVm9wBistMtkBP5/8S/hJiSg2NhUy/yiuQ1FbKg2uAKicLI0lF5w==
X-Gm-Gg: AfdE7clztVGCpexCFru2JWJ2ximiHv422vKyYipG4dDDQwolFhH54OS1gKWsc42Dutk
	BaokQlgyLv0vXQbdfeexeV63xAsPIpxzXUPfwmqVvKp9D2w2x/8w2nrc4rtNFbRWo0lrj+bCgDl
	HSx5llEMBxPbmt8FmlvgP2qU4d7pvjYxSwA89Qor71Uhjx9bkACOVyEWwRP/SfOGKnBlHRY4Qen
	0PSfXGgXD4nI01DlVEWa+aUGI6T28WSXXFKSyQpGYlUPNMZjJLwo3+5PH6JtW2Pp1W4YsU1vAQI
	6b86LfVk1yMHWRbMKnZ4qwhcIgMV5WWojX45LCxriTSKNaxDisy96oyCSlAUqkpcQk/02M19vko
	vHnuOQ2rXK/f8amvu7M4u26Xz1n5+Mu+MuzzPf8/ym2URtmcCDrGKK/QJpCJzOxCYZG0nZW9IzY
	Mf27meCWWlrI5Ea5+N27b7H9KUov6Fr+qFwJYz6pqDON84B7PFjHp1hQFGA9z//TelMEM3PjfcJ
	NT6tKJejxg=
X-Received: by 2002:a17:902:f650:b0:2c9:cb98:f4cf with SMTP id d9443c01a7336-2cee1c08775mr3093235ad.14.1783978002200;
        Mon, 13 Jul 2026 14:26:42 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf77e4sm104688515ad.22.2026.07.13.14.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:26:41 -0700 (PDT)
Date: Mon, 13 Jul 2026 21:26:38 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] kho: Introduce a helper to init unsplit pages
Message-ID: <alVX_DWAezlPyU5n@google.com>
References: <20260713204935.3069000-1-praan@google.com>
 <20260713204935.3069000-2-praan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260713204935.3069000-2-praan@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_142644_510762_5A434E16 
X-CRM114-Status: UNSURE (   8.70  )
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

On Mon, Jul 13, 2026 at 08:49:34PM +0000, Pranjal Shrivastava wrote:
>The current KHO restoration logic assumes all multi-page blocks are
>split into independent 4KB pages. Break out a helper to prepare for
>supporting high-order non-compound pages.
>
>Extract kho_init_unsplit_pages() to handle the refcount pattern
>where only the head page is refcounted. Use the helper for folio
>restoration that requires a similar refcount logic.
>
>Signed-off-by: Pranjal Shrivastava <praan@google.com>
>---
> kernel/liveupdate/kexec_handover.c | 29 +++++++++++++++++++----------
> 1 file changed, 19 insertions(+), 10 deletions(-)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

