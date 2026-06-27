Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F197C43211
	for <kexec@archiver.kernel.org>; Sat, 27 Jun 2026 00:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6fI86SlfzCXqZetzJ98HYtjazk1qqu/5Wh9zakbqJk=; b=SObcqLYXqBIv2sofsC6hrT0Lvq
	61Jpxdr4l1e+7dfwxaHdYX3Y9cZ8L/+qTJ6gFrsaOHi1yB4fhrmuS/nJDoyDlES9KwMKFC9gbpwC8
	c5zm3MRQb08ifzP1LMCalii6doVZGYEJgkfRBxRMDJ7ViXoiErBIP82hZindPf9DTb4dyd8ThF2zB
	s3nWJH0R0L3z0tP+qvAap4uk/g5xMFWu8GA+xfJRXt9T9sNSOdDXY+W71Ncf24iEigOKq0kc6D12v
	PaEio62qydiY1bHF3ehwaAfhpo7rJlIi3MpT7HBwWSxJrc4gtmpfRQnALhsFWcRkxp7Y6SSWlU8fa
	C6k2BvbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdHOS-0000000C2gE-2RH7;
	Sat, 27 Jun 2026 00:59:36 +0000
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdHOP-0000000C2fv-4Avn
	for kexec@lists.infradead.org;
	Sat, 27 Jun 2026 00:59:35 +0000
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-519eedc30a3so14535901cf.1
        for <kexec@lists.infradead.org>; Fri, 26 Jun 2026 17:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1782521973; x=1783126773; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6fI86SlfzCXqZetzJ98HYtjazk1qqu/5Wh9zakbqJk=;
        b=FiSwQznlgSoOVpbYEo/elq+YKXU2P6GoEddMOt4DFELZl8DaSIfAyythpazV7f7DAF
         TSLMU30TETUDEecNztkoWJAzoF9WrBJEcJqGu4b3ESQCZMolRhmyTaAiiwrWX/774WVy
         DsPLxQC5mHkMEENgkCqMTa+K1JPGJS/t61n8Gq+e6gq6XoWHLHAmrS2wTEtgrYWhc1WL
         oxcAO2Q/hPCshWUVbMe6aiBpdY5EwV1yvpwoEvKW/7SNblpgT2ROJQBlfh5sG216sFTr
         rW6CAk+dbmsIPwB+adrz+KKlgMJNcm43EllMh4pvQgbJ7jn2l8zYTDmLp6f6PZYV7TD2
         6axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782521973; x=1783126773;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6fI86SlfzCXqZetzJ98HYtjazk1qqu/5Wh9zakbqJk=;
        b=AkWrtiulz/Ekm4kahxx7WAnO9je2yf9u0oUn4/1mKsOuLEzst3Mrc1JOPrkHX5Yil7
         +yq3FRgtKGWrD/cVTxErmG1PiFM80sbeyej6iqcO0edKywE0/IJ9VyyJZk7IBZ1BvNAF
         3EwHDrHL+B3vhppBZU8fnzr+MvJ6Pc0B3Xi1xJrOSQyg1bqQXGMHNpwXa8zPCPQr/0dG
         TMcDdFbOIwySVs4EpzZMS1XqOzdG91eHUMivQ6h/+ERNL9Lj9CDKOFB2x0JOLDZPpSG7
         yXM3A1YNjQqS58n0q++2Aucbox/WG1s2DuRWLP/V9RHOaWfJFXSUoTNooUlAE+qfJR7P
         Z0Tw==
X-Forwarded-Encrypted: i=1; AFNElJ9HxdsCO+whczuhppOs5LXVkJs3dGM+Pquwi3EFQNFO3oct4ag+uLEnEQ7EV/BV34xKZH34fA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxukuUvLpQIqmygqxnCv1L2ET3VSXGdJl+QHSY11Vo6e/t03+I4
	85NyW+ewZ7uTewFzEeeNlGGdvEqn6JhSU2YJ8TBabzDPCBtXuJ+owy//4U2sHiwNOS77KLhFubg
	m48v2
