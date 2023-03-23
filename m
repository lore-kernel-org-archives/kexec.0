Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8947FC6FD1C
	for <kexec@archiver.kernel.org>; Thu, 23 Mar 2023 00:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8QtSPZUEX77bqg6eidAbmc+cJ5aDtg4fiWE9qG4sfIE=; b=pt6k7SOXqVWxc+
	Rt9H4EuIlkzXGniZXujQlYWAknnLh2F8zhmc010TA1bAFmJGKNjmh0s3yIWd3RnVDO9ZQsI3W00A7
	O26mycGlw3TGTzPMJ5eSrhNQ9/2K5sIZRZzo6jTOlWgivQv50HkCHn5Edn2hAJTLw0e08y4p1oKvp
	8cIl4YKNFMsXY/tWc3mgpIzbLUfGwjPvmnMrdVnAxTdWaKDlaX2L5+fV4WSQ/jlYttHMt8qOlSrfg
	r/iwbUAmYHcmK91VdecoBwQQ6tTH3LpEkpnMhRbfOtgqjnvgOWEETHBWJVFX8UOI8MUqnghiwOgyd
	s2Kf5lqg8ljm2krSmuFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pf8eO-000JPa-1O;
	Thu, 23 Mar 2023 00:17:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pf8eH-000JMk-1w
	for kexec@lists.infradead.org;
	Thu, 23 Mar 2023 00:17:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679530663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qSegs/F/HLoYtMQB109vZlwrTGVYOoKZXOG+DxwqFiw=;
	b=GkdGbgfbzore2Sx812nQLiX8rZUwJFDuK4/qLgL7zW7UqIc4gLKf3MZtK0mAEE7PYvlkov
	kaw1rrIpPEZxqlU3SJYVdANgEYjOpGBGtA7azJ1VgI2g8BY/W7hMTfC91jT4e4a2EWOCjG
	Ixx9tSDMYnlAWHp+fNPAR0iUyWX/49M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-efND3qEnOFeiV3szBBL7Ww-1; Wed, 22 Mar 2023 20:17:39 -0400
X-MC-Unique: efND3qEnOFeiV3szBBL7Ww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 813D9101A531;
	Thu, 23 Mar 2023 00:17:39 +0000 (UTC)
Received: from localhost (ovpn-12-97.pek2.redhat.com [10.72.12.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B84951731B;
	Thu, 23 Mar 2023 00:17:38 +0000 (UTC)
Date: Thu, 23 Mar 2023 08:17:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Philipp Rudo <prudo@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH] kexec: Support purgatories with .text.hot sections
Message-ID: <ZBuan2/9CVPffy9a@MiWiFi-R3L-srv>
References: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org>
 <ZBsSBr87al9ccG96@home.goodmis.org>
 <CANiDSCt_wvaHBq-Yss0QaKTtefBhWwtahFO8_jw6CPSvBwbbMg@mail.gmail.com>
 <ZBsWFOb9wDGSwRSW@MiWiFi-R3L-srv>
 <20230322110002.120cf674@gandalf.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230322110002.120cf674@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_171746_604487_EA7AAB90 
X-CRM114-Status: GOOD (  10.48  )
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

On 03/22/23 at 11:00am, Steven Rostedt wrote:
> On Wed, 22 Mar 2023 22:52:04 +0800
> Baoquan He <bhe@redhat.com> wrote:
> 
> > When you resne patch, please fix Philipp's mail adress as
> > 'Philipp Rudo <prudo@redhat.com>' if he should know this. He has joined
> > Redhat.
> 
> But I thought redhat *was* IBM? ;-)

That's interesting questioin, maybe yes on capital operation, but no
from company operation and management, in an engineer's eyes.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
