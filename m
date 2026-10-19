Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59705606A31B
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=forVSlVS;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=AB7itP/F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=quSCbZZ7Mq3acy8cy5BNYZd6wRzHmwo845Fz4abnb/A=; b=forVSlVSV04Ij1pPwzyCptX4x1
	TEA6GgAK2XtxkyVLiqH3AJj94Vg4KWLrYMGCAH4A1dA7yuIdxca7Nwjjrj5tuN4Dnqtu2ynrRssSU
	jxi7zgDHdynwxYnqZWtLHYrFu/TnjEHGQAiwtZfaFpUEzkyvsBBnMcBV+wsi1ILufEPT2+v6h/DSe
	NVtcTZYdtZ0wDKv0pFwgvRhAKp0M24vl2ZhDbex1QZYaes7n1JBA7rcbQRXoF0b/hYzjCZ8lzykbc
	qGuEwgjyjxIxKky2hDYl6TUdRUqSO9dFxxr6K+hKWFTcrx8NMWY2Nnz7FwUG1FhI1Jofiwb32h/nV
	hjASoCTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIvWy-00000008SLN-2U7P;
	Mon, 19 Oct 2026 22:08:32 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIvWu-00000008SFK-1OKF
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 22:08:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=quSCbZZ7Mq3acy8cy5BNYZd6wRzHmwo845Fz4abnb/A=; b=AB7itP/Fnc1oPYnH5pd4YSH42o
	2OY2m5EgkaQnfXK0/3PmNPIU1DjOHBAryL3MUewZ5eykRJ74om7LFh0usOxBn8u6osDqFIavDj7CQ
	gx6WCXTpe6bnGYQ7zn6VVbcbGLvQC/BumAliiMSGK5a7baOU7JR13kmW2s/CyZej4JkN9LgFzL0ig
	k0yoWzQcahjgjPUW76eQs8ofehz8dtgF8QC7mWzfdGwIPz4+tT+r1UcignhPisvESnru+Z2+izyVz
	j6UNVO8oMNmimLr3j74WHCsE799kWxWjmKmxEz1rycK/5Sm+xDxAH1O/PDx5zXL8tfb33LoT/fHtc
	C0M4XrmA==;
Received: from [177.189.74.83] (helo=[192.168.15.93])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xIvWX-003vJs-Sr; Tue, 20 Oct 2026 00:08:06 +0200
Message-ID: <609273bd-83d2-7a58-7c88-7e4e01461c1a@igalia.com>
Date: Mon, 19 Oct 2026 19:07:56 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/6] panic: Allow postponing pre-kdump notifiers
Content-Language: en-US
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
 Joel Granados <joel.granados@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Baoquan He <baoquan.he@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Dave Young <ruirui.yang@linux.dev>,
 Pratyush Yadav <pratyush@kernel.org>, virtualization@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com, Mike Rapoport <rppt@kernel.org>,
 linux-kernel@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>,
 Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Stephen Brennan <stephen.s.brennan@oracle.com>,
 Michael Kelley <mhklinux@outlook.com>, Ian Forbes <ian.forbes@broadcom.com>,
 Petr Mladek <pmladek@suse.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <52183acf25209275a9a57fe5d746f82d3b7efc3c.1790014793.git.zack.rusin@broadcom.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <52183acf25209275a9a57fe5d746f82d3b7efc3c.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_150828_395787_9EE1F699 
X-CRM114-Status: GOOD (  12.78  )
X-Spam-Score: -4.5 (----)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/09/2026 14:55, Zack Rusin wrote:
> Provide an escape hatch for debugging kdump failures that may involve
> pre-kdump callbacks. Add panic_pre_kdump_postpone to skip their early
> invocation in crash core without consuming the once-only guard.
> 
> When enabled, the chain runs before kdump only when
> crash_kexec_post_notifiers is also enabled. Leave the late panic call
> unchanged so callbacks remain eligible if that path is reached.
> Skipping the callbacks may prevent hypervisor crash handling.
> 
> Suggested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Link: https://lore.kernel.org/r/bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
> New in v2: optional postponement policy suggested by Guilherme.
> 
>  Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
>  include/linux/panic_notifier.h                  |  1 +
>  kernel/crash_core.c                             |  3 ++-
>  kernel/panic.c                                  |  2 ++
>  4 files changed, 19 insertions(+), 1 deletion(-)
> 

Thanks for implementing this! It makes sense to me...though I have some
"conflicting" comments in patch #2 heh

Cheers,


Guilherme


