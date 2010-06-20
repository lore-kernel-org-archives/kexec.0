Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OQGkc-0002uq-IM
	for kexec@lists.infradead.org; Sun, 20 Jun 2010 09:23:39 +0000
Date: Sun, 20 Jun 2010 11:23:34 +0200
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] kexec: export kexec.h to userspace
Message-ID: <20100620092333.GA10987@basil.fritz.box>
References: <20100619132235.GA24200@basil.fritz.box>
	<20100619182419.GA22079@merkur.ravnborg.org>
	<20100619195345.GT18946@basil.fritz.box>
	<20100620082315.GA23188@merkur.ravnborg.org>
	<m1bpb6ozef.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1bpb6ozef.fsf@fess.ebiederm.org>
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
Cc: Kexec Mailing List <kexec@lists.infradead.org>, akpm@linux-foundation.org, Andi Kleen <andi@firstfloor.org>, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org

> Can we please do this the other way around and create a kexec_user.h?
> Having a an xxx_user.h is a pattern we already have in the kernel.
> I can't find a signle xxxx_kernel.h

If you do that you have to change the man page.

Or just keep my simple patch.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
