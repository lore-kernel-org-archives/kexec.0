Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F45AC43219
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UUMsfd7PKeN9GG2n2SdR8pJ8WxiYjuNJ+go8Z/xpCV4=; b=jdqx3TJUCOn3pE
	DohfAGxTq02Ehdeu+o2ibqB+nBshYHgaCyWITvOaF312pfIoetL/mIPSZJDKXL3szwbTpTNZfMJaP
	IczZ1CeD1/wtVwlGFBIF+MOIncWojD2A0Z2FK2897cJL0X4hidZlvFAQrmOFNiLp6epx/N9fxAr/k
	6yiI6fJ1FU5Uozt1qFGnmDgJriygw5wiNAHeSiB67x8krL+fT/crRCFtZlgX7UGbq/u9YZ1yyfg5u
	8ohuv1fSwCiR6WG2wbxpEOEKbYYKyy4wEf+4EECnECZb/oDlC1kcPmk5whaHDOROap7q+w872YgG+
	/Yexd8LIgQ8/8jiBpy9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olsTL-008JJE-7b; Fri, 21 Oct 2022 13:54:03 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQi2-00CRJ2-CG
	for kexec@lists.infradead.org; Mon, 17 Oct 2022 14:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eElHYxMrmADQuWqD+WDhUZYBtoITxSmUO7MpBXGRkmQ=; b=aqI6CYf/xVNFFzyIlxNvV5AwVY
	M0E3vFyGECKDU83j+JHwZUaQdzRuy+pkdvMC/YJwGGZ3BBefMeqjtTdB9J3/AIdxtCiKRHtxF5Qam
	sgsn3SFqoak/XnT+alKs6GRUVjIdSutfRoVcUOmAp5Oht4grSgwZNF6m8/wgDKweX7cFySVSB0kqX
	hpt0MVh1JsMWahY8Db3dZ6Y7dm8204C1FwZhk76XIF3TUqiWMAs5A5iyo0G/YOi8DJBrA/Vi6GL/m
	CH9tt8cLMM8TrL0iwVMOwiY71A19GZlaTRdM7MWBmb3cg2FaiLF4Pd6ZypZYHoXY1VYddscC/IgCK
	tOlWbeNA==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1okQhy-000OIq-Co; Mon, 17 Oct 2022 16:03:10 +0200
Message-ID: <437dcc56-cdd3-9fee-3a06-d5ba3187eeb6@igalia.com>
Date: Mon, 17 Oct 2022 11:02:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 06/11] tracing: Improve panic/die notifiers
Content-Language: en-US
To: rostedt@goodmis.org
Cc: kexec@lists.infradead.org, pmladek@suse.com, bhe@redhat.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
 fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
 corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com,
 dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org,
 mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
 john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org,
 mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org,
 xuqiang36@huawei.com, Sergei Shtylyov <sergei.shtylyov@gmail.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-7-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220819221731.480795-7-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_070314_443498_A0CCA3E6 
X-CRM114-Status: GOOD (  11.50  )
X-Mailman-Approved-At: Fri, 21 Oct 2022 06:53:58 -0700
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
> Currently the tracing dump_on_oops feature is implemented through
> separate notifiers, one for die/oops and the other for panic;
> given they have the same functionality, let's unify them.
> 
> Also improve the function comment and change the priority of the
> notifier to make it execute earlier, avoiding showing useless trace
> data (like the callback names for the other notifiers); finally,
> we also removed an unnecessary header inclusion.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V3:
> - Removed goto usage, as per Steven suggestion (thanks!).
> 
> V2:
> - Different approach; instead of using IDs to distinguish die and
> panic events, rely on address comparison like other notifiers do
> and as per Petr's suggestion;
> 
> - Removed ACK from Steven since the code changed.
> 

Hi Steven, apologies for the re-ping. Is there anything else to do in
this one, or do you think it's good enough?

Thanks,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
