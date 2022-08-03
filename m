Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E72C19F28
	for <kexec@archiver.kernel.org>; Wed,  3 Aug 2022 13:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LTjHqD3dWwXzDu3tsa7SC+BRxhVEo7+9bDZSHmINuGg=; b=B8ftwXvsax7J+/
	5zpexjzz8aLWs5Xas6TZIc/mGiYtbQaMypD2aAqIz943EW/8Cf4SVKgGnStaRLeCp9/ouGu1gSGMR
	UWC9AXeokHJOdT2Mro9WKHtHNEMNF0pnf+CX8oj0ydbotlpI53tMJhir/evwbl0W/dIyLoFC8tLDU
	z3xHXivCa0JaKCNNlFKl7NgJYke//PKT5oM9OK6Vyh77TbPtFuXXfZ6Q+zy/ZwOQ9uKvsQNXkFqpo
	eGJ+sKBZ1fm4BCPfuTPThcQ7LNcs1WU9AFyrDbfQOVGVZidhkp8vLWilJzcrMfAaL7UFA0dgZJJH2
	nBSsyp+DkAeVmYxlG8Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJE2S-006AOc-1H; Wed, 03 Aug 2022 13:03:52 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJCoi-005Vy6-DM
	for kexec@lists.infradead.org; Wed, 03 Aug 2022 11:45:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WwoYUtZ0SBTmBiplSSvGAX51ksFV+vMwKXq76cKmqZc=; b=PH12LYzaBJIsPsoorzy/LOBk5b
	DAOCX7TeriDwoMrFWce+imjisHDjOUS6VebMOD4MKkAKoi3/06ZTZxqGYd6tHLqJG3m3/g03IEiRd
	cdx+LXVeIoNdp1GykmgvwDmzYt510+KI7GCtl/kN9/yG0hBmRV8NjBv0ZfAn3QAnITSgZN/iM/Hr5
	z/jod+tSK7jWfa8nKT6A3NJCTnwESuTQ+WhsSeIYAw7tRMdrgDi36Fw1l2oarC72jun4+QOKQu6Sw
	epKtE8zVB6n4PBly3ussy+gVloREkv+rf3PlCC4EkARbXhmiWNUBcEPUaHX87BWF1Hq2DBStbKaTG
	CoADEnDA==;
Received: from [187.56.70.103] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oJCo2-00FTyF-Ow; Wed, 03 Aug 2022 13:44:54 +0200
Message-ID: <943cb74b-96b8-a8d4-881e-4ff56b35bd7f@igalia.com>
Date: Wed, 3 Aug 2022 08:44:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 08/13] tracing: Improve panic/die notifiers
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kexec@lists.infradead.org,
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
 Sergei Shtylyov <sergei.shtylyov@gmail.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-9-gpiccoli@igalia.com>
 <YupBtiVkrmE7YQnr@MiWiFi-R3L-srv> <YupFeQ6AcfjUVpOW@MiWiFi-R3L-srv>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YupFeQ6AcfjUVpOW@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_044536_528810_0E7945C1 
X-CRM114-Status: GOOD (  11.74  )
X-Mailman-Approved-At: Wed, 03 Aug 2022 06:03:51 -0700
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

On 03/08/2022 06:52, Baoquan He wrote:
> [...]
>>
>> Although the switch-case code of original trace_die_handler() is werid, 
>> this unification is not much more comfortable. Just personal feeling
>> from code style, not strong opinion. Leave it to trace reviewers.
> 
> Please ignore this comment.
> 
> I use b4 to grab this patchset and applied, and started to check patch
> one by one. Then I realize it's all about cleanups which have got
> consensus in earlier rounds. Hope it can be merged when other people's
> concern is addressed, the whole series looks good to me, I have no
> strong concern to them.
> 

Thanks a lot for your reviews Baoquan, much appreciated =)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
