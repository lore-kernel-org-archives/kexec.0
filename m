Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5775C6FA8B
	for <kexec@archiver.kernel.org>; Mon, 19 Sep 2022 12:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kOaRvPVgWCOa+PQrKQxwj4prjxtoBS5xXpjChrJrEjY=; b=gQPXO3znLTWyR8
	65K5E9aCB/OImP1Wr0xXIJ+Mk6kgIOtoHwWubTKYeJyjdlfRKCCuWiefAcPm0zzzup31N5H+1cmig
	5Q54w36x7/70Wfwk+Z9tuFUpFM2aXnsBOSGMdEgrEY/vnXue8PWXWT3+RYs1pNtMB5iNRBlIvYZVq
	cuuCaOssIRfNKpuP/t4kHdhEP21lZS0o6acoZlnDjIy6bnFx+qFLpTl7CHwWsILgllwxN34p0DmPP
	4Y8gNhG93hcKrqAF+EqcJZZv138Si5G0JH9HyukTgERYGTcbJG+hFiuC+duJoPbmdXwXB7lZE76oG
	KGTd6zs3nm3EKCXOFiBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaGMm-00Bm3R-86; Mon, 19 Sep 2022 12:59:16 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZuvK-00Gp9K-E9
	for kexec@lists.infradead.org; Sun, 18 Sep 2022 14:05:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oqYUV0dWvcAo5VH7CFm/kLo2npwHY9kSddzY1OFsLfY=; b=UCgpbY6iwSSbEjm0uugXupccuO
	/lpQvNeWhP9/TfyCqoizhm6858ZNRSEeaQJYMCSVwsj/4UlJBP8nyESONeNp1HUuwStFD50uCGR1T
	08kEXe2PM2g73CwCScXcvthVd+D0nna9bnbHMvSD92cxC08Xt/3gNgPbORYTdAmU9BabBtZ43d5eA
	cABINOw87ofdrfB5BwdVaGEn4lJADJ927HqqT0D4CUh4xhQgnHJbgeJDDuMb3kpCgeXNCJ2on8cVb
	VGuvsSm/K+mUtlpn6zhKBSxfSHCBHYgent29etDa1GxW8ot9ijBmlOYteMYuMxI63Vcpfo8xiwx2x
	FuPaZ43g==;
Received: from 201-27-35-168.dsl.telesp.net.br ([201.27.35.168] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oZuvC-0081LD-2V; Sun, 18 Sep 2022 16:05:21 +0200
Message-ID: <afe16869-d5de-2072-52ba-cde61181fc11@igalia.com>
Date: Sun, 18 Sep 2022 11:04:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3 06/11] tracing: Improve panic/die notifiers
Content-Language: en-US
To: rostedt@goodmis.org, stern@rowland.harvard.edu
Cc: kexec@lists.infradead.org, pmladek@suse.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
 bhe@redhat.com, alejandro.j.jimenez@oracle.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
 corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com,
 dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org,
 mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
 john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org,
 mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, senozhatsky@chromium.org, tglx@linutronix.de,
 vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org,
 xuqiang36@huawei.com, Sergei Shtylyov <sergei.shtylyov@gmail.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-7-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220819221731.480795-7-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220918_070530_504073_409FF44B 
X-CRM114-Status: GOOD (  12.29  )
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
> [...]

Hi Steve, Alan - sorry for the ping (and I'm aware you're OOO Steve, saw
your auto-response email heh).

So, is this version good enough? Appreciate the reviews and in case it's
good, let me know your preference for picking it in your tree - I could
resend the patch alone if you prefer (not in the series), for example.

Thanks,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
