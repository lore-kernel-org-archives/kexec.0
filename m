Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBF0C43217
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 13:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=otZc2dWk+lrGip+eRmQhtpxMgVLAUh0zpQC8zveFfSg=; b=UIHNPH0GV0JPjv
	Pf2M1f7tUFBowKxmF2RygFVKdLirjagNNLQ4U8t6ookFhLMW2Bj5oxVDQnG52wQ8yG+HXV3SgFF28
	zLTUMO+o/PvxLJtKIcFRuWYTsr20mfVucOusxA2YRVDkKgt5AshOSM/SAfl0g32T6pNEUxk2env+T
	h1BDG215v7Lt97yKbwZNcmCjGqxnVriAR7Yj0onnpMRJi0ecB8DoRJXidlGZ3T7HH1tTJFm5rViPu
	56ArJbScpALXQU+aTShWtviG4o/pAxe0xTCXySJ9B2EjlVqpDrE1Td31ovRxj7Lvv85Qbo4NB8FGO
	6F0z+kREjaXfn0OAnWDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olsTa-008Jwt-I8; Fri, 21 Oct 2022 13:54:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oldwA-002Ef1-LA
	for kexec@lists.infradead.org; Thu, 20 Oct 2022 22:22:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E8A9161D33;
	Thu, 20 Oct 2022 22:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0BAC433D6;
	Thu, 20 Oct 2022 22:22:45 +0000 (UTC)
Date: Thu, 20 Oct 2022 18:22:49 -0400
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
Message-ID: <20221020182249.691bb82a@gandalf.local.home>
In-Reply-To: <6e2396d1-d0b2-0d1e-d146-f3ad7f2b39f8@igalia.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
	<20220819221731.480795-7-gpiccoli@igalia.com>
	<20221020172908.25c6e3a5@gandalf.local.home>
	<6e2396d1-d0b2-0d1e-d146-f3ad7f2b39f8@igalia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_152250_821539_D10E3070 
X-CRM114-Status: UNSURE (   9.60  )
X-CRM114-Notice: Please train this message.
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

On Thu, 20 Oct 2022 18:53:43 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> Could you pick it in your tree? Or do you prefer that I re-send as a
> solo patch, with your ACK?

I wasn't sure there were any dependencies on this. If not, I can take it.

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
