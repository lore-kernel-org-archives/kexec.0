Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF286ECAAD3
	for <kexec@archiver.kernel.org>; Mon, 19 Sep 2022 12:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hB25c3Lh/Wa6T1CMP+MxnV8/Hy/ucodA3lpZwHjxzRU=; b=EUkOrjomx+48E7
	ddA0QmshYD0SPKEE3m55CxoPREDXSqqsAePjBQO5+fR7CeCJ+/3jBDzjzOQR8QFlkrNokwhUT39G6
	YCAndM9BpGRdK4vTtzUhYg5V6yFPzig0KYXZGwD0hGiF/AfVJyKr0W2UqRLeI1lNJgofJErcZ5IMo
	8VimUdVOVB44PfwY+aNCQpjB5K6giaM9hjMTzYSM34I5mnupynnZC518d5PJso/oonlIbE2bLCAxp
	AENh1SoG2hqnHxg1RlBGbopsmQyCu4kHFUIEM60cydP51+NmVwmkUEBvIGC7uGYjGpUgXEZQE2gFY
	9PkztuWn8eHvVHfe2BBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaGMq-00Bm4y-Nb; Mon, 19 Sep 2022 12:59:20 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZv3d-00Gu72-5w
	for kexec@lists.infradead.org; Sun, 18 Sep 2022 14:14:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aDVyle5G3wtqIccxn/cBaHSZXXYVPnL6YNcpcqqbsXA=; b=I91NEcebw/ZpGroEZ11QU1CmBe
	qxInUn7rIoCX3CLVXGhhGfuz+ZmBv0nnIWJh9TyhqERtkoI6T0q2tisSnIhmcbyHxJNdNYDBf6A1N
	gTXmzClAfzBC6LtN7rIjPVIzVgYFHk9nHdF582Rl4jILjOuN6k+loxnoLdkCmi5LdumVTOSZpDK+q
	Y9ZtTZSPLNeG5QmwQkdpsdADSwd10DInYUGS44hH9YkaF7zoTcmDEKMFJKQSo+EaCUbjvmfZRaOT+
	Fslvq1PhA/2XIP1FVDJ6gsObNe9jSJWV0qymX9tQ4eqaV/F9OhxifebTXFFT52vNbBeWX0rN5rjcI
	bBzgCpTg==;
Received: from 201-27-35-168.dsl.telesp.net.br ([201.27.35.168] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oZv3a-0081yC-2g; Sun, 18 Sep 2022 16:14:02 +0200
Message-ID: <09016e20-5b38-3650-24bf-5fd649ee9b93@igalia.com>
Date: Sun, 18 Sep 2022 11:13:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3 11/11] panic: Fixes the panic_print NMI backtrace
 setting
Content-Language: en-US
To: akpm@linux-foundation.org, kexec@lists.infradead.org
Cc: bhe@redhat.com, pmladek@suse.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
 fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
 corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com,
 dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org,
 mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
 john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org,
 mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
 stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com,
 vkuznets@redhat.com, will@kernel.org, xuqiang36@huawei.com
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-12-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220819221731.480795-12-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220918_071405_252765_24CE1EF1 
X-CRM114-Status: GOOD (  22.86  )
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
> Commit 8d470a45d1a6 ("panic: add option to dump all CPUs backtraces in panic_print")
> introduced a setting for the "panic_print" kernel parameter to allow
> users to request a NMI backtrace on panic. Problem is that the panic_print
> handling happens after the secondary CPUs are already disabled, hence
> this option ended-up being kind of a no-op - kernel skips the NMI trace
> in idling CPUs, which is the case of offline CPUs.
> 
> Fix it by checking the NMI backtrace bit in the panic_print prior to
> the CPU disabling function.
> 
> Fixes: 8d470a45d1a6 ("panic: add option to dump all CPUs backtraces in panic_print")
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V3:
> - No changes.
> 
> V2:
> - new patch, there was no V1 of this one.
> 
> Hi folks, thanks upfront for reviews. This is a new patch, fixing an issue
> I found in my tests, so I shoved it into this fixes series.
> 
> Notice that while at it, I got rid of the "crash_kexec_post_notifiers"
> local copy in panic(). This was introduced by commit b26e27ddfd2a
> ("kexec: use core_param for crash_kexec_post_notifiers boot option"),
> but it is not clear from comments or commit message why this local copy
> is required.
> 
> My understanding is that it's a mechanism to prevent some concurrency,
> in case some other CPU modify this variable while panic() is running.
> I find it very unlikely, hence I removed it - but if people consider
> this copy needed, I can respin this patch and keep it, even providing a
> comment about that, in order to be explict about its need.
> 
> Let me know your thoughts! Cheers,
> 
> Guilherme
> 
> 
>  kernel/panic.c | 47 +++++++++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
> [...]

Hi Andrew, sorry for the ping.

Does the patch makes sense for you? Any comments are much appreciated!
Tnx in advance,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
