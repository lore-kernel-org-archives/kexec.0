Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA32C982DA
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 21:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WuxoEppFDE+hLBKCGA1L/0v2+lTpHSjJWhfVv76jKts=; b=kG0lTsuGj6tMipKnCDE2Nf57aO
	hr5oTOimarswa3h1kd3Ub+0dprdBlynIeL5HOHU94BMVF07zZFqvnHjpewbjYxpga0ajHKcIzXua2
	JJNPgqL8mdGrwxJFv10GaEbLjjn4vuU4uUUn658COS0yvNvUB80iQL4GuzXRWKlBUgKxQGarUlTD5
	teQfnu3pFyP0LuJ1SvGI6n1Cb/PpNOw9T//toxHapZ00VBmmTLQZ7pYUZOEdKj4R03WrqDzCLLyJ3
	4a7i38xMoiGoBp5aws4B3qxNK4O42G2wz2Y81vaYmAEEFStcLjoywC1ysSHUU7UPb61p0RoNLts2U
	PScDb1JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8OuJ-00000000RO9-3QhQ;
	Sun, 20 Sep 2026 21:17:07 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8OuH-00000000RNj-3aAZ
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 21:17:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=WuxoEppFDE+hLBKCGA1L/0v2+lTpHSjJWhfVv76jKts=; b=JCsKlXIbtQo5QkxsOYKHxV/5bX
	ydTQ8vbPPlRgJzMO1bpUUqQ3VTREbZBBc1Fmv8Dq3nkaiZkCiaW23EOg/dndqgivocFD96EiuIjKL
	xwen7ZamyZ7H5vtn6k0GJdvXwtkmaQLw/RwLh3xiPjmdNegIz0jzxzVsdD/ypM/gUY6fqLbKvUHXh
	H8d7jS6FDW8t1qentVfwJk7LdkoAr/7Jj3o1qJZP4QXYIQZnKm7eJEWoWrBSnq6R7q+gG0XWal4ke
	XgDOPGbJ5XGePkQBzBI04UbA8G1U/Mt/cG2JQXDpm4StwRTbE5dOTJDdq4t+fYDPvc893cJMWoOAn
	p89LTJ0g==;
Received: from [191.32.244.140] (helo=[192.168.1.56])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x8Osi-004orP-0B; Sun, 20 Sep 2026 23:15:27 +0200
Message-ID: <ebcf63b1-7410-4cb3-425c-da48b557556d@igalia.com>
Date: Sun, 20 Sep 2026 18:15:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump by
 default
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Petr Mladek <pmladek@suse.com>, Borislav Petkov <bp@alien8.de>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
 Joel Granados <joel.granados@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, virtualization@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 John Ogness <john.ogness@linutronix.de>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>,
 Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 Stephen Brennan <stephen.s.brennan@oracle.com>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
 <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
 <aquttpMVKX8e6zGB@pathway.suse.cz>
 <CABQX2QPJVg-dZB9f4ydRU_5W7nyWwVCQtDoRGoe1+9cA7wyUDw@mail.gmail.com>
 <bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com>
 <CABQX2QMDNHcKotEa_t9Y37L+uHhV-CfqSR2vcRpNT1c2O9C_2Q@mail.gmail.com>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CABQX2QMDNHcKotEa_t9Y37L+uHhV-CfqSR2vcRpNT1c2O9C_2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_141705_919113_78F00E29 
X-CRM114-Status: GOOD (  17.06  )
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

On 18/09/2026 20:00, Zack Rusin wrote:
> [...]
> Hi, Guilherme.
> 
> Thanks for looking at this and for adding Stephen. I'll keep you both copied.
> 

Hi Zach, thanks!


> [...] 
> I'm happy to add that as a separate patch if Petr agrees. With it set,
> the new list would follow ordinary panic-notifier ordering relative to
> kdump: it would run before a successful transition only when
> crash_kexec_post_notifiers is also set. If panic reaches the late
> site, the list would remain eligible to run there. I'd keep that site
> after sys_info() and before the kmsg dumpers so the log includes the
> additional notifier and panic_print output available at that point.
> 
> I've called it panic_pre_kdump_postpone after the list, but I'm fine
> with whatever name you and Petr prefer.
> 

Cool, makes sense to me and feel free to change names, I'm OK with any
name heheh


> [...] 
> Would keeping the two call sites, with postponement in a separate
> patch, work for you and Petr?
> 

Fine for me - thanks for working on that!
Cheers,


Guilherme


