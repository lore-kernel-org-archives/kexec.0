Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54620CAC5B9
	for <kexec@archiver.kernel.org>; Tue, 30 Sep 2025 08:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=75BCOOk4Otic7+i2rUytCMHq9hbBmmZg3qkoQqTuqQE=; b=PakqwbrfvOkbY6pWYXeUH/tHLN
	bmk5vOmD1Qk4FZPBBlwcuTCk/M0rF1bhIYbIziOjPOV+SVzOBLHp+gOD6wG6xReLGi/o6GP+eNEbz
	aKt1AsQ4fLkcRIUgS847oEVourozZGfC0NwVa4Q+KLrYvJCumt43q7weAbm8dWGxVug4JVLY0RfHJ
	P+PbH/Yw6S2Ay1IicqnKyCouQ9fobWhKZ+1k0PBXthrskqmEs7EOSxbe2ioXRNwenHFjk55WOUwnT
	l3cu8lVAiWM3Z1fWm5oR89Jv70AyjGTmz06IKWNMXjcoMYWgJiyv5ybOQsOysbEFUc/JZEMqNTWff
	TIIg8GcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3VoQ-00000004eil-3GTK;
	Tue, 30 Sep 2025 08:34:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3VoN-00000004eiK-37DH
	for kexec@lists.infradead.org;
	Tue, 30 Sep 2025 08:34:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 607CB43F12;
	Tue, 30 Sep 2025 08:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFB4C4CEF0;
	Tue, 30 Sep 2025 08:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759221255;
	bh=DIqR8FNBtOIohy00IuAhyDtN2iR0A/0XJnGWD1Yd0cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGgZHaO+CBl5ueiM+1pATbV42yAK/8gtpiP7zF4LB9tzahWouOxq7FFcDY6ejWSed
	 HsN4XE8zhwk3kXiEaEKHIFSbAde4M14h423t2uYLHjGzLIzY974Fz7TfY7Vd+/trz0
	 0S/v0nmxWPBQHiK5V81FURT02DJLmHb4MAtHMqK3QLsaAkLN2tArJfKmyM7KmvCq+G
	 pFDAxBkPcTAtWu85VyFi8rjw8TyR4K/LEA5+gYwhTKOXM9TRKQeN4BBgKD0HcfCKhE
	 ztTBO89IaFaMAvnuCDt9RSAPGZ5eLGZJD/uSwK93XRAsFVlAdtzpmm2aXUIvgIqulj
	 SRmmZVhU92eUA==
Date: Tue, 30 Sep 2025 09:34:12 +0100
From: Simon Horman <horms@kernel.org>
To: Khalid Aziz <khalid@gonehiking.org>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH kexec-tools] COPYING: Update with current text for GPL v2
Message-ID: <aNuWBL9lMM7cNxpj@horms.kernel.org>
References: <20250929191132.2511888-1-khalid@gonehiking.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929191132.2511888-1-khalid@gonehiking.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_013415_833691_30AD96EC 
X-CRM114-Status: UNSURE (   7.85  )
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

On Mon, Sep 29, 2025 at 01:11:31PM -0600, Khalid Aziz wrote:
> Text for GPL v2 has been updated to remove old mailing address. This
> updates the license text in COPYING file with the current license text
> from https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt
> 
> Signed-off-by: Khalid Aziz <khalid@gonehiking.org>

Thanks Khalid,

Applied.

- COPYING: Update with current text for GPL v2
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=591ebf60649d