X-Gm-Gg: AfdE7cmlydVQKK/YOoFfy1tB5FFJgPj50g2sW9zdtCzn3v20qsrxvANKqMFwFJy9M8I
	RTQy2uVHESBL5IcySmyPydP/ySgXdLJmbyCqih25s3dXAJjkRNKzbGnlLqBruIzsK1xVTcDnkPK
	EOPam9YXN9sp64YykYsmN9fLBb/RWU44nbSRZ6iUqX+TbKTefgbcN7OFrN+1ieAdZs+ondGE3xG
	eb/e6hpiI69Ci+S4JIK3ubHnOjJu71PhrbOPiPkunHUz+9gy8vrYP5T309A4MtXhe89aEUTBh+G
	+xa0VYp/vbk6XTWgBTfeJ+GOQce3tckx5PKCgR40mX8En0Vx23MSdbS2XXqXzJmyRlWy9/4EzXv
	VjzlxCict9tuynOxij064BY0mbqWBfk4kC8+JMRzfJMM1Z9ycgLqaaFZPp8IxvoAWO8/vBn4Ue/
	xP9uo/+OSUrvJEYxvcDsn3PoC0m+KMWCT56voGEZTbk+JaiMusUg==
X-Received: by 2002:a05:622a:652:b0:51a:8c97:938a with SMTP id d75a77b69052e-51a8c97961dmr30547341cf.65.1782521972789;
        Fri, 26 Jun 2026 17:59:32 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a876c888bsm18434161cf.9.2026.06.26.17.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 17:59:31 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 2/3] kho: add KHOSER_COPY_PTR to allow phys copy of
 serialized ptr
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
 kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260623105201.3724592-3-tarunsahu@google.com>
References: <20260623105201.3724592-1-tarunsahu@google.com>
 <20260623105201.3724592-3-tarunsahu@google.com>
Date: Sat, 27 Jun 2026 00:59:25 +0000
Message-Id: <178252196519.136430.866206127737477576.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=418;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=rwTVAsBBkl6m9nXDZzsnVlHfZlLxgx8r+wYRTya4rFU=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqPyByUQB3ZtOZejeLpITOeBDenLDFWImk+jAt5
 d7Mnw5s74KJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCaj8gcgAKCRC7dyhM23N6
 3kMzEACL+IpfP2QOYHoFVmDQ53QyykaWU1CyFZYqJxKRJOZqX+h6ti5kZr/QOGsJtRpcAKird5V
 nh6fuSEvCGiYyRbF5/zO9yMPaS2XLyiYQ6Bx5p6HCdE8RYtULu6ZXrqvy+frSw0ReetrKXJ8dfb
 1lBTjI6fbJpCjZnlxkGAt2m4TCJNn7Fu1Ww3uWyYrDYKVivpIp7mYLHIirsP4RjqpB+gvZNoCW2
 GJgfDrBKZOgFC5tX/9N6NrEVOAa0ga938R30US8+5RzIeu7GRzgU2SoBeAe7CAj9oTiJccLA6Gv
 DSRaurlixLG2myHzw66H/6l+oBHfQNdoAoDjSMOePteal9PDcJunUlv738WvzAhi11hbzIVyT0V
 JkpzfGq8aCIAMOHJf5ltBNHmS2YBhBIHAsuUKEsr1q3pF0lNdkf1A1wsfBihZ5dshufhToECQvw
 yTyN3+4uqnT9C052gMo/uJZPTBu6BAm291roodzJqw4opXE4zcx0SPBsv7q10ovTYtonbUa1yST
 phuAdlHeoDZsc2Jwl+mmbMTvf6moMDck59E3jlvb0Uym+VNEEo/AZsIxO5k4bPRSQtA1gU+s8ri
 hrXSXwMlBZuKGqDRwOTygeb71UMdrmwG55Hy+gZp5MgfYUvyo/JH68xtWyQpkTYPejQ0vIAyotF
 /68hf0eXsNoWTXQ==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_175934_069888_20DBF04D 
X-CRM114-Status: UNSURE (   7.14  )
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

On Tue, 23 Jun 2026 10:52:00 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
> Adding KHOSER_COPY_PTR to copy one serializeable pointer to
> another. It basically allows copy of phys val of the
> serializeable pointer.
> 
> It ignores the typecheck if any of the argument is of void *
> 
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

