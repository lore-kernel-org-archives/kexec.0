Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K3R3W-0003BT-9z
	for kexec@lists.infradead.org; Tue, 03 Jun 2008 07:35:42 +0000
Date: Tue, 3 Jun 2008 09:36:18 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Fix implicit declaration of inb/outb
Message-ID: <20080603093618.7974ffec@halley.suse.de>
In-Reply-To: <e2ed954f0806021843r648e4276v6c0d49aa1f601e17@mail.gmail.com>
References: <1212448806-22450-1-git-send-email-bwalle@suse.de>
	<e2ed954f0806021843r648e4276v6c0d49aa1f601e17@mail.gmail.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jamey Sharp <jamey@thetovacompany.com>
Cc: kexec@lists.infradead.org

* Jamey Sharp [2008-06-02 18:43]:
>
> Oh, dear--that doesn't work.

Thanks for catching that issue. But it also means that it *didn't* work
on x86-64 because inb() needed to call a function (I don't think that
the compiler did inline something when it even didn't know the
prototype).

My next patch should address that issue by just using the same header
file for i386 and x86-64. No need for code duplication here. And I
think we should use __always_inline__ in that case (yes, it's GNU only
but I think we can afford that for kexec-tools) to make sure that the
inlining takes also place for -O0.'


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Maintenance

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
