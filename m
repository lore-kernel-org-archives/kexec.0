Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09D4C433FE
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 13:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YWYxkFZXThjLNa/8O0DbCXS6XUbf5wGMFsNuZnGFHYI=; b=dj93cAAe5Ro66p
	55PXACYH8Oxd8Sn7dc+fKHcTe4PxT7BBb8TCLl0kGGheTA2JadGF6akyd+Da2IwSIIHm6wCzRhBQN
	JGnY+YApDkhzjPI7LG9CGigbQg8kYwqZJWfrol///DiwOXB3WZeU8uU/eHEFUkUhDfODE3URLQLXW
	dSpPHVnh4AZOpoYXnRaIDpIa82SyvgSYLl8Gi7o19iaC6c4/PNl1FWt+CSLt+fCSY5p+71GwqK4iL
	wxjjZux0L7QJERhwmZlXbtJKzICBdrgflVTgB+es54Ep/Y3WOHnUshRSmfE0XwDuTHwUk4EVmM94D
	b3IXMpuuUdQ65HwO+NMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olsTZ-008JvJ-2S; Fri, 21 Oct 2022 13:54:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1old6E-001yq6-4G
	for kexec@lists.infradead.org; Thu, 20 Oct 2022 21:29:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BDC2B61D28;
	Thu, 20 Oct 2022 21:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD56C433D6;
	Thu, 20 Oct 2022 21:29:03 +0000 (UTC)
Date: Thu, 20 Oct 2022 17:29:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
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
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com,
 will@kernel.org, xuqiang36@huawei.com, Sergei Shtylyov
 <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH V3 06/11] tracing: Improve panic/die notifiers
Message-ID: <20221020172908.25c6e3a5@gandalf.local.home>
In-Reply-To: <20220819221731.480795-7-gpiccoli@igalia.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
	<20220819221731.480795-7-gpiccoli@igalia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_142910_265942_205C92C2 
X-CRM114-Status: GOOD (  11.80  )
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

On Fri, 19 Aug 2022 19:17:26 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

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

Sorry for the late reply.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
