Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAC5C00140
	for <kexec@archiver.kernel.org>; Mon, 15 Aug 2022 17:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jRj688FPBbflhYwSn+shEFHicUFGebqmvhco7fmeycI=; b=wjIvWNGJSjfMci
	u0zwySzhfZ4vnFQMKyxPifJyB8Ls7lUqL9uDQYtUO+njTWukSAEnrNAJ3wnxobe/7kRgUb2Ozbd1G
	4GmUJLdvtEIOT2quaD9FekFto33o6wgfK/gbwbOlzqekuiGUEfmwU98csyUXxw0ew7lnjtrj0YbdG
	KbpY3wSlAt1M7poVypDwHL+2CV6eFJpmeb9/JZFcVKUhCXJ2DYXQqK+FdXp3LzyPjB1hka+cCrTGv
	WjKLr3RMUmJimMvRicyTnH0Y6Eb7RAJKYZh9rQWiubh7Kh8NdQltaFZ8WWetdSuUCPUTlujqNI7H2
	VM3FugoTj0MCVAWcr0Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNdiN-0029UE-5k; Mon, 15 Aug 2022 17:17:23 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oL4Ta-00EcdT-Hp
	for kexec@lists.infradead.org; Mon, 08 Aug 2022 15:15:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8NeebcQIowJFvYNvYAuayRA5HrGpbu0y4rq77R8ZNew=; b=UkbTPpK3PkL/KNCksKY7NedBjm
	eKGiMxQ4EDIlwc6yVThl6uDq8BNqa4i68qOQ2Qq5S90ePBFJodmONvOinj6rYRKU6GiWn/OWgq1Es
	UIzqDDJemiX7jgCVd3GNHShRuixAW+yG8Oh+DqrjWqkwf8Py90cGVhk2xbcxCWicuz/ewTPJeLHxT
	KjoC96tOXtJRhzyQkOrOz8StFqrRq+Uh/Pu/C6+u0nELLuErbjXiUorKj+4jNXJfclDHIn47M4+xG
	zqeERGj2xybEfBqXzwIGK7cVMaWSp/uv9wMXfCaStJPbYwCSSyhl1n6XwAwA+F2AzoQY35Tq/eNZY
	v+RLic4w==;
Received: from [187.56.70.103] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oL4T6-002tRL-3C; Mon, 08 Aug 2022 17:15:00 +0200
Message-ID: <019ae735-3d69-cb4e-c003-b83cc8cd76f8@igalia.com>
Date: Mon, 8 Aug 2022 12:14:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 03/13] firmware: google: Test spinlock on panic path to
 avoid lockups
Content-Language: en-US
To: Evan Green <evgreen@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-efi@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com,
 Petr Mladek <pmladek@suse.com>, kexec@lists.infradead.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
 fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
 Jonathan Corbet <corbet@lwn.net>, d.hatayama@jp.fujitsu.com,
 dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
 mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
 john.ogness@linutronix.de, Kees Cook <keescook@chromium.org>,
 luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
 Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner
 <tglx@linutronix.de>, vgoyal@redhat.com, vkuznets@redhat.com,
 Will Deacon <will@kernel.org>, David Gow <davidgow@google.com>,
 Julius Werner <jwerner@chromium.org>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-4-gpiccoli@igalia.com>
 <CAE=gft71vH+P3iAFXC0bLu0M2x2V4uJGWc82Xa+246ECuUdT-w@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAE=gft71vH+P3iAFXC0bLu0M2x2V4uJGWc82Xa+246ECuUdT-w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220808_081530_595566_43B25A4D 
X-CRM114-Status: GOOD (  14.65  )
X-Mailman-Approved-At: Mon, 15 Aug 2022 10:10:48 -0700
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

On 08/08/2022 02:07, Evan Green wrote:
> On Tue, Jul 19, 2022 at 12:55 PM Guilherme G. Piccoli
> <gpiccoli@igalia.com> wrote:
>>
>> Currently the gsmi driver registers a panic notifier as well as
>> reboot and die notifiers. The callbacks registered are called in
>> atomic and very limited context - for instance, panic disables
>> preemption and local IRQs, also all secondary CPUs (not executing
>> the panic path) are shutdown.
>>
>> With that said, taking a spinlock in this scenario is a dangerous
>> invitation for lockup scenarios. So, fix that by checking if the
>> spinlock is free to acquire in the panic notifier callback - if not,
>> bail-out and avoid a potential hang.
>>
>> Fixes: 74c5b31c6618 ("driver: Google EFI SMI")
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: David Gow <davidgow@google.com>
>> Cc: Evan Green <evgreen@chromium.org>
>> Cc: Julius Werner <jwerner@chromium.org>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> Reviewed-by: Evan Green <evgreen@chromium.org>

Thanks a bunch Evan!

Ard / Greg, do you think you could get this patch through your -next (or
-fixes) trees? Not sure which tree is the most common for picking GSMI
stuff.

I'm trying to get these fixes merged individually in their trees to not
stall the whole series and increase the burden of re-submitting.
Thanks in advance,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
