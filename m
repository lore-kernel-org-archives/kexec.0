Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264DAC6FD1F
	for <kexec@archiver.kernel.org>; Wed, 22 Mar 2023 15:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9POeZxLObP2KFjejMocGQ5CAseRDyRYj2L7Z8gGf/vY=; b=S7tV9ZfBQVv52F
	9NiXXvkdrcb7VN+yXPUyR+MxG0gN4AGVKemcBKob0NSk3xWgH/0BIQN3SjOeMKmYrtzgVt1UMGKqI
	QwLvS1VUC0cIlcOWFH8HGBOAEw4q0KJngtjvxUxh4CROHSy3uzuerdiepetI1bsGtUdwdNB7KAw7v
	hUBj9UOOmWCXx8y5drexfOqkOppC7HiV8owBU46p9JTgE0OZGfVGyEWC91elKcIK9fSSTiEjs7klU
	FhR+JBoQzsLsLCND3TZ/Na9px3Kutrzf6VC4WVaV+DZ9gCbgKwYT0GX/QdrzkxvxtDDg1jTHgV67y
	bpzsm1IfPiCylKpZ7e4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pezwo-00GPab-10;
	Wed, 22 Mar 2023 15:00:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pezwd-00GPVb-0k
	for kexec@lists.infradead.org;
	Wed, 22 Mar 2023 15:00:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7561962180;
	Wed, 22 Mar 2023 15:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130EDC4339E;
	Wed, 22 Mar 2023 15:00:04 +0000 (UTC)
Date: Wed, 22 Mar 2023 11:00:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Baoquan He <bhe@redhat.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Eric Biederman
 <ebiederm@xmission.com>, Philipp Rudo <prudo@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Philipp Rudo
 <prudo@redhat.com>
Subject: Re: [PATCH] kexec: Support purgatories with .text.hot sections
Message-ID: <20230322110002.120cf674@gandalf.local.home>
In-Reply-To: <ZBsWFOb9wDGSwRSW@MiWiFi-R3L-srv>
References: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org>
	<ZBsSBr87al9ccG96@home.goodmis.org>
	<CANiDSCt_wvaHBq-Yss0QaKTtefBhWwtahFO8_jw6CPSvBwbbMg@mail.gmail.com>
	<ZBsWFOb9wDGSwRSW@MiWiFi-R3L-srv>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_080007_518861_22FE3164 
X-CRM114-Status: UNSURE (   8.91  )
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

On Wed, 22 Mar 2023 22:52:04 +0800
Baoquan He <bhe@redhat.com> wrote:

> When you resne patch, please fix Philipp's mail adress as
> 'Philipp Rudo <prudo@redhat.com>' if he should know this. He has joined
> Redhat.

But I thought redhat *was* IBM? ;-)

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
