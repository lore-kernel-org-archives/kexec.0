Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC75CD6E64
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 08:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9masuDvZGRAE5YhO0nxFypjCa/sv5HXBG/vt0WeBSHY=; b=jKGUCBZWS41fJvJV5mBUWVRfdQ
	FqszDfyA1wYkzP010v1TZIcFHv9KXN6F/d6CojFYXJ36G3yGeBi/67SnGB7BqPWi/sMChgndJpopk
	K17hvOSMPbyMaNJvO6Ei2d3uKL6WLTApD0fp6evbV7ttj9ZqrLqFJpLuzziwUU7ocE7WRmP9hYHrv
	ZdTdqLUd9108W0wl0iCZS1OpuAqFqxBFIxK9EN8Ym6MZcQ1U1xK7pqWfD3koQjLcv0pldzBTyxKfE
	eDf/pAp1l0NRDfWvK2YgGXQuTb0LeBVI45HOA2cPeSkH4CqgsA3u4gsnuL8gkx6z/OAXppMEuwE5i
	wsl3fkrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKFz-0000000CXtK-3629;
	Tue, 02 Jun 2026 08:13:51 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKFy-0000000CXsi-2Efs
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 08:13:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 04FD160142;
	Tue,  2 Jun 2026 08:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856151F00893;
	Tue,  2 Jun 2026 08:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780388029;
	bh=9masuDvZGRAE5YhO0nxFypjCa/sv5HXBG/vt0WeBSHY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=BKXzTPVeNI3EzsZztLA+Etdw4lE1OGP7XkpvZ37eeDEGaDydQwyq9IugNdZBmAYvs
	 FnqxLdkt/2eygj2ytRe1nnhKx+iBbgy9pHJ0KDBfSNyODINtGD+F1dpz5xpaS4QY70
	 dzhesbOX4O+UE04WBYEPnUNMMhUfwjmCBQvOBV++UUSG9fn57/q+2X1iZUv3GtfKzS
	 Cm7GMdTCvrapPt8AGMxEExKMmU4sl/gawXrebtYxnhRpE/TeHiZ+jxfXv9ny1a3v8S
	 6nFXBkwl0eHnofOmZYQ64h4A+zO0Mdu8DNmWNYP6M03PUMobTq2oOtcAlkY+j4vc2V
	 If0s6C+uH6NbQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 03/13] liveupdate: centralize state management into
 struct luo_ser
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 akpm@linux-foundation.org, linux-mm@kvack.org, skhan@linuxfoundation.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 skhawaja@google.com, graf@amazon.com
In-Reply-To: <20260530221938.115978-4-pasha.tatashin@soleen.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-4-pasha.tatashin@soleen.com>
Date: Tue, 02 Jun 2026 11:13:34 +0300
Message-Id: <178038801487.119771.6308607614059754603.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Sat, 30 May 2026 22:19:28 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
> index 8f5c5dd01cd0..c8dd30b41238 100644
> --- a/kernel/liveupdate/luo_flb.c
> +++ b/kernel/liveupdate/luo_flb.c
> @@ -579,53 +565,18 @@ int __init luo_flb_setup_outgoing(void *fdt_out)
> [ ... skip 18 lines ... ]
> -	offset = fdt_subnode_offset(fdt_in, 0, LUO_FDT_FLB_NODE_NAME);
> -	if (offset < 0) {
> -		pr_err("Unable to get FLB node [%s]\n", LUO_FDT_FLB_NODE_NAME);
> -
> -		return -ENOENT;
> +	if (flbs_pa) {

I like 

	if (!flbs_pa)
		return;

more

>
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index 8d9201c25412..3b760fefa7b9 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -497,75 +494,34 @@ int luo_session_retrieve(const char *name, struct file **filep)
> [ ... skip 58 lines ... ]
> +	if (sessions_pa) {
> +		header_ser = phys_to_virt(sessions_pa);
> +		luo_session_global.incoming.header_ser = header_ser;
> +		luo_session_global.incoming.ser = (void *)(header_ser + 1);
> +		luo_session_global.incoming.active = true;
>  	}

Ditto

-- 
Sincerely yours,
Mike.


