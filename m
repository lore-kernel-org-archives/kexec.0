Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wx-out-0506.google.com ([66.249.82.224])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JoSAT-00080w-07
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 23:44:57 +0000
Received: by wx-out-0506.google.com with SMTP id s7so2058532wxc.24
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 16:44:56 -0700 (PDT)
Message-ID: <e2ed954f0804221644y436bd6cdoeb1fed2fd5d04ccb@mail.gmail.com>
Date: Tue, 22 Apr 2008 16:44:55 -0700
From: "Jamey Sharp" <jamey@thetovacompany.com>
Subject: Re: kexec --real-mode
In-Reply-To: <20080422151622.43c85a00@strauss.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
References: <20080422151622.43c85a00@strauss.suse.de>
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

On Tue, Apr 22, 2008 at 6:16 AM, Bernhard Walle <bwalle@suse.de> wrote:
> did anybody try the --real-mode option with current release? I tried
> it on two machines, and on one machine it just reboots, on the other
> machine it hangs.

I think you're experiencing a bug that I just proposed a patch for. :-)
You can confirm that: try adding the "--debug" option to your kexec
call. If that works correctly, then I think you'll find that the patch
in "[PATCH 2/9] Fix copy-paste bug: entry16 does not start at
entry16_debug" will solve your problem. That's archived here:

http://lists.infradead.org/pipermail/kexec/2008-April/001581.html

Jamey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
