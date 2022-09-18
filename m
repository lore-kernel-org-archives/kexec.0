Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B92FC54EE9
	for <kexec@archiver.kernel.org>; Mon, 19 Sep 2022 12:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LH4K5JWq3e/uSfrecVKb4qW/G+Sq2RlUpK1FMU/JntE=; b=ckJY3bcn94V4YW
	5wwortMYiYnpcT8kv/oPgkhO990Qpi7c5iCVxo7DC7wbIQOLSWOah/4giY+WNc26OuRQEhAsR3Vt0
	LJxc0j2W9gG1Ej5ryXHVq4cz5oViQFdKDJmq+KJevSd3nRyZUqYuRYEj3Zx9ZtowpQhia7ejAxOfK
	P2W1/YmMZYLj84VXBCfArNTjK3uC4VY7WuFwX+CGAynVYiahzNkhRXTybOCMNlPqMXiJgMgmbf2Ul
	pEhyRnhk8OS72YkaTK7b4E4ysAG+W06mm/6tEuvys0mIVB6vw+9KIS23QmLEpq9to2gFgjtMTRohy
	f4J0+DD/DXgYTfIuEOLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaGMn-00Bm3x-BR; Mon, 19 Sep 2022 12:59:17 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZuxY-00GqY0-NQ
	for kexec@lists.infradead.org; Sun, 18 Sep 2022 14:07:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pUONd9sTqqHQ9FE2X+xGZAJj/F2FA6dWtFbnIt7IXCg=; b=Za15UwOf4JMKB5OmKPAEs5edyT
	hm9DBfC6AsVVDWlpk9jCR4RAJfwFxZvDBrPDjM7FPnR8CQc6mnBPbKklp7RpkSg4uy7U5yWxfzDX6
	JGpBwlA7CMGkwxkfQse6Yv3rxgd3PfZyGrBnDK02+oXytNWrwtPF3kVodolPV60FDA/NMeFa/UUn7
	gG6zBfOO50qgALjpJ96tN0pA0MQ4+wvlONb0Ch2KCmDtBCukEU9WKOKSEiq89eXdrevIhn73mbVOx
	PkVhR+YO0CncisJIdaDg0n5k838u/ihZy+9z2xY8V62ivgFkp2wbPQ90xXuvii5z0SGorsSoJbLyg
	gkOx3KIA==;
Received: from 201-27-35-168.dsl.telesp.net.br ([201.27.35.168] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oZuxQ-0081WM-IK; Sun, 18 Sep 2022 16:07:40 +0200
Message-ID: <8cbe154c-4564-9480-e429-9599a215a651@igalia.com>
Date: Sun, 18 Sep 2022 11:07:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3 07/11] notifiers: Add tracepoints to the notifiers
 infrastructure
Content-Language: en-US
To: akpm@linux-foundation.org, Xiaoming Ni <nixiaoming@huawei.com>,
 Arjan van de Ven <arjan@linux.intel.com>
Cc: kexec@lists.infradead.org, bhe@redhat.com, pmladek@suse.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
 alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com,
 dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
 gregkh@linuxfoundation.org, mikelley@microsoft.com,
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de,
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org,
 xuqiang36@huawei.com, Cong Wang <xiyou.wangcong@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Valentin Schneider <valentin.schneider@arm.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-8-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220819221731.480795-8-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220918_070748_794284_E7A6A737 
X-CRM114-Status: GOOD (  12.24  )
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
> Currently there is no way to show the callback names for registered,
> unregistered or executed notifiers. This is very useful for debug
> purposes, hence add this functionality here in the form of notifiers'
> tracepoints, one per operation.
> 
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Xiaoming Ni <nixiaoming@huawei.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V3:
> - Yet another major change - thanks to Arjan's great suggestion,
> refactored the code to make use of tracepoints instead of guarding
> the output with a Kconfig debug setting.
> 
> V2:
> - Major improvement thanks to the great idea from Xiaoming - changed
> all the ksym wheel reinvention to printk %ps modifier;
> 
> - Instead of ifdefs, using IS_ENABLED() - thanks Steven.
> 
> - Removed an unlikely() hint on debug path.
> 
> [...]

Hi Arjan / Xioming, apologies for the ping.
Do you think the patch is good enough now? I liked the tracepoint
approach, indeed it was a much better idea than guarding the prints with
the DEBUG Kconfig heheh

Appreciate your opinions!
Thanks in advance,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
