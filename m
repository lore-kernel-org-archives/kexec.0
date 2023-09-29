Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB11E728C3
	for <kexec@archiver.kernel.org>; Fri, 29 Sep 2023 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=wKb/NiEPvX3IVLrapLlhP6Dxi1lakwXDJ42UxCG4kWU=; b=jMNoYcp4BxTlNU2Wjy3yh52G/H
	f7a22O++oRu3dldxwTml6C9/S7FRsMnaixWTqyaZwKTStkMptyYlMLx6Dba6ceW8Q5aRQPPjAjSJO
	0efnZRy4YgLK+AEjvL4JT8S6/oDKdzU4LoP1+e6cOtl7JU8SoxSji6m45otKxyWs4pMnZ9fIVJAHV
	5X/Gm8rwHK/fhGaNI+Hki9z6rGWLF7GyekE0w6guGuOZAleZANvum2phklLLeh9lagCayYFFuuRwe
	gShR8MZmI0Ow1JmnBGfXRRO+HryEcRT2ZhS3//93joM/PNg6NL+7ANrGMPi3VU0A5JIn0XDcur/oI
	BFH3IddQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qmFve-008FQg-3B;
	Fri, 29 Sep 2023 16:01:22 +0000
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qmFvb-008FNz-1d
	for kexec@lists.infradead.org;
	Fri, 29 Sep 2023 16:01:21 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:49814)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qmFvG-008vng-VE; Fri, 29 Sep 2023 10:00:59 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:42582 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qmFvF-00H9Oh-8k; Fri, 29 Sep 2023 10:00:58 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org,  Steven Rostedt <rostedt@goodmis.org>,
  Ricardo Ribalda <ribalda@google.com>,  Ross Zwisler <zwisler@google.com>,
  Rob Clark <robdclark@gmail.com>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  kexec@lists.infradead.org
References: <20230929021213.2364883-1-joel@joelfernandes.org>
Date: Fri, 29 Sep 2023 11:00:49 -0500
In-Reply-To: <20230929021213.2364883-1-joel@joelfernandes.org> (Joel
	Fernandes's message of "Fri, 29 Sep 2023 02:12:12 +0000")
Message-ID: <87bkdl55qm.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1qmFvF-00H9Oh-8k;;;mid=<87bkdl55qm.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19pIQoI2yAji5xXUZsxi83S5aP6GqyP94M=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230929_090119_568736_CAB7A791 
X-CRM114-Status: GOOD (  24.55  )
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

"Joel Fernandes (Google)" <joel@joelfernandes.org> writes:

> During kexec reboot, it is possible for a race to occur between
> device_shutdown() and userspace.  This causes accesses to GPU after pm_runtime
> suspend has already happened. Fix this by calling freeze_processes() before
> device_shutdown().

Is there any reason why this same race with between sys_kexec and the
adreno_ioctl can not happen during a normal reboot?

Is there any reason why there is not a .shutdown method to prevent the
race?

I would think the thing to do is to prevent this race in
kernel_restart_prepare or in the GPUs .shutdown method.  As I don't see
anything that would prevent this during a normal reboot.

>
> Such freezing is already being done if kernel supports KEXEC_JUMP and
> kexec_image->preserve_context is true. However, doing it if either of these are
> not true prevents crashes/races.

The KEXEC_JUMP case is something else entirely.  It is supposed to work
like suspend to RAM.  Maybe reboot should as well, but I am
uncomfortable making a generic device fix kexec specific.


> This fixes the following crash during kexec reboot on an ARM64 device
> with adreno GPU:
>
> [  292.534314] Kernel panic - not syncing: Asynchronous SError Interrupt
> [  292.534323] Hardware name: Google Lazor (rev3 - 8) with LTE (DT)
> [  292.534326] Call trace:
> [  292.534328]  dump_backtrace+0x0/0x1d4
> [  292.534337]  show_stack+0x20/0x2c
> [  292.534342]  dump_stack_lvl+0x60/0x78
> [  292.534347]  dump_stack+0x18/0x38
> [  292.534352]  panic+0x148/0x3b0
> [  292.534357]  nmi_panic+0x80/0x94
> [  292.534364]  arm64_serror_panic+0x70/0x7c
> [  292.534369]  do_serror+0x0/0x7c
> [  292.534372]  do_serror+0x54/0x7c
> [  292.534377]  el1h_64_error_handler+0x34/0x4c
> [  292.534381]  el1h_64_error+0x7c/0x80
> [  292.534386]  el1_interrupt+0x20/0x58
> [  292.534389]  el1h_64_irq_handler+0x18/0x24
> [  292.534395]  el1h_64_irq+0x7c/0x80
> [  292.534399]  local_daif_inherit+0x10/0x18
> [  292.534405]  el1h_64_sync_handler+0x48/0xb4
> [  292.534410]  el1h_64_sync+0x7c/0x80
> [  292.534414]  a6xx_gmu_set_oob+0xbc/0x1fc
> [  292.534422]  a6xx_get_timestamp+0x40/0xb4
> [  292.534426]  adreno_get_param+0x12c/0x1e0
> [  292.534433]  msm_ioctl_get_param+0x64/0x70
> [  292.534440]  drm_ioctl_kernel+0xe8/0x158
> [  292.534448]  drm_ioctl+0x208/0x320
> [  292.534453]  __arm64_sys_ioctl+0x98/0xd0
> [  292.534461]  invoke_syscall+0x4c/0x118
>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ricardo Ribalda <ribalda@google.com>
> Cc: Ross Zwisler <zwisler@google.com>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Tested-by: Ricardo Ribalda <ribalda@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/kexec_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index e2f2574d8b74..6599f485e42d 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1299,6 +1299,12 @@ int kernel_kexec(void)
>  	} else
>  #endif
>  	{
> +		error = freeze_processes();
> +		if (error) {
> +			error = -EBUSY;
> +			goto Unlock;
> +		}
> +
>  		kexec_in_progress = true;
>  		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
