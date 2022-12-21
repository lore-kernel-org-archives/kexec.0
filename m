Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72710C4332F
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sji+KiIObY+HfUHDL4ID68Wc23AQVrKSVOcyUIBTb2I=; b=w394rTGzDFg1Fc
	rOQ/uFLL1uQkT/p1ywP8RqZ4+oe70ZY/uFvtwx2C/BbkGw7SAHwu1Tk+cgUZHVS0wf0uiYPt5Dac9
	NJVMw+vND0nxBFViWlSLUmeXa75vdCR2hQgnSqT06JZeYoepiXGVkMDr+vBqMyRGhfhhjcvnZYk67
	sS7INxo+HVifQrNTYr1jJjTaBimZ4QxRg+pI1dYvj5uzS+l3dOE25DskWTzIlgzselmd2bPi/o8Dp
	eLun52wYALDiuYQX2fG2iOO20sp+aKbgJdmaXCWYB8icgRB8nhOxUR7u9QNxbJtqmiOWRIm6ykqxO
	TNp12251GyFACeO5C9vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7zuK-00FWHo-17; Wed, 21 Dec 2022 14:17:20 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7zrm-00FVWM-Ao
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 14:14:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id ED954B81B60;
	Wed, 21 Dec 2022 14:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588F6C433F0;
	Wed, 21 Dec 2022 14:14:38 +0000 (UTC)
Date: Wed, 21 Dec 2022 09:14:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v4 3/3] kexec: Introduce sysctl parameters
 kexec_load_limit_*
Message-ID: <20221221091435.5ed368cb@gandalf.local.home>
In-Reply-To: <20221114-disable-kexec-reset-v4-3-ab809c8d988c@chromium.org>
References: <20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org>
	<20221114-disable-kexec-reset-v4-3-ab809c8d988c@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_061442_580313_48A5DF76 
X-CRM114-Status: GOOD (  12.92  )
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
Cc: Jonathan Corbet <corbet@lwn.net>, Philipp Rudo <prudo@redhat.com>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Ross Zwisler <zwisler@kernel.org>, "Joel Fernandes \(Google\)" <joel@joelfernandes.org>, Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, 21 Dec 2022 13:50:03 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

> @@ -941,6 +995,20 @@ static struct ctl_table kexec_core_sysctls[] = {
>  		.extra1		= SYSCTL_ONE,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +	{
> +		.procname	= "kexec_load_limit_panic",
> +		.data		= &load_limit_panic,
> +		.maxlen		= sizeof(load_limit_panic),

If I understand the sysctl logic correctly, the .maxlen is the maxlen of
the input to the sysctl, and not the data. Usually set to sizeof(data)
because most proc_handlers write to data directly.

In this case, I believe it's not even used (you override it with the
struct ctl_table tmp). I guess it doesn't really matter what it's set to.
Perhaps just set it to zero and leave it out?

> +		.mode		= 0644,
> +		.proc_handler	= kexec_limit_handler,
> +	},
> +	{
> +		.procname	= "kexec_load_limit_reboot",
> +		.data		= &load_limit_reboot,
> +		.maxlen		= sizeof(load_limit_reboot),

Same here.

-- Steve

> +		.mode		= 0644,
> +		.proc_handler	= kexec_limit_handler,
> +	},
>  	{ }
>  };
>  

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
