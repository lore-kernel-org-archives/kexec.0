Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bxhGi-0005Bz-2L
 for kexec@lists.infradead.org; Fri, 21 Oct 2016 21:22:24 +0000
Received: by mail-pf0-x241.google.com with SMTP id 128so9598699pfz.1
 for <kexec@lists.infradead.org>; Fri, 21 Oct 2016 14:22:03 -0700 (PDT)
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net 0/2] net: dsa: bcm_sf2: Do not rely on kexec_in_progress
Date: Fri, 21 Oct 2016 14:21:54 -0700
Message-Id: <1477084916-26327-1-git-send-email-f.fainelli@gmail.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, ebiederm@xmission.com, kexec@lists.infradead.org, davem@davemloft.net, linux-kernel@vger.kernel.org

David, Eric,

These are the two patches following the discussing we had on kexec_in_progress.

Feel free to apply or discard them, thanks!

Florian Fainelli (2):
  Revert "kexec: Export kexec_in_progress to modules"
  net: dsa: bcm_sf2: Do not rely on kexec_in_progress

 drivers/net/dsa/bcm_sf2.c | 5 +++--
 kernel/kexec_core.c       | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
