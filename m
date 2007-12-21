Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J5WlX-0006xv-C4
	for kexec@lists.infradead.org; Fri, 21 Dec 2007 01:33:37 +0000
From: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [patch] kexec: Use target linker for purgatory
Date: Fri, 21 Dec 2007 10:28:22 +0900
References: <476B05C0.30201@am.sony.com>
In-Reply-To: <476B05C0.30201@am.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200712211028.23905.jk@ozlabs.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org

Geoff,

> Pugatory files need to be linked with the target linker,
> not the build linker.
>
>  	$(MKDIR) -p $(@D)
> -	$(LD) $(LDFLAGS) -o $@ $^
> +	$(CC) $(LDFLAGS) -o $@ $^

Shouldn't that be $(TARGET_CC) then?

Cheers,


Jeremy


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
