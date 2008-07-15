Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KIZY8-0001qg-7h
	for kexec@lists.infradead.org; Tue, 15 Jul 2008 01:41:52 +0000
From: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] Use CFLAGS for compiling bin2hex
Date: Tue, 15 Jul 2008 11:41:31 +1000
References: <1216046012-32349-1-git-send-email-bwalle@suse.de>
In-Reply-To: <1216046012-32349-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200807151141.31994.jk@ozlabs.org>
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
To: kexec@lists.infradead.org
Cc: Bernhard Walle <bwalle@suse.de>


>  $(BIN_TO_HEX): CC=$(BUILD_CC)
> -$(BIN_TO_HEX): CFLAGS=$(BUILD_CFLAGS)
> +$(BIN_TO_HEX): CFLAGS+=$(BUILD_CFLAGS)
>  $(BIN_TO_HEX): LDFLAGS=

Are you sure? CFLAGS will include stuff for $host (eg, -m64 for a 64-bit 
host machine).

Cheers,


Jeremy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
