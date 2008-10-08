Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KnTuf-0000Ww-5g
	for kexec@lists.infradead.org; Wed, 08 Oct 2008 07:56:53 +0000
From: Andreas Schwab <schwab@suse.de>
Subject: Re: [patch] ia64: Order of operations bug in PT_LOAD segment reader
References: <20081008064940.GA11893@verge.net.au>
Date: Wed, 08 Oct 2008 09:56:49 +0200
In-Reply-To: <20081008064940.GA11893@verge.net.au> (Simon Horman's message of
	"Wed, 8 Oct 2008 17:49:41 +1100")
Message-ID: <jeljwza5a6.fsf@sykes.suse.de>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Bernhard Walle <bwalle@suse.de>, "Luck,
	Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Jay Lan <jlan@sgi.com>

Simon Horman <horms@verge.net.au> writes:

> The bug comes about because the break statment was never executed because
> the if clause would bever be true because the if clause will never be true
> because &  has higher precedence than !=3D.
                 ^^^^^^
                 lower

Andreas.

-- =

Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
