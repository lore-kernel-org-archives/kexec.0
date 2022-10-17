Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DDCC433FE
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 13:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=60qHG85ROygkXG4j7a3r7Ro49qwKZsUWxqTf5u17F70=; b=NOmCO/NozS4CbH
	fD4WP6CtaZOQg91t2kkWbTYCW7bSOG1B+1oa1hsDi/hJ0eusjnuXkOO2/VCdTo6NM4ti13lmQoAwD
	XWZvk42uZ3fEjXJ4F7vpexkAfnpt10tOUnwGWNi0JTmsCMk0ejO5HYUYWViv8GbZ4iCZDEoCLSSAq
	7ZBjeMcEzjPJgwE5UgyCmhq7KY3y87OvfenH+4kWXoTbdzdplT8fIZ+n5oJASvjPYBTb1gKdv3H0C
	BEaufWjCQomQnO9PeXRc/iOjVMTMdoWogWPYXRlivG3dYLa77GUBf9PFzcLwvrl9AHNd1yu18ruem
	VmvCNyKVxpJxSSMPlenA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olsTO-008JSh-UG; Fri, 21 Oct 2022 13:54:06 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQlB-00CTO9-Ms
	for kexec@lists.infradead.org; Mon, 17 Oct 2022 14:06:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nnNaPHsK6FwMseLsC5mx5u23AVdFa4nC/67pGYTx9iw=; b=VnO3i3W9PnC25b/uABFAWH4zD9
	IddvmWj5M3YARUxvtiYJK9qOj9HsnaTXguCNUswoIDWihuxqgA0z7Td2FjR78uWHBvcy+a7MouxzO
	1ugt/DYFA1Lgg4Qfzki6NpD8qJbKPgg0OYXn1Jee7JsOdT3DPkQOl31y6AESAsFkdH5I40wha5BPs
	/BZtAPyrnYLzNk5NXdWpCnb0ZcB2xcASRfSNL/vA50luXoXH2aFpANFoii+++U5P/OCWXal++FJva
	NVxuR2YBT6IE5QidG5q30Mj/tkJnoKBETl2z1fasjEJLkbmLG+AjZLtpC7qOGEXBxs/bsk8YLuC0z
	EnRJofeg==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1okQkz-000OT3-Sj; Mon, 17 Oct 2022 16:06:17 +0200
Message-ID: <1df38599-ace7-5673-4cbd-7861de385d79@igalia.com>
Date: Mon, 17 Oct 2022 11:05:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 08/11] EDAC/altera: Skip the panic notifier if kdump is
 loaded
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: Dinh Nguyen <dinguyen@kernel.org>, Tony Luck <tony.luck@intel.com>,
 linux-edac@vger.kernel.org, bp@alien8.de
Cc: kexec@lists.infradead.org, bhe@redhat.com, pmladek@suse.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
 fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, corbet@lwn.net,
 d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com,
 feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com,
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de,
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org,
 xuqiang36@huawei.com
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-9-gpiccoli@igalia.com>
 <742d2a7e-efee-e212-178e-ba642ec94e2a@igalia.com>
In-Reply-To: <742d2a7e-efee-e212-178e-ba642ec94e2a@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_070629_750559_D80401C8 
X-CRM114-Status: GOOD (  10.66  )
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

On 18/09/2022 11:10, Guilherme G. Piccoli wrote:
> On 19/08/2022 19:17, Guilherme G. Piccoli wrote:
>> The altera_edac panic notifier performs some data collection with
>> regards errors detected; such code relies in the regmap layer to
>> perform reads/writes, so the code is abstracted and there is some
>> risk level to execute that, since the panic path runs in atomic
>> context, with interrupts/preemption and secondary CPUs disabled.
>>
>> Users want the information collected in this panic notifier though,
>> so in order to balance the risk/benefit, let's skip the altera panic
>> notifier if kdump is loaded. While at it, remove a useless header
>> and encompass a macro inside the sole ifdef block it is used.
>>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Petr Mladek <pmladek@suse.com>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>>
>> ---
>>
>> V3:
>> - added the ack tag from Dinh - thanks!
>> - had a good discussion with Boris about that in V2 [0],
>> hopefully we can continue and reach a consensus in this V3.
>> [0] https://lore.kernel.org/lkml/46137c67-25b4-6657-33b7-cffdc7afc0d7@igalia.com/
>>
>> V2:
>> - new patch, based on the discussion in [1].
>> [1] https://lore.kernel.org/lkml/62a63fc2-346f-f375-043a-fa21385279df@igalia.com/
>>
>> [...]
> 
> Hi Dinh, Tony, Boris - sorry for the ping.

Hey folks, apologies for the new ping.

Is there anything to improve here maybe? Reviews / opinions are very
appreciated!
Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
