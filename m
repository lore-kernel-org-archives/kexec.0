Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3EAC79F99
	for <kexec@archiver.kernel.org>; Sun,  6 Sep 2026 20:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9lfkzVniauHBDUZUWwmYVmAXW8jioDZoVwHD1zl/aeo=; b=VQCRycG8vfmifMGlEnCvnoQw/F
	G3TsS4vur2e2QnUKAqjIsI+wdXYWObji1fk1VS/V0ZNf1ccaeTG3HnJCon1fmgfLd0b4aJJnnjaD6
	DuYj7k8Xaw4Ukd0N/Ha1d9wPUo+SE2yUenCJwgG+SnCS7cCPFdoItelYAKJHgJ7gcCY1Kx/f0lAJW
	3l477NcLp72ODD3zzlrbXwbujq+JjeJqFwPz7SGhMrcVVTTMJolFN4HY+MiMnKiXLE4EB9Ibmzwxs
	9XiIGUJDuTZ3rLKENEqekIQmIy4bE2dfvLHPqYi7wxu/JbhNwvwM6JogkzRYoTEgF1S4ddjb7+dPk
	MWFTt2bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3JeZ-00000005Z2U-1xLw;
	Sun, 06 Sep 2026 20:39:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3JeX-00000005Z2L-3W1x
	for kexec@lists.infradead.org;
	Sun, 06 Sep 2026 20:39:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 284BE40AF6;
	Sun,  6 Sep 2026 20:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F841F00A3A;
	Sun,  6 Sep 2026 20:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788727187;
	bh=9lfkzVniauHBDUZUWwmYVmAXW8jioDZoVwHD1zl/aeo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=cp8wQt8aNj9FIuyGPFzrAcRmVtPOlyFJs6mbjmxyTlntQd9qnR2Rmve+W1ZA3fBv+
	 6+H5TpbE0vf9TAZZ4DSuyMBRvoEZL/BllBU0dc/g2eEf61w78Ka38iXC7RiWUXlXo0
	 dRnyL2RPbFrV2sNfipbi9kMPUldv5J1xSUHeZK2cOghPOVE+EZjbdNJl4CJRIR+KGX
	 a5igwscUE7ctwAA048l5Py4Hc4jVtrsy1mlY9NurCjNn6SN4rBlHdXX7aAGIvyeF8U
	 jGbOXs9AMbG7IHcewhwZvUFvUW4EeIAc1QWiLnhTz/bzHfHFylAnj6OvvaVU9XUJ65
	 5q6FgCKLIZpCw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/1] liveupdate: luo_file: Add documentation for
 dependencies
From: Mike Rapoport <rppt@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
 Alexander Graf <graf@amazon.com>, David Matlack <dmatlack@google.com>, 
 tarunsahu@google.com, open list <linux-kernel@vger.kernel.org>, 
 "open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
 "open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
In-Reply-To: <20260904220555.589752-2-skhawaja@google.com>
References: <20260904220555.589752-1-skhawaja@google.com>
 <20260904220555.589752-2-skhawaja@google.com>
Date: Sun, 06 Sep 2026 23:39:41 +0300
Message-Id: <178872718104.3691424.15410189304450384708.b4-review@b4>
X-Mailer: b4 0.17-dev
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

Hi Sami,

> Add documentation for dependencies between FDs preserved by File
> Handlers. This supplements the previously added

Why capital F and H? :)

I think we use "file handler" in the most places.

-- 
Sincerely yours,
Mike.


