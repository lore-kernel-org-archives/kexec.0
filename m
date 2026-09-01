Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C089C61DD3
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 20:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mfK6izrLfLkiHBzwxF34flt/9RhCVqgo4wqSf8tha6I=; b=SoQH/xWJa14mCKvRWkBMDT+YL6
	GGSOxLJQnPGdjDf8q65+4otXMuPD8IgoTjJ9iRNz+2RGnSShbkwVZn7D8vgZK1i1vxYZV4D34ewlk
	jE4gchPPPtJ06f+LxqdLK4SS73ruHh775rp+o3bormzD4iSt9oGFUYeFpa1bJbOMd+i4G9xcQQl/q
	pliXjvz92VTKgR5VofTJjap9wcMgEN30CURwKBO4DVM7O5DHu1LEU/zIGZ/ToqKlmLZ47vPp0K67R
	g0rUw7LrvAcqvkakzFVvZGg1gjspngPW7HntrXSh35uh+f7ZMXNrCXcYFqNoUDMJtbnLDgVP8391L
	mGCXGtow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1V5W-0000000DKJQ-3LvY;
	Tue, 01 Sep 2026 20:28:10 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1V5T-0000000DKJ4-248t
	for kexec@lists.infradead.org;
	Tue, 01 Sep 2026 20:28:08 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-c160420289bso27884866b.0
        for <kexec@lists.infradead.org>; Tue, 01 Sep 2026 13:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788294484; cv=none;
        d=google.com; s=arc-20260327;
        b=pFGcQa6HCWiowsb1771xAmxNc/w2nh5wFFow9MspkhL+hLg4T4G968yi7TYjZDUmLg
         U2jBBlbVC98BnhswXzJRH3qIAvVcyBZf1EzhtXirvtQaZ9Qw9gO+0qcE7NGb7/yqBt4L
         aGetml986L9zqssE8yrlashbFKZOoelDtjH/40xQutPjAU+3p7w72APJMLzJ8opSbtW0
         SVFFYWneCIzIj1PmYODnVU/dWqrCyiEvUoGrF++KE/3iSKkMFQyH3InYBN3lUN/CXH9H
         fnlkfMUb5f6wDlxpz++91/Cm1KO5liEGjG1fijlkjlOhzqTp1t6KR1S9pQhZy+pmUauu
         9dhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mfK6izrLfLkiHBzwxF34flt/9RhCVqgo4wqSf8tha6I=;
        fh=aTgVlVjXYDQ8kBmWlTtDCL6TTKvruKCzQ0Vg/3A4YfM=;
        b=R7o84mcts7X1/1Hd6fa1VIoAfLq6Ws75JyeU+hpVNVHDOmHB42rwRotpvxHrMwUw9j
         r5hLXyg7KiGOSc1rXYsBS9RK2IQ7W1OrdQ3vX8pR1uDGjr9W0043RboJFu9vryx2mlKL
         IdYAOoBl7U003vRFf8u6lON5RyLnVh0hVYLCHz+/BIZbI5O8R9ONvVeLISLSCbflIYTV
         96C8GLsuy3squRRJT2x5KeVOm0+i7Wc7JJZXLOivp4dS3Alz62yj1m1titMOkJvs0Q6y
         u16tnLoeNQ1+O2OHwASfovD6pbtlJWpWd4Wkro5JdN0tfdqjEY5JNppF19SvGlWdCh5h
         j38g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788294484; x=1788899284; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mfK6izrLfLkiHBzwxF34flt/9RhCVqgo4wqSf8tha6I=;
        b=gWXMI1ehImJ3mQ9nnWtD1GHRTbxBVf8Mf8imxnJWdyDGpAX15OwfysRoOKUhvt2vDv
         3nibgkdWSqs/MOA+w6jSN21TrZTVW+BuZqJeDmfRdvyzuTMe9bkREQc4ZHEOpziKPYXF
         doPY3hy/lssBtSlYalIEbV6TBTQmD0Z60+N0qLQoYRQv0NX2lshJ008ZQjn1CeABUE/u
         +uw4y3LvyLkrf2+7tvvnHFh9MnMN6SCQ8nJCekvdon0V1fZmDyMSS1O4nMthZwhSVjEe
         Zd7ybHsFpcPsKkqRQ8SxRNVfS1FIbh2O9wytrmgGWH7+JiMwJ0hQBfZ9kQ+kUHPg3DHv
         fHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788294484; x=1788899284;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mfK6izrLfLkiHBzwxF34flt/9RhCVqgo4wqSf8tha6I=;
        b=s4cIuN0K6EtlFy9nNLqwyP3vPQR0sMYwwHH4UdQtUOixKiANOE4nH59dL9qWHcwKr9
         j+KuByWQoOqYvU4jv8Ob0Gb1/73+EAv9IYHR8u+k7ex+KlXxu1evsOEKrPCxTrbBsNLy
         f6loiTqg7Zgp3Y4niZUtQZX3RL0+gZzCBrlu0p6RiIxI5sVtttpBGuzhPEfU/cUr3wGX
         QSQDWKC+fWQvZWOZNKz6Isv7TgYuNBh7Ol0sQS26bUHsF/MxFyUWwsXV51c8Ur+N+LiS
         vFTqOpfCn3dqoaZ3777qKzw6tDXOaHVt4PDAGJTtjAUp+V4h7c8kMWgo4rSyww9MH6pD
         z9fg==
