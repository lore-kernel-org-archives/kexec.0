Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SCnmh-0002c8-FH
 for kexec@lists.infradead.org; Wed, 28 Mar 2012 07:59:12 +0000
Message-ID: <4F72C4C8.2000600@canonical.com>
Date: Wed, 28 Mar 2012 09:59:04 +0200
From: Bouchard Louis <louis.bouchard@canonical.com>
MIME-Version: 1.0
Subject: Re: [PATCH makedumpfile v2 0/4] LZO Compression Support
References: <20120323163303.dee3795c.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120323.172608.488340508.d.hatayama@jp.fujitsu.com>
 <20120328141809.fac2af86.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120328.165020.183027661.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120328.165020.183027661.d.hatayama@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp, crash-utility@redhat.com

Hello,

Le 28/03/2012 09:50, HATAYAMA Daisuke a =E9crit :
> =

> Yes, I of course agree with the fact that makedumpfile for kdump 2nd
> kernel should always be built in statically linked way.
> =

> But I think two problems are different, that is, the problem making
> users easily able to choose build option by autotools, and the problem
> guranteeing that the makedumpfile for kdump 2nd kernel be built always
> statically.
> =


I don't see why it should be statically linked. Debian & Ubuntu both use
a dynamically linked makedumpfile for the 2nd kdump kernel.

Debian executes makedumpfile on the 'real' root FS while Ubuntu runs it
in the initramfs. It is simply a chroot on the root FS being mounted on
/root.

HTH,

...Louis
-- =

Louis Bouchard
Backline Support Analyst
Canonical Ltd
Ubuntu support: http://landscape.canonical.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
