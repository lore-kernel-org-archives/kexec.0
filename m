Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ew0-f221.google.com ([209.85.219.221])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NW6B2-0006sc-Ty
	for kexec@lists.infradead.org; Sat, 16 Jan 2010 10:46:49 +0000
Received: by ewy21 with SMTP id 21so2498121ewy.2
	for <kexec@lists.infradead.org>; Sat, 16 Jan 2010 02:46:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <BAY114-W336F3329F5DE1A53218CC5DD690@phx.gbl>
References: <BAY114-W49E2846C6D653AB15A9A03DD6C0@phx.gbl>
	<4B4E029E.4020404@am.sony.com>
	<BAY114-W336F3329F5DE1A53218CC5DD690@phx.gbl>
Date: Sat, 16 Jan 2010 11:46:41 +0100
Message-ID: <d1b08f941001160246y8849dd3t151f4923c033d71f@mail.gmail.com>
Subject: Re: Problems compiling kexec-tools
From: Andrea Adami <andrea.adami@gmail.com>
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
To: kexec@lists.infradead.org
Cc: Yuri Bushmelev <jay4mail@gmail.com>

> petitboot looks interesting; but I need the tool chain ready to go for x8=
6.
> Currently For our project,=A0we are using a patched version of kboot which
> runs on x86.
>
> I do see some benefit for petitboot with the graphical menu. Ideally we'd
> need a version which reads each partition looking for multiple /boot kern=
els
> and present a method to select each one using a alpha char. Kinda like the
> old System Commander app.
>
> In my config; I'll have multiple linux kernels on the disk. I envision
> having Android, Moblin2.0, and several other flavors of linux in partitio=
ns
> and needing to boot to each at runtime.

May I jump in and ask if you know about kexecboot?
http://projects.linuxtogo.org/mediawiki/index.php/Kexecboot

It's just kernel + minimal initramfs : kexec and kexecboot.

We would need more testing on other archs: we mostly build for arm
using OpenEmbedded.

Regards

Andrea

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
