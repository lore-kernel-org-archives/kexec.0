Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zz3zn-0004LW-Jz
 for kexec@lists.infradead.org; Wed, 18 Nov 2015 14:46:05 +0000
Received: by wmww144 with SMTP id w144so75291304wmw.0
 for <kexec@lists.infradead.org>; Wed, 18 Nov 2015 06:45:41 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 18 Nov 2015 22:45:41 +0800
Message-ID: <CA+MhoaMjeVODU_zt=8OoU4zAzBt6hA219=44kee+FR3Ew_v3Vw@mail.gmail.com>
Subject: How to understand "high" or "low" in crashkernel configuration?
From: Nan Xiao <xiaonan830818@gmail.com>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

Hi all,

When I use SuSE default Kdump configuration, I find there is "high" or "low" in
crashkernel's value, and it likes this:

    crashkernel=xxM,high Or crashkernel=xxM,low

But from this document(https://www.kernel.org/doc/Documentation/kdump/kdump.txt),
I can't find explanation of "high" or "low". How to understand it?

Thanks very much in advance!

Best Regards
Nan Xiao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
