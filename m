Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D323C32771
	for <kexec@archiver.kernel.org>; Sun, 18 Sep 2022 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+N0wo35uuFHaUDXNe3PkXEQeww6/8ZuI2U2zeU8GD00=; b=2wn6FdM28m9Pmu
	9X5/SmPO+NnptkTJJ9NPUNQUYQ1UbO7ABF678OufbCxrLpTMxbdSV4heQqx7oRCEO8EbjeOT37lHl
	nvH5HwzDoj3eaCsaeTQ8qVUFxQclHJI+mKBjl/fRE9DLV9NFIjwgEz77DyhCjClBagg5GoVZeUVh8
	w9yPEsGyjcpYUaC9elCYPHoRgCreKheKldF2/isd7pPJTQQCz3JSTrXtbo7FED5un7WYEM4hiceH6
	u9zfybh4gbYDeCchTkknwf5JfFrb8J3g0o0ysy0j4qkWb6ff6mf412N8oZL8mtgS/XtNbPZtgj+QX
	E5/X/WOr2A4GqR3/mJyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZv6A-00GvXF-1k; Sun, 18 Sep 2022 14:16:42 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZur9-00GmJM-Tb; Sun, 18 Sep 2022 14:01:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FD364ic7hwXbBNt0PyaEumKr+hXe/YHVGpj8xZwTcQc=; b=LlJa5ekJMCr4ru1VcgID5m7osa
	sLReM65mKivTkd/sK2WTXhur5XEJw1doYWDdqyLwUwo9WilGxBB5RPqM/K9n1LmBw//7tRDRDYHNL
	zBZL5uY3ffn3ONsHRNzqHIdmAudHZ3JULNK/FZzyEjmdWgSMxmej9U9tOy+kTr0D/SNLspstDV9uE
	7duwV8HQMtQv/TRS2hckPyWHujWlXVG3pgS90S7tcx39nUs9ztQL/9eeB2XhyUk4MygBAJAPeMa1+
	4IvXfsOdBUP4e73JwGJoGCQ7Yyn2xI+u8FSLn1a2kZnqfZO3GvPJatuV5CKnUsiACriLunll6O4i/
	2x0W5XsA==;
Received: from 201-27-35-168.dsl.telesp.net.br ([201.27.35.168] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oZur6-0080lc-Gi; Sun, 18 Sep 2022 16:01:08 +0200
Message-ID: <1f464f3d-6668-9e05-bcb7-1b419b5373e1@igalia.com>
Date: Sun, 18 Sep 2022 11:00:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3 04/11] um: Improve panic notifiers consistency and
 ordering
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: kexec@lists.infradead.org, bhe@redhat.com, pmladek@suse.com,
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
 peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
 stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com,
 vkuznets@redhat.com, will@kernel.org, xuqiang36@huawei.com,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Richard Weinberger <richard@nod.at>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-5-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220819221731.480795-5-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220918_070111_983620_47F7506C 
X-CRM114-Status: UNSURE (   9.65  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sun, 18 Sep 2022 07:16:40 -0700
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
> Currently the panic notifiers from user mode linux don't follow
> the convention for most of the other notifiers present in the
> kernel (indentation, priority setting, numeric return).
> More important, the priorities could be improved, since it's a
> special case (userspace), hence we could run the notifiers earlier;
> user mode linux shouldn't care much with other panic notifiers but
> the ordering among the mconsole and arch notifier is important,
> given that the arch one effectively triggers a core dump.
> 
> Fix that by running the mconsole notifier as the first panic
> notifier, followed by the architecture one (that coredumps).
> 
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Richard Weinberger <richard@nod.at>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> V3:
> - No changes.
> [...]

Hi Johannes, sorry for the ping. Do you think you could pick this one?
Or if you prefer, I can resend it alone (not in the series) - let me
know your preference.

Thanks,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
