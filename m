Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF86FC32789
	for <kexec@archiver.kernel.org>; Fri, 19 Aug 2022 09:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=osM3ZsPxmY2aANPeRHIalUb2YY931V7Tb70mQU0PLyA=; b=JmwXjc2hbE6aMa
	MIZVUasGEhqVoBu2fnaQBq893kATV+tqfArdfAkzcEzOKu5g4SL5zWB47sDyOVyfTgQCDP4DaFIkc
	RBZ2ygAL4JGRK0JqEC0cGUKVD1kHsLufkVK9WmrbGZz4JkQZFtw8XNIP3Q7CBBWiIC/EfV/EvOlmZ
	09HRhOtElcAWYOLwp7gnJ0EHJzFj0RdPk83+XyCzfzKmvjb3ra2Tk6tOHK74ofYZ5zOcoHwz//n5Y
	97Rl8GSgBZmWQD7mm1wlntvQunjb/gKjvskRJ2TFNMoQnPf5vFRFxjUFOUDLVV+UgozJYFqwS2vEW
	Smr/MiK6r2KZbTEUOYFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOyWh-0058VF-Vm; Fri, 19 Aug 2022 09:42:51 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOQBD-006jgS-KA
	for kexec@lists.infradead.org; Wed, 17 Aug 2022 21:02:25 +0000
Received: from zn.tnic (p200300ea971b98b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b0:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 751AA1EC050F;
	Wed, 17 Aug 2022 23:02:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1660770133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=uZECItNhJdPNjavGxubtrXL0+yXBikF6DOM/KqS2u80=;
	b=b7hT+f/JsqrlDXJwGOmfuimkYKB0/oh33XvT0jx0BM2Bc4a4tijQHcHePAxE0BR9Fy9hu+
	8Fy2/lMRzSkD3Pm0ODl6fqBgv8Ov0DWOXe2bQ/wNfgDKKHKkgY8Z7dpY0ES764epXpTN62
	dh5wMxHfa75JuW2trzFMuEyQ3QGfiG4=
Date: Wed, 17 Aug 2022 23:02:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
	halves@canonical.com, fabiomirmar@gmail.com,
	alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
	arnd@arndb.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com,
	dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
	gregkh@linuxfoundation.org, mikelley@microsoft.com,
	hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
	john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org,
	mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
	stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com,
	vkuznets@redhat.com, will@kernel.org, linux-edac@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 10/13] EDAC/altera: Skip the panic notifier if kdump
 is loaded
Message-ID: <Yv1XVRmTXHLhOkER@zn.tnic>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-11-gpiccoli@igalia.com>
 <Yv0mCY04heUXsGiC@zn.tnic>
 <46137c67-25b4-6657-33b7-cffdc7afc0d7@igalia.com>
 <Yv1C0Y25u2IB7PCs@zn.tnic>
 <7f016d7f-a546-a45d-c65c-bc35269b4faa@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f016d7f-a546-a45d-c65c-bc35269b4faa@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_140223_858794_727D4718 
X-CRM114-Status: GOOD (  11.83  )
X-Mailman-Approved-At: Fri, 19 Aug 2022 02:42:41 -0700
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

On Wed, Aug 17, 2022 at 05:28:34PM -0300, Guilherme G. Piccoli wrote:
> My understanding is the same as yours, i.e., this is not possible to
> collect from vmcore, it requires register reading. But again: if you
> kdump your machine today, you won't collect this information, patch
> changed nothing in that regard.

Why won't you be able to collect it? You can certainly access dmesg in
the vmcore and see those errors logged there.

> The one thing it changes is that you'd skip the altera register dump if
> kdump is set AND you managed to also set "crash_kexec_post_notifiers".

What your patch changes is, it prevents s10_edac_dberr_handler() from
logging potentially important fatal hw errors when kdump is loaded.

If Dinh is fine with that, I'll take the patch. But it looks like a bad
idea to me.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
