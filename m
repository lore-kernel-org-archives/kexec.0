Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD41C43217
	for <kexec@archiver.kernel.org>; Mon, 28 Nov 2022 23:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fo8FspNX89CjrlbyK0rnJJLDt8fQaus4Krm5L4jpw2k=; b=PRP/WpgXi9RHgG
	vScAo41H4s4FlVbrn2Zi1mdbBDHTUED8tzw0lgwQRKTY5mf5qx/7AbhesQEZtsjtCjg5eKB2cb/YI
	KT0QYyziYgDSurKJkNWY7bQVCmaZ4Dp1hdun0VaZpDbaZEjJyBtgu8sOIkpupsMcp7AIBrtCKmxVG
	ZF12Vlz0++vJgDAlklVObUNhcH3iC3+0YfN3iDti3BQlAW0RQqip0E9p22AZnQfHf8EkmSiL26ALh
	sCaz4WFvLkQEEJNdhwKrGsjH3ZHoSqf3WBFWN04HudJPksQGWBT1834Gwxmu6Lxi+0gdkFuyZ0Z8q
	e6bKybo9o8Zq5Exe06KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozngq-004nen-Qb; Mon, 28 Nov 2022 23:37:32 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozngi-004nbf-9q
	for kexec@lists.infradead.org; Mon, 28 Nov 2022 23:37:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 9E9B8B81034;
	Mon, 28 Nov 2022 23:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D87C433D7;
	Mon, 28 Nov 2022 23:37:20 +0000 (UTC)
Date: Mon, 28 Nov 2022 18:37:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Philipp Rudo <prudo@redhat.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Eric Biederman
 <ebiederm@xmission.com>, Jonathan Corbet <corbet@lwn.net>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, Ross Zwisler <zwisler@kernel.org>,
 linux-doc@vger.kernel.org, "Joel Fernandes (Google)"
 <joel@joelfernandes.org>
Subject: Re: [PATCH v1 2/2] kexec: Introduce kexec_reboot_disabled
Message-ID: <20221128183718.46c08bb5@gandalf.local.home>
In-Reply-To: <20221128172347.629a75c2@rotkaeppchen>
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
	<20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org>
	<20221117160650.16e06b37@rotkaeppchen>
	<CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
	<20221121150948.6f7c1f1f@rotkaeppchen>
	<CANiDSCtqYykAjRinx9r4O+DxdTBA=OQSjF8URmM6X54nN7pDUA@mail.gmail.com>
	<20221124124000.5af23cad@rotkaeppchen>
	<CANiDSCvO+6TrM900Z_Jr4QL=c1uHS21deto7cU9W4mr7KimhJQ@mail.gmail.com>
	<20221124160115.23ae7928@rotkaeppchen>
	<CANiDSCvJqPogBXWUvQq6ZZaX_bonLBLhJXFyNQbULb0WnJw5UQ@mail.gmail.com>
	<20221128172347.629a75c2@rotkaeppchen>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_153724_515694_4837E807 
X-CRM114-Status: GOOD (  10.38  )
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

On Mon, 28 Nov 2022 17:28:55 +0100
Philipp Rudo <prudo@redhat.com> wrote:

> To be honest I don't think we make a progress here at the moment. I
> would like to hear from others what they think about this.

Not sure if you missed my reply.

  https://lore.kernel.org/all/20221128114200.72b3e2fe@gandalf.local.home/

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