X-Gm-Message-State: AFuF++lXUDbo7gdA3mCK6ort7dQuzKsv9c/9vaqybm111+NIWbGem5ZN
	2o+pedj0FzOpAfD/NZ5ThGWZZp/QXXPIq2YlLM9bg1+KbL9wMErEMaypNmkSgXKn/SYRpsXHbPY
	9KTs8PEruHWPUXzQzJMT4Jthw6I6Y3upL4woUH7wfPE2QdMOZ7eXUopC8QuQ=
X-Gm-Gg: AR+sD10tklulUw1tMc493gdir7E7cA9XVzciT3PlWpjF+r0QxS0+wnAjNCdJY8svBTB
	zhBvqF39nnOBsxjaScVDuphAFmq8KGBZq2aFX0lq53DKHOhi2EmJBUUDMT//Y087GT+pelWHmI9
	jT4WIJzTTGgkvk4hI/JxFAN1zUmRw7ZpaYehWM3mJ+i0DgzDgV973ZfHiqeZT92JRKz5X2uTNjj
	FtWimMgIZ7ABYe6r5MyXdq2M/arbZ3kCTb12Rg2NjppIxNDFgKXfbt5h/jQTU0FWCFrzR4uc09J
	mDRD22pjYoaYINMchtB3M6o2R2PN2CXF20SrjByNFEpQAQ==
X-Received: by 2002:a17:907:1c28:b0:c25:2d27:5652 with SMTP id
 a640c23a62f3a-c25b3cc9a35mr769868866b.11.1788294483990; Tue, 01 Sep 2026
 13:28:03 -0700 (PDT)
MIME-Version: 1.0
From: David Matlack <dmatlack@google.com>
Date: Tue, 1 Sep 2026 13:27:34 -0700
X-Gm-Features: AcwNN1V4N1onRzX3h6LdZEVx9K8dpLeuQDd7RVnqczZMYgPrRcJGPrLqHA8BQSg
Message-ID: <CALzav=eL-cARsaH4AO4PzeOPNDmTHpCZbYh9yX_U8pbz96qdTQ@mail.gmail.com>
Subject: RFC: Enable Sashiko code reviews for kexec@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, 
	Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_132807_538256_69BE9C88 
X-CRM114-Status: UNSURE (   9.74  )
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

Hi kexec@ mailing list and maintainers,

I would like to enable Sashiko code reviews for patches sent to the
kexec mailing list. I have found it useful for patches I have sent and
reviewed on the kvm and linux-pci mailing lists, which have Sashiko
enabled.

I sent a pull request to Sashiko to add kexec here:

  https://github.com/sashiko-dev/sashiko/pull/474

I wanted to start this thread to call attention to that pull request
and see if there are any objections, or opinions about how it should
be configured.

Thanks.
--David

