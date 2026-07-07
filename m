Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0EBC43458
	for <kexec@archiver.kernel.org>; Tue,  7 Jul 2026 02:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/LkxGxrdfXAMwbooc2xbIL9hEUlDluU32Qi7rBGIEBg=; b=qiNZy+h3EMDyYDkCQ+e3A2wLzf
	iV9+mnBs7TY9B42lcVOPhaaTKFboB10XX2WrX/2wi0kTlArml4iPJXA16zCWXhjFsNU1+7cI3MNNf
	oJevh1kfgX26Lkzpn01eRRh2ZcdwmVh3huLNv0U4YqBeieNzrADSu/jFGqtysQSxLuuXmbhZJ29UX
	snYys0xIcF9KpGVuVuz/mWVEuh5pulNv4X4Vun/WoStAsXQKL/dYxgLukGc8hc6v0yd6klAWIjGDr
	GQvgzOlQt7vca2YzxXrt/Sk7OEF+PKx835m2nekbiRAmxTh8pXHdt8CmWsikKO8guksWpR+Ut4zuv
	Q/jUlUCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgvkV-0000000Dwz0-2p3u;
	Tue, 07 Jul 2026 02:41:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgvkT-0000000Dwyq-0nuU;
	Tue, 07 Jul 2026 02:41:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 042E2600AA;
	Tue,  7 Jul 2026 02:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3691F000E9;
	Tue,  7 Jul 2026 02:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783392083;
	bh=/LkxGxrdfXAMwbooc2xbIL9hEUlDluU32Qi7rBGIEBg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KW/PfXAzjfuVQFay9ui4hKELGG1lw0/4l4GoFzm2QSezH7FybLAl+cHM2uRDrcGnt
	 GgrjeHYAZ40xpO9/aUQlS0hVvTGlwEWiWQrkSY1KELoOa61c2dibu//cbuarZ9ICEx
	 eco01BJhNcwfyCh7vPtJV0IjqiC4i9n8rlDkG/iMQfA4MC23DUGiJ+a3HoQA1rcPHT
	 g+4pZ9yalFzLMuyl8eHTJ28jP9fXh8/Bg/CshR5zfj1vad0hQplXU37hbWyw/MfNbc
	 uoIqw1lisMrPVYFKFBUNhmYdRyXABqngQxpvqFEa8q8LvGHb4XblTPm/CnK4ULRsj2
	 2Y1aY+MTG8Dng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199D03925F7B;
	Tue,  7 Jul 2026 02:41:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] riscv: Prevent NULL pointer dereference in
 machine_kexec_prepare
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <178339206389.1302215.10769604011679543705.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 02:41:03 +0000
References: <20260703111530.91285-2-ltao@redhat.com>
In-Reply-To: <20260703111530.91285-2-ltao@redhat.com>
To: Tao Liu <ltao@redhat.com>
Cc: linux-riscv@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, bhe@redhat.com, zohar@linux.ibm.com,
 roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, linux-integrity@vger.kernel.org,
 pratyush@kernel.org, Markus.Elfring@web.de, kernel-janitors@vger.kernel.org,
 jarkko@kernel.org, stable@vger.kernel.org, nutty.liu@hotmail.com
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

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Fri,  3 Jul 2026 23:15:31 +1200 you wrote:
> A NULL pointer dereference issue is noticed in riscv's machine_kexec_prepare(),
> where image->segment[i].buf might be NULL and copied unchecked.
> 
> The NULL buf comes from ima_add_kexec_buffer(), where kbuf is added by
> kexec_add_buffer(), but kbuf.buffer is NULL, then it is copied without
> a check in machine_kexec_prepare().
> 
> [...]

Here is the summary with links:
  - [v4] riscv: Prevent NULL pointer dereference in machine_kexec_prepare
    https://git.kernel.org/riscv/c/60d607dc599a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



