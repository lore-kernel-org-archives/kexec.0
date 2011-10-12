Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-gx0-f177.google.com ([209.85.161.177])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RDu6y-0003pj-PQ
	for kexec@lists.infradead.org; Wed, 12 Oct 2011 08:24:25 +0000
Received: by ggnm2 with SMTP id m2so524515ggn.36
	for <kexec@lists.infradead.org>; Wed, 12 Oct 2011 01:24:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1317603918-30762-1-git-send-email-horms@verge.net.au>
References: <1317603918-30762-1-git-send-email-horms@verge.net.au>
Date: Wed, 12 Oct 2011 17:24:23 +0900
Message-ID: <CANqRtoT1ik9x+s10K6dBy34pDv5+up9dCweVF5MOctWeB=gxAw@mail.gmail.com>
Subject: Re: [PATCH v2] sh: Take into account the base of System RAM in
	virt_to_phys()
From: Magnus Damm <magnus.damm@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Paul Mundt <lethal@linux-sh.org>, kexec@lists.infradead.org, linux-sh@vger.kernel.org

On Mon, Oct 3, 2011 at 10:05 AM, Simon Horman <horms@verge.net.au> wrote:
> Previously virt_to_phys() assumed that physical memory always started
> at address 0. This is not always the case.
>
> Tested on an sh7757lcr (32bit system) whose only System RAM region is
> 40000000-4effffff and an ecovec24 (29bit system).
>
> Signed-off-by: Simon Horman <horms@verge.net.au>
>
> ---
> =A0kexec/arch/sh/kexec-sh.c | =A0 45 ++++++++++++++++++++++++++++++++++++=
++++++++-
> =A01 files changed, 44 insertions(+), 1 deletions(-)
>
> v2
> * Only use the base of System RAM as an offset into physical memory
> =A0if 32bit addressing is in use.

This version looks much better, thanks!

/ magnus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
