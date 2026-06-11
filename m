Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5961CD98CE
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RTxBAyxRVCg/U/4ECvI3vDi2RWcOyrJFqYDJvpHGCRM=; b=fJIwbADoiIZf7Qtzik7kEHitO+
	fKDYnsG5nIb3XTRy/cI0xeX3fn73X6BhAO27HZdYRrWWIErGN6KIg0R8ZxRevPZEZb2AcYmn6ZUHX
	yQi4TuMT/qPLACKOB8L8RHRw8gRX2OhpSVt5rmA5kXmcy6XOCCDRieaeI/2tGNUjXJA5j3m07bsV3
	vU3V/WD/Ag/YCnl1vBOXkHmEWfeyX6129y1t0mRrmMSE1rwLjfAw7J7xeL3rwc3gmlAi7FzAdUqBb
	u8V1UgB67mIbcgc0BCGA97hl6KvLTQ3AnIGj2Jt7ZAviuwYo3ifu99UPlXqICAfdFCcgywyT17v2S
	2kMV+dkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXerG-00000009RNZ-0Fm5;
	Thu, 11 Jun 2026 12:50:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXerE-00000009RNN-2uAn
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 12:50:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BB1EC6001A;
	Thu, 11 Jun 2026 12:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E371F00893;
	Thu, 11 Jun 2026 12:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781182203;
	bh=RTxBAyxRVCg/U/4ECvI3vDi2RWcOyrJFqYDJvpHGCRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZqwCpQ5giiEbZ6HPQXU57vzYbd0eqj1oQQQuG9Py9U81JcyZbOb9nxVdsABuFt8LP
	 AN6lkVi9sWYi6JHHuHWDFzF/qar6P8XXBVBPJKVt0Gjp3Hv2dH0rsdNrE10qfYm6Ze
	 u+OtFTDJ0INAO8f7fXKTzRzdmlMrUSRj29pBmPvRejiMqh6kYmYE4BYH/w2hztpIbt
	 M0ikeXZD1KcOFmKpWTXGQsjF4nG1tRp6U9Mm1T2xZHq8P0s1DbTg//KGTnTi8oLCk2
	 rcsT8sMekob13zVrLf3Xyvesg0AQwH/KfIQR0/uYt+O7SzJQatbFLTeuKbT/X74iZc
	 +gUko3oBini6g==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>
Cc: linux-kernel@vger.kernel.org, vipinsh@google.com, 
 kexec@lists.infradead.org
In-Reply-To: <faec5df2a3e90240cde5897bae2250cd7d44aeac.1781170056.git.tarunsahu@google.com>
References: <faec5df2a3e90240cde5897bae2250cd7d44aeac.1781170056.git.tarunsahu@google.com>
Subject: Re: [PATCH v2] liveupdate: Document that retrieve failure is
 permanent
Message-Id: <178118219664.1648214.15000032478572564661.b4-ty@b4>
Date: Thu, 11 Jun 2026 15:49:56 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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

On Thu, 11 Jun 2026 09:30:40 +0000, Tarun Sahu wrote:
> liveupdate: Document that retrieve failure is permanent

Applied to next branch of liveupdate/linux.git tree, thanks!

[1/1] liveupdate: Document that retrieve failure is permanent
      commit: e98a9c61721c14bcd29f11f4802e52e908701f7a

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: next

--
Sincerely yours,
Mike.



