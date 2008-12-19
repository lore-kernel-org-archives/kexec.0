Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from metropolitan.anduras.de ([80.237.200.159])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LDjz4-000399-Fh
	for kexec@lists.infradead.org; Fri, 19 Dec 2008 18:21:58 +0000
Message-ID: <494BE644.9000705@anduras.de>
Date: Fri, 19 Dec 2008 19:21:56 +0100
From: Sven Anders <anders@anduras.de>
MIME-Version: 1.0
Subject: Re: kexec kernel with embedded initrd?
References: <49498F24.7040000@anduras.de> <494BD7DF.8080101@am.sony.com>
In-Reply-To: <494BD7DF.8080101@am.sony.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoffrey.levand@am.sony.com>, kexec@lists.infradead.org

Geoff Levand schrieb:
> Sven Anders wrote:
>> I want to boot a kernel (bzImage) with an embedded initrd (CPIO archive =
using
>> the CONFIG_INITRAMFS_SOURCE option).
>>
>> Can I simply load the kernel with kexec or do I have to extract the init=
rd
>> first and load them using the --initrd option?
>>
>> If I have to extract them first, is there a tool for this?
> =

> You should be able to just load the bzImage.  The kernel image should know
> how to then use the initramfs.  I know it works for powepc64 at least.

Hmm?!

If I load the same image directly (in kvm) in works. If I use kexec, it giv=
es
me a kernel panic "Unable to mount root fs on unknown-block(3,0).
Any special option needed?
Maybe I'm doing something wrong, I will double check (again)...
(I'm using bzImage on i386).

Regards
 Sven

-- =

 Sven Anders <anders@anduras.de>                 () Ascii Ribbon Campaign
                                                 /\ Support plain text e-ma=
il
 ANDURAS service solutions AG
 Innstra=DFe 71 - 94036 Passau - Germany
 Web: www.anduras.de - Tel: +49 (0)851-4 90 50-0 - Fax: +49 (0)851-4 90 50-=
55

Rechtsform: Aktiengesellschaft - Sitz: Passau - Amtsgericht Passau HRB 6032
Mitglieder des Vorstands: Sven Anders, Marcus Junker
Vorsitzender des Aufsichtsrats: Mark Peters


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
