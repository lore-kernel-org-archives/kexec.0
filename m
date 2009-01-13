Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]
	helo=WA4EHSOBE004.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LMoCm-0004de-4t
	for kexec@lists.infradead.org; Tue, 13 Jan 2009 18:41:38 +0000
Message-ID: <496CE056.5040904@am.sony.com>
Date: Tue, 13 Jan 2009 10:41:26 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: newbie question: kexec linux-based bootstrap
References: <F795765B112E7344AF36AA911279641508F6AFCB@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <F795765B112E7344AF36AA911279641508F6AFCB@xmb-sjc-212.amer.cisco.com>
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
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Cc: kexec@lists.infradead.org

Hi,

Bizhan Gholikhamseh (bgholikh) wrote:
> I have been investigating how to boot Linux as bootstrap to boot another
> Linux.

The ps3 uses this method for its bootloaders.  The linux kernel and a
small file system are put into the system's flash memory.

You can find some (old) info about the petitboot bootloader here:

  http://ozlabs.org/~jk/projects/petitboot/

Another kexec based bootloader is kboot:

  http://kboot.sourceforge.net/

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
