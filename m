Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f188.google.com ([209.85.211.188])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NbDM1-0000tO-7q
	for kexec@lists.infradead.org; Sat, 30 Jan 2010 13:27:18 +0000
Received: by ywh26 with SMTP id 26so5589407ywh.12
	for <kexec@lists.infradead.org>; Sat, 30 Jan 2010 05:27:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4d358c531001210657k5c683b51sa2eda66e0787020d@mail.gmail.com>
References: <4d358c531001210657k5c683b51sa2eda66e0787020d@mail.gmail.com>
Date: Sat, 30 Jan 2010 21:27:11 +0800
Message-ID: <e997b7421001300527m683ccc4cl4e86715555f0b791@mail.gmail.com>
Subject: Re: kexec_load failed: Bad address - mips64 /Octeon Cavium
From: "wilbur.chan" <wilbur512@gmail.com>
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
To: Vishnu Yadav <vishnuyadav@gmail.com>
Cc: kexec@lists.infradead.org

2010/1/21 Vishnu Yadav <vishnuyadav@gmail.com>:
> I am trying to run kexec on mips 64 bit . on Octeon Cavium card.
> =A0I have applied the mips patches as told on net and somewhere in=A0 this
> mailing list.
>
> I get below error .
>
> ./kexec -l vmlinux.64
> kexec_load failed: Bad address

You have to check the kexec-tools code why this message print, or look
up sys_kexec_load directly to see if it was address aligned.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
