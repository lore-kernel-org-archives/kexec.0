Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [71.5.56.119] (helo=mail.litepoint.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTZAc-00060w-MP
 for kexec@lists.infradead.org; Wed, 10 Feb 2016 18:07:19 +0000
From: Rudici Cazeao <rudici.cazeao@litepoint.com>
Date: Wed, 10 Feb 2016 10:06:56 -0800
Subject: Kexec on ARM?
Message-ID: <689B1B2CF734104FB52EED5DDD4A6D6502A395A08F19@LPEXMB01.litepoint.internal>
References: <20160122233514.GA25777@ycc.fr>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E19AFB@BPXM01GP.gisp.nec.co.jp>
 <20160127085821.3be424e1@hananiah.suse.cz>
 <20160127103741.0e4fec81@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E1B252@BPXM01GP.gisp.nec.co.jp>
 <20160201130042.5c83f7ae@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E1B6CE@BPXM01GP.gisp.nec.co.jp>
 <20160202070044.GN6903@ycc.fr> <20160209093150.35da61c2@hananiah.suse.cz> 
Content-Language: en-US
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

All,
After compiling the exec tools from my ubuntu machine to run on an ARMv7 target,

1)	I loaded the kernel using : kexec  -f uImage --append="$ ( cat /proc/cmdline )"
2)	Afterwards, I ran: kexec -e 

Note: uImage was successfully loaded using u-boot.

From my serial output, I get the following messages:

Bye!
Uncompressing Linux... done, booting the kernel.   And it just hangs there.

Occasionaly, it goes further and actually prints:

Linux version xxxxxx 
Date: XXX
CPU:XXX
Machine:XXX
Early serial console at MMIO32 0Xxxxxxxxxx

Does anyone have any idea on how to help fix this.

I am also constrained to use kexect-tools 2.0.2




Thanks,


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
