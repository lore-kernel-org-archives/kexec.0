Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gw.goop.org ([64.81.55.164] helo=mail.goop.org)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hmanh-00023B-BT
	for kexec@lists.infradead.org; Fri, 11 May 2007 15:29:14 -0400
Message-ID: <4644C401.5010208@goop.org>
Date: Fri, 11 May 2007 12:29:05 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [Fastboot] restoring x86 BIOS state before reboot
References: <20070406154628.GG12005@jukie.net>
	<m1zm4rd676.fsf@ebiederm.dsl.xmission.com>
	<20070429094135.GA10948@suse.de> <20070511182329.GJ4052@ucw.cz>
In-Reply-To: <20070511182329.GJ4052@ucw.cz>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>

Pavel Machek wrote:
> I do not think OLPC is using linuxBIOS these days. What they have
> certainly looks like Sun's ROM monitor.

Yep, looks like they've got Mitch Bradley, (ex?) of Firmworks, doing
their firmware.  That means its pretty much exactly OpenFirmware.  Lots
of yummy, delicious Forth.

    J

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
