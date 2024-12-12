Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DCEE7717F
	for <kexec@archiver.kernel.org>; Thu, 12 Dec 2024 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MYtUHevlD/VAi+BQIN1FQyz5FRV7Cxz6CcOV50CYjns=; b=VBnyjqRiBsSRnNGiPByiiijxxi
	m/wZ/uAqM6wOciYlJDzxaUM4ubyjiadP1/BiZue5eOkT0yccTLpmU322lVphyEHeWyXlHxqqwGsv3
	efTqXEe04srUBpekLDA8xvxcPRqHgdF21I6e+6n5oA3CPQv8VOJDpXgkcDWXwIqlpOMfiCLaVY6IN
	fjDtYZ9GDpEcRvl+Um9P/FIan/j2GqDYBPSW73Bd2n+4jeEfmhO23mgKXPgEdFks4yOyzrrN/hJ1Y
	LHxTvyZtBVp9ZQt+qYxl5BpV+lYybp+Pp30GCYpbMvW2Emncsn2T9zDJrK5jkyfc8O/mxLnG6hoQB
	q2y7qxJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLnfn-00000001M0A-1mG0;
	Thu, 12 Dec 2024 18:12:27 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLnYZ-00000001JYW-23MV
	for kexec@lists.infradead.org;
	Thu, 12 Dec 2024 18:05:00 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734026696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYtUHevlD/VAi+BQIN1FQyz5FRV7Cxz6CcOV50CYjns=;
	b=bz84LmJqy0WgbpnPlL12Drayp6PdZXeOncH6+aJH2AW42ofiLIn/UzpiXx4qGBIwS/AZyQ
	LkpBXXvQWOpEOgqd85tAHfovIGCU9RebgtYAFsU7fbMztPpNXZuVtRl8P4uyJwa5hKpzGO
	z1h85VE0r+kIiQnpBMWTR4md5nuRJnX5x37mApezuilkulLSa/7yPwolcApBhPerqz3itw
	VMUlnKb6CiIqBdJRRWP8o4o4wNXssc7/T5sm8kIKheRH4llMqU38gj/yZmNf7fKChwHjJ1
	ycLLECfO7/5k8AYYRO+S7CC0yYwtpprF1zpH0SGHcZt+lFFYwfrozit8iJXTxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734026696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYtUHevlD/VAi+BQIN1FQyz5FRV7Cxz6CcOV50CYjns=;
	b=0jmImqkd7LLBEP58eu5FTlq0fFjlEsg1GOKACUNYIB6YPdezn/M4GCfFsykGaMZcltMDVy
	PAQLG/AAmnATNfAQ==
To: David Woodhouse <dwmw2@infradead.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung
 <dyoung@redhat.com>, kexec <kexec@lists.infradead.org>, linux-ext4
 <linux-ext4@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>,
 Paolo Bonzini <bonzini@redhat.com>, ming.lei@redhat.com, Petr Mladek
 <pmladek@suse.com>, John Ogness <jogness@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
In-Reply-To: <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
 <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
Date: Thu, 12 Dec 2024 19:04:55 +0100
Message-ID: <87a5d0aibc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_100459_665159_1586F5C0 
X-CRM114-Status: UNSURE (   9.91  )
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

On Thu, Dec 12 2024 at 13:46, David Woodhouse wrote:
> On Thu, 2024-12-12 at 14:34 +0100, Thomas Gleixner wrote:
>> 
>> David, can you retest with the debug patch below? That should pin-point
>> the real culprit.
>
> B[    1.545489] ------------[ cut here ]------------
> [    1.546338] DEBUG_LOCKS_WARN_ON(suspend_syscore_active)
> [    1.546375] WARNING: CPU: 0 PID: 18 at kernel/locking/lockdep.c:4471 lockdep_hardirqs_on+0x13a/0x140

Now this starts to be completely mysterious:

> [    1.571399]  finish_task_switch.isra.0+0xc4/0x2d0
> [    1.572062]  __schedule+0x50a/0x1a10

How on earth did this end up in schedule() on the rcu_gp_kthread between
syscore_suspend() and syscore_resume()?

> [    1.575896]  rcu_gp_fqs_loop+0x10b/0x5b0
> [    1.576455]  ? _raw_spin_unlock_irq+0x28/0x50
> [    1.577072]  rcu_gp_kthread+0xf8/0x1b0
> [    1.577621]  kthread+0xd5/0x100
> [    1.578066]  ? __pfx_kthread+0x10/0x10

I tried to reproduce, but failed. Do you have a simple reproducer
recipe?

Thanks,

        tglx

