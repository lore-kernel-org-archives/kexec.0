Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OQ3yw-0000yz-7c
	for kexec@lists.infradead.org; Sat, 19 Jun 2010 19:45:35 +0000
Date: Sat, 19 Jun 2010 21:45:32 +0200
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] kexec_load manpage
Message-ID: <20100619194532.GQ18946@basil.fritz.box>
References: <20100619132633.GA24277@basil.fritz.box>
	<m1mxuqu8yr.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1mxuqu8yr.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-man@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Kexec Mailing List <kexec@lists.infradead.org>, mtk.manpages@gmail.com

On Sat, Jun 19, 2010 at 12:18:52PM -0700, Eric W. Biederman wrote:
> Andi Kleen <andi@firstfloor.org> writes:
> 
> > Here are the beginnings of a kexec_load manpage.
> >
> > Probably needs some more review from Eric and may need some additional
> > information.
> >
> > The syscall is actually only usable with a kernel patch to export
> > the header I just sent separately.
> 
> The syscall has been used for years with a separate non-kernel header.

Yes but that's not a sane interface that can be documented.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
