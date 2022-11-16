Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AC4C433FE
	for <kexec@archiver.kernel.org>; Wed, 16 Nov 2022 20:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WGFG6Gr/gSaYxYpu0Z4amLpMfJHUh4AAAuAVZTNox8w=; b=2IBVkW3xHl0yN7
	T/nS7jJTK5/sYDYsaeA5CfYryJn6+gck64W9KUWBEcIuT3FNOO6EnGSjEHLe1TDkVi8RD+k66DGB+
	toh+xuYAgzecp3KTnDRfQRS55xIO4ryG3z/veH/pAycMHOTzs2AC/m7+ksRygKZgfD8JdOvkqCOB9
	ivNCH4y+3MSLh8JjtrgwQ5MrtRu7CI8iWUDSM+FQzDL4rIctujh23AN8P/RIwEUjum1ulNl6DQC4r
	znqs4mZzvPX+Cyxw/QxqkZ006qYzu6M0E4pZqO+94eLNbcxv5ZOGycBMQ1LrlXvUr3BGN+ZRxDtNa
	CO4j+ohZK+6V96g+lJVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovOoy-007eNc-3Z; Wed, 16 Nov 2022 20:15:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovOoq-007dq0-OI
	for kexec@lists.infradead.org; Wed, 16 Nov 2022 20:15:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 218C061F8E;
	Wed, 16 Nov 2022 20:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB46C433C1;
	Wed, 16 Nov 2022 20:15:25 +0000 (UTC)
Date: Wed, 16 Nov 2022 15:16:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, ribalda@google.com, zwisler@google.com,
 robdclark@gmail.com, Eric Biederman <ebiederm@xmission.com>,
 kexec@lists.infradead.org
Subject: Re: [PATCH RFC] kexec: Freeze processes before kexec
Message-ID: <20221116151610.7294a9e8@gandalf.local.home>
In-Reply-To: <20221116195624.124092-1-joel@joelfernandes.org>
References: <20221116195624.124092-1-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_121536_887153_43141DF9 
X-CRM114-Status: GOOD (  13.12  )
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

On Wed, 16 Nov 2022 19:56:24 +0000
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1175,6 +1175,12 @@ int kernel_kexec(void)
>  	} else
>  #endif
>  	{
> +		error = freeze_processes();
> +		if (error) {
> +			error = -EBUSY;
> +			goto Unlock;
> +		}

If this is the path of a kernel panic, do we really want to check the
return error of freeze_processes()? We are panicing, there's not much more
we can do.

-- Steve


> +
>  		kexec_in_progress = true;
>  		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
