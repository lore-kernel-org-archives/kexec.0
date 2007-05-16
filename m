Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HoHeN-0003N4-Kr
	for kexec@lists.infradead.org; Wed, 16 May 2007 07:26:48 -0400
Date: Wed, 16 May 2007 13:26:21 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] [makedumpfile] Implement memory regions on IA64
Message-ID: <20070516112621.GA18616@suse.de>
References: <20070515220845.GB823@suse.de>
	<20070516202000oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070516202000oomichi@mail.jp.nec.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Jay Lan <jlan@sgi.com>, Kexec Mailing List <kexec@lists.infradead.org>

* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-05-16 13:20]:
> =

> I propose that makedumpfile distinguishes the page table (3L or 4L)
> by checking the defined file name of pud_t.
> I'm trying for the above implementation.
> I will send you the patch when it is complete.

If that works it's clearly the better approach.


Thanks,
   Bernhard
-- =

SUSE LINUX Products GmbH          Tel. +49 (911) 74053-0
Maxfeldstr. 5                     GF: Markus Rex
90409 N=FCrnberg, Germany           HRB 16746 (AG N=FCrnberg)
OpenPGP DDAF6454: F61F 34CC 09CA FB82 C9F6  BA4B 8865 3696 DDAF 6454

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
