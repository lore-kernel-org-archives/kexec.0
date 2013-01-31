Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U0scs-0005bE-Dx
 for kexec@lists.infradead.org; Thu, 31 Jan 2013 11:48:19 +0000
Received: from 171.136.114.78.rev.sfr.net ([78.114.136.171]
 helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <louis.bouchard@canonical.com>)
 id 1U0scq-00044r-Ug
 for kexec@lists.infradead.org; Thu, 31 Jan 2013 11:48:17 +0000
From: Louis Bouchard <louis.bouchard@canonical.com>
Subject: [PATCH] --dump-dmesg fix for post 3.5 kernels
Date: Thu, 31 Jan 2013 12:48:07 +0100
Message-Id: <1359632888-11345-1-git-send-email-louis.bouchard@canonical.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

This patch fixes the --dump-dmesg options that no longer works with
the variable-length record format of the kernel log buffer.

Kind regards,

...Louis

--
Louis Bouchard
Backline Support Analyst
Canonical Ltd
Ubuntu support: http://landscape.canonical.com 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
