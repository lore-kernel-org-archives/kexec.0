Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A55C6FA90
	for <kexec@archiver.kernel.org>; Mon, 19 Sep 2022 12:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WMC4xcuyS+adVz5jNXexo0if+rfG3/wUeIN20o0wMzA=; b=Cd5hCO5Yr9aXqP
	XGUnQa3ddlB/jiKqbPpGa6bTgozbY2eBYqvREKsss9vcoEHxO22jAFNkW/PG2AlvHiI13AIdlTrFc
	GBMWKfVJlTBY4B7AkogtAzZ7y1m2ZaqdRQJZoBfWHDGsb5sM3A5Lt/W/YUFD0jUuL0zcfiqsFOSHO
	JCX0rsR6FTP62GFS2+rUeGI4jCG9S47egXjJ25lqH/C9LiA/Z2iYkTvD0phPf/7qmO1peAht85Ru7
	1DJc6z4uyaOBv2ZZT/je0vHlW2GJpkIGGWiAi9VL1GI5rZ9mpCCnGCC+BxjXoP8h7ZiXjeaPHP/Gs
	pl09jXEA04GITdJrCUNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaGMo-00Bm4H-HH; Mon, 19 Sep 2022 12:59:18 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZv13-00GsWA-6w
	for kexec@lists.infradead.org; Sun, 18 Sep 2022 14:11:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bwmvJwxPeNYhJEAaFgEWNBX/KyHgDekYx6WCRbaGWM0=; b=KZIkD3cmZfcEiXmABlPjjaLiDb
	bJNCdA+1Q7QBMN9nFMUF1H65lNIZlsbpgHyFW5q4VwWHXYhYbxMez0r/7aGSVr9Mkja8EO8MWEeQj
	lrjejbImGizBzW+8AgwyGLN4sifu6bi7V+tm3s55Fxmk2AK/+8MIuSfEy9CqMADv36A3TsLYZen9N
	KDoIEGQoTK5GSQTRFs8z9adomivJAtykmQZbdkrSrCI3Wd5/XkK4ejy4ayTqK2ESRa9XWRhsuVkoj
	okKLPL03XBWw1PbW0w+MsrxIcrcH/Fbb839uUfQTMb4OfciqtWsH6enCr3/CvRYrUbfVntwIzJFeZ
	OauP3Qdg==;
Received: from 201-27-35-168.dsl.telesp.net.br ([201.27.35.168] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oZv0s-0081ni-U0; Sun, 18 Sep 2022 16:11:15 +0200
Message-ID: <742d2a7e-efee-e212-178e-ba642ec94e2a@igalia.com>
Date: Sun, 18 Sep 2022 11:10:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3 08/11] EDAC/altera: Skip the panic notifier if kdump is
 loaded
Content-Language: en-US
To: bhe@redhat.com, kexec@lists.infradead.org,
 Dinh Nguyen <dinguyen@kernel.org>, Tony Luck <tony.luck@intel.com>,
 linux-edac@vger.kernel.org, bp@alien8.de
Cc: pmladek@suse.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
 alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com,
 dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
 gregkh@linuxfoundation.org, mikelley@microsoft.com,
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de,
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org,
 xuqiang36@huawei.com
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-9-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220819221731.480795-9-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220918_071125_277966_D3791769 
X-CRM114-Status: GOOD (  12.98  )
X-Mailman-Approved-At: Mon, 19 Sep 2022 05:59:14 -0700
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

On 19/08/2022 19:17, Guilherme G. Piccoli wrote:
> The altera_edac panic notifier performs some data collection with
> regards errors detected; such code relies in the regmap layer to
> perform reads/writes, so the code is abstracted and there is some
> risk level to execute that, since the panic path runs in atomic
> context, with interrupts/preemption and secondary CPUs disabled.
> 
> Users want the information collected in this panic notifier though,
> so in order to balance the risk/benefit, let's skip the altera panic
> notifier if kdump is loaded. While at it, remove a useless header
> and encompass a macro inside the sole ifdef block it is used.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V3:
> - added the ack tag from Dinh - thanks!
> - had a good discussion with Boris about that in V2 [0],
> hopefully we can continue and reach a consensus in this V3.
> [0] https://lore.kernel.org/lkml/46137c67-25b4-6657-33b7-cffdc7afc0d7@igalia.com/
> 
> V2:
> - new patch, based on the discussion in [1].
> [1] https://lore.kernel.org/lkml/62a63fc2-346f-f375-043a-fa21385279df@igalia.com/
> 
> [...]

Hi Dinh, Tony, Boris - sorry for the ping.

Appreciate reviews on this one - Dinh already ACKed the patch but Boris
raised some points in the past version [0], so any opinions or
discussions are welcome!

Thanks,


Guilherme


[0]
https://lore.kernel.org/lkml/46137c67-25b4-6657-33b7-cffdc7afc0d7@igalia.com/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
