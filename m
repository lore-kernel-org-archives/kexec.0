Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bej6W-0003es-Nr
 for kexec@lists.infradead.org; Tue, 30 Aug 2016 13:29:33 +0000
Received: by mail-wm0-x232.google.com with SMTP id i5so36063601wmg.0
 for <kexec@lists.infradead.org>; Tue, 30 Aug 2016 06:29:07 -0700 (PDT)
Received: from [192.168.1.2] (191.181.12.109.rev.sfr.net. [109.12.181.191])
 by smtp.gmail.com with ESMTPSA id 207sm18687590wmb.7.2016.08.30.06.29.04
 for <kexec@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Aug 2016 06:29:04 -0700 (PDT)
From: Louis Bouchard <louis.bouchard@canonical.com>
Subject: "kernel version not supported" message is causing concerns
Message-ID: <57C58A20.7000704@canonical.com>
Date: Tue, 30 Aug 2016 15:29:04 +0200
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

Hello,

Every so often, I get questions or bug report about the fact that makedumpfile
issues the following message when running :

   The kernel version is not supported.
   The created dumpfile may be incomplete.

While I understand the requirement for this message, it almost systematically is
understood by users as "makedumpfile is broken".

I would like to discuss the opportunity of changing the wording of this message
so it appears less confusing. Maybe something like :

Warning: makedumpfile has not been tested on this version of the kernel.
         If the created dumpfile is incomplete, you may need to upgrade to a
         newer version of makedumpfile.

I would be happy to propose a pull request for such a change if accepted.

Kind regards,

...Louis


-- 
Louis Bouchard
Software engineer, Cloud & Sustaining eng.
Canonical Ltd
Ubuntu developer                       Debian Maintainer
GPG : 429D 7A3B DD05 B6F8 AF63  B9C4 8B3D 867C 823E 7A61

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
