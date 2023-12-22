Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354B4C4706C
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 13:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ieauXWdSvaDEzhMfJ2EGeXxz2wqPbQHrziSAgotmGr8=; b=KXRHn5JI4mMcpA
	CWL8xXwzkLWaa0B68xcF3o0pH1fmtlLYw3R0c1RDAPb0TxLP3jofzXR7TnKrYKhp5Wr70PD1xA03D
	mz1aDHytnJowhz5xXft88O1e/bA6xPUzUYyOGiZYBBAD5hxwCjvIl8MiWFoStLBdI4mOqyF86sh1B
	MEKm21HP7VVRavLg/X6icrZM7jryCm9y3wN3FWWnO45WsIwJGtoeyQ4cPNpbq2taGwV9uIVy/p0vv
	j9aO0mpw2OjHq93ATLxMp9ojhHUpcc5HfcNv3hf4Qxkgljs6amIOTbDDTyiWZv3oCwlnvlV0OnBmy
	xoxgokCWBxjoj2rE8rwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGfSJ-0060y6-2q;
	Fri, 22 Dec 2023 13:20:47 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGfSG-0060xj-2A
	for kexec@lists.infradead.org;
	Fri, 22 Dec 2023 13:20:45 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28bd09e35e8so1144552a91.0
        for <kexec@lists.infradead.org>; Fri, 22 Dec 2023 05:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703251243; x=1703856043; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WT4MjJ9bS77O5qTpD5figlXHQdMav7Y2fGf4WbcZiI=;
        b=QSj7/kfq91Cwk6Bqty4w44OKK7gheGDH5QdeJ1eVX+3BQBk9KnJRNVt2NQUlHyIEF9
         1d3jY2IvdfL/TtyCGgGBk/52rdxvA7q81ULlMuBH3Ex1rGe3b0oh9iPFKu0vG3iExt/L
         4tsqy4kO1gdQu4eorTCOyNkc1J5/vBlgU0Rh130JJTrAtvRdqlNhmpC2fLE/41gF8yrt
         KhPTWTLiq67VV9cC+DZ/gRBnGqk1GY333JEBfWk2pFW6o/HwfOdOwInbWYt/9B62p/fV
         DlJDw6UWy/DxmUHzs63GDRCDI/f4kqpMq4tW1iUftoJ1JPIYpCtc+m5sjBHe1DCrSKVE
         q0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703251243; x=1703856043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WT4MjJ9bS77O5qTpD5figlXHQdMav7Y2fGf4WbcZiI=;
        b=HJrCkdMEyYrwzFLO96spUrGQZ9yPYrrLJjqfgoqjoFvFePYV2DK09ZrNnXM/UG9uaw
         zvQ9k16QPWL23Vy99uyfDoV6Z8Y3UJc17yi4CXPC87hRJgzLED4JKCxLJHcAkUBsoeFh
         5UUuJUihdEyjwWJYepyStfKhCDPGOZ2xv0GhXV7hERcN6FoR37PyCm5hLqEtpwRH0enP
         1/chCipYACpUH/KtjrlcznzjgkD/7oZLuXoqfTJ7z9HSkP0WaSrl3Ez+WBn/17PeX5mS
         wE7Su7z5FExm4Y2DE9lKY7b9t0Nf8yl8fTIcac1mTVN53qG82InSRVwfBeRfml4cGudY
         IAAg==
X-Gm-Message-State: AOJu0Yy9lqWeBk+sl0FiMbsXQLdVBRJRETjAcwiHJF+sG/Lfzw2ez98P
	uZERfpjm5sqneXSNQdjdXwE=
X-Google-Smtp-Source: AGHT+IHwN7ttdc36kO6cjjpCx99jIHOvvfzu+69mfoVOfHGuh6eea0V34pCRS+MxhMLrxr3KkHUItQ==
X-Received: by 2002:a17:90a:c213:b0:28a:dcd2:7bea with SMTP id e19-20020a17090ac21300b0028adcd27beamr720337pjt.32.1703251242835;
        Fri, 22 Dec 2023 05:20:42 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id y21-20020a17090ad71500b0028b43d3250csm3563166pju.43.2023.12.22.05.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 05:20:42 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: akpm@linux-foundation.org
Cc: bhe@redhat.com,
	ebiederm@xmission.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH] kexec_core: fix the assignment to kimage->control_page
Date: Fri, 22 Dec 2023 21:20:33 +0800
Message-ID: <20231222132033.92651-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221141258.7113f9b2599ea6d3b6638e08@linux-foundation.org>
References: <20231221141258.7113f9b2599ea6d3b6638e08@linux-foundation.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_052044_734989_95CFC8B2 
X-CRM114-Status: GOOD (  13.41  )
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

On Thu, 21 Dec 2023 14:12:58 -0800, Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 21 Dec 2023 12:23:08 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> 
> > image->control_page represents the starting address for allocating the next
> > control page, while hole_end represents the address of the last valid byte
> > of the currently allocated control page.
> > 
> > Therefore, after successfully allocating a control page, image->control_page
> > should be updated to `hole_end + 1`, rather than hole_end.
> 
> Thanks.  Again, please include a description of the userspace-visible effects of the bug.

This bug actually does not affect the correctness of allocating control
pages, because image->control_page is currently only used in
kimage_alloc_crash_control_pages(), and this function, when allocating
control pages, will first align image->control_page up to the nearest
`(1 << order) << PAGE_SHIFT` boundary, then use this value as the starting
address of the next control page. This ensures that the newly allocated
control page will use the correct starting address and not overlap with
previously allocated control pages.

Although it does not affect the correctness of the final result, it is
better for us to set image->control_page to the correct value, in case it
might be used elsewhere in the future, potentially causing errors.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
