Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8D1C54EBD
	for <kexec@archiver.kernel.org>; Tue, 10 Jan 2023 02:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f2GEiJze/5lmzg4dSUsoKI+HAcySWGerqCOChAMOe5g=; b=POs6NwwHX1WwRq
	22suCXVA0ybwrXgsYAcWw5o5K818jYtsl8hkOUOju7Nczd+q10RY2BjmmyfLPbQ/HFx3R81p9VGnI
	4sfVFIIULhB0ByB8UlML1yAIt9ms4wVcNa5u7hJoTZLDcx6HPNjWkdAahRYJge1d1/N6CxOxoCLSw
	zvqSSKNLPy1Hc1awt0kU60KnBiPDy7428kTs1+Yh9Xn0tGPIo2fF0lJ/LaB4MhcCzvhS4pzGDEpH2
	EggdZ9yVuIS+ArZFCtPl6/I1QmlP7ZhnVk5JJ4MUya6XHfddClAJ97KlV4mTuJhwHkCSLkv7oviFL
	Orxdf0B+Sav8vYmMzS0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF4Rh-004zkK-N4; Tue, 10 Jan 2023 02:33:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF4Rf-004zjd-8z
	for kexec@lists.infradead.org; Tue, 10 Jan 2023 02:33:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673317978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l94HaeBEBiFD5ilSjwcw6DDx5RLDQlnkVXrKy/YYH8k=;
	b=L4F3reB/4Rl8V1jFlOW9ZUWRrRWx2NakYi6nKk/7myFMHzRG8MPTWTn/l5Ix7UBjlGHDEk
	JnD9l+5XutszrCpC+dxhZirpzPcwQcX4XVcizy7SbUyTOflhGyoGNhF2qAhXlxl4XpD0AG
	wxHU0AlcR6dpVpE85ZfgZmXXwdeLU4o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-tXc1h2RJOnCvWpTl6LAxOg-1; Mon, 09 Jan 2023 21:32:55 -0500
X-MC-Unique: tXc1h2RJOnCvWpTl6LAxOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A42F33804062;
	Tue, 10 Jan 2023 02:32:54 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CBCFF2166B26;
	Tue, 10 Jan 2023 02:32:53 +0000 (UTC)
Date: Tue, 10 Jan 2023 10:32:49 +0800
From: Baoquan He <bhe@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>, akpm@linux-foundation.org
Subject: Re: [PATCH v6 0/3] kexec: Add new parameter to limit the access to
 kexec
Message-ID: <Y7zOUdQdbV+c+6P2@fedora>
References: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_183259_411868_AF501551 
X-CRM114-Status: GOOD (  22.09  )
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
Cc: Jonathan Corbet <corbet@lwn.net>, Petr Tesarik <petr@tesarici.cz>, Philipp Rudo <prudo@redhat.com>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Eric Biederman <ebiederm@xmission.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Ross Zwisler <zwisler@kernel.org>, "Joel Fernandes \(Google\)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 01/04/23 at 03:38pm, Ricardo Ribalda wrote:
> Add two parameter to specify how many times a kexec kernel can be loaded.
> 
> These parameter allow hardening the system.
> 
> While we are at it, fix a documentation issue and refactor some code.

The whole series looks good to me, thx.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> To: Jonathan Corbet <corbet@lwn.net>
> To: Eric Biederman <ebiederm@xmission.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ross Zwisler <zwisler@kernel.org>
> To: Philipp Rudo <prudo@redhat.com>
> To: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: Petr Tesarik <petr@tesarici.cz>
> Cc: Baoquan He <bhe@redhat.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> ---
> Changes in v6:
> - Fix kexec type on kexec_file
> - Match the length of the table borders to the sections underline (Thanks Bagas!)
> - Fix typo on kexec_load_limit_reboot (Thanks Petr!)
> - Improve commit message (Thanks Baoquan!)
> - Link to v5: https://lore.kernel.org/r/20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org
> 
> Changes in v5:
> - Remove maxlen from ctl_table. Thanks Steven!
> - Link to v4: https://lore.kernel.org/r/20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org
> 
> Changes in v4 (Thanks Steven!):
> - Uses sysctl instead or module_parameters
> - Pass image type instead of boolean to permitted
> - Fix typo on flag handling
> - Return -EINVAL for values that does not change the current value.
> - Link to v3: https://lore.kernel.org/r/20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org
> 
> Changes in v3:
> - s/paramter/parameter/ Thanks Ghilherme!
> - s/permited/permitted/ Thanks Joel!
> - Link to v2: https://lore.kernel.org/r/20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org
> 
> Changes in v2:
> - Instead of kexec_reboot_disabled, add two new counters (Thanks Philipp!)
> - Link to v1: https://lore.kernel.org/r/20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org
> 
> ---
> Ricardo Ribalda (3):
>       Documentation: sysctl: Correct kexec_load_disabled
>       kexec: Factor out kexec_load_permitted
>       kexec: Introduce sysctl parameters kexec_load_limit_*
> 
>  Documentation/admin-guide/sysctl/kernel.rst | 25 +++++++-
>  include/linux/kexec.h                       |  3 +-
>  kernel/kexec.c                              |  4 +-
>  kernel/kexec_core.c                         | 94 ++++++++++++++++++++++++++++-
>  kernel/kexec_file.c                         | 11 ++--
>  5 files changed, 127 insertions(+), 10 deletions(-)
> ---
> base-commit: 479174d402bcf60789106eedc4def3957c060bad
> change-id: 20221114-disable-kexec-reset-19b7e117338f
> 
> Best regards,
> -- 
> Ricardo Ribalda <ribalda@chromium.org>
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
