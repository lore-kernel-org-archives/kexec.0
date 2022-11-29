Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB16C46467
	for <kexec@archiver.kernel.org>; Tue, 29 Nov 2022 14:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x5nB6ERHcujeFtA6tCBwHJG19z6Em8t/HX0sJoxp/44=; b=QgaQ8EyqcPylb/
	v7Pk2pWwNhTyhaChN702pXYVNRD8qOFi3u+CwbH7SUp+wJPE8zLI1LiwB2QFgLJANrrvqac1fcRKu
	tfR7AL602BsUr3QD5RkUz6VNbNnscHpekkiOHVVpG7eodtaaoIF7wevxsFmfT4G/yzixC2znvX0tn
	fjltlvYn2uNmm+ejFKph/it11vF15lEoZTCjy1o4JAQmAmqO0p8WR/xoBcaLLAvogQhQ3W4IUGFHC
	S+sUfx9MZlm9RZoGHwjqKUNDymCyWx69DajmsY8BYxI38xkaW5OyLzvwWFaWBGbNQ61h730NtcPWi
	IhEY8xPLz/nIeYEq0GXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01fK-009HYT-2a; Tue, 29 Nov 2022 14:32:54 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01fG-009HW1-Np
	for kexec@lists.infradead.org; Tue, 29 Nov 2022 14:32:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 297F8B810E7;
	Tue, 29 Nov 2022 14:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38F5C433D7;
	Tue, 29 Nov 2022 14:32:46 +0000 (UTC)
Date: Tue, 29 Nov 2022 09:32:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Philipp Rudo <prudo@redhat.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Eric Biederman
 <ebiederm@xmission.com>, Jonathan Corbet <corbet@lwn.net>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, Ross Zwisler <zwisler@kernel.org>,
 linux-doc@vger.kernel.org, "Joel Fernandes (Google)"
 <joel@joelfernandes.org>
Subject: Re: [PATCH v1 2/2] kexec: Introduce kexec_reboot_disabled
Message-ID: <20221129093245.599903e7@gandalf.local.home>
In-Reply-To: <20221129144450.75a7181e@rotkaeppchen>
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
	<20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org>
	<20221117160650.16e06b37@rotkaeppchen>
	<CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
	<20221121150948.6f7c1f1f@rotkaeppchen>
	<CANiDSCtqYykAjRinx9r4O+DxdTBA=OQSjF8URmM6X54nN7pDUA@mail.gmail.com>
	<20221124124000.5af23cad@rotkaeppchen>
	<CANiDSCvO+6TrM900Z_Jr4QL=c1uHS21deto7cU9W4mr7KimhJQ@mail.gmail.com>
	<20221124160115.23ae7928@rotkaeppchen>
	<20221128114200.72b3e2fe@gandalf.local.home>
	<20221129144450.75a7181e@rotkaeppchen>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_063250_953603_D12B177C 
X-CRM114-Status: GOOD (  14.46  )
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

On Tue, 29 Nov 2022 14:44:50 +0100
Philipp Rudo <prudo@redhat.com> wrote:

> An alternative approach and sort of compromise I see is to convert
> kexec_load_disabled from a simple on/off switch to a counter on how
> often a kexec load can be made (in practice a tristate on/off/one-shot
> should be sufficient). Ideally the reboot and panic path will
> have separate counters. With that you could for example use
> kexec_load_limit.reboot=0 and kexec_load_limit.panic=1 to disable the
> load of images for reboot while still allow to load a crash kernel
> once. With this you have the flexibility you need while also preventing
> a race where an attacker overwrites your crash kernel before you can
> toggle the switch. What do you think?

I actually like this idea :-)

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
