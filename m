Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from an-out-0708.google.com ([209.85.132.242])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K3LYb-0000FZ-9m
	for kexec@lists.infradead.org; Tue, 03 Jun 2008 01:43:25 +0000
Received: by an-out-0708.google.com with SMTP id c24so326527ana.99
	for <kexec@lists.infradead.org>; Mon, 02 Jun 2008 18:43:24 -0700 (PDT)
Message-ID: <e2ed954f0806021843r648e4276v6c0d49aa1f601e17@mail.gmail.com>
Date: Mon, 2 Jun 2008 18:43:23 -0700
From: "Jamey Sharp" <jamey@thetovacompany.com>
Subject: Re: [PATCH] Fix implicit declaration of inb/outb
In-Reply-To: <1212448806-22450-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
References: <1212448806-22450-1-git-send-email-bwalle@suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

On Mon, Jun 2, 2008 at 4:20 PM, Bernhard Walle <bwalle@suse.de> wrote:
> --- a/purgatory/arch/i386/console-x86.c
> +++ b/purgatory/arch/i386/console-x86.c
> @@ -1,5 +1,5 @@
>  #include <stdint.h>
> -#include <arch/io.h>
> +#include <sys/io.h>
>  #include <purgatory.h>

Oh, dear--that doesn't work. I just submitted the opposite patch a few
weeks ago, because readw and writew are in arch/io.h but not sys/io.h.
Undoing that would break i386 again; details are in the commit
message.

Jamey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
